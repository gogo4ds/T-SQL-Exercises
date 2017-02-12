-- Problem 1.	Employee Address
SELECT TOP 5 
	e.EmployeeID, 
	e.JobTitle, 
	a.AddressID, 
	a.AddressText 
FROM Employees AS e
INNER JOIN Addresses AS a 
	ON e.AddressID = a.AddressID
ORDER BY e.AddressID

-- Problem 2.	Addresses with Towns
SELECT TOP 50 
	e.FirstName, 
	e.LastName, 
	t.Name,
	a.AddressText 
FROM Employees AS e
INNER JOIN Addresses AS a 
	ON e.AddressID = a.AddressID
	INNER JOIN Towns AS t 
	ON a.TownID = t.TownID
ORDER BY e.FirstName, e.LastName

-- Problem 3.	Sales Employee
SELECT e.EmployeeID
	,e.FirstName
	,e.LastName
	,d.Name
FROM Employees AS e
INNER JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
	WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID

-- Problem 4.	Employee Departments
SELECT TOP 5 e.EmployeeID
	,e.FirstName
	,e.Salary
	,(SELECT d.Name FROM Departments AS d 
		WHERE e.DepartmentID = d.DepartmentID)
FROM Employees AS e
WHERE e.Salary > 15000
ORDER BY e.DepartmentID

-- Problem 5.	Employees Without Project
SELECT TOP 3 e.EmployeeID 
	,e.FirstName
FROM Employees as e
LEFT JOIN EmployeesProjects AS ep
	ON ep.EmployeeID = e.EmployeeID
	WHERE ep.EmployeeID IS NULL
ORDER BY e.EmployeeID

-- Problem 6.	Employees Hired After
SELECT e.FirstName, 
	e.LastName,
	e.HireDate,
	d.Name
FROM Employees AS e
INNER JOIN Departments AS d
	ON d.DepartmentID = e.DepartmentID
	AND d.Name IN ('Sales', 'Finance')
WHERE e.HireDate > '01.01.1999'

-- Problem 7.	Employees with Project
SELECT TOP 5 e.EmployeeID 
	,e.FirstName
	,p.Name
FROM Employees as e
INNER JOIN EmployeesProjects AS ep
	ON ep.EmployeeID = e.EmployeeID
INNER JOIN Projects as p
	ON ep.ProjectID = p.ProjectID
	WHERE p.StartDate > '08.13.2002'
	AND p.EndDate IS NULL
ORDER BY e.EmployeeID

-- Problem 8.	Employee 24
SELECT e.EmployeeID 
	,e.FirstName
	,(SELECT CASE WHEN p.StartDate > '01.01.2005'
			 THEN NULL 
			 ELSE p.Name END   
	FROM Projects AS p 
	WHERE p.ProjectID = ep.ProjectID) AS ProjectName
FROM Employees AS e
INNER JOIN EmployeesProjects AS ep
	ON ep.EmployeeID = e.EmployeeID
WHERE e.EmployeeID = 24


-- Problem 9.	Employee Manager
SELECT e.EmployeeID
	,e.FirstName
	,e.ManagerID
	,(SELECT e2.FirstName
		FROM Employees AS e2
		WHERE e2.EmployeeID = e.ManagerID) AS [ManagerName]
FROM Employees as e
WHERE e.ManagerID IN (3, 7)
ORDER BY EmployeeID

-- Problem 10.	Employee Summary
SELECT TOP 50 e.EmployeeID
	,CONCAT(e.FirstName, ' ', e.LastName) AS [EmployeeName]
	,(SELECT CONCAT(e2.FirstName, ' ', e2.LastName)
		FROM Employees AS e2
		WHERE e2.EmployeeID = e.ManagerID) AS [ManagerName]
	,d.Name AS [DepartmentName]
FROM Employees as e
LEFT JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
ORDER BY EmployeeID

-- Problem 11.	Min Average Salary
WITH avgSalaries_CTE (averages) 
AS
	(SELECT AVG(Salary)
	FROM Employees
	GROUP BY DepartmentID)
SELECT MIN(averages) AS [MinAverageSalary] 
FROM avgSalaries_CTE