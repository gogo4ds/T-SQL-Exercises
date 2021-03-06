CREATE PROC usp_CalculateFutureValueForAccount (@accountId INT, @interestRate FLOAT)
AS

	SELECT ah.Id
		,ah.FirstName 
		,ah.LastName
		,a.Balance AS [Current Balance]
		,[dbo].[ufn_CalculateFutureValue] (a.Balance, @interestRate, 5) AS [Balance in 5 years]
	FROM AccountHolders as ah
	INNER JOIN Accounts AS a	
	ON a.AccountHolderId = ah.Id
	AND a.Id = @accountId

EXEC usp_CalculateFutureValueForAccount 1, 0.1