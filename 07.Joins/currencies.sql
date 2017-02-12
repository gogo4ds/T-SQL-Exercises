-- Problem 15.	*Continents and Currencies
WITH Maxes_CTE (continent, curr, usage)
AS
(SELECT c.ContinentCode
	,c.CurrencyCode
	,MAX(c.Usage) AS Usage
FROM (SELECT ContinentCode
	,CurrencyCode 
	,COUNT(CountryCode) AS Usage
FROM Countries
GROUP BY CurrencyCode, ContinentCode) AS c
GROUP BY c.ContinentCode, c.CurrencyCode
HAVING MAX(c.Usage) >= 2)
,
CTE (cont, usag)
AS
(SELECT continent
	,MAX(usage)
FROM Maxes_CTE
GROUP BY continent
)

SELECT continent
	,curr
	,MAX(usage) AS maxUsage
FROM Maxes_CTE
GROUP BY curr, continent