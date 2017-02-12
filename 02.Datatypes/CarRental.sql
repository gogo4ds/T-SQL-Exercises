CREATE DATABASE CarRental
USE CarRental

CREATE TABLE Categories (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	Category varchar(50) NOT NULL,
	DailyRate varchar(50),
	WeeklyRate varchar(50),
	MonthlyRate varchar(50),
	WeekendRate varchar(50)
)

INSERT INTO Categories (Category)
VALUES 
		('Cars'),
		('Trucks'),
		('SUVs')

CREATE TABLE Cars  (
	Id INT IDENTITY NOT NULL,
	PlateNumber varchar(10) NOT NULL,
	Make nvarchar(25) NOT NULL,
	Model nvarchar(25),
	CarYear DATE,
	CategoryId INT,
	Doors TINYINT,
	Picture VARBINARY(MAX),
	Condition VARCHAR(10) CHECK (Condition IN ('New', 'Used')) NOT NULL,
	Available BIT DEFAULT 0 NOT NULL
)

ALTER TABLE Cars
ADD CONSTRAINT PK_Cars PRIMARY KEY (Id, PlateNumber)

ALTER TABLE Cars
ADD CONSTRAINT DF_Condition DEFAULT 'New' FOR [Condition]

INSERT INTO Cars (PlateNumber, Make)
VALUES ('CA 2312 XA',	'Audi'),
		('A 8612 BA', 'Opel'),
		('BP 2112 CA', 'Range Rover')

CREATE TABLE Employees  (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Title varchar(50) NOT NULL,
	Notes varchar(MAX),
)

INSERT INTO Employees (FirstName, LastName, Title)
VALUES 
		('Miguel', 'Rodriguez', 'Sales specialist'),
		('Samuel', 'Jackson', 'Agent'),
		('Toni', 'Naika', 'Barovets')

CREATE TABLE Customers   (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	DriverLicenceNumber varchar(50) NOT NULL,
	FullName varchar(50) NOT NULL,
	Address varchar(255) NOT NULL,
	City varchar(50),
	ZIPCode TINYINT,
	Notes varchar(MAX)
)

INSERT INTO Customers (DriverLicenceNumber, FullName, Address, City)
VALUES 
		('XA 1212 LS', 'Donald Trump', 'White House', 'Washington'),
		('DA 6228 RS', 'Barak Obama', 'next to the White House', 'Washington'),
		('HA 7238 LT', 'Hilary Clinton', 'far far away from the White House', 'NOT Washington')

CREATE TABLE RentalOrders    (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	EmployeeId INT NOT NULL,
	CustomerId INT NOT NULL,
	CarId INT NOT NULL,
	CarCondition varchar(50) DEFAULT 'New' NOT NULL,
	TankLevel varchar(50),
	KilometrageStart INT,
	KilometrageEnd INT,
	TotalKilometrage INT,
	StartDate varchar(50),
	EndDate DATE,
	TotalDays varchar(50),
	RateApplied varchar(50),
	TaxRate varchar(50),
	OrderStatus varchar(50) NOT NULL,
	Notes nvarchar(MAX),
)

ALTER TABLE RentalOrders
ADD CONSTRAINT FK_EmployeeId 
FOREIGN KEY (EmployeeId) 
REFERENCES Employees (Id)

ALTER TABLE RentalOrders
ADD CONSTRAINT FK_CustomerId
FOREIGN KEY (CustomerId)
REFERENCES Customers (Id)

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, OrderStatus)
VALUES 
		(1, 2, 3, 'Sold'),
		(2, 1, 2, 'In Progress'),
		(2, 2, 2, 'Waiting')