CREATE DATABASE SoftUni
USE SoftUni

CREATE TABLE Towns (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	Name nvarchar(50) NOT NULL
)

CREATE TABLE Addresses (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	AddressText nvarchar(150) NOT NULL,
	TownId INT NOT NULL
)

CREATE TABLE Departments (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	Name nvarchar(50) NOT NULL
)

CREATE TABLE Employees (
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	MiddleName nvarchar(50),
	LastName nvarchar(50) NOT NULL,
	JobTitle nvarchar(50),
	DepartmentId INT,
	HireDate DATE,
	Salary DECIMAL(10, 2),
	AddressId INT
)

ALTER TABLE Employees
ADD JobTitle nvarchar(50)

ALTER TABLE Addresses WITH CHECK ADD
CONSTRAINT FK_Addresses_TownId FOREIGN KEY (TownId) REFERENCES Towns(Id)

ALTER TABLE Employees WITH CHECK ADD
CONSTRAINT FK_AddressId FOREIGN KEY (AddressId) REFERENCES Addresses(Id),
CONSTRAINT FK_DepartmentId FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)

ALTER TABLE Towns
ADD CONSTRAINT UQ_Towns UNIQUE (Name)

ALTER TABLE Departments
ADD CONSTRAINT UQ_Departments UNIQUE (Name)

INSERT INTO Towns (Name)
VALUES 
		('Sofia'),
		('Plovdiv'),
		('Varna'),
		('Burgas')

INSERT INTO Departments (Name)
VALUES 
		('Engineering'),
		('Sales'),
		('Marketing'),
		('Software Development'),
		('Quality Assurance')

INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
VALUES 
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '02.01.2013', 3500.00),
	('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '03.02.2004', 4000.00),
	('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '08.28.2016', 525.25),
	('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '12.09.2007', 3000.00),
	('Peter', 'Pan', 'Pan', 'Intern', 3, '08.28.2016', 3599.88)


SELECT * FROM Towns ORDER BY Name ASC
SELECT * FROM Departments ORDER BY Name ASC
SELECT * FROM Employees ORDER BY Salary DESC

SELECT Name FROM Towns ORDER BY Name ASC
SELECT Name FROM Departments ORDER BY Name ASC
SELECT FirstName, LastName, JobTitle, Salary FROM Employees ORDER BY Salary DESC

UPDATE Employees
SET Salary = Salary * 1.1

SELECT Salary FROM Employees

TRUNCATE TABLE Occupancies