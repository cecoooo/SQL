-- 1
use SoftUni

SELECT TOP(5) 
	e.EmployeeID
	,e.JobTitle
	,a.AddressID
	,a.AddressText 
FROM Employees e
JOIN Addresses a on a.AddressID = e.AddressID
ORDER BY a.AddressID;

-- 2
SELECT TOP(50)
	e.FirstName
	,e.LastName
	,t.[Name] Town
	,a.AddressText 
FROM Employees e
JOIN Addresses a ON e.AddressID = a.AddressID
JOIN Towns t ON t.TownID = a.TownID
ORDER BY e.FirstName, e.LastName;

-- 3
SELECT TOP(50) 
	e.EmployeeID
	,e.FirstName
	,e.LastName
	,d.[Name] DepartmentName 
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.[Name] = 'Sales'
ORDER BY e.EmployeeID;

-- 4
SELECT TOP(5) 
	e.EmployeeID
	,e.FirstName
	,e.Salary
	,d.[Name] DepartmentName 
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID;

-- 5
SELECT TOP(3) 
	e.EmployeeID
	,e.FirstName 
FROM Employees e
LEFT JOIN EmployeesProjects ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.EmployeeID IS NULL
ORDER BY e.EmployeeID;

-- 6
SELECT 
	e.FirstName
	,e.LastName
	,e.HireDate
	,d.[Name] 
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE e.HireDate > '01-01-1999' AND (d.[Name] = 'Sales' OR d.[Name] = 'Finance')
ORDER BY e.HireDate;

-- 7
SELECT TOP(5) 
	e.EmployeeID	
	,e.FirstName
	,p.[Name] ProjectName 
FROM Employees e
JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects p ON p.ProjectID = ep.ProjectID
WHERE FORMAT(p.StartDate, 'dd-MM-yyyy') > '13-08-2002' AND p.EndDate IS NULL	
ORDER BY e.EmployeeID;

-- 8
SELECT 
	e.EmployeeID
	,e.FirstName
	,CASE 
	WHEN
		DATEPART(year, p.StartDate) >= 2005 
		THEN NULL
		ELSE p.[Name]
	END ProjectName
FROM Employees e
JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects p ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24;

-- 9
SELECT 
	e.EmployeeID
	,e.FirstName
	,e.ManagerID
	,m.FirstName ManagerName 
FROM Employees e
JOIN Employees m ON m.EmployeeID = e.ManagerID
WHERE e.ManagerID IN (3,7)
ORDER BY e.EmployeeID;

-- 10
SELECT TOP(50)
	e.EmployeeID 
	,CONCAT_WS(' ', e.FirstName, e.LastName) EmployeeName
	,CONCAT_WS(' ' , m.FirstName, m.LastName) ManagerName
	,d.[Name] DepartmentName	
FROM Employees e
LEFT JOIN Employees m ON m.EmployeeID = e.ManagerID
LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID
ORDER BY EmployeeID;

-- 11
SELECT TOP(1) 
	AVG(e.Salary) MinAverageSalary 
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY e.DepartmentID
ORDER BY MinAverageSalary;