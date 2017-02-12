CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber (@Salary MONEY)
AS
	DECLARE @Salary MONEY;
	SELECT * FROM Employees
GO