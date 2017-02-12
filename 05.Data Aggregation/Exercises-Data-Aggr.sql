-- Exercise 1
SELECT COUNT(*) AS [Count] 
FROM [dbo].[WizzardDeposits]

-- Exercise 2
SELECT MAX(MagicWandSize) AS [LongestMagicWand] 
FROM [WizzardDeposits]

-- Exercise 3
SELECT w.DepositGroup, MAX(w.MagicWandSize) AS [LongestMagicWand] 
FROM WizzardDeposits AS w GROUP BY w.DepositGroup

-- Exercise 4: Smallest Deposit Group per Magic Wand Size

SELECT m.DepositGroup FROM (SELECT w.DepositGroup, AVG(w.MagicWandSize) AS AverageSalary 
	FROM WizzardDeposits as w
	GROUP BY w.DepositGroup) AS m
	WHERE AverageSalary = (SELECT MIN(AverageSalary) FROM
(SELECT w.DepositGroup, AVG(w.MagicWandSize) AS AverageSalary 
	FROM WizzardDeposits as w
	GROUP BY w.DepositGroup) AS m)

-- Exercise 5: Deposits Sum
SELECT w.DepositGroup, SUM(w.DepositAmount) AS TotalSum 
FROM WizzardDeposits AS w
GROUP BY w.DepositGroup

-- Problem 6.	Deposits Sum for Ollivander Family
SELECT w.DepositGroup, SUM(w.DepositAmount) AS TotalSum 
FROM WizzardDeposits AS w
WHERE w.MagicWandCreator = 'Ollivander family'
GROUP BY w.DepositGroup

-- Problem 7.	Deposits Filter
SELECT w.DepositGroup, SUM(w.DepositAmount) AS TotalSum 
FROM WizzardDeposits AS w
WHERE w.MagicWandCreator = 'Ollivander family'
GROUP BY w.DepositGroup
HAVING SUM(w.DepositAmount) < 150000
ORDER BY TotalSum DESC
 	
-- Problem 8. Deposit Charge
SELECT w.DepositGroup, w.MagicWandCreator, MIN(w.DepositCharge) AS MinDepositCharge 
FROM WizzardDeposits AS w
GROUP BY w.DepositGroup, w.MagicWandCreator
ORDER BY w.MagicWandCreator, w.DepositGroup

--Problem 9.	Age Groups	
SELECT groups.AgeGroup, COUNT(groups.Age) FROM
(SELECT 
CASE WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
	WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
	WHEN w.Age >= 61 THEN '[61+]'
END AS AgeGroup, w.Age
FROM WizzardDeposits AS w) AS groups
GROUP BY groups.AgeGroup

-- Problem 10.	First Letter
SELECT DISTINCT LEFT(FirstName, 1) AS FirstName
FROM WizzardDeposits 
WHERE DepositGroup = 'Troll Chest'
ORDER BY FirstName

-- Problem 11.	Average Interest
SELECT DepositGroup, 
		IsDepositExpired,
		AVG(DepositInterest) AS [AverageInterest] 
FROM WizzardDeposits
WHERE DepositStartDate > '01.01.1985'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired

-- Problem 12.	* Rich Wizard, Poor Wizard
SELECT SUM(differences.Difference) AS SumDifference FROM
(SELECT w.DepositAmount - (SELECT DepositAmount FROM WizzardDeposits AS w2 WHERE Id = w.Id + 1) AS [Difference]
FROM WizzardDeposits AS w) AS differences

-- Problem 13.	Departments Total Salaries
USE SoftUni

SELECT DepartmentID, SUM(Salary) AS TotalSalary 
FROM Employees
GROUP BY DepartmentID

-- Problem 14.	Employees Minimum Salaries
SELECT DepartmentID, MIN(Salary) AS MinimumSalary 
FROM Employees
WHERE DepartmentID IN (2,5,7)
GROUP BY DepartmentID

-- Problem 15.	Employees Average Salaries
SELECT * INTO MyNewTable
FROM Employees
WHERE Salary > 30000

DELETE FROM MyNewTable WHERE ManagerID = 42

UPDATE MyNewTable
SET Salary = Salary + 5000 
WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary) AS AverageSalary 
FROM MyNewTable
GROUP BY DepartmentID

-- Problem 16.	Employees Maximum Salaries
SELECT DepartmentID, MAX(Salary) AS MaxSalary 
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

-- Problem 17.	Employees Count Salaries
SELECT COUNT(Salary) AS [Count] FROM Employees WHERE ManagerID IS NULL

-- Problem 18.	*3rd Highest Salary
SELECT e1.DepartmentID, MAX(Salary) AS MaxSalary
FROM Employees AS e1
	INNER JOIN
	(
	SELECT e2.DepartmentID, MAX(Salary) AS MaxSalary
	FROM Employees AS e2
		INNER JOIN (
			SELECT DepartmentID, MAX(Salary) AS MaxSalary
			FROM Employees
			GROUP BY DepartmentID
		) AS thirdMaxSalaries ON thirdMaxSalaries.DepartmentID = e2.DepartmentID AND thirdMaxSalaries.MaxSalary > e2.Salary
	GROUP BY e2.DepartmentID
	) AS secondMaxSalaries ON secondMaxSalaries.DepartmentID = e1.DepartmentID AND secondMaxSalaries.MaxSalary > e1.Salary
GROUP BY e1.DepartmentID
ORDER BY e1.DepartmentID


SELECT DepartmentID, Salary
FROM Employees AS e1
ORDER BY DepartmentID, Salary

-- Problem 19.	**Salary Challenge
SELECT TOP 10
	e.FirstName,
	e.LastName,
	e.DepartmentID, 
	e.Salary,
	(SELECT
		AVG(a.Salary) FROM Employees as a
		WHERE a.DepartmentID = e.DepartmentID) AS Average
	FROM Employees AS e
	WHERE e.Salary > (SELECT
		AVG(e2.Salary) FROM Employees AS e2
		WHERE e2.DepartmentID = e.DepartmentID)
ORDER BY e.DepartmentID