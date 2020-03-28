----------------------------------------------------------------------------------------------------------------
-- Create Database --
----------------------------------------------------------------------------------------------------------------
Drop database if exists DB_Project;
create database DB_Project CHARACTER SET utf8 COLLATE UTF8_GENERAL_CI ;

----------------------------------------------------------------------------------------------------------------
-- Patient --
----------------------------------------------------------------------------------------------------------------
Use DB_Project;
Drop table if exists patient;
Drop table if exists Patient;

create table Patient (
	
	-- PK, Patient PPS
	PPSN varchar(8) not null,
		
	-- Patient Name, 45 char limit, cannot be NULL
	patient_Name varchar(45) not null,
	
	-- Patient Address
	patient_Address varchar(150) not null,
	
	-- Patient Number
	patient_Phone varchar(15) not null,
	
	-- Patient Email
	patient_EMail varchar(50),
	
	-- Patient profile and XRay
	patient_Profile LONGBLOB DEFAULT NULL,           
	xray_path varchar(50) DEFAULT NULL,  
	
	-- Mark Updates
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
		
	-- Set Primary Key for table
	PRIMARY KEY (PPSN)
		
) Engine=InnoDB;

-- Populate Table -- 
Insert into Patient (PPSN, patient_Name, patient_Address, patient_Phone, patient_EMail, patient_Profile, xray_path, last_update) values
('1234567A', 'Darragh Lally', 'Portumna, Co. Galway', '353851234567', 'darragh@mail.com', load_file('C:/PatientProfile/jj.jpg'), '/PatientDetails/xr1.jpg', CURRENT_TIMESTAMP), 
('1345678B', 'John Doe', 'Salthill, Galway', '0879876541', '', load_file('C:/PatientProfile/pj.jpg'), '/PatientDetails/xr2.jpg', CURRENT_TIMESTAMP),
('1456789C', 'Jane Doe', 'Salthill, Galway', '0855574630', 'jj@yahoo.com', load_file('C:/PatientProfile/ee.jpg'), '/PatientDetails/xr3.jpg', CURRENT_TIMESTAMP),
('1567890D', 'Dow Jones', 'Ballybane, Galway', '091555555', 'money@talks.com', load_file('C:/PatientProfile/dj.jpg'), '/PatientDetails/xr1.jpg',CURRENT_TIMESTAMP),
('1678901E', 'Mary Murphy', 'Doughiska, Galway', '091525249','', load_file('C:/PatientProfile/rp.jpg'), '/PatientDetails/xr2.jpg', CURRENT_TIMESTAMP);

----------------------------------------------------------------------------------------------------------------
-- Payment -- Is connected to Patient
----------------------------------------------------------------------------------------------------------------
Use DB_Project;
Drop table if exists payment;
Drop table if exists Payment;

create table Payment (

	-- PK, payment_ID
	payment_ID tinyint unsigned not null auto_increment,

	-- Payment Type, Default is first in list, illegal value to  ' '
	payment_Type ENUM ('UPDATE', 'Medical Card', 'Insurance', 'Credit Card', 'Cash', 'Installments'),
	
	-- FK, patient PPSN
	PPSN varchar(8) not null,
	
	-- Mark Updates
	last_update  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	-- Set PK
	primary key (payment_ID),
	
	-- Set FK
	foreign key(PPSN) references Patient(PPSN)
	
) Engine=InnoDB;

-- Populate Table
insert into Payment (payment_Type, PPSN, last_update) values
(2, '1234567A', CURRENT_TIMESTAMP),
(1, '1345678B', CURRENT_TIMESTAMP),
(5, '1456789C', CURRENT_TIMESTAMP),
(4, '1567890D', CURRENT_TIMESTAMP),
(6, '1678901E', CURRENT_TIMESTAMP);

----------------------------------------------------------------------------------------------------------------
-- Bill -- Is connected to Payment
----------------------------------------------------------------------------------------------------------------
Use DB_Project;
Drop table if exists bill;
Drop table if exists Bill;

create table Bill (

	-- PK, bill_ID
	bill_ID tinyint unsigned not null auto_increment,
	
	-- FK, payment_ID 
	payment_ID tinyint unsigned not null,
	
	-- Treatment*/******************************************************
	
	-- Bill Amount, Range from -9999.99 to 9999.99
	bill_Amount decimal(6,2) unsigned,
	
	-- Mark Updates
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	-- Set PK
	primary key (bill_ID),
	
	-- Set FK
	foreign key (payment_ID) references Payment(payment_ID)
	
) Engine=InnoDB;

-- Populate Table
insert into Bill (payment_ID, bill_Amount, last_update) values
(1, 120.00, CURRENT_TIMESTAMP),
(2, 0.00, CURRENT_TIMESTAMP),
(3, 500.00, CURRENT_TIMESTAMP),
(4, 30.00, CURRENT_TIMESTAMP),
(5, 175.00, CURRENT_TIMESTAMP);

----------------------------------------------------------------------------------------------------------------
-- Appointment -- Connected to Patient
----------------------------------------------------------------------------------------------------------------
Use DB_Project;
Drop table if exists appointment;
Drop table if exists Appointment;

create table Appointment (

	-- PK, Appointment ID
	appointment_ID tinyint unsigned not null auto_increment,
	
	-- FK, patiend ID
	PPSN varchar(8) not null,
	
	-- Date 
	appointment_Date varchar(10) not null,
	
	-- Time
	appointment_Time varchar(4) not null,

	-- Mark Updates
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	-- Set PK
	primary key (appointment_ID),
	
	-- Set FK
	foreign key (PPSN) references Patient(PPSN)
	
) Engine=InnoDB;

-- Populate Table
insert into appointment (PPSN, appointment_Date, appointment_Time, last_update) values
('1234567A', '01/01/2021', '0900', CURRENT_TIMESTAMP),
('1345678B', '01/01/2021', '1100',CURRENT_TIMESTAMP),
('1456789C', '02/01/2021', '0900',CURRENT_TIMESTAMP),
('1567890D', '02/01/2021', '1100',CURRENT_TIMESTAMP),
('1678901E', '03/01/2021', '0900',CURRENT_TIMESTAMP);

----------------------------------------------------------------------------------------------------------------
-- Specialist -- Connected to Appointment
----------------------------------------------------------------------------------------------------------------
Use DB_Project;
Show tables;
Drop table if exists specialist;
Drop table if exists Specialist;

create table Specialist (

	-- PF, Referral ID
	ref_ID tinyint unsigned not null auto_increment,

	-- FK, Appointment number
	appointment_ID tinyint unsigned not null,

	-- Specialist name
	specialist_Name ENUM ('Dr. Desmond', 'Mrs. Burke', 'Mr. Smyth', 'Ms. Jones') not null,

	-- Mark Updates
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	-- Set PK
	primary key (ref_ID),
	
	-- Set FK, Appointment Number
	foreign key (appointment_ID) references Appointment(appointment_ID)
	
) Engine=InnoDB;

-- Populate Table
insert into specialist (appointment_ID, specialist_Name, last_update) values
(1, 1, CURRENT_TIMESTAMP),
(2, 1, CURRENT_TIMESTAMP),
(3, 2, CURRENT_TIMESTAMP),
(5, 4, CURRENT_TIMESTAMP);

----------------------------------------------------------------------------------------------------------------
-- Treatment -- 
----------------------------------------------------------------------------------------------------------------
Use DB_Project;
Show tables;
Drop table if exists Treament;
Drop table if exists Treatment;

create table Treatment (

	-- PK,
	treatment_ID tinyint unsigned not null auto_increment,
	
	-- Treatment Type
	treatment_Type ENUM ('Check Up', 'Cleaning', 'Filling', 'Braces', 'Root Canal') not null,
	
	-- Treatment Cost
	treatment_Cost decimal(6,2) unsigned not null,
	
	-- Mark Updates
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	-- Set PK
	primary key (treatment_ID)
	
) Engine=InnoDB;

-- Populate Table
insert into treatment (treatment_Type, treatment_Cost, last_update) values
(1, 50.00, CURRENT_TIMESTAMP),
(2, 75.00, CURRENT_TIMESTAMP),
(3, 120.00, CURRENT_TIMESTAMP),
(4, 3000.00, CURRENT_TIMESTAMP),
(5, 1200.00, CURRENT_TIMESTAMP);