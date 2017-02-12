-- Problem 1.	One-To-One Relationship
USE Hotel
GO

CREATE TABLE Persons (
	PersonID INT NOT NULL,
	FirstName varchar(50) NOT NULL,
	Salary decimal(8, 2),
	PassportID INT
)

CREATE TABLE Passports (
	PassportID INT NOT NULL,
	PassportNumber varchar(8) NOT NULL
)

INSERT INTO Persons(PersonID, FirstName, Salary, PassportID)
VALUES (1, 'Roberto', 43300.00, 102),
		(2, 'Tom', 56100.00, 103),
		(3, 'Yana', 60200.00, 101)

INSERT INTO Passports(PassportID, PassportNumber)
VALUES (101, 'N34FG21B'),
		(102, 'K65LO4R7'),
		(103, 'ZE657QP2')

ALTER TABLE Passports
ADD CONSTRAINT PK_Passports PRIMARY KEY(PassportID)

ALTER TABLE Persons
ADD CONSTRAINT PK_Persons PRIMARY KEY(PersonID),
	CONSTRAINT FK_Persons_Passports FOREIGN KEY(PassportID)
		REFERENCES Passports(PassportID)

-- Problem 2.	One-To-Many Relationship
CREATE TABLE Models (
	ModelID INT PRIMARY KEY NOT NULL,
	Name varchar(50) NOT NULL,
	ManufacturerID INT NOT NULL,
)

CREATE TABLE Manufacturers (
	ManufacturerID INT PRIMARY KEY NOT NULL,
	Name varchar(8) NOT NULL,
	EstablishedOn DATE
)

INSERT INTO Models(ModelID, Name, ManufacturerID)
VALUES (101, 'X1', 1),
		(102, 'i6', 1),
		(103, 'Model S', 2),
		(104, 'Model X', 2),
		(105, 'Model 3', 2),
		(106, 'Nova', 3)

INSERT INTO Manufacturers(ManufacturerID, Name, EstablishedOn)
VALUES (1, 'BMW', '07/03/1916'),
		(2, 'Tesla', '01/01/2003'),
		(3, 'Lada', '01/05/1966')

ALTER TABLE Models
ADD	CONSTRAINT FK_Models_Manufacturers FOREIGN KEY(ManufacturerID)
		REFERENCES Manufacturers(ManufacturerID)

-- Problem 3.	Many-To-Many Relationship
CREATE TABLE Students(
	StudentID INT PRIMARY KEY NOT NULL,
	Name varchar(50) NOT NULL
)

CREATE TABLE Exams(
	ExamID INT PRIMARY KEY NOT NULL,
	Name varchar(50) NOT NULL
)

CREATE TABLE StudentsExams(
	StudentID INT NOT NULL,
	ExamID INT NOT NULL
)

INSERT INTO Students(StudentID, Name)
VALUES 
	(1, 'Mila'),
	(2, 'Toni'),
	(3, 'Ron')

INSERT INTO Exams(ExamID, Name)
VALUES 
	(101, 'SpringMVC'),
	(102, 'Neo4j'),
	(103, 'Oracle 11g')

INSERT INTO StudentsExams(StudentID, ExamID)
VALUES 
	(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103)

ALTER TABLE StudentsExams
ADD CONSTRAINT PK_StudentsExams PRIMARY KEY (StudentID, ExamID),
	CONSTRAINT FK_StudentsExams_StudentID FOREIGN KEY (StudentID)
		REFERENCES Students(StudentID),
	CONSTRAINT FK_StudentsExams_ExamID FOREIGN KEY (ExamID)
		REFERENCES Exams(ExamID)

-- Problem 4.	Self-Referencing 
CREATE TABLE Teachers(
	TeacherID INT PRIMARY KEY NOT NULL,
	Name varchar(50) NOT NULL,
	ManagerID INT
)

INSERT INTO Teachers (TeacherID, Name, ManagerID)
VALUES 
		(101, 'John', NULL),
		(102, 'Maya', 106),
		(103, 'Silvia', 106),
		(104, 'Ted', 105),
		(105, 'Mark', 101),
		(106, 'Greta', 101)

ALTER TABLE Teachers
ADD	CONSTRAINT FK_Teachers_ManagerID FOREIGN KEY (ManagerID)
		REFERENCES Teachers(TeacherID);

SELECT MountainRange FROM Mountains