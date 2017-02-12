CREATE DATABASE Hotel
USE Hotel

CREATE TABLE Employees 
(
	Id INT IDENTITY NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50),
	Title varchar(50),
	Notes nvarchar(max)
)

ALTER TABLE Employees
ADD CONSTRAINT PK_Employees PRIMARY KEY (Id)

INSERT INTO Employees (FirstName, LastName, Title)
VALUES 
		('Minka', 'Markova', 'Receptionist'), 
		('Marko', 'Markov', 'Receptionist'),
		('Genka', 'Shikerova', 'Manager')


CREATE TABLE Customers
(
	AccountNumber INT PRIMARY KEY NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50),
	PhoneNumber VARCHAR(15) NOT NULL,
	EmergencyName nvarchar(max),
	EmergencyNumber VARCHAR(15),
	Notes nvarchar(max)
)

INSERT INTO Customers (AccountNumber, FirstName, PhoneNumber)
VALUES 
		(1234839, 'Pesho', '+359888122444'), 
		(343243, 'Gesho', '+35988394444'),
		(46332343, 'Mesho', '+359888122324')

CREATE TABLE RoomStatus (
	RoomStatus VARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE RoomStatus
ADD CONSTRAINT PK_RoomStatus PRIMARY KEY(RoomStatus)

INSERT INTO RoomStatus (RoomStatus)
VALUES 
		('Available'), 
		('Inavailable'),
		('Cleaning')

CREATE TABLE RoomTypes (
	RoomType VARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE RoomTypes
ADD CONSTRAINT DF_RoomType DEFAULT 'Double' FOR [RoomType]

ALTER TABLE RoomTypes
ADD CONSTRAINT PK_RoomTypes PRIMARY KEY(RoomType)

INSERT INTO RoomTypes (RoomType)
VALUES 
		('Apartment'), 
		('Double Room'),
		('Single Room')

CREATE TABLE BedTypes (
	BedType VARCHAR(50) DEFAULT 'Single' PRIMARY KEY NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO BedTypes (BedType)
VALUES 
		('Double'), 
		('Big Bed'),
		('Single')

CREATE TABLE Rooms (
	RoomNumber INT PRIMARY KEY NOT NULL,
	RoomType VARCHAR(50) NOT NULL,
	BedType VARCHAR(50) NOT NULL,
	Rate INT,
	RoomStatus VARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE Rooms WITH CHECK ADD
	CONSTRAINT FK_RoomType FOREIGN KEY (RoomType) REFERENCES RoomTypes(RoomType),
	CONSTRAINT FK_BedType FOREIGN KEY (BedType) REFERENCES BedTypes(BedType),
	CONSTRAINT FK_RoomStatus FOREIGN KEY (RoomStatus) REFERENCES RoomStatus(RoomStatus)

INSERT INTO Rooms (RoomNumber, RoomType, BedType, RoomStatus)
VALUES 
		(2, 'Double Room', 'Single', 'Available'), 
		(4, 'Single Room', 'Big Bed', 'Inavailable'),
		(12, 'Apartment', 'Big Bed', 'Cleaning')

CREATE TABLE Payments (
	Id int PRIMARY KEY NOT NULL IDENTITY,
	EmployeeId INT NOT NULL,
	PaymentDate DATE DEFAULT GETDATE() NOT NULL,
	AccountNumber INT NOT NULL,
	FirstDateOccupied DATE NOT NULL,
	LastDateOccupied DATE DEFAULT GETDATE() NOT NULL,
	TotalDays INT,
	AmountCharged decimal(10, 2) NOT NULL,
	TaxRate decimal(5, 2) DEFAULT 11.2,
	TaxAmount decimal (10, 2) NOT NULL,
	PaymentTotal decimal(10, 2) NOT NULL,
	Notes nvarchar(MAX)
)

ALTER TABLE Payments WITH CHECK ADD 
	CONSTRAINT FK_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES Employees(Id)

INSERT INTO Payments (EmployeeId, AccountNumber, FirstDateOccupied, AmountCharged, TaxAmount, PaymentTotal)
VALUES 
		(1, 2234, '12.12.2016', 812.22, 100, 912.22),
		(2, 2324, '11.12.2016', 5000.82, 287.2, 5287.84),
		(3, 32432, '10.01.2016', 4004, 180, 40184)

CREATE TABLE Occupancies (
	Id INT PRIMARY KEY NOT NULL IDENTITY,
	EmployeeId INT NOT NULL,
	DateOccupied DATE NOT NULL,
	AccountNumber INT NOT NULL,
	RoomNumber INT NOT NULL,
	RateApplied DECIMAL(5, 2) DEFAULT 11.2,
	PhoneCharge DECIMAL(10, 2) DEFAULT 0 NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE Occupancies WITH CHECK ADD
	CONSTRAINT FK_Occupancies_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES Employees(Id),
	CONSTRAINT FK_RoomNumber FOREIGN KEY (RoomNumber) REFERENCES Rooms(RoomNumber)

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, PhoneCharge)
VALUES 
		(1, '12.12.2016', 813342, 2, 912),
		(2, '11.12.2016', 50003, 4, 52),
		(3, '10.01.2016', 400434, 12, 40)