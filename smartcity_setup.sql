-- Drop tables in reverse order to avoid dependency issues
DROP TABLE Students CASCADE CONSTRAINTS;
DROP TABLE PatientsCASCADE CONSTRAINTS;
DROP TABLE EducationCASCADE CONSTRAINTS;
DROP TABLE HospitalCASCADE CONSTRAINTS;
DROP TABLE Traffic_Management CASCADE CONSTRAINTS;
DROP TABLE Citizen CASCADE CONSTRAINTS;
DROP TABLE Assets CASCADE CONSTRAINTS;
DROP TABLE Transportation CASCADE CONSTRAINTS;
DROP TABLE Property CASCADE CONSTRAINTS;

-- Create table Property
CREATE TABLE Property (
    Property_ID VARCHAR(10) PRIMARY KEY,
    Area INT,
    Prop_type VARCHAR(20),
    Prop_address VARCHAR(50),
    Value INT,
    No_of_floor INT,
    Category VARCHAR(15)
);

-- Create table Transportation
CREATE TABLE Transportation (
    Vehicle_plate VARCHAR(10) PRIMARY KEY,
    Reg_ID VARCHAR(10),
    Chassis VARCHAR(10),
    Engine INT,
    Make VARCHAR(10),
    Model VARCHAR(10),
    Year DATE
);

-- Create table Assets
CREATE TABLE Assets (
    Asset_ID VARCHAR(10) PRIMARY KEY,
    Vehicle_plate VARCHAR(10),
    Property_ID VARCHAR(10)
);

-- Create table Citizen
CREATE TABLE Citizen (
    CNIC VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(20),
    Contact VARCHAR(15),
    Email VARCHAR(30),
    Address VARCHAR(20),
    DOB DATE,
    Religion VARCHAR(10),
    Occupation VARCHAR(20),
    Gender VARCHAR(10),
    Language VARCHAR(10),
    Marital_Status VARCHAR(10),
    No_of_child INT,
    Asset_ID VARCHAR(10),
    CONSTRAINT fk_citizen_asset FOREIGN KEY (Asset_ID) REFERENCES Assets(Asset_ID)
);

-- Create table Traffic_Management
CREATE TABLE Traffic_Management (
    Trfc_ID VARCHAR(10) PRIMARY KEY,
    Location VARCHAR(50),
    Date_Time TIMESTAMP,
    Vehicle_plate VARCHAR(10),
    Speed INT,
    CONSTRAINT fk_traffic_management_vehicle FOREIGN KEY (Vehicle_plate) REFERENCES Transportation(Vehicle_plate)
);

-- Create table Hospital
CREATE TABLE Hospital (
    Hosp_ID VARCHAR(10) PRIMARY KEY,
    Type VARCHAR(10),
    Hosp_name VARCHAR(50),
    Hosp_Addr VARCHAR(50),
    Hosp_Ranking INT,
    Standard INT,
    Hosp_contact_no VARCHAR(15),
    Hosp_email VARCHAR(40),
    No_patients INT,
    Hosp_no_staff INT
);


-- Create table Education
CREATE TABLE Education (
    Edu_id VARCHAR(10) PRIMARY KEY,
    Edu_type VARCHAR(10),
    Edu_Name VARCHAR(60),
    Edu_ranking INT,
    Edu_no_staff INT,
    Edu_Address VARCHAR(60),
    Edu_email VARCHAR(50),
    No_students INT
);

-- Create table Patients
CREATE TABLE Patients (
    Pat_ID VARCHAR(10) PRIMARY KEY,
    Patient_CNIC VARCHAR(20),
    No_of_days_stayed INT,
    Last_diagnose VARCHAR(15),
    Date_of_arrival DATE,
    Hosp_ID VARCHAR(10)
);

-- Create table Students
CREATE TABLE Students (
    Std_ID VARCHAR(10) PRIMARY KEY,
    Student_CNIC VARCHAR(20),
    Class INT,
    Last_grade INT,
    Date_of_admission DATE,
    Edu_id VARCHAR(10));

-- Insert into Property
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P001', 240, 'House', 'Gulshan-e-Iqbal, 123 ABC Street, District East', 5000000, 2, 'Residential');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P002', 120, 'Apartment', 'Clifton, 456 XYZ Road, District South', 3000000, 10, 'Commercial');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P003', 300, 'House', 'Defence, 789 DEF Avenue, District South', 7000000, 3, 'Residential');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P004', 100, 'Shop', 'Saddar, 101 PQR Street, District South', 2000000, 1, 'Commercial');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P005', 160, 'Apartment', 'North Nazimabad, 202 MNO Road, District Central', 4000000, 8, 'Residential');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P006', 200, 'House', 'Malir, 303 GHI Avenue, District Malir', 6000000, 2, 'Residential');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P007', 140, 'Apartment', 'Korangi, 404 JKL Road, District Korangi', 3500000, 6, 'Commercial');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P008', 220, 'House', 'Nazimabad, 505 RST Street, District Central', 5500000, 2, 'Residential');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P009', 90, 'Shop', 'Gulistan-e-Jauhar, 606 UVW Road, District East', 2500000, 1, 'Commercial');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P010', 320, 'House', 'DHA, 707 CBA Avenue, District South', 8000000, 4, 'Residential');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P011', 130, 'Apartment', 'PECHS, 808 EFG Road, District East', 3200000, 7, 'Residential');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P012', 270, 'House', 'KDA Scheme, 909 HIJ Street, District Central', 6500000, 3, 'Residential');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P013', 180, 'Warehouse', 'SITE, 111 KLM Avenue, District West', 1800000, 1, 'Commercial');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P014', 240, 'House', 'Shah Faisal Colony, 212 NOP Street, District East', 4700000, 2, 'Residential');
INSERT INTO Property (Property_ID, Area, Prop_type, Prop_address, Value, No_of_floor, Category) VALUES
('P015', 150, 'Apartment', 'Gulshan-e-Maymar, 313 QRS Road, District East', 3800000, 5, 'Residential');



-- Insert into Transportation
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('ABC123', 'KHI-1234', 'Sedan', 1800, 'Toyota', 'Corolla', TO_DATE('2019', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('DEF456', 'KHI-2345', 'Sedan', 1800, 'Honda', 'Civic', TO_DATE('2018', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('GHI789', 'KHI-3456', 'Hatchback', 1000, 'Suzuki', 'Cultus', TO_DATE('2020', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('JKL012', 'KHI-4567', 'Sedan', 1800, 'Toyota', 'Prius', TO_DATE('2017', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('MNO345', 'KHI-5678', 'Sedan', 1500, 'Honda', 'City', TO_DATE('2016', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('PQR678', 'KHI-6789', 'Hatchback', 1300, 'Suzuki', 'Swift', TO_DATE('2019', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('STU901', 'KHI-7890', 'Sedan', 1500, 'Toyota', 'Yaris', TO_DATE('2020', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('VWX234', 'KHI-8901', 'Sedan', 2000, 'Honda', 'Accord', TO_DATE('2018', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('YZA567', 'KHI-9012', 'Hatchback', 1000, 'Suzuki', 'Wagon R', TO_DATE('2017', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('BCD890', 'KHI-0123', 'Sedan', 2500, 'Toyota', 'Camry', TO_DATE('2020', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('EFG123', 'KHI-2345', 'Sedan', 1800, 'Honda', 'Civic', TO_DATE('2019', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('HIJ456', 'KHI-3456', 'Hatchback', 1000, 'Suzuki', 'Alto', TO_DATE('2018', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('KLM789', 'KHI-4567', 'Sedan', 1800, 'Toyota', 'Corolla', TO_DATE('2017', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('NOP012', 'KHI-5678', 'Sedan', 1500, 'Honda', 'City', TO_DATE('2016', 'YYYY'));
INSERT INTO Transportation (Vehicle_plate, Reg_ID, Chassis, Engine, Make, Model, Year) VALUES
('QRS345', 'KHI-6789', 'Hatchback', 1300, 'Suzuki', 'Swift', TO_DATE('2019', 'YYYY'));



-- Insert into Assets
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A001', 'ABC123', 'P001');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A002', 'DEF456', 'P002');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A003', 'GHI789', 'P003');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A004', 'JKL012', 'P004');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A005', 'MNO345', 'P005');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A006', 'PQR678', 'P006');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A007', 'STU901', 'P007');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A008', 'VWX234', 'P008');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A009', 'YZA567', 'P009');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A010', 'BCD890', 'P010');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A011', 'EFG123', 'P011');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A012', 'HIJ456', 'P012');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A013', 'KLM789', 'P013');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A014', 'NOP012', 'P014');
INSERT INTO Assets (Asset_ID, Vehicle_plate, Property_ID) VALUES ('A015', 'QRS345', 'P015');

-- Insert into Citizen
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('1234567890123', 'John', '1234567890', 'john.doe@example.com', '123 Main Street', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Islam', 'Engineer', 'Male', 'English', 'Single', 0, 'A001');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('2345678901234', 'Jane', '2345678901', 'jane.smith@example.com', '456 Elm Street', TO_DATE('1992-05-15', 'YYYY-MM-DD'), 'Islam', 'Doctor', 'Female', 'English', 'Married', 2, 'A002');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('6543789012345', 'Ali', '3456789012', 'ali.khan@example.com', '789 Oak Street', TO_DATE('1988-12-31', 'YYYY-MM-DD'), 'Islam', 'Teacher', 'Male', 'Urdu', 'Single', 0, 'A003');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('4567650123456', 'Fatima', '4567890123', 'fatima.ahmed@example.com', '101 Pine Street', TO_DATE('1995-07-20', 'YYYY-MM-DD'), 'Islam', 'Lawyer', 'Female', 'English', 'Single', 0, 'A004');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('5678900034567', 'Ahmed', '5678901234', 'ahmed.khan@example.com', '202 Cedar Street', TO_DATE('1985-03-10', 'YYYY-MM-DD'), 'Islam', 'Businessman', 'Male', 'Urdu', 'Married', 3, 'A005');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('6000012345678', 'Aisha', '6789012345', 'aisha.malik@example.com', '303 Maple Street', TO_DATE('1998-11-28', 'YYYY-MM-DD'), 'Islam', 'Student', 'Female', 'English', 'Single', 0, 'A006');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('7890111156789', 'Mohammad', '7890123456', 'mohammad.ali@example.com', '404 Birch Street', TO_DATE('1993-04-05', 'YYYY-MM-DD'), 'Islam', 'Engineer', 'Male', 'Urdu', 'Single', 0, 'A007');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('8901222267890', 'Sana', '8901234567', 'sana.ahmed@example.com', '505 Cherry Street', TO_DATE('1982-09-15', 'YYYY-MM-DD'), 'Islam', 'Doctor', 'Female', 'English', 'Married', 2, 'A008');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('9012333378901', 'Usman', '9012345678', 'usman.khan@example.com', '606 Pine Street', TO_DATE('1987-06-25', 'YYYY-MM-DD'), 'Islam', 'Teacher', 'Male', 'Urdu', 'Single', 0, 'A009');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('0123455589012', 'Zara', '0123456789', 'zara.khan@example.com', '707 Cedar Street', TO_DATE('1991-02-14', 'YYYY-MM-DD'), 'Islam', 'Lawyer', 'Female', 'English', 'Married', 1, 'A010');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('1234569990123', 'Ali', '1234567890', 'ali.raza@example.com', '808 Birch Street', TO_DATE('1980-11-05', 'YYYY-MM-DD'), 'Islam', 'Businessman', 'Male', 'Urdu', 'Married', 2, 'A011');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('2345671201234', 'Sadia', '2345678901', 'sadia.khan@example.com', '909 Cherry Street', TO_DATE('1994-08-22', 'YYYY-MM-DD'), 'Islam', 'Student', 'Female', 'English', 'Single', 0, 'A012');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('3456785512345', 'Ameer', '3456789012', 'ameer.ali@example.com', '111 Pine Street', TO_DATE('1997-01-30', 'YYYY-MM-DD'), 'Islam', 'Engineer', 'Male', 'Urdu', 'Single', 0, 'A013');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('4567896723456', 'Anaya', '4567890123', 'anaya.malik@example.com', '212 Cedar Street', TO_DATE('1989-06-17', 'YYYY-MM-DD'), 'Islam', 'Doctor', 'Female', 'English', 'Married', 2, 'A014');
INSERT INTO Citizen (CNIC, Name, Contact, Email, Address, DOB, Religion, Occupation, Gender, Language, Marital_Status, No_of_child, Asset_ID) VALUES
('5678903434567', 'Ahmed', '5678901234', 'ahmed.butt@example.com', '313 Birch Street', TO_DATE('1996-09-08', 'YYYY-MM-DD'), 'Islam', 'Teacher', 'Male', 'Urdu', 'Single', 0, 'A015');


-- Insert into Traffic_Management
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T001', 'Regent Plaza, Shahrah-e-Faisal', TO_TIMESTAMP('2024-06-08 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'ABC123', 60);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T002', 'Star Gate, Shahrah-e-Faisal', TO_TIMESTAMP('2024-06-08 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'DEF456', 50);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T003', 'NASTP, Shahrah-e-Faisal', TO_TIMESTAMP('2024-06-08 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'GHI789', 45);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T004', 'Karsaz, Shahrah-e-Faisal', TO_TIMESTAMP('2024-06-08 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'JKL012', 55);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T005', 'FTC, Shahrah-e-Faisal', TO_TIMESTAMP('2024-06-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'MNO345', 65);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T006', 'Safoora Chorangi, University Road', TO_TIMESTAMP('2024-06-08 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'PQR678', 70);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T007', 'Johar Chorangi, University Road', TO_TIMESTAMP('2024-06-08 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'STU901', 40);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T008', 'Safari Park, University Road', TO_TIMESTAMP('2024-06-08 14:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'VWX234', 55);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T009', 'NIPA, University Road', TO_TIMESTAMP('2024-06-08 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'YZA567', 50);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T010', 'Regent Plaza, Shahrah-e-Faisal', TO_TIMESTAMP('2024-06-08 16:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'BCD890', 60);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T011', 'Star Gate, Shahrah-e-Faisal', TO_TIMESTAMP('2024-06-08 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'EFG123', 65);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T012', 'NASTP, Shahrah-e-Faisal', TO_TIMESTAMP('2024-06-08 17:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'HIJ456', 55);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T013', 'Karsaz, Shahrah-e-Faisal', TO_TIMESTAMP('2024-06-08 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'KLM789', 40);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T014', 'FTC, Shahrah-e-Faisal', TO_TIMESTAMP('2024-06-08 19:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'NOP012', 50);
INSERT INTO Traffic_Management (Trfc_ID, Location, Date_Time, Vehicle_plate, Speed) VALUES
('T015', 'Safoora Chorangi, University Road', TO_TIMESTAMP('2024-06-08 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'QRS345', 45);


-- Insert into Hospital
INSERT INTO Hospital (Hosp_ID, Type, Hosp_name, Hosp_Addr, Hosp_Ranking, Standard, Hosp_contact_no, Hosp_email, No_patients, Hosp_no_staff) VALUES
('H001', 'Public', 'Jinnah Postgraduate Medical Centre', 'Rafiqui H.J. Shaheed Road, District South', 5, 3, '021-1234567', 'info@jpmc.gov.pk', 1500, 200);
INSERT INTO Hospital (Hosp_ID, Type, Hosp_name, Hosp_Addr, Hosp_Ranking, Standard, Hosp_contact_no, Hosp_email, No_patients, Hosp_no_staff) VALUES
('H002', 'Private', 'Aga Khan University Hospital', 'Stadium Road, District East', 1, 5, '021-2345678', 'info@aku.edu', 1000, 500);
INSERT INTO Hospital (Hosp_ID, Type, Hosp_name, Hosp_Addr, Hosp_Ranking, Standard, Hosp_contact_no, Hosp_email, No_patients, Hosp_no_staff) VALUES
('H003', 'Public', 'Civil Hospital Karachi', 'Baba-e-Urdu Road, District South', 4, 3, '021-3456789', 'info@civilhospital.gov.pk', 1200, 180);
INSERT INTO Hospital (Hosp_ID, Type, Hosp_name, Hosp_Addr, Hosp_Ranking, Standard, Hosp_contact_no, Hosp_email, No_patients, Hosp_no_staff) VALUES
('H004', 'Private', 'South City Hospital', 'Clifton, District South', 2, 5, '021-4567890', 'info@southcityhospital.com', 800, 300);
INSERT INTO Hospital (Hosp_ID, Type, Hosp_name, Hosp_Addr, Hosp_Ranking, Standard, Hosp_contact_no, Hosp_email, No_patients, Hosp_no_staff) VALUES
('H005', 'Private', 'Ziauddin Hospital', 'North Nazimabad, District Central', 3, 4, '021-5678901', 'info@ziauddinhospital.com', 700, 250);
INSERT INTO Hospital (Hosp_ID, Type, Hosp_name, Hosp_Addr, Hosp_Ranking, Standard, Hosp_contact_no, Hosp_email, No_patients, Hosp_no_staff) VALUES
('H006', 'Public', 'Abbasi Shaheed Hospital', 'Paposh Nagar, District Central', 5, 3, '021-6789012', 'info@abbasishaheedhospital.gov.pk', 1100, 150);

-- Insert into Education
INSERT INTO Education (Edu_id, Edu_type, Edu_Name, Edu_ranking, Edu_no_staff, Edu_Address, Edu_email, No_students) VALUES
('E001', 'Public', 'University of Karachi', 5, 500, 'Main University Road, Gulshan-e-Iqbal, District East', 'info@uok.edu.pk', 20000);
INSERT INTO Education (Edu_id, Edu_type, Edu_Name, Edu_ranking, Edu_no_staff, Edu_Address, Edu_email, No_students) VALUES
('E002', 'Private', 'Aga Khan University', 1, 700, 'Stadium Road, Block 1, Gulshan-e-Iqbal, District East', 'info@aku.edu', 15000);
INSERT INTO Education (Edu_id, Edu_type, Edu_Name, Edu_ranking, Edu_no_staff, Edu_Address, Edu_email, No_students) VALUES
('E003', 'Public', 'NED University of Engineering and Technology', 3, 550, 'University Road, Block 1, Gulistan-e-Jauhar, District East', 'info@neduet.edu.pk', 18000);
INSERT INTO Education (Edu_id, Edu_type, Edu_Name, Edu_ranking, Edu_no_staff, Edu_Address, Edu_email, No_students) VALUES
('E004', 'Public', 'Institute of Business Administration (IBA)', 2, 600, 'University Road, Gulshan-e-Iqbal, District East', 'info@iba.edu.pk', 22000);
INSERT INTO Education (Edu_id, Edu_type, Edu_Name, Edu_ranking, Edu_no_staff, Edu_Address, Edu_email, No_students) VALUES
('E005', 'Private', 'Karachi Grammar School (KGS)', 4, 400, 'ST-19, Block 5, Clifton, District South', 'info@kgs.edu.pk', 10000);
INSERT INTO Education (Edu_id, Edu_type, Edu_Name, Edu_ranking, Edu_no_staff, Edu_Address, Edu_email, No_students) VALUES
('E006', 'Public', 'Dawood University of Engineering and Technology (DUET)', 6, 450, 'New M.A. Jinnah Road, District Central', 'info@duet.edu.pk', 16000);
INSERT INTO Education (Edu_id, Edu_type, Edu_Name, Edu_ranking, Edu_no_staff, Edu_Address, Edu_email, No_students) VALUES
('E007', 'Private', 'Karachi University Business School (KUBS)', 7, 300, 'Main University Road, Gulshan-e-Iqbal, District East', 'info@ku.edu.pk', 12000);


-- Insert into Patients
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P001', '3456789123456', 5, 'Fever', TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'H001');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P002', '4567891234567', 3, 'Fracture', TO_DATE('2024-06-03', 'YYYY-MM-DD'), 'H001');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P003', '5678912345678', 7, 'Appendicitis', TO_DATE('2024-06-02', 'YYYY-MM-DD'), 'H002');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P004', '6789123456789', 4, 'Malaria', TO_DATE('2024-06-05', 'YYYY-MM-DD'), 'H002');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P005', '7891234567890', 6, 'Dengue', TO_DATE('2024-06-04', 'YYYY-MM-DD'), 'H003');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P006', '8912345678901', 2, 'Injury', TO_DATE('2024-06-06', 'YYYY-MM-DD'), 'H003');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P007', '9012345678901', 5, 'Typhoid', TO_DATE('2024-06-07', 'YYYY-MM-DD'), 'H004');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P008', '0123456789012', 3, 'Flu', TO_DATE('2024-06-08', 'YYYY-MM-DD'), 'H004');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P009', '1234567890123', 4, 'Pneumonia', TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'H001');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P010', '2345678901234', 2, 'Asthma', TO_DATE('2024-06-03', 'YYYY-MM-DD'), 'H001');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P011', '3456789012345', 6, 'Diabetes', TO_DATE('2024-06-02', 'YYYY-MM-DD'), 'H002');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P012', '4567890123456', 5, 'Hypertension', TO_DATE('2024-06-05', 'YYYY-MM-DD'), 'H002');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P013', '5678901234567', 3, 'Allergy', TO_DATE('2024-06-04', 'YYYY-MM-DD'), 'H003');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P014', '6789012345678', 7, 'Bronchitis', TO_DATE('2024-06-06', 'YYYY-MM-DD'), 'H003');
INSERT INTO Patients (Pat_ID, Patient_CNIC, No_of_days_stayed, Last_diagnose, Date_of_arrival, Hosp_ID) VALUES
('P015', '7890123456789', 4, 'Rheumatism', TO_DATE('2024-06-07', 'YYYY-MM-DD'), 'H004');


-- INSERT INTO Students table
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S001', '1234567890123', '14', 11, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'E001');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S002', '2345678901234', '15', 10, TO_DATE('2023-08-15', 'YYYY-MM-DD'), 'E001');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S003', '3456789012345', '16', 9, TO_DATE('2023-07-30', 'YYYY-MM-DD'), 'E001');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S004', '4567890123456', '13', 8, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'E001');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S005', '5678901234567', '13', 7, TO_DATE('2023-08-15', 'YYYY-MM-DD'), 'E002');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S006', '6789012345678', '14', 6, TO_DATE('2023-07-30', 'YYYY-MM-DD'), 'E002');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S007', '7890123456789', '17', 5, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'E002');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S008', '8901234567890', '16', 4, TO_DATE('2023-08-15', 'YYYY-MM-DD'), 'E003');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S009', '9012345678901', '14', 3, TO_DATE('2023-07-30', 'YYYY-MM-DD'), 'E003');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S010', '0123456789012', '14', 2, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'E003');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S011', '1234567890123', '14', 1, TO_DATE('2023-08-15', 'YYYY-MM-DD'), 'E004');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S012', '2345678901234', '15', 1, TO_DATE('2023-07-30', 'YYYY-MM-DD'), 'E004');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S013', '3456789012345', '15', 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'E005');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S014', '4567890123456', '13', 1, TO_DATE('2023-08-15', 'YYYY-MM-DD'), 'E005');
INSERT INTO Students (Std_ID, Student_CNIC, Class, Last_grade, Date_of_admission, Edu_id) VALUES
('S015', '5678901234567', '16', 1, TO_DATE('2023-07-30', 'YYYY-MM-DD'), 'E005');



