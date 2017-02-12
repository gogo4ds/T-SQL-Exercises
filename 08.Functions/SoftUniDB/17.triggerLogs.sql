CREATE TRIGGER tr_BalanceUpdate ON Accounts AFTER UPDATE
AS
BEGIN
	INSERT INTO Logs (AccountId, OldSum, NewSum)
	SELECT i.Id
		,d.Balance
		,i.Balance
	FROM inserted AS i
	INNER JOIN deleted AS d
	ON i.Id = d.Id
END

