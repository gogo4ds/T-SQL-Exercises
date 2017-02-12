SELECT rr.CountryName
	,rr.ContinentName
	,COUNT(rr.RiverName) AS RiversCount
	,CASE 
		WHEN SUM(rr.Length) IS NULL THEN 0 
		ELSE
			 SUM(rr.Length) END AS TotalLength
FROM
(SELECT c.CountryName 
	,con.ContinentName
	,r.RiverName
	,r.Length
FROM Countries AS c
INNER JOIN Continents AS con
ON con.ContinentCode = c.ContinentCode
LEFT JOIN CountriesRivers AS cr
ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r
ON r.Id = cr.RiverId) AS rr
GROUP BY rr.CountryName, rr.ContinentName
ORDER BY RiversCount DESC
		,TotalLength DESC
		,rr.CountryName