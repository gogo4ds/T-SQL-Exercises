CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan (@num DECIMAL(10, 2))
AS
	SELECT ah.FirstName
		,ah.LastName
	FROM AccountHolders AS ah
	INNER JOIN Accounts AS a
	ON a.AccountHolderId = ah.Id
	GROUP BY FirstName, LastName
	HAVING SUM(a.Balance) > @num

EXEC usp_GetHoldersWithBalanceHigherThan 28734.223