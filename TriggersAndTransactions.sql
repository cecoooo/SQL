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