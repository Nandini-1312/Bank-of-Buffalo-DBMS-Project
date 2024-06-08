REM   Script: DBMS Project - Bank of Buffalo
REM   Complete SQL scripts including - 
DDL, DML and select statements

DROP TABLE Bank CASCADE CONSTRAINTS;

DROP TABLE Branch CASCADE CONSTRAINTS;

DROP TABLE Employees CASCADE CONSTRAINTS;

DROP TABLE Customer CASCADE CONSTRAINTS;

DROP TABLE Customer_Individual CASCADE CONSTRAINTS;

DROP TABLE Customer_Business CASCADE CONSTRAINTS;

DROP TABLE Account CASCADE CONSTRAINTS;

DROP TABLE Cards CASCADE CONSTRAINTS;

DROP TABLE Insurance_Account CASCADE CONSTRAINTS;

DROP TABLE Loan_Account CASCADE CONSTRAINTS;

DROP TABLE Transactions CASCADE CONSTRAINTS;

CREATE TABLE Bank( 
	Bank_ID INTEGER NOT NULL, 
	Bank_Name VARCHAR2(30) NOT NULL, 
	Head_Office_Location VARCHAR2(100), 
	Head_Office_Contact NUMBER(10,0), 
	CONSTRAINT Bank_PK PRIMARY KEY (Bank_ID) 
);

CREATE TABLE Branch( 
	Branch_ID INTEGER NOT NULL, 
	Bank_ID INTEGER NOT NULL, 
	Branch_Name VARCHAR2(30) NOT NULL, 
	Branch_Address VARCHAR2(100), 
	Phone NUMBER(10,0), 
	CONSTRAINT Branch_PK PRIMARY KEY (Branch_ID), 
	CONSTRAINT Branch_FK FOREIGN KEY (Bank_ID) REFERENCES Bank(Bank_ID) 
);

CREATE TABLE Employees( 
	Employee_ID INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 1001 
		INCREMENT BY 1 
		MINVALUE 1001), 
	Branch_ID INTEGER NOT NULL, 
	Bank_ID INTEGER NOT NULL, 
	Employee_First_Name VARCHAR2(30) NOT NULL, 
	Employee_Last_Name VARCHAR2(30), 
	Job_Title VARCHAR2(30), 
	Employee_Type VARCHAR2(9) CHECK (Employee_Type IN ('Temporary','Permanent')), 
	Phone NUMBER(10,0), 
	Mail_Id VARCHAR2(30), 
	CONSTRAINT Employees_PK PRIMARY KEY (Employee_ID), 
	CONSTRAINT Employees_FK1 FOREIGN KEY (Bank_ID) REFERENCES Bank(Bank_ID) , 
	CONSTRAINT Employees_FK2 FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID) 
);

CREATE TABLE Customer ( 
	Customer_ID INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 50001 
		INCREMENT BY 1 
		MINVALUE 50001), 
	Branch_ID INTEGER, 
	Customer_Type VARCHAR2(10) CHECK (Customer_Type IN ('Individual','Business')), 
	CONSTRAINT Customer_PK PRIMARY KEY (Customer_ID), 
	CONSTRAINT Customer_FK FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID) 
);

CREATE TABLE Customer_Individual( 
	Customer_ID INTEGER NOT NULL, 
	Customer_First_Name VARCHAR2(30) NOT NULL , 
    Customer_Last_Name VARCHAR2(30) , 
	SSN NUMBER(9,0) , 
	Address VARCHAR2(100) , 
	Phone NUMBER(10,0) , 
	Mail_ID VARCHAR2(30) , 
	DOB DATE , 
	Gender VARCHAR2(6) , 
	Nationality VARCHAR2(30) , 
	CONSTRAINT Customer_Individual_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Customer_Business( 
	Customer_ID INTEGER NOT NULL, 
	Company_Name VARCHAR2(30) , 
	TIN NUMBER(9,0) , 
	Company_Location VARCHAR2(100) , 
	Company_Number NUMBER(10,0) , 
	Company_Mail_ID VARCHAR2(30) , 
	CONSTRAINT Customer_Business_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Account( 
	Account_Number INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 100001 
		INCREMENT BY 1 
		MINVALUE 100001), 
	Customer_ID INTEGER NOT NULL, 
	Account_Type VARCHAR2(8) CHECK (Account_Type IN ('Savings','Checking')), 
	Account_Balance DECIMAL(15,2), 
	Interest_Rate DECIMAL(5, 2), 
	Beneficiary VARCHAR2(60), 
	Opening_Date DATE DEFAULT SYSDATE, 
	CONSTRAINT Account_PK PRIMARY KEY (Account_Number), 
	CONSTRAINT Account_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Cards( 
	Account_Number INTEGER NOT NULL, 
	Card_Number INTEGER NOT NULL, 
	Card_Type VARCHAR2(6) CHECK (Card_Type IN ('Debit','Credit')) NOT NULL, 
	CVV INTEGER NOT NULL, 
	CONSTRAINT Cards_FK FOREIGN KEY (Account_Number) REFERENCES Account (Account_Number) 
);

CREATE TABLE Insurance_Account ( 
	Policy_Number INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 50000001 
		INCREMENT BY 1 
		MINVALUE 50000001), 
	Customer_ID INTEGER, 
	Insurance_Amount DECIMAL(15, 2), 
	Insurance_Type VARCHAR2(8) CHECK(Insurance_Type IN('Vehicles','Health','Life')), 
	Nominee_name VARCHAR2(60), 
	Insurance_open_date DATE DEFAULT SYSDATE, 
	CONSTRAINT Insurance_Account_PK PRIMARY KEY (Policy_Number), 
	CONSTRAINT Insurance_Account_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Loan_Account ( 
	Loan_Number INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 101 
		INCREMENT BY 1 
		MINVALUE 101), 
	Customer_ID INTEGER, 
	Loan_Type VARCHAR2(9) CHECK (Loan_Type IN ('Personal','Home','Education','Vehicles')), 
	Loan_Amount DECIMAL(15, 2), 
	Interest_Rates DECIMAL(5, 2), 
	Tenure DECIMAL(5, 2), 
	CONSTRAINT Loan_Account_PK PRIMARY KEY (Loan_Number), 
	CONSTRAINT Loan_Account_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Transactions ( 
	Transaction_ID INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 1 
		INCREMENT BY 1 
		MINVALUE 1), 
	Account_Number INTEGER NOT NULL, 
	Loan_Number INTEGER, 
	Policy_Number INTEGER, 
	Transaction_Amount DECIMAL(15,2), 
	Transaction_Date TIMESTAMP(6) DEFAULT SYSDATE, 
	Transaction_Type VARCHAR2(6) CHECK (Transaction_Type IN ('Credit','Debit')), 
	Payment_Type VARCHAR2(14) CHECK (Payment_Type IN ('Cash','Debit Card','Credit Card', 'Net 
	Banking','Wire Transfers')), 
	Charges DECIMAL(15,2), 
	CONSTRAINT Transaction_PK PRIMARY KEY (Transaction_ID), 
	CONSTRAINT Transaction_FK1 FOREIGN KEY (Account_Number) REFERENCES Account(Account_Number), 
	CONSTRAINT Transaction_FK2 FOREIGN KEY (Loan_Number) REFERENCES Loan_Account(Loan_Number), 
	CONSTRAINT Transaction_FK3 FOREIGN KEY (Policy_Number) REFERENCES Insurance_Account(Policy_Number) 
);

INSERT INTO Bank (Bank_ID, Bank_Name, Head_Office_Location, Head_Office_Contact) 
VALUES ('100', 'Bank of Buffalo', '7231 Beilfuss Junction', '7164886544');

INSERT INTO Bank (Bank_ID, Bank_Name, Head_Office_Location, Head_Office_Contact) 
VALUES ('101', 'CitySavings Bank', '08 Pankratz Junction', '1323205802');

INSERT INTO Bank (Bank_ID, Bank_Name, Head_Office_Location, Head_Office_Contact) 
VALUES ('102', 'CapitalTrust Financial', '98793 Ruskin Way', '8564547201');

INSERT INTO Bank (Bank_ID, Bank_Name, Head_Office_Location, Head_Office_Contact) 
VALUES ('103', 'MetroBank Alliance', '43641 Truax Way', '7594709159');

INSERT INTO Bank (Bank_ID, Bank_Name, Head_Office_Location, Head_Office_Contact) 
VALUES ('104', 'HarborNational', '9853 Union Drive', '9766480778');

INSERT INTO Bank (Bank_ID, Bank_Name, Head_Office_Location, Head_Office_Contact) 
VALUES ('105', 'SummitFinance Corporation', '16 Annamark Center', '8557896370');

INSERT INTO Bank (Bank_ID, Bank_Name, Head_Office_Location, Head_Office_Contact) 
VALUES ('106', 'Pioneer Credit Union', '84879 American Hill', '6375606833');

INSERT INTO Bank (Bank_ID, Bank_Name, Head_Office_Location, Head_Office_Contact) 
VALUES ('107', 'Evergreen Bank Group', '7368 Nelson Trail', '1252703629');

INSERT INTO Bank (Bank_ID, Bank_Name, Head_Office_Location, Head_Office_Contact) 
VALUES ('108', 'Crestview Financial Services', '2415 Crescent Oaks Court', '5488510741');

INSERT INTO Bank (Bank_ID, Bank_Name, Head_Office_Location, Head_Office_Contact) 
VALUES ('109', 'Horizon Trust Bank', '440 Di Loreto Junction', '9567375757');

INSERT INTO Branch (Branch_ID, Bank_ID, Branch_Name, Branch_Address, Phone) 
VALUES ('1', '100', 'Downtown Branch', '7231 Beilfuss Junction', '7164886544');

INSERT INTO Branch (Branch_ID, Bank_ID, Branch_Name, Branch_Address, Phone) 
VALUES ('2', '100', 'Main Street Branch', '835 Charing Cross Way', '6799243949');

INSERT INTO Branch (Branch_ID, Bank_ID, Branch_Name, Branch_Address, Phone) 
VALUES ('3', '100', 'City Center Branch', '7 Loeprich Park', '5311440973');

INSERT INTO Branch (Branch_ID, Bank_ID, Branch_Name, Branch_Address, Phone) 
VALUES ('4', '100', 'Suburbia Branch', '7721 Sugar Hill', '2593301431');

INSERT INTO Branch (Branch_ID, Bank_ID, Branch_Name, Branch_Address, Phone) 
VALUES ('5', '100', 'Central Plaza Branch ', '440 Muir Plaza', '1152013477');

INSERT INTO Branch (Branch_ID, Bank_ID, Branch_Name, Branch_Address, Phone) 
VALUES ('6', '100', 'Riverside Branch', '036 Straubel Terrace', '3472044007');

INSERT INTO Branch (Branch_ID, Bank_ID, Branch_Name, Branch_Address, Phone) 
VALUES ('7', '100', 'Hilltop Branch', '499 Hanson Court', '9934868003');

INSERT INTO Branch (Branch_ID, Bank_ID, Branch_Name, Branch_Address, Phone) 
VALUES ('8', '100', 'Sunset Boulevard Branch', '6 Bunker Hill Avenue', '2326973790');

INSERT INTO Branch (Branch_ID, Bank_ID, Branch_Name, Branch_Address, Phone) 
VALUES ('9', '100', 'Harbor View Branch', '1 Heffernan Place', '4552769569');

INSERT INTO Branch (Branch_ID, Bank_ID, Branch_Name, Branch_Address, Phone) 
VALUES ('10', '100', 'Willow Creek Branch', '2543 Delaware Drive', '3423423477');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('3', '100', 'Parrnell', 'Johnke', 'Chief Design Engineer', 'Temporary', '2019175575', 'dgideon1@live.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('3', '100', 'Didi', 'Noades', 'Registered Nurse', 'Temporary', '7077480213', 'diacovelli2@psu.edu');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('3', '100', 'Darlleen', 'Fouch', 'Research Assistant III', 'Temporary', '6759631339', 'khugo3@usatoday.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('3', '100', 'Ketty', 'Silbersak', 'Help Desk Technician', 'Temporary', '8823391508', 'ggolston4@vistaprint.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('4', '100', 'Greg', 'Jeffcock', 'Tax Accountant', 'Temporary', '8042063835', 'rstockall5@nytimes.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('4', '100', 'Rollins', 'Szachniewicz', 'Nurse Practicioner', 'Temporary', '9121430673', 'myitzhok6@opensource.org');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('6', '100', 'Melody', 'Vaines', 'Cost Accountant', 'Temporary', '2715462926', 'kbeadle7@nba.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('6', '100', 'Kaja', 'McNelly', 'Legal Assistant', 'Permanent', '6958081339', 'gderill8@wp.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('1', '100', 'Garnet', 'Lawlee', 'Information Systems Manager', 'Permanent', '4836009342', 'tproudlove9@nydailynews.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('1', '100', 'Ted', 'Fowells', 'Staff Accountant IV', 'Permanent', '9545191811', 'gflorencea@blogs.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('2', '100', 'Gaylord', 'Gipp', 'Chief Design Engineer', 'Permanent', '4156624137', 'hwoollastonb@abc.net.au');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('2', '100', 'Hurley', 'Arundale', 'General Manager', 'Permanent', '1073573493', 'lsommertonc@nifty.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('2', '100', 'Lamond', 'Lief', 'Account Representative II', 'Permanent', '6432356588', 'asikorskid@java.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('9', '100', 'Amby', 'Gebby', 'Structural Analysis Engineer', 'Permanent', '5458042801', 'asachnoe@gizmodo.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('9', '100', 'Araldo', 'Briiginshaw', 'Staff Accountant I', 'Permanent', '2685899798', 'tloggf@indiegogo.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('9', '100', 'Teodora', 'Bilverstone', 'Chemical Engineer', 'Permanent', '8902939642', 'gbasketterg@apple.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('10', '100', 'Gregor', 'Huburn', 'Software Consultant', 'Permanent', '1556666406', 'kjorinh@merriam-webster.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('5', '100', 'Karalee', 'Speek', 'VP Sales', 'Permanent', '5143873756', 'kjensoni@admin.ch');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('7', '100', 'Kata', 'Hubbock', 'Accounting Analyst IV', 'Permanent', '1906223228', 'rtesterj@cocolog-nifty.com');

INSERT INTO Employees (Branch_ID, Bank_ID, Employee_First_Name, Employee_Last_Name, Job_Title, Employee_Type, Phone, Mail_Id) 
VALUES ('8', '100', 'Randa', 'Warbey', 'Professor', 'Permanent', '3411223228', 'erwerj@cocolog-nifty.com');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('1', 'Individual');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('2', 'Individual');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('3', 'Individual');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('4', 'Individual');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('5', 'Individual');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('6', 'Individual');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('7', 'Individual');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('8', 'Individual');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('9', 'Individual');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('10', 'Individual');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('1', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('2', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('3', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('4', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('5', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('6', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('7', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('8', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('9', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('10', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('6', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('7', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('8', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('9', 'Business');

INSERT INTO Customer (Branch_ID, Customer_Type) 
VALUES ('10', 'Business');

INSERT INTO Customer_Individual (Customer_ID, Customer_First_Name, Customer_Last_Name, SSN, Address, Phone, Mail_ID, DOB, Gender, Nationality) 
VALUES ('50001', 'Daloris', 'Whitebrook', '831377562', '69033 Park Meadow Drive', '5831911500', 'dwhitebrook0@patch.com', '26-Aug-2007', 'Female', 'United States');

INSERT INTO Customer_Individual (Customer_ID, Customer_First_Name, Customer_Last_Name, SSN, Address, Phone, Mail_ID, DOB, Gender, Nationality) 
VALUES ('50002', 'Donnell', 'Kench', '794887347', '21332 Spenser Pass', '1012101422', 'dkench1@ehow.com', '13-Mar-2000', 'Male', 'United States');

INSERT INTO Customer_Individual (Customer_ID, Customer_First_Name, Customer_Last_Name, SSN, Address, Phone, Mail_ID, DOB, Gender, Nationality) 
VALUES ('50003', 'Keane', 'Croft', '684246379', '309 4th Street', '1322783404', 'kcroft2@smh.com.au', '13-Jun-2004', 'Male', 'United States');

INSERT INTO Customer_Individual (Customer_ID, Customer_First_Name, Customer_Last_Name, SSN, Address, Phone, Mail_ID, DOB, Gender, Nationality) 
VALUES ('50004', 'Taffy', 'Eastmead', '306430834', '767 Hudson Way', '8694426024', 'teastmead3@hc360.com', '18-Jun-2001', 'Female', 'United States');

INSERT INTO Customer_Individual (Customer_ID, Customer_First_Name, Customer_Last_Name, SSN, Address, Phone, Mail_ID, DOB, Gender, Nationality) 
VALUES ('50005', 'Kaleb', 'Meeland', '102280372', '293 Valley Edge Circle', '2251010034', 'kmeeland4@phoca.cz', '20-Nov-2004', 'Male', 'United States');

INSERT INTO Customer_Individual (Customer_ID, Customer_First_Name, Customer_Last_Name, SSN, Address, Phone, Mail_ID, DOB, Gender, Nationality) 
VALUES ('50006', 'Nanni', 'Alstead', '441110790', '13289 Prairie Rose Park', '7147975595', 'nalstead5@rediff.com', '18-Feb-2002', 'Female', 'United States');

INSERT INTO Customer_Individual (Customer_ID, Customer_First_Name, Customer_Last_Name, SSN, Address, Phone, Mail_ID, DOB, Gender, Nationality) 
VALUES ('50007', 'Teodorico', 'Muggeridge', '191283781', '46 Coolidge Junction', '7453580862', 'tmuggeridge6@google.cn', '09-Nov-2003', 'Male', 'United States');

INSERT INTO Customer_Individual (Customer_ID, Customer_First_Name, Customer_Last_Name, SSN, Address, Phone, Mail_ID, DOB, Gender, Nationality) 
VALUES ('50008', 'Stace', 'MacKomb', '747271588', '65327 Fordem Point', '6696174369', 'smackomb7@who.int', '11-oct-2000', 'Female', 'United States');

INSERT INTO Customer_Individual (Customer_ID, Customer_First_Name, Customer_Last_Name, SSN, Address, Phone, Mail_ID, DOB, Gender, Nationality) 
VALUES ('50009', 'Desmond', 'Gantlett', '219432074', '3 Blaine Terrace', '9555593545', 'dgantlett8@surveymonkey.com', '03-Sep-2004', 'Male', 'United States');

INSERT INTO Customer_Individual (Customer_ID, Customer_First_Name, Customer_Last_Name, SSN, Address, Phone, Mail_ID, DOB, Gender, Nationality) 
VALUES ('50010', 'Clovis', 'Ridings', '109928586', '3831 Huxley Lane', '8736827412', 'cridings9@cnbc.com', '13-Aug-1997', 'Female', 'United States');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50011 ','Tech Innovators Inc. ','123456789 ','123 Tech Lane, Silicon Valley ','9876543210 ','techinnovators@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50012 ','Data Dynamics Solutions ','987654321 ','456 Data Street, Cyber City ','9387399475 ','datadynamics@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50013 ','John Enterprises Ltd. ','863463884 ','789 Commerce Road, Tech Town ','9673267273 ','johnenterprise@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50014 ','Jack Technologies Inc. ','842868473 ','321 Code Avenue, Developer City ','9632537261 ','jacktech@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50015 ','Bryan Systems Solutions ','873674826 ','654 Byte Boulevard, Softwareville ','9665376225 ','bryansystem@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50016 ','James Innovations Corp. ','635372823 ','987 Algorithm Drive, Data Metropolis ','9834624532 ','jamesinoov@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50017 ','Deen Dynamics Tech Solutions ','228272662 ','789 Cloud Lane, Megadata City ','9763536375 ','deentech@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50018 ','Erving Technologies Ltd. ','745663782 ','543 Matrix Street, Code Capital ','9377343484 ','ervingtech@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50019 ','Perry Solutions Inc. ','637836238 ','876 Binary Avenue, Algorithm Megatown ','9836357625 ','perrysolu@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50020 ','Teja Tech Solutions ','567237833 ','234 JavaScript Street, Frontend City ','9536675727 ','tejatech@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50021 ','DataCraft Ltd. ','856389373 ','789 API Lane, Datatown ','9836636530 ','datacraft@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50022 ','CloudGenius Corp. ','756485759 ','123 Cloud Avenue, Cloud City ','9056737639 ','cloudcrop@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50023 ','InnoTech Solutions Ltd. ','647835689 ','456 Innovation Road, Innovatetown ','8363783833 ','innotechsol@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50024 ','CodeMasters Ltd. ','774784638 ','321 Code Lane, Codetropolis ','9373637863 ','codemasters@gmail.com');

INSERT INTO Customer_Business (Customer_ID, Company_Name, TIN, Company_Location, Company_Number, Company_Mail_ID) 
VALUES ('50025 ','BitWizards Inc. ','937493963 ','654 Bit Street, Wizardville ','7283783354 ','bitwizards@gmail.com');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50001','Savings','8364.74','2','Sophia Robinson','20-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50002','Checking','47442.33','1.5','Ethan Baker','3-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50003','Checking','47234.65','1.5','Ava Cooper','17-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50004','Savings','58584.34','2','Lucas Hill','18-Jul-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50005','Checking','44744.98','1.5','Aria Wright','6-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50006','Savings','87876.65','2','Oliver Reed','21-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50007','Savings','9373.67','2','Stella Mitchell','15-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50008','Savings','94357.67','2','Mason Evans','16-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50009','Checking','7745.35','1.5','Lily Perez','30-Jul-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50010','Checking','7748.98','1.5','Jackson Lee','21-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50011','Savings','6000','2','John Doe','19-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50012','Checking','5304.56','1.5','Jane Smith','18-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50013','Checking','47837.38','1.5','Samuel Johnson','7-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50014','Checking','76474.36','1.5','Emily Davis','23-Jul-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50015','Savings','8463.98','2','Michael Brown','28-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50016','Savings','10008.39','2','Olivia White','20-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50017','Checking','83893.37','1.5','Daniel Wilson','11-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50018','Checking','74644.37','1.5','Sophia Miller','15-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50019','Savings','63637.35','2','Ethan Taylor','29-Jul-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50020','Savings','33433.76','2','Ava Harris','21-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50021','Savings','35468.86','2','Noah Martin','5-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50022','Savings','36474.23','2','Liam Wilson','9-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50023','Checking','63637.67','1.5','Mia Turner','27-Jul-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50024','Checking','5453.65','1.5','Emma Johnson','12-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50025','Savings','76273.09','2','Aiden Davis','29-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50009','Savings','8475.35','1.5','Lily Perez','30-Jul-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50010','Savings','4268.98','1.5','Jackson Lee','21-Aug-2023');

INSERT INTO Account (Customer_ID, Account_Type, Account_Balance, Interest_Rate, Beneficiary, Opening_Date) 
VALUES ('50011','Checking','3483.63','2','John Doe','19-Aug-2023');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100001','2156986589754233', 'Debit', '123');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100002','5568974545931002', 'Debit', '234');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100003','2566698700123658', 'Debit', '345');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100004','1455698302587954', 'Debit', '407');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100005','1566897542150369', 'Debit', '208');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100006','4044675713292604', 'Debit', '225');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100007','4556698702333658', 'Debit', '902');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100008','4520012589633145', 'Debit', '554');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100009','5546588963212556', 'Debit', '658');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100010','4500123985745522', 'Debit', '458');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100011','1222569875236985', 'Debit', '989');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100012','0012214555895854', 'Debit', '001');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100013','1122566986633555', 'Debit', '244');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100014','4599887563258745', 'Debit', '221');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100015','7896325410236589', 'Debit', '898');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100016','4555689956181551', 'Debit', '221');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100017','2568785345451023', 'Debit', '224');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100018','0123369855478654', 'Debit', '445');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100019','2236985745236985', 'Debit', '007');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100020','1123568974101236', 'Debit', '200');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100021','1125698545698521', 'Debit', '221');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100022','1125896470236978', 'Debit', '904');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100023','4520012589633112', 'Debit', '514');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100024','5546588963222589', 'Debit', '653');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100025','4500123985724454', 'Debit', '459');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100001','2156986589752256', 'Credit', '122');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100002','5568974545978596', 'Credit', '201');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100003','2566698700145896', 'Credit', '965');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100004','1455698302512569', 'Credit', '456');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100005','1566897542101236', 'Credit', '012');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100006','4044675713278965', 'Credit', '266');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100007','4556698702301236', 'Credit', '996');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100008','4520012589645896', 'Credit', '536');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100009','5546588963215236', 'Credit', '696');

INSERT INTO cards (Account_Number, Card_Number, Card_Type, CVV) 
VALUES ('100010','4500123985799865', 'Credit', '478');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50001','6000.54','Vehicles','Alice Johnson','20-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50003','10000.65','Health','Benjamin Smith','1-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50004','20000.56','Life','Chloe Williams','4-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50008','3000.65','Vehicles','Daniel Brown','5-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50010','20000.57','Life','Jack Taylor','8-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50009','9000.45','Health','Finnegan Taylor','12-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50010','12000.98','Health','Grace Miller','15-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50005','20000.75','Life','Henry Wilson','16-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50002','11000.25','Health','Isabella Turner','9-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50002','20000.45','Life','Jack Martin','17-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50003','3000.15','Vehicles','Kayla Harris','25-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50006','15000.75','Health','Liam Red','24-Sep-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50007','4000.75','Vehicles','Mia White','4-Oct-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50007','20000.25','Life','Noah Anderson','2-Oct-2023');

INSERT INTO Insurance_Account (Customer_ID, Insurance_Amount, Insurance_Type, Nominee_name, Insurance_open_date) 
VALUES ('50001','20000.25','Health','Olivia Parker','6-Oct-2023');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50001','Personal','5000','5.5','12');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50002','Home','100000','4.25','120');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50003','Education','15000','6','24');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50004','Vehicles','30000','3.75','36');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50005','Personal','8000','6','18');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50006','Home','75000','4','84');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50007','Education','20000','5.25','36');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50008','Vehicles','40000','4.5','48');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50009','Personal','6000','5','12');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50010','Home','90000','4.75','96');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50004','Education','12000','5.75','18');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50003','Vehicles','35000','3.5','60');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50006','Personal','7000','4.8','24');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50001','Home','85000','4.2','72');

INSERT INTO Loan_Account (Customer_ID, Loan_Type, Loan_Amount, Interest_Rates, Tenure) 
VALUES ('50005','Education','18000','6.25','30');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100001','','50000001','5000.54','10-Oct-2023','Debit','Cash','0');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100002','102','','757','18-Oct-2023','Credit','Wire Transfers','0.5');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100003','','','975','19-Oct-2023','Credit','Wire Transfers','0.5');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100004','','','143.62','07-Oct-2023','Debit','Debit Card','2');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100005','','','106','26-Oct-2023','Debit','Debit Card','2');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100006','','','540.48','05-Oct-2023','Debit','Debit Card','0.01');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100007','','','500','12-Oct-2023','Credit','Cash','0');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100008','','','228.5','08-Oct-2023','Debit','Credit Card','2.5');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100009','','','102.63','20-Oct-2023','Debit','Debit Card','2');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100010','','','175.41','24-Oct-2023','Debit','Debit Card','2');

INSERT INTO Transactions(Account_number, Loan_number, Policy_number, Transaction_Amount, Transaction_Date, Transaction_Type, Payment_Type, Charges) 
VALUES('100011','','','1000','03-Oct-2023','Credit','Cash','0');

SELECT * FROM Bank;

SELECT * FROM Branch;

SELECT * FROM Employees;

SELECT * FROM Customer;

SELECT * FROM Customer_Individual;

SELECT * FROM Customer_Business;

SELECT * FROM Account;

SELECT * FROM Cards;

SELECT * FROM Insurance_Account;

SELECT * FROM Loan_Account;

SELECT * FROM Transactions;

SELECT t.Transaction_ID, t.Transaction_Amount, t.Transaction_Type,  
       a.Account_Number, a.Account_Type, a.Account_Balance  
FROM Transactions t  
JOIN Account a ON t.Account_Number = a.Account_Number  
WHERE t.Transaction_Amount > 500  
ORDER BY t.Transaction_Amount DESC;

SELECT C.CUSTOMER_ID, C.CUSTOMER_TYPE AS CUSTOMER_TYPE, NVL( (CUSTOMER_FIRST_NAME ||	CUSTOMER_LAST_NAME),COMPANY_NAME) AS CUSTOMER 
FROM Customer C 
LEFT JOIN Customer_Individual CI 
	ON C.CUSTOMER_ID = CI.CUSTOMER_ID 
    AND C.CUSTOMER_TYPE = 'Individual' 
LEFT JOIN Customer_Business CB 
	ON C.CUSTOMER_ID = CB.CUSTOMER_ID 
	AND C.CUSTOMER_TYPE = 'Business' 
ORDER BY C.CUSTOMER_TYPE , CUSTOMER;

SELECT b.Branch_Name, COUNT(c.Customer_ID) AS Total_Customers  
FROM Branch b  
LEFT JOIN Customer c ON b.Branch_ID = c.Branch_ID  
GROUP BY b.Branch_Name  
ORDER BY b.Branch_Name;

SELECT a.Account_Number, t.Transaction_ID, t.Transaction_Amount 
FROM Account a 
JOIN Transactions t ON a.Account_Number = t.Account_Number 
WHERE t.Transaction_Amount > ( 
    SELECT AVG(Transaction_Amount) 
    FROM Transactions 
) 
ORDER BY t.Transaction_Amount DESC;

SELECT DISTINCT c.Customer_Type, 
       COUNT(DISTINCT a.Account_Number) AS Total_Accounts, 
       MIN(a.Account_Balance) AS Min_Account_Balance, 
       MAX(a.Account_Balance) AS Max_Account_Balance, 
       SUM(t.Transaction_Amount) AS Total_Transaction_Amount 
FROM Customer c 
JOIN Account a ON c.Customer_ID = a.Customer_ID 
LEFT JOIN Transactions t ON a.Account_Number = t.Account_Number 
GROUP BY c.Customer_Type 
HAVING SUM(t.Transaction_Amount) > 500 
ORDER BY Total_Accounts DESC;

SELECT Account_Type, ROUND(AVG(Account_Balance),2) AS Avg_Balance  
FROM Account  
GROUP BY Account_Type;

DROP TABLE Bank CASCADE CONSTRAINTS;

DROP TABLE Branch CASCADE CONSTRAINTS;

DROP TABLE Employees CASCADE CONSTRAINTS;

DROP TABLE Customer CASCADE CONSTRAINTS;

DROP TABLE Customer_Individual CASCADE CONSTRAINTS;

DROP TABLE Customer_Business CASCADE CONSTRAINTS;

DROP TABLE Account CASCADE CONSTRAINTS;

DROP TABLE Cards CASCADE CONSTRAINTS;

DROP TABLE Insurance_Account CASCADE CONSTRAINTS;

DROP TABLE Loan_Account CASCADE CONSTRAINTS;

DROP TABLE Transactions CASCADE CONSTRAINTS;

CREATE TABLE Bank( 
	Bank_ID INTEGER NOT NULL, 
	Bank_Name VARCHAR2(30) NOT NULL, 
	Head_Office_Location VARCHAR2(100), 
	Head_Office_Contact NUMBER(10,0), 
	CONSTRAINT Bank_PK PRIMARY KEY (Bank_ID) 
);

CREATE TABLE Branch( 
	Branch_ID INTEGER NOT NULL, 
	Bank_ID INTEGER NOT NULL, 
	Branch_Name VARCHAR2(30) NOT NULL, 
	Branch_Address VARCHAR2(100), 
	Phone NUMBER(10,0), 
	CONSTRAINT Branch_PK PRIMARY KEY (Branch_ID), 
	CONSTRAINT Branch_FK FOREIGN KEY (Bank_ID) REFERENCES Bank(Bank_ID) 
);

CREATE TABLE Employees( 
	Employee_ID INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 1001 
		INCREMENT BY 1 
		MINVALUE 1001), 
	Branch_ID INTEGER NOT NULL, 
	Bank_ID INTEGER NOT NULL, 
	Employee_First_Name VARCHAR2(30) NOT NULL, 
	Employee_Last_Name VARCHAR2(30), 
	Job_Title VARCHAR2(30), 
	Employee_Type VARCHAR2(9) CHECK (Employee_Type IN ('Temporary','Permanent')), 
	Phone NUMBER(10,0), 
	Mail_Id VARCHAR2(30), 
	CONSTRAINT Employees_PK PRIMARY KEY (Employee_ID), 
	CONSTRAINT Employees_FK1 FOREIGN KEY (Bank_ID) REFERENCES Bank(Bank_ID) , 
	CONSTRAINT Employees_FK2 FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID) 
);

CREATE TABLE Customer ( 
	Customer_ID INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 50001 
		INCREMENT BY 1 
		MINVALUE 50001), 
	Branch_ID INTEGER, 
	Customer_Type VARCHAR2(10) CHECK (Customer_Type IN ('Individual','Business')), 
	CONSTRAINT Customer_PK PRIMARY KEY (Customer_ID), 
	CONSTRAINT Customer_FK FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID) 
);

CREATE TABLE Customer_Individual( 
	Customer_ID INTEGER NOT NULL, 
	Customer_First_Name VARCHAR2(30) NOT NULL , 
    Customer_Last_Name VARCHAR2(30) , 
	SSN NUMBER(9,0) , 
	Address VARCHAR2(100) , 
	Phone NUMBER(10,0) , 
	Mail_ID VARCHAR2(30) , 
	DOB DATE , 
	Gender VARCHAR2(6) , 
	Nationality VARCHAR2(30) , 
	CONSTRAINT Customer_Individual_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Customer_Business( 
	Customer_ID INTEGER NOT NULL, 
	Company_Name VARCHAR2(30) , 
	TIN NUMBER(9,0) , 
	Company_Location VARCHAR2(100) , 
	Company_Number NUMBER(10,0) , 
	Company_Mail_ID VARCHAR2(30) , 
	CONSTRAINT Customer_Business_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Account( 
	Account_Number INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 100001 
		INCREMENT BY 1 
		MINVALUE 100001), 
	Customer_ID INTEGER NOT NULL, 
	Account_Type VARCHAR2(8) CHECK (Account_Type IN ('Savings','Checking')), 
	Account_Balance DECIMAL(15,2), 
	Interest_Rate DECIMAL(5, 2), 
	Beneficiary VARCHAR2(60), 
	Opening_Date DATE DEFAULT SYSDATE, 
	CONSTRAINT Account_PK PRIMARY KEY (Account_Number), 
	CONSTRAINT Account_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Cards( 
	Account_Number INTEGER NOT NULL, 
	Card_Number INTEGER NOT NULL, 
	Card_Type VARCHAR2(6) CHECK (Card_Type IN ('Debit','Credit')) NOT NULL, 
	CVV INTEGER NOT NULL, 
	CONSTRAINT Cards_FK FOREIGN KEY (Account_Number) REFERENCES Account (Account_Number) 
);

CREATE TABLE Insurance_Account ( 
	Policy_Number INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 50000001 
		INCREMENT BY 1 
		MINVALUE 50000001), 
	Customer_ID INTEGER, 
	Insurance_Amount DECIMAL(15, 2), 
	Insurance_Type VARCHAR2(8) CHECK(Insurance_Type IN('Vehicles','Health','Life')), 
	Nominee_name VARCHAR2(60), 
	Insurance_open_date DATE DEFAULT SYSDATE, 
	CONSTRAINT Insurance_Account_PK PRIMARY KEY (Policy_Number), 
	CONSTRAINT Insurance_Account_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Loan_Account ( 
	Loan_Number INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 101 
		INCREMENT BY 1 
		MINVALUE 101), 
	Customer_ID INTEGER, 
	Loan_Type VARCHAR2(9) CHECK (Loan_Type IN ('Personal','Home','Education','Vehicles')), 
	Loan_Amount DECIMAL(15, 2), 
	Interest_Rates DECIMAL(5, 2), 
	Tenure DECIMAL(5, 2), 
	CONSTRAINT Loan_Account_PK PRIMARY KEY (Loan_Number), 
	CONSTRAINT Loan_Account_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Transactions ( 
	Transaction_ID INTEGER GENERATED ALWAYS AS IDENTITY 
		(START WITH 1 
		INCREMENT BY 1 
		MINVALUE 1), 
	Account_Number INTEGER NOT NULL, 
	Loan_Number INTEGER, 
	Policy_Number INTEGER, 
	Transaction_Amount DECIMAL(15,2), 
	Transaction_Date TIMESTAMP(6) DEFAULT SYSDATE, 
	Transaction_Type VARCHAR2(6) CHECK (Transaction_Type IN ('Credit','Debit')), 
	Payment_Type VARCHAR2(14) CHECK (Payment_Type IN ('Cash','Debit Card','Credit Card', 'Net 
	Banking','Wire Transfers')), 
	Charges DECIMAL(15,2), 
	CONSTRAINT Transaction_PK PRIMARY KEY (Transaction_ID), 
	CONSTRAINT Transaction_FK1 FOREIGN KEY (Account_Number) REFERENCES Account(Account_Number), 
	CONSTRAINT Transaction_FK2 FOREIGN KEY (Loan_Number) REFERENCES Loan_Account(Loan_Number), 
	CONSTRAINT Transaction_FK3 FOREIGN KEY (Policy_Number) REFERENCES Insurance_Account(Policy_Number) 
);

