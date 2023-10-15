CREATE DATABASE TouristAgency;
USE TouristAgency;

-- 1
CREATE TABLE Countries(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Destinations(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,[Name] NVARCHAR(50) NOT NULL
	,CountryId INT NOT NULL FOREIGN KEY REFERENCES Countries(Id) ON DELETE CASCADE
)

CREATE TABLE Rooms(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,[Type] NVARCHAR(40) NOT NULL
	,Price DECIMAL(18,2) NOT NULL
	,BedCount INT NOT NULL	
)

CREATE TABLE Hotels(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,[Name] NVARCHAR(50) NOT NULL
	,DestinationId INT NOT NULL FOREIGN KEY REFERENCES Destinations(Id) ON DELETE CASCADE
)

CREATE TABLE Tourists(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,[Name] VARCHAR(80) NOT NULL
	,PhoneNumber VARCHAR(20) NOT NULL
	,Email VARCHAR(80)
	,CountryId INT NOT NULL FOREIGN KEY REFERENCES Countries(Id) ON DELETE CASCADE
)

CREATE TABLE Bookings(
	Id INT PRIMARY KEY IDENTITY(1,1)
	,ArrivalDate DATETIME2 NOT NULL
	,DepartureDate DATETIME2 NOT NULL
	,AdultsCount INT NOT NULL
	,ChildrenCount INT NOT NULL
	,TouristId INT NOT NULL FOREIGN KEY REFERENCES Tourists(Id) ON DELETE CASCADE
	,HotelId INT NOT NULL FOREIGN KEY REFERENCES Hotels(Id) ON DELETE CASCADE
	,RoomId INT NOT NULL FOREIGN KEY REFERENCES Rooms(Id) ON DELETE CASCADE
)

CREATE TABLE HotelsRooms(
	HotelId INT NOT NULL FOREIGN KEY REFERENCES Hotels(Id) ON DELETE CASCADE
	,RoomId INT NOT NULL FOREIGN KEY REFERENCES Rooms(Id) ON DELETE CASCADE
	CONSTRAINT PK_HotelsRooms PRIMARY KEY(HotelId, RoomId)
)

-- 2
INSERT INTO Tourists([Name], PhoneNumber, Email, CountryId)
VALUES
('John Rivers', '653-551-1555', 'john.rivers@example.com', 6),
('Adeline Aglaé', '122-654-8726', 'adeline.aglae@example.com', 2),
('Sergio Ramirez', '233-465-2876', 's.ramirez@example.com', 3),
('Johan Müller', '322-876-9826', 'j.muller@example.com', 7),
('Eden Smith', '551-874-2234', 'eden.smith@example.com', 6);

INSERT INTO Bookings(ArrivalDate, DepartureDate, AdultsCount, ChildrenCount, TouristId, HotelId, RoomId)
VALUES
('2024-03-01', '2024-03-11', 1, 0, 21, 3, 5),
('2023-12-28', '2024-01-06', 2, 1, 22, 13, 3),
('2023-11-15', '2023-11-20', 1, 2, 23, 19, 7),
('2023-12-05', '2023-12-09', 4, 0, 24, 6, 4),
('2024-05-01', '2024-05-07', 6, 0, 25, 14, 6);

-- 3
UPDATE Bookings
SET DepartureDate = DATEADD(day, 1, DepartureDate)
WHERE MONTH(ArrivalDate) = 12 AND YEAR(DepartureDate) = 2023;

UPDATE Tourists
SET Email = NULL
WHERE [Name] LIKE '%MA%';

-- 4
ALTER TABLE Tourists
ADD CONSTRAINT fk_employee
FOREIGN KEY (CountryId)
REFERENCES Countries (Id)
ON DELETE CASCADE;

DELETE FROM Tourists
WHERE [Name] LIKE '%Smith';

-- 5
SELECT 
	FORMAT(b.ArrivalDate, 'yyyy-MM-dd') ArrivalDate
	,b.AdultsCount
	,b.ChildrenCount
FROM Bookings b
JOIN Rooms r ON b.RoomId = r.Id 
ORDER BY r.Price DESC, b.ArrivalDate

-- 6
SELECT 
	h.Id
	,[Name]
FROM Hotels h
JOIN HotelsRooms hr ON hr.HotelId = h.Id
JOIN Rooms r ON r.Id = hr.RoomId
WHERE r.[Type] = 'VIP Apartment'
ORDER BY (
		SELECT 
			COUNT(*)
		FROM Bookings
		WHERE HotelId = h.Id
) DESC

-- 7
SELECT 
	t.Id
	,t.[Name]
	,t.PhoneNumber
FROM Tourists t
LEFT JOIN Bookings b ON t.Id = b.TouristId
LEFT JOIN Hotels h ON h.Id = b.HotelId
WHERE HotelId IS NULL 
ORDER BY t.[Name]

-- 8
SELECT TOP(10)
	h.[Name] HotelName
	,d.[Name] DestinationName
	,c.[Name] CountryName
FROM Bookings b
JOIN Hotels h ON h.Id = b.HotelId
JOIN Destinations d ON h.DestinationId = d.Id
JOIN Countries c ON c.Id = d.CountryId
WHERE h.Id % 2 = 1 AND FORMAT(b.ArrivalDate, 'yyyy-MM-dd') < '2023-12-31'
ORDER BY c.[Name], b.[ArrivalDate]

-- 9
SELECT
	h.[Name] HotelName
	,r.Price RoomPrice
FROM Hotels h
JOIN Bookings b ON b.HotelId = h.Id
JOIN Rooms r ON r.Id = b.RoomId
JOIN Tourists t ON t.Id = b.TouristId
WHERE t.[Name] NOT LIKE '%EZ'
ORDER BY RoomPrice DESC

-- 10
SELECT 
	h.[Name] HotelName
	,SUM(r.Price*DATEDIFF(day, b.ArrivalDate, b.DepartureDate)) HotelRevenue
FROM Hotels h 
JOIN Bookings b ON b.HotelId = h.Id
JOIN Rooms r ON r.Id = b.RoomId
GROUP BY h.[Name]
ORDER BY HotelRevenue DESC

-- 11
CREATE OR ALTER FUNCTION udf_RoomsWithTourists(@name VARCHAR(80))
RETURNS INT
AS
BEGIN	
	DECLARE @res INT;
	SET @res = (
		SELECT 
			SUM(b.AdultsCount)+SUM(b.ChildrenCount)
		FROM Rooms r
		JOIN Bookings b ON r.Id = b.RoomId
		GROUP BY r.[Type]
		HAVING r.[Type] = @name
	);
	RETURN @res;
END;

SELECT dbo.udf_RoomsWithTourists('Double Room')

-- 12
CREATE PROCEDURE usp_SearchByCountry @country VARCHAR(50) 
AS
BEGIN
	SELECT 
		t.[Name]
		,t.PhoneNumber
		,t.Email
		,COUNT(b.TouristId) CountOfBookings
	FROM Tourists t
	JOIN Bookings b ON b.TouristId = t.Id
	JOIN Countries c ON c.Id = t.CountryId
	WHERE c.[Name] = @country
	GROUP BY t.[Name], t.[PhoneNumber], t.[Email]
	ORDER BY t.[Name], CountOfBookings
END;

EXEC usp_SearchByCountry 'Greece'