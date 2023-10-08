-- 7
USE SoftUni;

CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @I INT = 1;
	WHILE @I <= LEN(@word)
	BEGIN
		IF @setOfLetters NOT LIKE '%' + SUBSTRING(@word, @I, 1) + '%'
		BEGIN
			RETURN 0;
		END
		SET @I = @I + 1;
	END
	RETURN 1;
END;

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'halves')

-- 9
use Bank;

CREATE OR ALTER PROCEDURE usp_GetHoldersFullName 
AS 
SELECT 
	CONCAT_WS(' ', FirstName, LastName) [Full Name]
FROM AccountHolders

EXEC usp_GetHoldersFullName

-- 10
CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan @number decimal(9,2)
AS
SELECT
	ah.FirstName [First Name]
	,ah.LastName [Last Name]
FROM AccountHolders ah
JOIN Accounts a ON a.AccountHolderId = ah.Id
WHERE a.Balance > @number
ORDER BY FirstName, LastName

EXEC dbo.usp_GetHoldersWithBalanceHigherThan @number = 421343


-- 11
CREATE OR ALTER FUNCTION ufn_CalculateFutureValue(@I DECIMAL(12, 4), @R FLOAT, @T INT)
RETURNS DECIMAL(12, 4)
AS
BEGIN
	RETURN @I*(POWER(1+@R, @T))
END

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)

-- 12
CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount @AccountId INT, @InterestRate FLOAT
AS
SELECT 
	a.Id [Account Id]
	,ah.FirstName [First Name]
	,ah.LastName [Last Name]
	,a.Balance [Current Balance]
	,dbo.ufn_CalculateFutureValue(Balance, @InterestRate, 5) [Balance in 5 years]
FROM AccountHolders ah
JOIN Accounts a ON a.AccountHolderId = ah.Id
WHERE a.Id = @AccountId

EXEC usp_CalculateFutureValueForAccount @AccountId = 1, @InterestRate = 0.1

-- 13
USE Diablo;

CREATE FUNCTION ufn_CashInUsersGames(@name VARCHAR(50))
RETURNS TABLE
AS
RETURN 
SELECT 
	SUM(Cash) SumCash
FROM UsersGames ug
JOIN Games g ON g.Id = ug.GameId
WHERE g.[Name] = @name AND ug.Id % 2 = 1


select * from dbo.ufn_CashInUsersGames('Love in a mist')

sele