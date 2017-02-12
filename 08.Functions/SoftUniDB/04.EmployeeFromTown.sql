CREATE PROCEDURE usp_GetEmployeesFromTown (@Town varchar(50))
AS
	SELECT F.FirstName
		,F.LastName
	FROM
	(SELECT e.FirstName, e.LastName, t.Name FROM Employees AS e
	 INNER JOIN Addresses AS a
	 ON a.AddressID = e.AddressID
	 INNER JOIN Towns AS t
	 ON t.TownID = a.TownID) AS F
	 WHERE F.Name = @Town
GO

EXEC usp_GetEmployeesFromTown 'Sofia'