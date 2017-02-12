CREATE PROCEDURE usp_AssignProject (@emloyeeId INT, @projectID INT)
AS
	BEGIN TRANSACTION
	INSERT INTO EmployeesProjects (EmployeeID, ProjectID)
	VALUES (@emloyeeId, @projectID)
	
	DECLARE @projectsCount INT = (SELECT
		COUNT(*) AS Count
	FROM EmployeesProjects 
	WHERE 
	EmployeeID = @emloyeeId
	GROUP BY EmployeeID)

	IF(@projectsCount > 3)
	BEGIN
		ROLLBACK
		RAISERROR('The employee has too many projects!', 16, 1)
	END
	ELSE
		COMMIT

EXEC usp_AssignProject 1, 3
