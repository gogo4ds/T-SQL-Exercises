SELECT g.Name [Game]
	,gt.Name AS [Game Type]
	,u.Username AS Username
	,ug.Level AS Level
	,ug.Cash AS Cash
	,ch.Name [Character]
FROM Users AS u
LEFT JOIN UsersGames AS ug
  ON ug.UserId = u.Id
LEFT JOIN Games AS g
  ON g.Id = ug.GameId
LEFT JOIN Characters AS ch
  ON ch.Id = ug.CharacterId
LEFT JOIN GameTypes AS gt
  ON gt.Id = g.GameTypeId
ORDER BY ug.Level DESC
	,u.Username
	,g.Name
