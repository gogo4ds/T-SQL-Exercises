SELECT u.Username
	,g.Name AS [Game]
	,COUNT(it.Price) AS [Items Count]
	,SUM(it.Price) AS [Items Price]
FROM Users AS u
INNER JOIN UsersGames AS ug
  ON ug.UserId = u.Id
INNER JOIN Games AS g
  ON g.Id = ug.GameId
INNER JOIN UserGameItems AS ugi
  ON ugi.UserGameId = ug.Id
INNER JOIN Items AS it
  ON it.Id = ugi.ItemId
GROUP BY u.Username, g.Name
HAVING COUNT(it.Price) >= 10
ORDER BY [Items Count] DESC
	,[Items Price] DESC
	,u.Username