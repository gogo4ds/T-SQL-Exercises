CREATE DATABASE University
GO
USE University

CREATE TABLE Majors (
	MajorID INT PRIMARY KEY NOT NULL,
	Name varchar(50) NOT NULL
)

CREATE TABLE Students (
	StudentID INT PRIMARY KEY NOT NULL,
	StudentNumber varchar(50) NOT NULL,
	StudentName varchar(50),
	MajorID INT,
)

CREATE TABLE Payments (
	PaymentID INT PRIMARY KEY NOT NULL,
	PaymentDate DATE,
	PaymentAmount decimal(8, 2) NOT NULL,
	StudentID INT,
)

CREATE TABLE Subjects (
	SubjectID INT PRIMARY KEY NOT NULL,
	SubjectName varchar(50) NOT NULL,
)

CREATE TABLE Agenda (
	StudentID INT  NOT NULL,
	SubjectID INT NOT NULL,
	CONSTRAINT PK_Agenda PRIMARY KEY (StudentID, SubjectID),
	CONSTRAINT FK_Agenda_Students FOREIGN KEY (StudentID)
		REFERENCES Students(StudentID),
	CONSTRAINT FK_Agenda_Subjects FOREIGN KEY (SubjectID)
		REFERENCES Subjects(SubjectID)
)

ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Students FOREIGN KEY(StudentID)
REFERENCES Students(StudentID)

ALTER TABLE Students
ADD CONSTRAINT FK_Students_Majors FOREIGN KEY(MajorID)
REFERENCES Majors(MajorID)

