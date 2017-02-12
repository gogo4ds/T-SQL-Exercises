CREATE PROCEDURE usp_GetTownsStartingWith (@StartString varchar(max))
AS
	SELECT Name FROM Towns
	WHERE CHARINDEX(@StartString, Name, 1) = 1
GO

EXEC usp_GetTownsStartingWith 'be'