SELECT [Email Provider]
	,COUNT(*) AS [Number Of Users]
FROM
(SELECT SUBSTRING(Email
				 ,CHARINDEX('@', Email, 1) + 1
				 ,LEN(Email) - CHARINDEX('@',Email, 1) + 1)
	 AS [Email Provider]
FROM Users) AS p
GROUP BY p.[Email Provider]
ORDER BY [Number Of Users] DESC, [Email Provider]