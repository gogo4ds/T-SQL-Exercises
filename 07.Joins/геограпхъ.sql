-- Problem 12.	Highest Peak in Bulgaria
SELECT c.CountryCode
	,m.MountainRange
	,p.PeakName
	,p.Elevation
FROM Countries AS c
INNER JOIN MountainsCountries AS mc 
	ON mc.CountryCode = c.CountryCode
INNER JOIN Mountains AS m
	ON m.Id = mc.MountainId
INNER JOIN Peaks AS p
	ON p.MountainId = m.Id
WHERE c.CountryCode = 'BG'
 AND p.Elevation > 2835
ORDER BY p.Elevation DESC

-- Problem 13.	Count Mountain Ranges
SELECT c.CountryCode
	,COUNT(mc.CountryCode) AS [MountainRanges]
FROM Countries AS c
INNER JOIN MountainsCountries AS mc
	ON mc.CountryCode = c.CountryCode
	AND c.CountryCode IN ('BG', 'RU', 'US')
GROUP BY c.CountryCode

-- Problem 14.	Countries with rivers
WITH COUNTRIES_CTE (cName, code)
AS
(	
	SELECT CountryName
		,CountryCode
	FROM Countries
	WHERE ContinentCode = 'AF'
)

SELECT TOP 5 cName
	,r.RiverName
FROM COUNTRIES_CTE AS c
LEFT JOIN CountriesRivers AS cr
	ON cr.CountryCode = c.code
LEFT JOIN Rivers AS r
	ON r.Id = cr.RiverId
ORDER BY cName

-- Problem 16.	Countries Without any Mountains
WITH CountriesWithMountains (code)
AS
(SELECT c.CountryCode FROM Countries AS c
INNER JOIN MountainsCountries AS m
ON m.CountryCode = c.CountryCode)

SELECT COUNT(CountryCode) - (SELECT COUNT(DISTINCT code) 
							FROM CountriesWithMountains) 
		AS CountryCode
FROM Countries










