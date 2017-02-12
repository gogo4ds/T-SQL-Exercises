CREATE PROCEDURE usp_GetHoldersFullName
AS
	(SELECT FirstName + ' ' + LastName AS FullName
	FROM AccountHolders)

EXEC usp_GetHoldersFullName
