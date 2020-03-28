Database Managemetn Project 2020
Darragh Lally - G00220290

USER NAME: DL
PASSWORD: DL
IP: 34.71.229.66 - NOTE: This will change as I am turning off VM as requested

TABLES:
As recommended in brief
1. patient
2. appointment
3. bill
4. payment
5. specialist
6. treatment

HOW TO:
These steps will get the database on your machine and populate the tables.
1. Download file: DBMS_G00220290
2. Run Wamp
3. Copy and Paste contents of 'CreateDentalPractice' into mysql console
4. Copy 'PatientProfile' folder to C drive.
5. Copy 'PatientDetails' folder into - Wamp64/www folder located on C drive
6. Copy all .php files into - Wamp64/www folder also

RUN: 
1. Open browser
2. Type: localhost/patients.php	
	This will bring up first query file and display a table on your browser window
3. Type: localhost/patient_bills.php
	This will bring up second query file and display on window

FOR MYSQL CONSOLE:
CRUD available on database through the mysql console.
1. use db_project;
2. show tables;

Select:
select * from patient;
select * from appointment;
select * from bill;
select * from payment;
select * from specialist;
select * from treatment;

Create/ Insert: 
Insert into Patient (PPSN, patient_Name, patient_Address, patient_Phone, patient_EMail, patient_Profile, xray_path, last_update) values
('9988776F', 'Peter Pan', 'Some ship', '0000000', 'peter@pan.com';

Delete:
Delete from patient where PPSN = '9988776F';
