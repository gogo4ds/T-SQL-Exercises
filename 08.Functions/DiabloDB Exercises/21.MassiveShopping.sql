DECLARE @userLevel INT = (SELECT ug.Level FROM UsersGames AS ug
						INNER JOIN Users AS u
						ON u.Id = ug.UserId
						INNER JOIN Games AS g
						ON g.Id = ug.GameId
						AND g.Name = 'Safflower'
						AND u.Username = 'Stamat')

DECLARE @UsersGameId INT = (SELECT ug.Id FROM UsersGames AS ug
						INNER JOIN Users AS u
						ON u.Id = ug.UserId
						INNER JOIN Games AS g
						ON g.Id = ug.GameId
						AND g.Name = 'Safflower'
						AND u.Username = 'Stamat')

DECLARE @userId INT = (SELECT Id 
						FROM Users 
						WHERE Username = 'Stamat')

DECLARE @userMoney MONEY = (SELECT CAST(Cash AS MONEY) 
							FROM UsersGames 
							WHERE Id = @UsersGameId)

BEGIN TRANSACTION

	DECLARE @ItemsSum1 MONEY = (SELECT SUM(Price)
								FROM  Items AS it
								WHERE it.MinLevel IN (11, 12))

	INSERT INTO UserGameItems (ItemId, UserGameId)
	SELECT Id, @UsersGameId FROM Items
	WHERE MinLevel IN (11, 12)

	IF(@userMoney < @ItemsSum1 OR @userLevel < 12)
	 BEGIN
		ROLLBACK
	 END
	ELSE
	 BEGIN
		UPDATE UsersGames
		SET Cash -= @ItemsSum1
		WHERE UserId = @userId
		COMMIT
	 END

BEGIN TRANSACTION

	DECLARE @ItemsSum2 MONEY = (SELECT SUM(Price)
								FROM  Items AS it
								WHERE it.MinLevel IN (19, 20, 21))

	INSERT INTO UserGameItems (ItemId, UserGameId)
	SELECT Id, @UsersGameId FROM Items
	WHERE MinLevel IN (19, 20, 21)

	IF(@userMoney < @ItemsSum2 OR @userLevel < 21)
	 BEGIN
		ROLLBACK
	 END
	ELSE
	 BEGIN
		UPDATE UsersGames
		SET Cash -= @ItemsSum2
		WHERE UserId = @userId
		COMMIT
	 END

SELECT it.Name FROM Items AS it
INNER JOIN UserGameItems AS ugi
ON it.Id = ugi.ItemId
AND ugi.UserGameId = @UsersGameId
ORDER BY it.Name