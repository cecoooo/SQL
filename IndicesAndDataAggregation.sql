USE [Gringotts]

-- 1
SELECT COUNT(*) [Count] FROM WizzardDeposits;

-- 2
SELECT MAX(MagicWandSize) LongestMagicWand FROM WizzardDeposits;

-- 3
SELECT
	DepositGroup,  
	MAX(MagicWandSize) LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup

-- 4
SELECT TOP(2)
	DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

-- 5

SELECT 
	DepositGroup,
	SUM(DepositAmount) TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup

-- 6
SELECT 
	DepositGroup,
	SUM(DepositAmount) TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

-- 7
SELECT 
	DepositGroup,
	SUM(DepositAmount) TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

-- 8
SELECT 
	DepositGroup
	,MagicWandCreator
	,MIN(DepositCharge) MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

-- 9


-- 10
SELECT 
	SUBSTRING(FirstName, 1, 1) FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest' 
GROUP BY SUBSTRING(FirstName, 1, 1)
ORDER BY FirstLetter

-- 11
SELECT 
	DepositGroup
	,IsDepositExpired
	,AVG(DepositInterest) AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate > '01-01-1985'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired 

-- 12


-- 13
USE SoftUni

SELECT 
	d.DepartmentID
	,SUM(e.Salary) TotalSalary
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentID
ORDER BY d.DepartmentID;

-- 14
SELECT 
	d.DepartmentID
	,MIN(e.Salary) MinimumSalary
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE HireDate > '01-01-2000'
GROUP BY d.DepartmentID
HAVING d.DepartmentID IN(2, 5, 7)
ORDER BY d.DepartmentID;

-- 15


-- 16
SELECT 
	e.DepartmentID
	,MAX(Salary) MaxSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY e.DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000;

-- 17
SELECT 
	COUNT(*) [Count]
FROM Employees
WHERE ManagerID IS NULL;

-- 18
SELECT 
	DepartmentID
	,(
		SELECT TOP 1
			Salary
		FROM (
		SELECT Salary FROM 
			(SELECT TOP 3 
			Salary 
			FROM Employees ee
			WHERE e.DepartmentID = ee.DepartmentID
			ORDER BY Salary DESC) t1
		) t
		ORDER BY Salary ASC
	) ThirdHighestSalary
FROM Employees e
GROUP BY DepartmentID

-- 19