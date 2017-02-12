CREATE PROCEDURE usp_TransferMoney 
	(@senderID INT, 
	@receiverID INT, 
	@amount MONEY)
AS
	BEGIN TRANSACTION

	DECLARE @senderBalance MONEY = (SELECT Balance FROM Accounts WHERE Id = @senderID)

	EXEC dbo.usp_WithdrawMoney @senderID, @amount
	EXEC dbo.usp_DepositMoney @receiverID, @amount

	IF ((SELECT TOP 1 Id FROM Accounts ORDER BY Id DESC) >= @senderID OR 
		(SELECT TOP 1 Id FROM Accounts ORDER BY Id DESC) >= @receiverID)
	BEGIN
		IF(@amount <= 0 OR @amount IS NULL)
		 BEGIN
			ROLLBACK;
		 END
		ELSE IF(@senderBalance < @amount)
		 BEGIN
			ROLLBACK;
		 END
		ELSE IF (@senderID <= 0)
		 BEGIN
			ROLLBACK;
		 END
		ELSE
		 COMMIT
		END
	ELSE
	 BEGIN
		ROLLBACK
	 END