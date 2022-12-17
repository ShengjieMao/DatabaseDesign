USE "Team18_22fall"

GO

--create tables:


CREATE TABLE "Patient" (
  PatientId INT NOT NULL,
  Lastname varchar(30) NOT NULL,
  Firstname varchar(30) NOT NULL,
  BirthDate Date NOT NULL,
  Address1 varchar(100),
  Address2 varchar(100),
  PhoneNo varchar(10) CHECK(PhoneNo like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL,
  Gender varchar(30),
  EmergencyContact varchar(10) CHECK(EmergencyContact like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  Zipcode varchar(5) CHECK(Zipcode like '[0-9][0-9][0-9][0-9][0-9]'),
  InsuranceId INT,
  PRIMARY KEY (PatientId),
  FOREIGN KEY (InsuranceId) REFERENCES Insurance(InsuranceID)
);

CREATE TABLE Appointment  (
  AppoinmentID INT NOT NULL,
  PatientID  INT NOT NULL,
  StaffID INT NOT NULL,
  AppointmentDate DATE NOT NULL,
  Symptom VARCHAR(500),
  PRIMARY KEY (AppoinmentID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
  FOREIGN KEY (PatientID) REFERENCES Patient(PatientId)
);

CREATE TABLE MedicalRecord (
  ID INT NOT NULL,
  PatientID INT NOT NULL,
  StaffID INT NOT NULL,
  Symptom VARCHAR(500),
  Prescription VARCHAR(500),
  PharmacyID INT,
  Date DATE NOT NULL,
  Cost INT NOT NULL,
  TreatmentID INT ,
  PRIMARY KEY (ID),
  FOREIGN KEY (PatientID) REFERENCES Patient(PatientId),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
  FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID),
  FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID)
);

CREATE TABLE dbo.Supplier (
  SupplierID  INT NOT NULL PRIMARY KEY ,
  SupplierName VARCHAR(100) NOT NULL,
  ContactEmail VARCHAR(100) NOT NULL UNIQUE,
  ContactPhoneNo VARCHAR(10) NOT NULL,
  Address1 VARCHAR(150) NOT NULL,
  Address2 VARCHAR(150) NOT NULL,
  Zipcode VARCHAR(5) NOT NULL,
  Category VARCHAR(10) NOT NULL,
 -- FOREIGN KEY (SupplierID) REFERENCES dbo.Product(SupplierID)
);

CREATE TABLE dbo.Product (
  ProductID INT NOT NULL PRIMARY KEY,
  ProductName VARCHAR(100) NOT NULL,
  Price INT NOT NULL,
  SupplierID INT NOT NULL,
  FOREIGN KEY (SupplierID) REFERENCES dbo.Supplier(SupplierID)
);

CREATE TABLE dbo.Purchase (
  ProductID INT NOT NULL,
  Date Date NOT NULL,
  ClinicID INT NOT NULL,
  Amount INT NOT NULL,
  PurchaseID INT NOT NULL PRIMARY KEY,
  FOREIGN KEY (ClinicID) REFERENCES dbo.Clinic(ClinicID),
  FOREIGN KEY (ProductID) REFERENCES dbo.Product(ProductID)
);

CREATE TABLE Treatment
(
  TreatmentID INT NOT NULL,
  Date DATE NOT NULL,
  NameofTreatment VARCHAR(50) NOT NULL,
  PatientID INT NOT NULL,
  DentistID INT NOT NULL,
  NurseID INT NOT NULL,
  ProcessOfTreatment VARCHAR(30) NOT NULL,
  PRIMARY KEY (TreatmentID),
  FOREIGN KEY (PatientID) REFERENCES Patient(PatientId),
  FOREIGN KEY (DentistID) REFERENCES Dentist(StaffID),
  FOREIGN KEY (NurseID) REFERENCES Nurse(StaffID)
);

CREATE TABLE Pharmacy
(
  PharmacyID INT NOT NULL,
  PharmacyName VARCHAR(30) NOT NULL,
  PharmacyAddress1 VARCHAR(50) NOT NULL,
  PharmacyAddress2 VARCHAR(50),
  PharmacyZipcode INT NOT NULL,
  PharmacyPhoneNo BIGINT  NOT NULL,
  PRIMARY KEY (PharmacyID),
  CONSTRAINT PharmacyPhoneNo CHECK(PharmacyPhoneNo like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  CONSTRAINT PharmacyZipcode CHECK(PharmacyZipcode like '[0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE Clinic
(
  ClinicID INT NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Zipcode INT NOT NULL,
  Revenue INT NOT NULL,
  Address1 VARCHAR(50) NOT NULL,
  Address2 VARCHAR(50) NOT NULL,
  PRIMARY KEY (ClinicID),
  CONSTRAINT ClinicZipco CHECK(Zipcode like '[0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE Staff
(
	StaffID INT NOT NULL, 
	LastName VARCHAR(30), 
	FirstName VARCHAR(30), 
	BirthDate DATE,
	Address1 VARCHAR(100),
	Address2 VARCHAR(100),
	PhoneNo VARCHAR(10) UNIQUE,
	Position VARCHAR(30),
	SALARY VARCHAR(20),
	Clinicid INT NOT NULL,
	ZipCode VARCHAR(5),
	CONSTRAINT CK_PHONE CHECK(PhoneNo like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CONSTRAINT CK_ZipCode CHECK(ZipCode like '[0-9][0-9][0-9][0-9][0-9]'),
	PRIMARY KEY(StaffID),
	FOREIGN KEY(Clinicid) REFERENCES Clinic(ClinicID)
);

CREATE TABLE Nurse
(
	StaffID INT NOT NULL PRIMARY KEY,
	Speciality VARCHAR(50),
	Language VARCHAR(20),
	WorkingDay VARCHAR(15),
	RoomNo INT NOT NULL
	FOREIGN KEY(StaffID) REFERENCES Staff(StaffID) 
);

CREATE TABLE Dentist
(
	StaffID INT NOT NULL PRIMARY KEY,
	Speciality VARCHAR(50),
	Language VARCHAR(20),
	WorkingDay VARCHAR(15),
	RoomNo INT NOT NULL, 
	NurseID INT NOT NULL,
	FOREIGN KEY(StaffID) REFERENCES Staff(StaffID),
	FOREIGN KEY(NurseID) REFERENCES Nurse(StaffID)
);

CREATE TABLE dbo.InsuranceCompany (
  InsuranceCompanyID int not null,
  InsuranceCompanyName varchar(50) not null,
  Contact varchar(10) not null,
  Address1 varchar(100) not null,
  Address2 varchar(100) not null,
  ZipCode varchar(5) not null,
  CONSTRAINT ck_zip check ([ZipCode] LIKE REPLICATE('[0-9,-]', 5)),
  PRIMARY KEY (InsuranceCompanyID)
);

CREATE TABLE dbo.Insurance (
  InsuranceID int not null,
  PlanName varchar(50) not null,
  CompanyID int not null,
  HighestCover int not null,
  ExpiredDate date not null,
  PayMethod varchar(30) not null,
  PRIMARY KEY (InsuranceID),
  FOREIGN KEY (CompanyID) REFERENCES InsuranceCompany(InsuranceCompanyID)
);



--insert data:

INSERT INTO Patient
VALUES (1,'Jackson','Mike','1999-02-01','203 First Ave.','','4313453213','Male','4313453213','02133',1);
INSERT INTO Patient
VALUES (2,'Swift','Linda','1963-02-01','10 Second St.','','4351344138','Female','2134456773','03124',6);
INSERT INTO Patient
VALUES (3,'Williams','John','1975-08-25','241 Tully St.','','3136683207','Male','3136683207','02175',3);
INSERT INTO Patient
VALUES (4,'Stroble','Bonnie','1984-10-03','3707 Benson Park Drive','','4054011356','Female','3136683207','03109',1);
INSERT INTO Patient
VALUES (5,'Reed','John','1974-06-07','2259 Hazelwood Avenue','','5153652686','Male','5153652686','03209',2);
INSERT INTO Patient
VALUES (6,'Martinez','Eric','1987-06-19','2265 Bingamon Road','','4404891409','Male','5105922474','44113',2);
INSERT INTO Patient
VALUES (7,'Garrity','Joann','1999-11-09','3594 Caldwell Road','','5853182240','Female','5853182240','14202',9);
INSERT INTO Patient
VALUES (8,'Maddy','Salvador','1940-09-12','35 Canis Heights Drive','','2136167035','Male','2136167035','92705',2);
INSERT INTO Patient
VALUES (9,'Wyman','Skye','1948-02-17','1069 Bernardo Street','','8129257340','Female','5084296235','47610',7);
INSERT INTO Patient
VALUES (10,'Collins','Michele','1985-10-17','1832 Cost Avenue','','3014295049','Female','9722308658','20706',3);




INSERT INTO Appointment
VALUES(1,1,1,'2022-07-10','Pain in teech')
INSERT INTO Appointment
VALUES(2,1,1,'2023-01-15','Tooth sensitivity.')
INSERT INTO Appointment
VALUES(3,3,1,'2022-06-22','Mild pain when eating or drinking something sweet, hot or cold.')
INSERT INTO Appointment
VALUES(4,6,4,'2023-01-10','Visible or pits in teeth.')
INSERT INTO Appointment
VALUES(5,9,6,'2023-01-20','Brown staining on surface of a tooth.')
INSERT INTO Appointment
VALUES(6,2,8,'2022-09-11','Pain when biting down.')
INSERT INTO Appointment
VALUES(7,2,8,'2022-12-20','Pain that interferes with daily living')
INSERT INTO Appointment
VALUES(8,5,17,'2022-9-20','Chipped Tooth')
INSERT INTO Appointment
VALUES(9,8,17,'2023-01-02','hyperdontia')
INSERT INTO Appointment
VALUES(10,10,20,'2022-11-12','Gap Between Teeth')



INSERT INTO MedicalRecord
VALUES(1,1,1,'Bleeding Teeth','Cleaning teeth',NULL,'2022-02-20',200,1)
INSERT INTO MedicalRecord
VALUES(2,7,26,'Gap Between Teeth','Treat dental caries',NULL,'2022-11-25',2000,7)
INSERT INTO MedicalRecord
VALUES(3,3,8,'Bleeding Teeth','Cleaning teeth',NULL,'2022-02-22',200,4)
INSERT INTO MedicalRecord
VALUES(4,2,20,'Pain in teech','Anti-pain pills',1,'2022-02-20',34,NULL)
INSERT INTO MedicalRecord
VALUES(5,1,8,'Pain in teech','Avoid eating hard food',NULL,'2022-02-20',73,NULL)
INSERT INTO MedicalRecord
VALUES(6,3,10,'Holes in teeth','Extract the tooth',NULL,'2022-02-23',1560,5)
INSERT INTO MedicalRecord
VALUES(7,2,6,'Bleeding Teeth','Cleaning teeth',NULL,'2022-02-22',200,2)
INSERT INTO MedicalRecord
VALUES(8,5,17,'Bleeding Teeth','Cleaning teeth',NULL,'2022-11-23',200,6)
INSERT INTO MedicalRecord
VALUES(9,10,2,'Holes in teeth','Extract the tooth',NULL,'2022-02-21',2302,4)
INSERT INTO MedicalRecord
VALUES(10,6,20,'Holes in teeth','Treat dental caries',NULL,'2022-11-25',3000,7)


insert into Supplier values(000881, 'Medental', 'medental@gmail.com', '6178888657', '16B, Smith Street Boston', 'Chicago, IL', '60007', 'level1');
insert into Supplier values(000882, 'CrownMed', 'crownMed@gmail.com', '8573186401', '104C, Ward Street', 'Detroit, MI', '48208', 'level1');
insert into Supplier values(000883, 'Hiossen', 'hiossen@gmail.com', '8573186403', '15B, Smith Street', 'New York, NY', '10001', 'level2');
insert into Supplier values(000884, 'Sammed', 'sammed@gmail.com', '8563452348', '19A, Parker Street', 'Columbus, OH', '43068', 'level2');
insert into Supplier values(000885, 'Envista', 'envista@gmail.com', '8563452349', '360B, Huntington Avenue', 'Boston, MA', '02115', 'level3');
insert into Supplier values(000886, 'KaVo Group', 'kavo@gmail.com', '8563452311', '12A, England Street', 'Newark, NJ', '07107', 'level3');
insert into Supplier values(000887, 'Biberach', 'biberach@gmail.com', '8563452313', '320B, Newburry Street', 'Philadelphia, PA', '19099', 'level3');
insert into Supplier values(000888, 'Straumann', 'straumann@gmail.com', '8563452314', '320A, Stetson Street', 'Atlanta, GA', '30311', 'level4');
insert into Supplier values(000889, 'Nordent', 'nordent@gmail.com', '8573186408', '60F, New England Street', 'Baltimore, MD', '21213', 'level5');
insert into Supplier values(000890, 'Lexicon', 'lexicon@gmail.com', '8573788648', '133E, West Village', 'Seattle, WA', '98101', 'level5');

insert into Product values(000660, 'dental basin', 45, 000881);
insert into Product values(000661, 'dental cream', 38, 000882);
insert into Product values(000662, 'full metal crown', 610, 000883);
insert into Product values(000663, 'dental chair', 500, 000884);
insert into Product values(000664, 'model', 55, 000885);
insert into Product values(000665, 'S.S.wire clasp', 79, 000886);
insert into Product values(000666, 'oeclusal', 128, 000887);
insert into Product values(000667, 'Anterior', 229, 000888);
insert into Product values(000668, 'gum procelain', 66, 000889);
insert into Product values(000669, 'dental bone file', 23, 000890);

insert into Purchase values(000660, '2022-04-15 9:16:20', 1, 1020, 000478);
insert into Purchase values(000661, '2022-04-16 10:15:20', 2, 700, 000479);
insert into Purchase values(000662, '2022-04-23 19:15:56', 3, 2300, 000480);
insert into Purchase values(000663, '2022-04-15 17:18:45', 4, 4000, 000481);
insert into Purchase values(000664, '2022-04-23 10:27:55', 5, 1980, 000482);
insert into Purchase values(000665, '2022-04-14 8:15:20', 6, 3400, 000483);
insert into Purchase values(000666, '2022-04-15 17:18:45', 7, 1520, 000484);
insert into Purchase values(000667, '2022-04-23 10:28:55', 8, 178, 000485);
insert into Purchase values(000668, '2022-04-21 21:17:19', 9, 2000, 000486);
insert into Purchase values(000669, '2022-05-01 5:14:20', 10, 500, 000487);


/* INSERT SCRIPT FOR Treatment */
INSERT INTO Treatment VALUES(000001,'2022-2-20','teeth cleaning',000001,000001,000003,'finished');
INSERT INTO Treatment VALUES(000002,'2022-2-21','extract a tooth',000010,000002,000004,'finished');
INSERT INTO Treatment VALUES(000003,'2022-2-22','teeth cleaning',000002,000006,000005,'finished');
INSERT INTO Treatment VALUES(000004,'2022-2-22','teeth cleaning',000003,000008,000009,'finished');
INSERT INTO Treatment VALUES(000005,'2022-2-23','extract a tooth',000003,000010,000013,'finished');
INSERT INTO Treatment VALUES(000006,'2022-11-23','teeth cleaning',000005,000017,000018,'finished');
INSERT INTO Treatment VALUES(000007,'2022-11-25','Treat dental caries',000006,000020,000037,'finished');
INSERT INTO Treatment VALUES(000008,'2022-11-25','Treat dental caries',000007,000026,000041,'finished');
INSERT INTO Treatment VALUES(000009,'2022-11-27','teeth cleaning',000008,000043,000055,'on progress');
INSERT INTO Treatment VALUES(000010,'2022-11-27','teeth cleaning',000009,000066,000088,'on progress');

/* INSERT SCRIPT FOR Pharmacy */
INSERT INTO dbo.Pharmacy VALUES(000001, 'GoodHealth', '6414 NE Bothell Way','N/A',98110,4254867111);
INSERT INTO Pharmacy VALUES(000002, 'StayHealth', '6415 NE Bird Way','N/A',98111,4255567312);
INSERT INTO Pharmacy VALUES(000003, 'TeethHealth', '6424 NE Birlinton Way','N/A',98112,3124867221);
INSERT INTO Pharmacy VALUES(000004, 'GoodTeath', '6414 NE Sunside St','Room 210',98113,4254294655);
INSERT INTO Pharmacy VALUES(000005, 'Hui.Parm', '933 Denny Road','N/A',98226,4254842713);
INSERT INTO Pharmacy VALUES(000006, 'Hu.Parm', '1333 Summer St','N/A',98178,4245867114);
INSERT INTO Pharmacy VALUES(000007, 'Bartel.Parm', '116 Westlake S','N/A',98377,2064867229);
INSERT INTO Pharmacy VALUES(000008, 'Karen Parm', '225 2nd Ave','N/A',98412,2087767178);
INSERT INTO Pharmacy VALUES(000009, 'Rite Parm', '289 Robinhood St','N/A',98512,4230484721);
INSERT INTO Pharmacy VALUES(000010, 'Nancy Parm', '726 Woodland Ave','N/A',98234,4254867000);


/* INSERT SCRIPT FOR Clinic */
INSERT INTO Clinic VALUES(000001, 'Katemine Clinic', 98110,4209775,'800 NE 42ND ST','N/A');
INSERT INTO Clinic VALUES(000002, 'Karen Clinic', 98225,5557654,'5000 25TH AVE','N/A');
INSERT INTO Clinic VALUES(000003, 'Musk Clinic', 98150,1234567,'5001 NE PARK PL','N/A');
INSERT INTO Clinic VALUES(000004, 'Jacob Clinic', 98556,7654321,'1001 BROADWAY','N/A');
INSERT INTO Clinic VALUES(000005, 'Lucy Clinic', 98145,2345678,'2700 4TH AVE','N/A');
INSERT INTO Clinic VALUES(000006, 'One Clinic', 97119,8765432,'1018 S 99TH PL','N/A');
INSERT INTO Clinic VALUES(000007, 'The Clinic', 98020,345678,'1230 5TH AVE','N/A');
INSERT INTO Clinic VALUES(000008, 'SLU Clinic', 98089,9876543,'588 BELL ST','N/A');
INSERT INTO Clinic VALUES(000009, 'UV Clinic', 98398,4567890,'3024 NE 143RD ST','N/A');
INSERT INTO Clinic VALUES(000010, 'Benson Clinic', 98198,98765432,'901 E ROANOKE ST','N/A');

INSERT INTO Staff VALUES(000001, 'Messi', 'Leo', '1987-06-24', '10 Av.d I¨¦na, 75116 Paris, France', '', '6663332222', 'Dentist', '140000', 000001, '02199');
INSERT INTO Staff VALUES(000003, 'Annabelle', 'Wallis', '1984-09-05', 'Coolhurst Rd, London, United Kingdom', '', '6663331111', 'Nurse', '65000', 000001, '88001');


INSERT INTO Staff VALUES(000002, 'Fricks', 'Adam', '1991-08-24', '2479 Chipmunk Lane', 'Kingfield, ME', '6779000111', 'Dentist', '130000', 000002, '04947');
INSERT INTO Staff VALUES(000004, 'Cox', 'Patricia', '1942-01-20', '102 Carter Street', 'Bartelso, IL', '3583439823', 'Nurse', '66000', 000002, '62218');
INSERT INTO Staff VALUES(000006, 'Foster', 'James', '2000-01-21', '4370 Roosevelt Road', 'Garden City, KS', '6202604750', 'Dentist', '110000', 000003, '67846');
INSERT INTO Staff VALUES(000005, 'Blackburn', 'Ramon', '1977-05-25', '184 Sheila Lane', 'Sparks, NV', '7754769754', 'Nurse', '65500', 000003, '95826');
INSERT INTO Staff VALUES(000008, 'Barnes', 'Jaime', '1974-03-15', '1333 Prospect Valley Road', 'Los Angeles, CA', '3109832539', 'Dentist', '135000', 000004, '90067');
INSERT INTO Staff VALUES(000009, 'Sousa', 'Benjamin', '1942-02-10', '4251 Farland Street', 'Chicago, IL', '7739345988', 'Nurse', '55000', 000004, '60631');
INSERT INTO Staff VALUES(000010, 'Moss', 'Rachelle', '1986-08-13', '1450 Timber Ridge Road', 'Sacramento, CA', '9168432045', 'Dentist', '98000', 000005, '95827');
INSERT INTO Staff VALUES(000013, 'Autry', 'Susan', '1996-02-10', '2341 Timber Oak Drive', 'Lubbock, TX', '8062013482', 'Nurse', '57000', 000005, '79401');
INSERT INTO Staff VALUES(000017, 'Gill', 'Debbra', '1939-08-01', '3347 Lawman Avenue', 'Falls Church, VA', '7032063524', 'Dentist', '184000', 000006, '22042');
INSERT INTO Staff VALUES(000018, 'Teegarden', 'Jesus', '1973-05-18', '4221 Charles Street', 'Southfield, MI', '7345087166', 'Nurse', '54000', 000006, '48075');
INSERT INTO Staff VALUES(000043, 'Flowers', 'Eric', '1943-06-13', '1910 Crim Lane', 'Brookville, OH', '9378332173', 'Dentist', '240000', 000007, '45309');
INSERT INTO Staff VALUES(000055, 'Montes', 'Pablo', '1975-06-18', '561 Carson Street', 'Lexington, KY', '8592685128', 'Nurse', '55000', 000007, '40502');
INSERT INTO Staff VALUES(000026, 'Cartwright', 'Erica', '2000-07-20', '3092 Fairfax Drive', 'Red Bank, NJ', '9089139969', 'Dentist', '146000', 000008, '07701');
INSERT INTO Staff VALUES(000037, 'Mathison', 'Teresa', '1986-12-03', '1823 Oakmound Road', 'Chicago, IL', '7733044002', 'Nurse', '69000', 000008, '60603');
INSERT INTO Staff VALUES(000020, 'Smith', 'Jonathan', '1963-11-21', '697 May Street', 'Sharpsburg, KY', '6062479386', 'Dentist', '175000', 000009, '40374');
INSERT INTO Staff VALUES(000070, 'Ortega', 'Hazel', '2002-10-30', '2196 Patterson Road', 'Brooklyn, NY', '7188530371', 'Nurse', '70000', 000009, '11219');
INSERT INTO Staff VALUES(000066, 'Clark', 'Robert', '1961-09-25', '3898 Upton Avenue', 'North Deering, ME', '2078786606', 'Dentist', '137000', 000010, '04103');
INSERT INTO Staff VALUES(000088, 'Ochoa', 'Kristin', '1976-05-26', '3796 Hinkle Lake Road', 'Boston, MA', '6175177194', 'Nurse', '59000', 000010, '02110');
INSERT INTO Staff VALUES(000101, 'Blakeney', 'Jane', '1984-03-09', '4938 Villa Drive', 'South Bend, IN', '5742818241', 'Nurse', '60000', 000010, '46625');
INSERT INTO Staff VALUES(000041, 'Black', 'Josephine', '1958-04-12', '1849 Diamond Street', 'Charlotte, NC', '8284751138', 'Nurse', '75000', 000007, '28217');
INSERT INTO Staff VALUES(000109, 'Giuliani', 'Elizabeth', '1961-12-21', '158 Bird Street', 'Nara Visa, NM', '5056333450', 'Nurse', '48000', 000008, '88430');
INSERT INTO Staff VALUES(000080, 'Fox', 'Gladys ', '2003-06-11', '2486 Sheila Lane', 'Las Vegas, NV', '7755401945', 'Nurse', '80000', 000009, '89101');
INSERT INTO Staff VALUES(000096, 'Keech', 'Phyllis', '1976-12-28', '471 Rosewood Lane', 'New York, NY', '2129565515', 'Nurse', '71000', 000001, '10019');
INSERT INTO Staff VALUES(000205, 'Hall', 'Sherri', '1998-03-21', '4438 Tree Frog Lane', 'Lonejack, MO', '8165664642', 'Nurse', '57000', 000002, '64070');
INSERT INTO Staff VALUES(000113, 'Herren', 'Faith', '1957-01-13', '3178 Sardis Sta', 'Euless, TX', '8176147968', 'Nurse', '45000', 000001, '76039');
INSERT INTO Staff VALUES(000654, 'Seman', 'Mary', '1975-01-11', '60 Wilkinson Street', 'Nashville, TN', '6153833585', 'Nurse', '56000', 000003, '37212');
INSERT INTO Staff VALUES(000158, 'York', 'Shanna', '1964-04-21', '4325 Copperhead Road', 'Hartford, CT', '8605983362', 'Nurse', '70000', 000002, '06103');
INSERT INTO Staff VALUES(000226, 'Thompson', 'Peter', '1956-06-14', '156 Cherry Tree Drive', 'Jacksonville, FL', '9042835968', 'Dentist', '129000', 000001, '32257');
INSERT INTO Staff VALUES(000255, 'Giuliani', 'Fred', '1946-01-06', '2108 River Road', 'Pueblo, CO', '7195623245', 'Dentist', '146000', 000009, '81003');
INSERT INTO Staff VALUES(000718, 'Frazier', 'Bob', '1977-05-07', '1120 Church Street', 'New York, NY', '7184077349', 'Dentist', '146000', 000010, '10017');


--Insert Sales(6)
INSERT INTO Staff VALUES(000801, 'Malone', 'Hope', '1956-12-22', '924 Benson Park Drive', 'Oklahoma City, OK', '4054096011', 'Sales', '76000', 000010, '10017');
INSERT INTO Staff VALUES(000802, 'Vasquez', 'Steven', '1987-10-08', '3740 Station Street', 'Walnut Creek, CA', '5109438797', 'Sales', '86000', 000001, '94597');
INSERT INTO Staff VALUES(000803, 'Lewis', 'Otis', '1982-05-31', '2778 Bubby Drive', 'Smithville, TX', '5123601136', 'Sales', '67000', 000003, '78957');
INSERT INTO Staff VALUES(000804, 'Mallard', 'Pauline', '1977-05-07', '2429 Jody Road', 'Lansdowne, PA', '6106261033', 'Sales', '105000', 000004, '19050');
INSERT INTO Staff VALUES(000805, 'Cleveland', 'Amanda', '1976-05-07', '2586 Big Elm', 'Overland Park, MO', '8168248673', 'Sales', '95000', 000009, '64110');
INSERT INTO Staff VALUES(000806, 'Burnett', 'Christina', '1978-01-29', '913 Marion Drive', 'Tampa, FL', '8133728052', 'Sales', '88000', 000008, '33619');



--Insert Accounts(7)
INSERT INTO Staff VALUES(000901, 'Campbell', 'Andrew', '1969-10-09', '1797 Maple Street', 'Anaheim, CA', '7142811644', 'Account', '60000', 000001, '92807');
INSERT INTO Staff VALUES(000902, 'Vasquez', 'Steven', '1987-10-08', '3740 Station Street', 'Orlando, FL', '4078567183', 'Account', '78000', 000002, '32809');
INSERT INTO Staff VALUES(000903, 'Romero', 'Richard', '1977-11-06', '1258 Calico Drive', 'Kennewick, WA', '5096282726', 'Account', '65000', 000003, '99336');
INSERT INTO Staff VALUES(000904, 'Laine', 'Dayna', '1957-09-03', '1270 Hillside Drive', 'North Billerica, MA', '3392272075', 'Account', '55000', 000004, '01862');
INSERT INTO Staff VALUES(000905, 'Richey', 'Clarence', '1980-04-30', '2414 Illinois Avenue', 'Portland, OR', '5037057420', 'Account', '95000', 000005, '97205');
INSERT INTO Staff VALUES(000906, 'Masters', 'Gertrude', '1985-10-23', '1526 Oakwood Avenue', 'New York, NY', '2126453169', 'Account', '87000', 000006, '10011');
INSERT INTO Staff VALUES(000907, 'Barker', 'Sarah', '1986-01-10', '2309 Woodstock Drive', 'El Monte, CA', '6264502302', 'Account', '70000', 000007, '91731');
INSERT INTO Staff VALUES(000908, 'Connors', 'Kara', '1997-11-24', '3011 Cherry Ridge Drive', 'Mount Clemens, MI', '5862470427', 'Account', '95000', 000008, '48044');
INSERT INTO Staff VALUES(000909, 'Stevens', 'Racquel', '1977-08-27', '962 Hidden Meadow Drive', 'Fredonia, ND', '7016985479', 'Account', '104000', 000009, '58440');
INSERT INTO Staff VALUES(000910, 'Decarlo', 'Claudia', '1979-01-08', '3781 Mutton Town Road', 'Kingston, WA', '3606381389', 'Account', '79000', 000010, '98346');


INSERT INTO Nurse VALUES(000003, 'Critical Care',  'English', '02-04', 000051);
INSERT INTO Nurse VALUES(000004, 'Emergency Care',  'French, English', '02-04', 000001);
INSERT INTO Nurse VALUES(000005, 'Emergency Care',  'English', '02-04', 000002);
INSERT INTO Nurse VALUES(000009, 'Emergency Care',  'English, Chinese', '02-04', 000003);
INSERT INTO Nurse VALUES(000013, 'Emergency Care',  'English', '02-04', 000004);
INSERT INTO Nurse VALUES(000018, 'Critical Care',  'English, Japanese', '02-04', 000005);
INSERT INTO Nurse VALUES(000037, 'Critical Care',  'English, Spain', '02-04', 000006);
INSERT INTO Nurse VALUES(000041, 'Critical Care',  'French, Korean', '01-04', 000007);
INSERT INTO Nurse VALUES(000055, 'Critical Care',  'English', '01-04', 000008);
INSERT INTO Nurse VALUES(000070, 'Specific Disease Care',  'English', '01-04', 000009);
INSERT INTO Nurse VALUES(000080, 'Specific Disease Care',  'English, German', '01-04', 000010);
INSERT INTO Nurse VALUES(000088, 'Specific Disease Care',  'English', '01-04', 000011);
INSERT INTO Nurse VALUES(000096, 'Specific Disease Care',  'English, Russian', '01-04', 000012);
INSERT INTO Nurse VALUES(000101, 'Geriatrics',  'English', '01-05', 000013);
INSERT INTO Nurse VALUES(000109, 'Geriatrics',  'English', '01-05', 000014);
INSERT INTO Nurse VALUES(000113, 'Geriatrics',  'English', '01-05', 000015);
INSERT INTO Nurse VALUES(000158, 'Pediatrics',  'English', '01-05', 000016);
INSERT INTO Nurse VALUES(000205, 'Pediatrics',  'English, Chinese', '01-05', 000017);
INSERT INTO Nurse VALUES(000654, 'Pediatrics',  'English', '01-05', 000018);


INSERT INTO Dentist VALUES(000001, 'Surgery', 'English, Spanish', '01-05', 000051, 000003);
INSERT INTO Dentist VALUES(000002, 'Surgery', 'English, Spanish', '01-05', 000051, 000158);
INSERT INTO Dentist VALUES(000006, 'Surgery', 'English, Spanish', '01-05', 000051, 000005);
INSERT INTO Dentist VALUES(000008, 'Periodontics', 'English, French', '01-05', 000051, 000009);
INSERT INTO Dentist VALUES(000010, 'Periodontics', 'English, French', '01-05', 000051, 000013);
INSERT INTO Dentist VALUES(000017, 'Periodontics', 'English, French', '01-05', 000051, 000018);
INSERT INTO Dentist VALUES(000020, 'Endodontics', 'English, Chinese', '01-05', 000051, 000080);
INSERT INTO Dentist VALUES(000026, 'Endodontics', 'English, Chinese', '01-05', 000051, 000109);
INSERT INTO Dentist VALUES(000043, 'Endodontics', 'English, Chinese', '01-05', 000051, 000055);
INSERT INTO Dentist VALUES(000066, 'Endodontics', 'English, Indian', '01-05', 000051, 000088);
INSERT INTO Dentist VALUES(000226, 'Orofacial Pain', 'English, Indian', '01-05', 000051, 000096);
INSERT INTO Dentist VALUES(000255, 'Orofacial Pain', 'English, Indian', '01-05', 000051, 000070);
INSERT INTO Dentist VALUES(000718, 'Orofacial Pain', 'English, Japanese', '01-05', 000051, 000101);

insert into dbo.InsuranceCompany(InsuranceCompanyID, InsuranceCompanyName, Contact, Address1, Address2, ZipCode)
values (000001, 'ACompany', '8583012345', '101 First Ave', 'Room 101', '98109'),
        (000002, 'BCompany', '5092341234', '123 Second St', 'Room 123', '92123'),
        (000003, 'CCompany', '5013142345', '401 Many Ave', 'Unit 402', '96130'),
        (000004, 'DCompany', '8583024567', '319 NW St', 'Room 204', '98109'),
        (000005, 'ECompany', '5042071359', '615 Pine Ave S', 'Room 302', '98109'),
        (000006, 'Wataru', '6012473189', '2400 NE St', 'Room 65', '98115'),
        (000007, 'Maison', '6052173189', '729 NE St', 'Floor 3rd', '97128'),
        (000008, 'Stonemill', '4157893876', '561 Valerine St', 'First Floor', '94110'),
        (000009, 'Samurai', '7021233764', '3650 S Blvd', '1st floor', '89103'),
        (000010, 'Hanu', '2132477370', '2999 W St', '#105', '90020');

insert into dbo.Insurance(InsuranceID, PlanName, CompanyID, HighestCover, ExpiredDate, PayMethod)
values (000001, 'Student', 000001, 50000, '12-12-2022', 'afterpay'),
        (000002, 'Military', 000002, 100000, '11-11-2023', 'bill'),
        (000003, 'Home', 000003, 180000, '02-02-2023', 'bill'),
        (000004, 'Health', 000004, 70000, '04-05-2023', 'check'),
        (000005, 'Life', 000005, 80000, '03-11-2023', 'check'),
        (000006, 'Auto', 000006, 90000, '06-09-2023', 'afterpay'),
        (000007, 'Umbrella', 000007, 120000, '12-11-2023', 'check'),
        (000008, 'Student', 000008, 40000, '06-07-2023', 'check'),
        (000009, 'Student', 000009, 40000, '04-03-2023', 'check'),
        (000010, 'Life', 000010, 150000, '11-10-2023', 'bill');

--create views:

--view1
--Function: View the nearest MedicalRecord of each patient

GO
CREATE VIEW CheckNearestMedicalRecord
AS
SELECT ID AS MedicalRecordID,p.Firstname,p.Lastname,Symptom,Prescription,Date
FROM(
SELECT *,RANK() OVER(PARTITION BY PatientID ORDER BY Date) AS Rank
FROM MedicalRecord mr
) sub
JOIN Patient p
  ON sub.PatientID = p.PatientId
WHERE Rank = 1
GO
SELECT * FROM CheckNearestMedicalRecord

--view2
--Function: view the insurance plan for every patient

GO
CREATE VIEW ViewInsurancePlan
AS
SELECT p.Firstname,p.Lastname,i.PlanName,i.HighestCover
FROM Patient p
JOIN Insurance i
  ON p.InsuranceId = i.InsuranceID

GO
SELECT * FROM ViewInsurancePlan

--view 3
--Function: Found all the dentist who can speak spanish

CREATE VIEW FoundSpanishDentist
AS
SELECT s.FirstName,s.LastName,d.Language,d.Speciality,d.WorkingDay
FROM Dentist d
JOIN Staff s
  ON s.StaffID = d.StaffID
WHERE d.Language LIKE '%Spanish%'

GO
SELECT * FROM FoundSpanishDentist

--view 4
--Function: Found all the dentist who dont have a appointment

GO
CREATE VIEW ViewNoAppointmentDentist
AS
SELECT s.StaffID,s.FirstName,s.LastName,d.Speciality,d.WorkingDay
FROM Dentist d
JOIN Staff s
  ON d.StaffID = s.StaffID
WHERE d.StaffID NOT IN (SELECT a.StaffID
FROM Appointment a
WHERE DATEDIFF(day,GETDATE(),a.AppointmentDate) > 0
);

GO
SELECT * FROM ViewNoAppointmentDentist


--Table-level CHECK Constraints based on a function
--check appointment date is expired or not


CREATE FUNCTION CheckAppointmentExpired
(@PatientID INT)
RETURNS SMALLINT
AS 
BEGIN
	DECLARE @Count INT = 0;
	SELECT @Count = COUNT(AppoinmentID)
	FROM dbo.Appointment a
	JOIN Patient p
	ON a.PatientID = p.PatientID
	WHERE a.PatientID = @PatientID AND DATEDIFF(day,GETDATE(), a.AppointmentDate) > 0 AND DATEDIFF(day, p.BirthDate, GETDATE()) >= 18
	RETURN @Count;
END

ALTER TABLE Appointment DROP CONSTRAINT BanBadBehavior;

DROP FUNCTION CheckAppointmentExpired;

ALTER TABLE Appointment ADD CONSTRAINT BadBehavior CHECK (dbo.CheckAppointmentExpired(PatientID) <= 1);

DROP TABLE Appointment;

INSERT INTO Appointment(AppoinmentID, PatientID, StaffID,AppointmentDate)
	VALUES(14, 1, 1,'2023-11-12');


--Computed function
--compute the total cost for each product purchase

create function dbo.calcCost
(@productID int)
returns int 
as
begin
    declare @total int;
    select @total = sum(pro.Price * pur.Amount)
    from Product pro
        join Purchase pur
        on pro.ProductID = pur.ProductID
    where pro.ProductID = @productID;
    return @total;
end;

alter table dbo.Purchase add totalCost as dbo.calcCost(ProductID);