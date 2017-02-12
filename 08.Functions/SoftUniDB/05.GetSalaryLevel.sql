CREATE FUNCTION	ufn_GetSalaryLevel (@salary MONEY)
RETURNS VARCHAR(7)
AS
BEGIN
	DECLARE @result varchar(7) = 'High'

	IF(@salary < 30000)
	 BEGIN
		SET @result = 'Low'
	 END
	ELSE IF (@salary <= 50000)
	 BEGIN
		SET @result = 'Average'
	 END

	RETURN @result
END

CREATE PROCEDURE usp_EmployeesBySalaryLevel (@Level varchar(7))
AS
	SELECT FirstName
			,LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @Level

EXEC usp_EmployeesBySalaryLevel 'high'
