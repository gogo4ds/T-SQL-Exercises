CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber (@Salary MONEY)
AS
	SELECT FirstName, LastName 
	FROM Employees
	WHERE Salary >= @Salary
GO

EXEC usp_GetEmployeesSalaryAboveNumber 50000