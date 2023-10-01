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