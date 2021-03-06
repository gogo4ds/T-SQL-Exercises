-- Exercise 1
SELECT [FirstName]
      ,[LastName]
  FROM [SoftUni].[dbo].[Employees]
  WHERE FirstName LIKE 'sa%'

-- Exercise 2
SELECT FirstName, LastName FROM Employees WHERE CHARINDEX('ei', LastName, 1) > 0

-- Exercise 3
SELECT FirstName 
FROM Employees 
	WHERE DepartmentID IN (3, 10) 
		AND CAST(YEAR(HireDate) AS int) BETWEEN 1995 AND 2005

-- Exercise 4
SELECT FirstName, LastName 
FROM Employees 
	WHERE JobTitle NOT LIKE '%engineer%'

-- Exercise 5
SELECT Name FROM Towns WHERE LEN(Name) IN (5, 6) ORDER BY Name

-- Exercise 6
SELECT TownID, Name FROM Towns WHERE Name LIKE '[MKBE]%' ORDER BY Name

-- Exercise 7
SELECT TownID, Name FROM Towns WHERE Name NOT LIKE '[RBD]%' ORDER BY Name

-- Exercise 8
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees WHERE CAST(YEAR(HireDate) AS int) > 2000

SELECT * FROM V_EmployeesHiredAfter2000

-- Exercise 9
SELECT FirstName, LastName FROM Employees WHERE LEN(LastName) = 5

USE Geography
-- Exercise 10
SELECT CountryName, IsoCode FROM Countries WHERE LEN(CountryName) - LEN(REPLACE(CountryName, 'a', '')) >= 3 ORDER BY IsoCode

SELECT CountryName, IsoCode FROM Countries WHERE CountryName LIKE '%a%a%a%' ORDER BY IsoCode

-- Exercise 11
SELECT 
		p.PeakName, 
		r.RiverName, 
		LOWER(LEFT(p.PeakName, LEN(p.PeakName) - 1) + r.RiverName) AS Mix
	FROM 
		(SELECT * FROM Peaks) AS p, 
		(SELECT * FROM Rivers) AS r
			WHERE RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
			ORDER BY Mix

-- Exercise 12
USE Diablo

SELECT TOP (50) Name, FORMAT(Start, 'yyyy-MM-dd') AS Started
	FROM Games 
		WHERE CAST(YEAR(Start) AS INT) BETWEEN 2011 AND 2012 
		ORDER BY Start, Name

-- Exercise 13
SELECT 
	Username, 
	RIGHT(Email, LEN(Email) - CHARINDEX('@',Email)) AS [Email Provider] 
FROM Users 
		ORDER BY [Email Provider], Username

-- Exercise 14
SELECT Username, IpAddress  
	FROM Users 
		WHERE CHARINDEX('.', IpAddress) = 4  
			AND CHARINDEX('.', REVERSE(IpAddress)) = 4 
			AND SUBSTRING(IpAddress, 5, 1) = 1
		ORDER BY Username

SELECT Username, IpAddress  
FROM Users 
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

-- Exercise 15
SELECT Name
	 ,CASE 
		WHEN DATEPART(hh, Start) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(hh, Start) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN DATEPART(hh, Start) BETWEEN 18 AND 23 THEN 'Evening' 
	END AS [Part of the Day]
	,CASE 
		WHEN Duration <= 3 THEN 'Extra Short'
		WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		WHEN Duration IS NULL THEN 'Extra Long'
		END AS Duration
	FROM Games ORDER BY Name, Duration, [Part of the Day]

-- Exercise 16
USE Orders

SELECT ProductName
	,OrderDate
	,DATEADD(day, 3, OrderDate) AS [Pay Due]
	,DATEADD(month, 1, OrderDate) AS [Deliver Due]
FROM Orders

CREATE TABLE People (
	Id int NOT NULL IDENTITY PRIMARY KEY, 
	Name varchar(50) NOT NULL,
	Birthdate DATE
)

INSERT INTO People (Name, Birthdate)
VALUES ('Victor', '2000-12-07 00:00:00.000'),
('Steven', '1992-09-10 00:00:00.000'),
('Stephen', '1910-09-19 00:00:00.000'),
('John', '2010-01-06 00:00:00.000')

SELECT Name, 
	DATEDIFF(year, Birthdate, GETDATE()) AS [Age in Years]
	,DATEDIFF(month, Birthdate, GETDATE()) AS [Age in Months]
	,DATEDIFF(day, Birthdate, GETDATE()) AS [Age in Days]
	,DATEDIFF(minute, Birthdate, GETDATE()) AS [Age in Minutes]
 FROM People