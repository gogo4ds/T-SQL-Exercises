WITH Averages_CTE (avgMind, avgLuck, avgSpeed)
AS
(SELECT AVG(st.Mind) AS [AvgMind]
	,AVG(st.Luck) AS [AvgLuck]
	,AVG(st.Speed) AS [AvgSpeed]
FROM Items AS it
INNER JOIN [Statistics] AS st
ON st.Id = it.StatisticId)

SELECT it.Name
	,it.Price
	,it.MinLevel
	,st.Strength
	,st.Defence
	,st.Speed
	,st.Luck
	,st.Mind
FROM Items AS it
INNER JOIN [Statistics] AS st
ON st.Id = it.StatisticId
WHERE st.Mind > (SELECT avgMind FROM Averages_CTE) 
AND st.Luck > (SELECT avgLuck FROM Averages_CTE)
AND st.Speed > (SELECT avgSpeed FROM Averages_CTE) 
ORDER BY it.Name


