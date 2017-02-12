BEGIN TRANSACTION

ALTER TABLE [dbo].[EmployeesProjects]
DROP CONSTRAINT [FK_EmployeesProjects_Employees]

ALTER TABLE [dbo].[EmployeesProjects]
ADD CONSTRAINT [FK_EmployeesProjects_Employees] FOREIGN KEY (EmployeeID)
REFERENCES Employees(EmployeeID) ON DELETE CASCADE

ALTER TABLE Employees
DROP CONSTRAINT [FK_Employees_Employees]

ALTER TABLE Employees
DROP CONSTRAINT [FK_Employees_Departments]

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID) ON DELETE CASCADE

DELETE FROM Departments
WHERE Name IN ('Production', 'Production Control')

ROLLBACK