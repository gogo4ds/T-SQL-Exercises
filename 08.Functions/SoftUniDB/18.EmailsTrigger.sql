CREATE TRIGGER tr_emailsOn ON [dbo].[Logs] FOR INSERT
AS
BEGIN
	INSERT INTO NotificationEmails(Recipient, Subject, Body)
	SELECT AccountId
		,'Balance change for account: '
			   + CAST(AccountId AS varchar) AS Subject
		,'On ' + FORMAT(GETDATE(), 'MMM dd yyyy h:mmtt') 
			   + ' your balance was changed from ' 
			   + CAST(OldSum AS varchar)  
			   + ' to ' 
			   + CAST(NewSum AS varchar) + '.' AS Body
	FROM inserted
END


UPDATE Accounts
SET Balance += 1
WHERE Id = 1
