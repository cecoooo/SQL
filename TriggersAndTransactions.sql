USE Bank

-- 1
CREATE TABLE Logs(
	LogId int primary key identity(1,1)
	,AccountId int foreign key references Accounts(Id)
	,OldSum decimal(12, 2) not null
	,NewSum decimal(12, 2) not null
)

CREATE TRIGGER AfterUpdateAccount
ON Accounts
FOR UPDATE
AS
BEGIN
	INSERT INTO Logs(AccountId, OldSum, NewSum)
	SELECT 
		i.Id
		,d.Balance
		,i.Balance
	FROM inserted i
	JOIN deleted d ON i.Id = d.Id
END

-- 2
CREATE TABLE NotificationEmails(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,Recipient INT NOT NULL
	,[Subject] TEXT NOT NULL
	,Body TEXT NOT NULL
)

CREATE TRIGGER SendEmail
ON Logs
FOR INSERT
AS
BEGIN
	INSERT INTO NotificationEmails(Recipient, [Subject], Body)
	SELECT 
		i.AccountId
		,(SELECT CONCAT_WS(' ', 'Balance change for account:', i.AccountId))
		,(SELECT CONCAT_WS(' ', 'On', GETDATE(), 'your balance was changed from', i.OldSum, 'to', i.NewSum))
	FROM inserted i
END

UPDATE Accounts
SET Balance /= 1.1
WHERE id = 1;

-- 3
CREATE OR ALTER PROCEDURE usp_DepositMoney @AccountId INT, @MoneyAmount DECIMAL(12, 4)
AS
BEGIN 
	BEGIN TRANSACTION 
	UPDATE Accounts
	SET Balance += @MoneyAmount
	WHERE Id = @AccountId
	
	IF @@ROWCOUNT <> 1 OR @MoneyAmount < 0
	BEGIN
		ROLLBACK;
	END
	COMMIT
END

-- 4
CREATE OR ALTER PROCEDURE usp_WithdrawMoney @AccountId INT, @MoneyAmount DECIMAL(12, 4)
AS
BEGIN 
	BEGIN TRANSACTION 
	UPDATE Accounts
	SET Balance -= @MoneyAmount
	WHERE Id = @AccountId
	
	IF @@ROWCOUNT <> 1 OR @MoneyAmount < 0
	BEGIN
		ROLLBACK;
	END
	COMMIT
END

-- 5
CREATE OR ALTER PROCEDURE usp_TransferMoney @SenderId INT, @ReceiverId INT, @Amount DECIMAL(12, 4)
AS
BEGIN
	BEGIN TRANSACTION

	UPDATE Accounts
	SET Balance += @Amount
	WHERE Id = @ReceiverId

	UPDATE Accounts
	SET Balance -= @Amount
	WHERE Id = @SenderId

	COMMIT
END

--Test
usp_TransferMoney @SenderId = 2, @ReceiverId = 1, @Amount = 10

-- 6
USE Diablo


-- 7
BEGIN TRANSACTION

UPDATE UsersGames
SET Cash -= (
	SELECT 
	SUM(i.Price)
	FROM Users u
	JOIN UsersGames ug ON u.Id = ug.UserId
	JOIN Games g ON ug.GameId = g.Id
	JOIN UserGameItems ugi ON ugi.UserGameId = ug.Id
	JOIN Items i ON i.Id = ugi.ItemId
	WHERE ug.[Level] IN(11,12,19,20,21)  
)
WHERE id = (SELECT TOP(1)
	ug.Id
FROM Users u
JOIN UsersGames ug ON ug.UserId = u.Id
JOIN Games g ON g.Id = ug.GameId
WHERE u.Username = 'Stamat' AND g.Name = 'Safflower')

IF (SELECT TOP(1)
	Cash
FROM UsersGames
WHERE Id = (SELECT TOP(1)
	ug.Id
FROM Users u
JOIN UsersGames ug ON ug.UserId = u.Id
JOIN Games g ON g.Id = ug.GameId
WHERE u.Username = 'Stamat' AND g.Name = 'Safflower')) < 0
BEGIN 
	ROLLBACK
END

INSERT INTO UserGameItems(ItemId, UserGameId)
SELECT 
	i.id
	,(SELECT TOP(1)
	ug.Id
FROM Users u
JOIN UsersGames ug ON ug.UserId = u.Id
JOIN Games g ON g.Id = ug.GameId
WHERE u.Username = 'Stamat' AND g.Name = 'Safflower')
FROM Items i
JOIN UserGameItems ugi ON i.Id = ugi.ItemId
JOIN UsersGames ug ON ug.Id = ugi.UserGameId
WHERE [Level] IN(11,12,19,20,21)  

COMMIT

-- 8
USE SoftUni

CREATE PROCEDURE usp_AssignProject @emloyeeId INT, @projectID INT
AS
BEGIN 
	BEGIN TRANSACTION
	DECLARE @numOfProjects INT;
	SELECT @numOfProjects = COUNT(*) FROM EmployeesProjects
	WHERE EmployeeID = @emloyeeId

	IF @numOfProjects > 3 
	BEGIN;
		THROW 16, 'The employee has too many projects!', 1
	END;

	INSERT INTO EmployeesProjects(EmployeeID, ProjectID)
	VALUES(@emloyeeId, @projectID)

	COMMIT
END

-- 9 
CREATE TABLE Deleted_Employees(
EmployeeId INT PRIMARY KEY IDENTITY(1,1)
,FirstName VARCHAR(100) NOT NULL
,LastName VARCHAR(100) NOT NULL
,MiddleName VARCHAR(100) NOT NULL
,JobTitle VARCHAR(100) NOT NULL
,DepartmentId INT FOREIGN KEY REFERENCES Departments(DepartmentID) 
,Salary DECIMAL(9,2)
)

CREATE TRIGGER AfterFiringEmployees
ON Employees
FOR DELETE
AS
BEGIN
	INSERT INTO Deleted_Employees(FirstName, LastName, MiddleName, JobTitle, DepartmentId, Salary)
	SELECT 
		FirstName
		,LastName
		,MiddleName
		,JobTitle
		,DepartmentID
		,Salary
	FROM deleted
END