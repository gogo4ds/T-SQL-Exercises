CREATE DATABASE Minions

USE Minions

CREATE TABLE Minions 
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) not null,
	Age int
)

CREATE TABLE Towns 
(
	Id int PRIMARY KEY IDENTITY,
	Name nvarchar(50) not null
)

ALTER TABLE Minions
ADD TownId int FOREIGN KEY (TownId) References Towns (Id)

INSERT INTO Towns (Id, Name)
VALUES 
	(1, 'Sofia'),
	(2, 'Plovdiv'), 
	(3, 'Varna')

INSERT INTO Minions (Id, Name, Age, TownId)
VALUES 
	(1, 'Kevin', 22, 1),
	(2, 'Bob', 15, 3),
	(3, 'Steward', NULL, 2)
	
--	Select * from Minions
--	Select * from Towns

CREATE TABLE People (
	Id int IDENTITY PRIMARY KEY NOT NULL,
	Name nvarchar(200) NOT NULL,
	Picture image,
	Height decimal(10, 2),
	Weight decimal(10, 2),
	Gender char CHECK(Gender in ('m', 'f')) NOT NULL,
	Birthdate DATE NOT NULL,
	Biography nvarchar(max)
)

INSERT INTO People (Name, Height, Weight, Gender, Birthdate)
VALUES 
	('Pesho', 1.80, 80.04, 'm', '20.12.1996'),
	('Gesho', 1.84, 84, 'm', '14.12.1996'),
	('fdfsd', 1.80, 80.04, 'm', '20.12.1996'),
	('Gesfdfho', 1.84, 84, 'm', '14.12.1996'),
	('dfddfd', 1.80, 80.04, 'm', '20.12.1996')

DROP TABLE Users


CREATE TABLE Users (
	Id int IDENTITY NOT NULL,
	Username varchar(30) UNIQUE NOT NULL,
	Password varchar(26) NOT NULL,
	ProfilePicture VARBINARY(MAX) CHECK (DATALENGTH(ProfilePicture) < 900 * 1024),
	LastLoginTime DATE,
	IsDeleted BIT
)

ALTER TABLE Users
ADD CONSTRAINT pk_Users PRIMARY KEY (Id, Username)

INSERT INTO Users (Username, Password, IsDeleted)
VALUES 
	('Pesho', 'pesho', 0),
	('Gesho', 'gesho', 1),
	('Mehoi', 'pesho', 0),
	('fdfd', 'gesho', 1),
	('Peshsdo', 'pesho', 1)

ALTER TABLE Users
ADD CONSTRAINT DF_LastLoginTime DEFAULT  getutcdate() for [LastLoginTime]

ALTER TABLE Users
DROP CONSTRAINT pk_Users

ALTER TABLE Users
ADD CONSTRAINT CH_UsernameLenght CHECK (LEN(Username) > 3)

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username)
