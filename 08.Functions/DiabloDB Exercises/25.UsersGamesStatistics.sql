SELECT Username
	,Game
	,Character
	,[Items Strenght] + [GameType Strenght] + [Character Strenght] AS Strenght
	,[Items Defence] + [GameType Defence] + [Character Defence] AS Defence
	,[Items Speed] + [GameType Speed] + [Character Speed] AS Speed
	,[Items Mind] + [GameType Mind] + [Character Mind] AS Mind
	,[Items Luck] + [GameType Luck] + [Character Luck] AS Luck
FROM (SELECT u.Username
	,g.Name [Game]
	,MAX(ch.Name) AS [Character]
	,SUM(statsItems.Strength) AS [Items Strenght]
	,MAX(stastGameType.Strength) AS [GameType Strenght]
	,MAX(statsCharacter.Strength) AS [Character Strenght]
	,SUM(statsItems.Defence) AS [Items Defence]
	,MAX(stastGameType.Defence) AS [GameType Defence]
	,MAX(statsCharacter.Defence) AS [Character Defence]
	,SUM(statsItems.Speed) AS [Items Speed]
	,MAX(stastGameType.Speed) AS [GameType Speed]
	,MAX(statsCharacter.Speed) AS [Character Speed]
	,SUM(statsItems.Mind) AS [Items Mind]
	,MAX(stastGameType.Mind) AS [GameType Mind]
	,MAX(statsCharacter.Mind) AS [Character Mind]
	,SUM(statsItems.Luck) AS [Items Luck]
	,MAX(stastGameType.Luck) AS [GameType Luck]
	,MAX(statsCharacter.Luck) AS [Character Luck]
FROM Users AS u
INNER JOIN UsersGames AS ug
  ON ug.UserId = u.Id
INNER JOIN Games AS g
  ON g.Id = ug.GameId
INNER JOIN Characters AS ch
  ON ch.Id = ug.CharacterId
INNER JOIN UserGameItems AS ugi
  ON ugi.UserGameId = ug.Id
INNER JOIN Items AS it
  ON it.Id = ugi.ItemId
INNER JOIN GameTypes AS gt
  ON gt.Id = g.GameTypeId
INNER JOIN [Statistics] AS statsItems
   ON statsItems.Id = it.StatisticId
INNER JOIN [Statistics] AS stastGameType
   ON stastGameType.Id = gt.BonusStatsId
INNER JOIN [Statistics] AS statsCharacter
   ON statsCharacter.Id = ch.StatisticId
   GROUP BY u.Username, g.Name) AS userData
ORDER BY Strenght DESC ,Defence DESC ,Speed DESC ,Mind DESC ,Luck DESC





