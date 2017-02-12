SELECT m.MountainRange, p.PeakName, p.Elevation 
FROM Mountains as m
INNER JOIN Peaks AS p
	ON p.MountainId = m.Id AND m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC