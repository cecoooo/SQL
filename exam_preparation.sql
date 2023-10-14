CREATE DATABASE Boardgames;
USE Boardgames;

-- 1
CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Addresses(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,StreetName VARCHAR(100) NOT NULL
	,StreetNumber INT NOT NULL
	,Town NVARCHAR(30) NOT NULL
	,Country NVARCHAR(50) NOT NULL
	,ZIP INT NOT NULL
)

CREATE TABLE Publishers(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,[Name] NVARCHAR(30)	NOT NULL UNIQUE
	,AddressId INT NOT NULL FOREIGN KEY REFERENCES Addresses(Id) ON DELETE CASCADE
	,Website VARCHAR(40)
	,Phone VARCHAR(20)
)

CREATE TABLE PlayersRanges(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,PlayersMin INT NOT NULL
	,PlayersMax INT NOT NULL
)

CREATE TABLE Boardgames(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,[Name] VARCHAR(30) NOT NULL
	,YearPublished INT NOT NULL
	,Rating DECIMAL(9,2) NOT NULL
	,CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id) ON DELETE CASCADE
	,PublisherId INT NOT NULL FOREIGN KEY REFERENCES Publishers(Id) ON DELETE CASCADE 
	,PlayersRangeId INT NOT NULL FOREIGN KEY REFERENCES PlayersRanges(Id) ON DELETE CASCADE
)

CREATE TABLE Creators(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,FirstName VARCHAR(30) NOT NULL
	,LastName VARCHAR(30) NOT NULL
	,Email VARCHAR(30) NOT NULL
)

CREATE TABLE CreatorsBoardgames(
	CreatorId INT NOT NULL FOREIGN KEY REFERENCES Creators(Id) ON DELETE CASCADE
	,BoardgameId INT NOT NULL FOREIGN KEY REFERENCES Boardgames(Id) ON DELETE CASCADE
	,CONSTRAINT PK_CreatorsBoardgames PRIMARY KEY(CreatorId, BoardgameId)
)

-- 2
INSERT INTO Boardgames([Name], YearPublished, Rating, CategoryId, PublisherId, PlayersRangeId)
VALUES
('Deep Blue', 2019, 5.67, 1, 15, 7),
('Paris', 2016, 9.78, 7, 1, 5),
('Catan: Starfarers', 2021, 9.87, 7, 13, 6),
('Bleeding Kansas', 2020, 3.25, 3, 7, 4),
('One Small Step', 2019, 5.75, 5, 9, 2)

INSERT INTO Publishers([Name], AddressId, Website, Phone)
VALUES
('Agman Games', 5, 'www.agmangames.com', '+16546135542'),
('Amethyst Games', 7, 'www.amethystgames.com', '+15558889992'),
('BattleBooks', 13, 'www.battlebooks.com', '+12345678907')

-- 3
UPDATE pr
SET pr.PlayersMax += 1
FROM PlayersRanges pr
JOIN Boardgames b ON b.PlayersRangeId = pr.Id
WHERE pr.PlayersMax = 2 AND pr.PlayersMin = 2;

UPDATE Boardgames
SET [Name] = CONCAT_WS('', [Name], 'V2')
WHERE YearPublished >= 2020;

-- 4
DELETE FROM Addresses
WHERE Town LIKE 'T%' OR Country LIKE 'T%';

SELECT COUNT(*) FROM Addresses
SELECT COUNT(*) FROM Boardgames
SELECT COUNT(*) FROM CreatorsBoardgames
SELECT COUNT(*) FROM Publishers

-- 5
SELECT  
	[Name]
	,Rating
FROM Boardgames
ORDER BY YearPublished, [Name] DESC

-- 6
SELECT 
	b.Id 
	,b.[Name]
	,b.YearPublished
	,c.[Name] CategoryName
FROM Boardgames b
JOIN Categories c ON b.CategoryId = c.Id
WHERE c.[Name] = 'Strategy Games' OR c.[Name] = 'Wargames'
ORDER BY b.YearPublished DESC

-- 7
SELECT 
	c.Id
	,CONCAT_WS(' ', c.FirstName, c.LastName) CreatorName
	,c.Email
FROM Creators c
FULL OUTER JOIN CreatorsBoardgames cb ON cb.CreatorId = c.Id
FULL OUTER JOIN Boardgames b ON cb.BoardgameId = b.Id
WHERE cb.BoardgameId IS NULL 

-- 8
SELECT TOP(5)
	b.[Name]
	,b.Rating
	,c.[Name] CategoryName
FROM Boardgames b
JOIN PlayersRanges p ON b.PlayersRangeId = p.Id
JOIN Categories c ON c.Id = b.CategoryId
WHERE (b.Rating > 7 AND b.Name LIKE '%a%') OR (b.Rating > 7.50 AND p.PlayersMax = 5 AND p.PlayersMin = 2)
ORDER BY b.[Name], b.Rating DESC

-- 9
SELECT 
	CONCAT_WS(' ', c.FirstName, c.LastName) FullName
	,c.Email
	,MAX(b.Rating)
FROM Creators c
JOIN CreatorsBoardgames cb ON cb.CreatorId = c.Id
JOIN Boardgames b ON cb.BoardgameId = b.Id
WHERE c.Email LIKE '%.com'
GROUP BY CONCAT_WS(' ', c.FirstName, c.LastName), c.Email
ORDER BY FullName

-- 10
SELECT 
	c.LastName
	,CEILING(AVG(b.Rating)) AverageRating
	,p.[Name] PublisherName
FROM Creators c
JOIN CreatorsBoardgames cb ON cb.CreatorId = c.Id
JOIN Boardgames b ON b.Id = cb.BoardgameId
JOIN Publishers p ON p.Id = b.PublisherId
GROUP BY c.LastName, p.[Name]
HAVING p.[Name] = 'Stonemaier Games'
ORDER BY AverageRating DESC, LastName

-- 11
CREATE FUNCTION udf_CreatorWithBoardgames(@name VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @res INT; 
	SET @res = (SELECT 
		COUNT(*)
	FROM Creators c
	JOIN CreatorsBoardgames cb ON c.Id = cb.CreatorId
	JOIN Boardgames b ON b.Id = cb.BoardgameId
	WHERE c.FirstName = @name);
	RETURN @res;
END;

SELECT dbo.udf_CreatorWithBoardgames('Bruno')

-- 12
CREATE PROCEDURE usp_SearchByCategory @category VARCHAR(50)
AS
BEGIN
	SELECT 
		b.[Name]
		,b.YearPublished
		,b.Rating
		,c.[Name] CategoryName
		,p.[Name] PublisherName
		,CONCAT_WS(' ', pr.PlayersMin, 'people') PlayersMin
		,CONCAT_WS(' ', pr.PlayersMax, 'people') PlayersMax
	FROM Boardgames b
	JOIN PlayersRanges pr ON b.PlayersRangeId = pr.Id
	JOIN Publishers p ON p.Id = b.PublisherId
	JOIN Categories c ON b.CategoryId = c.Id
	WHERE c.[Name] = @category
	ORDER BY PublisherName, YearPublished DESC
END

EXEC usp_SearchByCategory 'Wargames'