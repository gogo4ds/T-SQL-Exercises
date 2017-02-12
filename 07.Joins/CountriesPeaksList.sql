SELECT TOP 5 dd.CountryName
	,CASE 
		WHEN dd.PeakName IS NULL THEN '(no highest peak)' 
		ELSE dd.PeakName END AS HighestPeakName
	,CASE 
		WHEN dd.Elevation IS NULL THEN 0 
		ELSE dd.Elevation END AS HighestPeakElevation
	,CASE 
		WHEN dd.MountainRange IS NULL THEN '(no mountain)' 
		ELSE dd.MountainRange END AS Mountain
FROM
(SELECT c.CountryName
	,p.PeakName
	,p.Elevation
	,DENSE_RANK() OVER (PARTITION By c.CountryName ORDER BY p.Elevation DESC) AS Rank
	,m.MountainRange
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc
	ON mc.CountryCode = c.CountryCode
LEFT JOIN Mountains AS m
	ON m.Id = mc.MountainId
LEFT JOIN Peaks AS p
	ON p.MountainId = m.Id) AS dd
WHERE dd.Rank = 1
ORDER BY dd.CountryName, dd.PeakName