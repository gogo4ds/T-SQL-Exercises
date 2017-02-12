UPDATE Countries
SET CountryName = 'Burma'
WHERE CountryName = 'Myanmar'

INSERT INTO Monasteries (Name, CountryCode)
SELECT 'Hanga Abbey'
	,CountryCode
FROM Countries
WHERE CountryName = 'Tanzania'

INSERT INTO Monasteries (Name, CountryCode)
SELECT 'Myin-Tin-Daik'
	,CountryCode
FROM Countries
WHERE CountryName = 'Myanmar'

SELECT con.ContinentName AS ContinentName
	,c.CountryName AS CountryName
	,COUNT(m.Name) AS MonasteriesCount
FROM Continents AS con
INNER JOIN Countries AS c
ON con.ContinentCode = c.ContinentCode
LEFT JOIN Monasteries AS m
ON m.CountryCode = c.CountryCode
WHERE c.IsDeleted = 0
GROUP BY ContinentName, CountryName
ORDER BY MonasteriesCount DESC, CountryName