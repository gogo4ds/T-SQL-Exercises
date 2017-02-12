CREATE DATABASE Movies
USE Movies
CREATE TABLE Directors (
	Id int NOT NULL IDENTITY PRIMARY KEY,
	DirectorName varchar(255) NOT NULL,
	Notes nvarchar(MAX)
)

INSERT INTO Directors (DirectorName, Notes)
VALUES 
	('Steven Spielberg', 'Pichaga e toq'),
	('George Lucas', 'Titanik e potopil toq'),
	('Eduard Nolan', 'Inception stuff'),
	('Darron Aronoffski', 'Ne znam taka li se pishe imeto mu'),
	('Steven Spielberg', 'Pichaga e toq')


CREATE TABLE Genres (
	Id int NOT NULL IDENTITY PRIMARY KEY,
	GenreName varchar(255) NOT NULL,
	Notes nvarchar(MAX)
)

INSERT INTO Genres (GenreName, Notes)
VALUES 
	('Comedy', 'яко смях'),
	('Action', 'стрелят се'),
	('Horror', 'малиии бегай, че страшно'),
	('Drama', 'ше ревна'),
	('Sci-Fi', 'ебаси мамата')

CREATE TABLE Categories (
	Id int NOT NULL IDENTITY PRIMARY KEY,
	CategoryName varchar(255) NOT NULL,
	Notes nvarchar(MAX)
)

INSERT INTO Categories (CategoryName)
VALUES 
	('Blockbusters'),
	('Hollywood'),
	('BollyWood'),
	('SitComs'),
	('TV')

CREATE TABLE Movies (
	Id int NOT NULL IDENTITY PRIMARY KEY,
	Title varchar(200) NOT NULL,
	DirectorId int,
	CopyrightYear DATE,
	Length decimal(10, 2),
	GenreId int,
	CategoryId int,
	Rating TINYINT CHECK (Rating >= 0 AND Rating <= 10),
	Notes nvarchar(MAX)
)

INSERT INTO Movies (Title, DirectorId, Length, GenreId, CategoryId, Rating)
VALUES 
	('Life of Pi', 1, 120, 1, 2, 9),
	('The Matrix', 3, 120.22, 5, 2, 10)

INSERT INTO Movies (Title, DirectorId, Rating)
VALUES 
	('Titanic', 2, 7),
	('Jurasic Park', 1, 6)
