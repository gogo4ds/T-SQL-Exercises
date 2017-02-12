WITH Peaks_CTE (cName, peakElevation)
AS
(SELECT c.CountryName 
	,MAX(p.Elevation)
FROM Countries AS c
LEFT JOIN MountainsCountries AS m
	ON c.CountryCode = m.CountryCode
LEFT JOIN Mountains AS mount
	ON mount.Id = m.MountainId
LEFT JOIN Peaks as p
	ON p.MountainId = m.MountainId
GROUP BY c.CountryName)
,Rivers_CTE (cName, riverLenght)
AS
(SELECT c2.CountryName
	,MAX(r.Length)
FROM Countries AS c2
LEFT JOIN CountriesRivers AS cr
	ON cr.CountryCode = c2.CountryCode
LEFT JOIN Rivers as r
	ON r.Id = cr.RiverId
GROUP BY c2.CountryName)

SELECT TOP 5 CountryName
	,p.peakElevation
	,r.riverLenght
FROM Countries AS c
LEFT JOIN Peaks_CTE AS p
	ON p.cName = c.CountryName
LEFT JOIN Rivers_CTE AS r
	ON c.CountryName = r.cName
ORDER BY p.peakElevation DESC
	,r.riverLenght DESC
	,c.CountryName