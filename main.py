from flask import Flask, render_template, request, redirect, url_for, jsonify
import cx_Oracle
from datetime import datetime
import webbrowser

app = Flask(__name__)

db_config = {
    "user": "system",
    "password": "dell2350",
    "dsn": "localhost:1521/xepdb1"
}
webpage_opened = False
tables = ["Patients", "Students", "Education", "Hospital", "Traffic_Management", "Citizen", "Assets", "Transportation", "Property"]
def get_table_schema(table):
    connection = None
    cursor = None
    try:
        connection = cx_Oracle.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute(
            f"SELECT column_name, data_type, nullable FROM all_tab_columns WHERE table_name = '{table.upper()}'")
        columns = [{"name": row[0], "type": row[1], "nullable": row[2], "pattern": get_pattern(row[1])} for row in
                   cursor.fetchall()]
        return columns
    except cx_Oracle.DatabaseError as e:
        print(e)
        return []
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


def get_pattern(data_type):
    if data_type in ['NUMBER', 'FLOAT', 'DOUBLE PRECISION']:
        return r"[0-9]*\.?[0-9]+"
    elif data_type == 'DATE':
        return r"\d{4}-\d{2}-\d{2}"
    elif data_type == 'TIMESTAMP(6)':
        return r"\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} (AM|PM)"
    else:
        return r".*"

def fetch_existing_data(table):
    connection = None
    cursor = None
    try:
        connection = cx_Oracle.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute(f"SELECT * FROM {table}")
        columns = [col[0] for col in cursor.description]
        rows = cursor.fetchall()
        data = [dict(zip(columns, row)) for row in rows]
        return data
    except cx_Oracle.DatabaseError as e:
        print(e)
        return None
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


@app.route('/')
def index():
    return render_template('index.html', tables=tables)


@app.route('/load_data')
def load_data():
    table = request.args.get('table')
    if not table:
        return jsonify([])

    connection = None
    cursor = None
    try:
        connection = cx_Oracle.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute(f"SELECT * FROM {table}")  # Fetch first 10 rows for display
        columns = [col[0] for col in cursor.description]
        rows = cursor.fetchall()
        data = [dict(zip(columns, row)) for row in rows]
        return jsonify(data)
    except cx_Oracle.DatabaseError as e:
        return str(e), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/update_form')
def update_form():
    table = request.args.get('table')
    columns = get_table_schema(table)
    old_data = fetch_existing_data(table)
    return render_template('update_form.html', table=table, columns=columns, old_data=old_data)

@app.route('/update', methods=['POST'])
def update_data():
    table = request.form['table']
    column_name = request.form['column']
    column_value = request.form['value']
    condition_column = request.form['condition_column']
    condition_value = request.form['condition_value']
    condition_operator = request.form['condition']
    column_types = get_column_data_types(table)
    script = generate_update_script(table, column_name, column_value, condition_column, condition_value,
                                    condition_operator, column_types)
    print("Update Script:", script)

    try:
        connection = cx_Oracle.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute(script)
        connection.commit()

        return redirect(url_for('index'))
    except cx_Oracle.DatabaseError as e:
        return jsonify({'success': False, 'error': str(e)}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
def get_column_data_types(table):
    connection = None
    cursor = None
    column_types = {}
    try:
        connection = cx_Oracle.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute(f"SELECT column_name, data_type FROM all_tab_columns WHERE table_name = '{table.upper()}'")
        for row in cursor.fetchall():
            column_name = row[0]
            data_type = row[1]
            if data_type.startswith('TIMESTAMP'):
                column_types[column_name] = 'TIMESTAMP(6)'
            else:
                column_types[column_name] = data_type

    except cx_Oracle.DatabaseError as e:
        print(e)
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
    return column_types
def generate_update_script(table, column_name, column_value, condition_column, condition_value, condition_operator, column_types):
    # Determine if quotes should be added based on data types
    if column_value.lower() == 'null':
        set_cond = f"{column_name} = {column_value}"
    elif column_types.get(column_name.upper()) in ['VARCHAR2','VARCHAR', 'CHAR', 'NCHAR', 'NVARCHAR']:
        set_cond = f"{column_name} = '{column_value}'"
    elif column_types.get(column_name.upper()) == 'DATE':
        set_cond = f"{column_name} = to_date('{column_value}','YYYY-MM-DD')"
    elif column_types.get(column_name.upper()) == 'TIMESTAMP(6)':
        set_cond = f"{column_name} = to_timestamp('{column_value}','YYYY-MM-DD HH24:MI:SS')"
    else:
        set_cond = f"{column_name} = {column_value}"

    if condition_value.lower() == 'null':
        condition = f"{condition_column} IS {condition_value}"
    elif column_types.get(condition_column.upper()) in ['VARCHAR2','VARCHAR', 'CHAR', 'NCHAR', 'NVARCHAR'] :
        if condition_operator == 'LIKE':
            condition_value = f"'%{condition_value}%'"
        else:
            condition_value = f"'{condition_value}'"# Enclose condition value in quotes
        condition = f"{condition_column} {condition_operator} {condition_value}"
    elif column_types.get(condition_column.upper()) == 'DATE':
        #condition_value = datetime.strptime(condition_value.split('T')[0], '%Y-%m-%d').strftime('%Y-%m-%d')
        condition = f"{condition_column} {condition_operator} to_date('{condition_value}','YYYY-MM-DD')"
    elif column_types.get(condition_column.upper()) == 'TIMESTAMP(6)':
        #condition_value = datetime.strptime(condition_value, '%Y-%m-%dT%H:%M:%S').strftime('%Y-%m-%d %H:%M:%S')
        condition = f"{condition_column} {condition_operator} to_timestamp('{condition_value}','YYYY-MM-DD HH24:MI:SS')"
    elif condition_value == 'null' and condition_operator == '=':
        condition = f"{condition_column} is {condition_value}"
    else:
        condition = f"{condition_column} {condition_operator} {condition_value}"

    return f"UPDATE {table} SET {set_cond} WHERE {condition}"

@app.route('/insert_form')
def insert_form():
    table = request.args.get('table')
    columns = get_table_schema(table)
    today = datetime.now().strftime('%Y-%m-%d')  # Get today's date in YYYY-MM-DD format
    return render_template('insert_form.html', table=table, columns=columns, today=today)

@app.route('/insert', methods=['POST'])
def insert():
    table = request.form['table']
    columns = get_table_schema(table)
    values = {}

    # Parse date inputs to the format expected by the database
    for column in columns:
        column_name = column['name']
        column_type = column['type']
        if column_name in request.form:
            value = request.form[column_name]
            if column_type == 'DATE':
                try:
                    value = datetime.strptime(value, '%Y-%m-%d').date()
                    # Convert the date to the Oracle TO_DATE format string
                    values[column_name] = value
                except ValueError:
                    return f"Invalid date format for column {column_name}. Please use YYYY-MM-DD format.", 400
            elif column_type == 'TIMESTAMP(6)':
                timestamp_value = request.form.get(column_name)
                if timestamp_value:
                    print(timestamp_value)
                    try:
                        value = datetime.strptime(timestamp_value, '%Y-%m-%dT%H:%M:%S')
                        formatted_value = value.strftime('%d-%b-%y %I.%M.%S.%f %p')
                        print(formatted_value)
                        values[column_name] = formatted_value
                    except ValueError:
                        return f"Invalid timestamp format for column {column_name}. Please use YYYY-MM-DDTHH:MM format.", 400
            else:
                values[column_name] = value
            print(f"{column_name}: {values[column_name]}")

    # Constructing the SQL INSERT statement with bind variables
    columns_str = ', '.join(values.keys())
    placeholders = ', '.join([f":{key}" for key in values.keys()])
    sql_insert = f"INSERT INTO {table} ({columns_str}) VALUES ({placeholders})"

    print("SQL Insert Command:", sql_insert)
    connection = None
    cursor = None
    try:
        connection = cx_Oracle.connect(**db_config)
        cursor = connection.cursor()
        # Convert datetime values to the correct format for Oracle
        for key, val in values.items():
            if isinstance(val, datetime):
                if 'T' in request.form[key]:  # Check if it was a TIMESTAMP
                    values[key] = val.strftime('%Y-%m-%d %H:%M:%S')
                else:  # It was a DATE
                    values[key] = val.strftime('%Y-%m-%d')

        cursor.execute(sql_insert, values)  # Execute the SQL command with values directly
        connection.commit()
        return redirect(url_for('index'))
    except cx_Oracle.DatabaseError as e:
        print(e)
        return str(e), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/delete_form')
def delete_form():
    table = request.args.get('table')
    columns = get_table_schema(table)
    return render_template('delete_form.html', table=table, columns=columns)
@app.route('/submit', methods=['POST'])
def submit():
    data = request.form
    print("Received data:")
    for key, value in data.items():
        print(f"{key}: {value}")
    return "Data received successfully"
@app.route('/delete', methods=['POST'])
def delete_data():
    table = request.form['table']
    condition_column = request.form['condition_column']
    condition_value = request.form['condition_value']
    condition_operator = request.form['condition_operator']

    # Retrieve column data types from the database
    column_types = get_column_data_types(table)

    # Generate delete script with proper quoting based on data types
    script = generate_delete_script(table, condition_column, condition_operator, condition_value, column_types)
    print("Delete Script:", script)

    try:
        connection = cx_Oracle.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute(script)
        connection.commit()
        return redirect(url_for('index'))
    except cx_Oracle.DatabaseError as e:
        return jsonify({'success': False, 'error': str(e)}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

def generate_delete_script(table, condition_column, condition_operator, condition_value, column_types):
    # Determine if quotes should be added based on data types
    if condition_value.lower() == 'null':
        condition = f"{condition_column} IS {condition_value}"
    elif column_types.get(condition_column.upper()) in ['VARCHAR2', 'VARCHAR', 'CHAR', 'NCHAR', 'NVARCHAR']:
        if condition_operator == 'LIKE':
            condition_value = f"'%{condition_value}%'"
        else:
            condition_value = f"'{condition_value}'"  # Enclose condition value in quotes
        condition = f"{condition_column} {condition_operator} {condition_value}"
    elif column_types.get(condition_column.upper()) == 'DATE':
        condition_value = f"to_date('{condition_value}','YYYY-MM-DD')"  # Convert date format
        condition = f"{condition_column} {condition_operator} {condition_value}"
    elif column_types.get(condition_column.upper()) == 'TIMESTAMP(6)':
        condition_value = f"to_timestamp('{condition_value}','YYYY-MM-DD HH24:MI:SS')"  # Convert timestamp format
        condition = f"{condition_column} {condition_operator} {condition_value}"
    else:
        condition = f"{condition_column} {condition_operator} {condition_value}"

    return f"DELETE FROM {table} WHERE {condition}"

def generate_search_script(table, condition_column, condition_operator, condition_value, column_types):
    # Determine if quotes should be added based on data types
    if condition_value == 'null':
        condition = f"{condition_column} is {condition_value}"
    elif column_types.get(condition_column.upper()) in ['VARCHAR2','VARCHAR', 'CHAR', 'NCHAR', 'NVARCHAR']:
        if condition_operator == "LIKE":
            condition = f"{condition_column} like '%{condition_value}%'"
        else:
            condition = f"{condition_column} = '{condition_value}'"

            print(condition_operator)
    elif column_types.get(condition_column.upper()) == 'DATE':
        condition = f"{condition_column} {condition_operator} to_date('{condition_value}','YYYY-MM-DD')"
    elif column_types.get(condition_column.upper()) == 'TIMESTAMP(6)':
        condition = f"{condition_column} {condition_operator} to_timestamp('{condition_value}','YYYY-MM-DD HH24:MI:SS')"
    else:
        condition = f"{condition_column} {condition_operator} {condition_value}"

    return f"SELECT * FROM {table} WHERE {condition}"

@app.route('/search_form')
def search_form():
    table = request.args.get('table')
    columns = get_table_schema(table)
    return render_template('search_form.html', table=table, columns=columns)
@app.route('/search', methods=['GET'])
def search_data():
    table = request.args.get('table')
    condition_column = request.args.get('condition_column')
    condition_value = request.args.get('condition_value')
    condition_operator = request.args.get('condition')
    # Retrieve column data types from the database
    column_types = get_column_data_types(table)

    # Generate search script with proper quoting based on data types
    script = generate_search_script(table, condition_column, condition_operator, condition_value, column_types)
    print("Search Script:", script)

    connection = None
    cursor = None
    try:
        connection = cx_Oracle.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute(script)
        rows = cursor.fetchall()
        columns = [col[0] for col in cursor.description]
        data = [dict(zip(columns, row)) for row in rows]
        return jsonify(data)
    except cx_Oracle.DatabaseError as e:
        return str(e), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


@app.route('/favicon.ico')
def favicon():
    return '', 204  # No Content


if __name__ == '__main__':
    if not webpage_opened:
        url = "http://127.0.0.1:5000"
        webbrowser.open(url)
        webpage_opened = True

    app.run(debug=True)
