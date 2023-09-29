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

-- 12
USE	[Geography]

SELECT 
	c.CountryCode
	,m.MountainRange
	,p.PeakName
	,p.Elevation
FROM Peaks p
JOIN Mountains m ON p.MountainId = m.Id
JOIN MountainsCountries mc ON m.Id = mc.MountainId
JOIN Countries c ON c.CountryCode = mc.CountryCode
WHERE p.Elevation > 2835 AND c.CountryCode = 'BG'
ORDER BY p.Elevation DESC;

-- 13
SELECT 
	c.CountryCode
	,COUNT(m.MountainRange) MountainRanges
FROM Countries c
JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
JOIN Mountains m ON m.Id = mc.MountainId
GROUP BY c.CountryCode
HAVING c.CountryCode in ('BG', 'RU', 'US')

-- 14
SELECT TOP(5)
	c.CountryName
	,r.RiverName
FROM Countries c
LEFT JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers r ON r.Id = cr.RiverId
JOIN Continents cn ON c.ContinentCode = cn.ContinentCode
WHERE cn.ContinentCode = 'AF'
ORDER BY c.CountryName;

-- 15
SELECT 
	co.ContinentCode
	,cu.CurrencyCode
	,c.*
FROM Continents co
JOIN Countries c ON c.ContinentCode = co.ContinentCode
JOIN Currencies cu ON cu.CurrencyCode = c.CurrencyCode
GROUP BY co.ContinentCode, cu.CurrencyCode

SELECT 
	cu.CurrencyCode
	,c.CountryName
FROM Currencies cu
JOIN Countries c ON c.CurrencyCode = cu.CurrencyCode
GROUP BY cu.CurrencyCode

-- 16
SELECT COUNT(*) Count FROM Countries c
LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
WHERE MC.MountainId IS NULL;

-- 17
SELECT TOP(5)
	c.CountryName
	,MAX(p.Elevation) HighestPeakElevation
	,MAX(r.[Length]) LongestRiverLength
FROM Countries c
LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
JOIN Mountains m ON m.id = mc.MountainId
JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
JOIN Rivers r ON r.Id = cr.RiverId
JOIN Peaks p ON p.MountainId = m.id
GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, c.CountryName;

