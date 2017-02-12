CREATE TABLE Monasteries (
	Id INT IDENTITY PRIMARY KEY,
	Name varchar(100) NOT NULL,
	CountryCode char(2) NOT NULL,
	CONSTRAINT FK_MonasteriesCountries FOREIGN KEY (CountryCode)
	REFERENCES Countries(CountryCode)
)

INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR')

UPDATE Countries
SET IsDeleted = 1
WHERE CountryCode IN (  
SELECT c.CountryCode
FROM Countries AS c
INNER JOIN CountriesRivers AS cr
ON cr.CountryCode = c.CountryCode
GROUP BY c.CountryCode
HAVING COUNT(*) > 3)

SELECT mon.Name AS Monastery
	,c.CountryName AS Country
FROM Monasteries AS mon
INNER JOIN Countries AS c
ON c.CountryCode = mon.CountryCode
AND c.IsDeleted = 0
ORDER BY mon.Name
