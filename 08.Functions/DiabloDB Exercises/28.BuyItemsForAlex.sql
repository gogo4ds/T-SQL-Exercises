DECLARE @UserGameId INT = (SELECT ug.Id [UserGameId]
							FROM Users AS u
							INNER JOIN UsersGames AS ug
							ON ug.UserId = u.Id
							INNER JOIN Games AS g
							ON g.Id = ug.GameId
							WHERE Username = 'Alex'
							AND g.Name = 'Edinburgh')

DECLARE @TotalItemsPrice MONEY = (SELECT SUM(it.Price)
								FROM Items AS it
								WHERE it.Name IN ('Blackguard', 'Bottomless Potion of Amplification', 
												'Eye of Etlich (Diablo III)', 'Gem of Efficacious Toxin', 
												'Golden Gorget of Leoric', 'Hellfire Amulet'))

INSERT INTO UserGameItems (ItemId, UserGameId)
	SELECT it.Id [ItemId]
		,@UserGameId
	FROM Items AS it
	WHERE it.Name IN ('Blackguard', 'Bottomless Potion of Amplification', 
						'Eye of Etlich (Diablo III)', 'Gem of Efficacious Toxin', 
						'Golden Gorget of Leoric', 'Hellfire Amulet')

UPDATE UsersGames
SET Cash -= @TotalItemsPrice
WHERE Id = @UserGameId

SELECT u.Username
	,g.Name [Game Name]
	,ug.Cash
	,it.Name [Items]
FROM Users AS u
INNER JOIN UsersGames AS ug
ON ug.UserId = u.Id
INNER JOIN Games AS g
ON g.Id = ug.GameId
INNER JOIN UserGameItems AS ugi
ON ugi.UserGameId = ug.Id
INNER JOIN Items AS it
ON it.Id = ugi.ItemId	
WHERE g.Name = 'Edinburgh'
ORDER BY it.Name



