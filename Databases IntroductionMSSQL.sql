-- Problem01
CREATE DATABASE [Minions]
USE Minions

-- Problem02
CREATE TABLE [Minions](
	[id] INT PRIMARY KEY,
	[name] VARCHAR(50),
	[age] INT 
)

CREATE TABLE Towns(
	[id] int primary key,
	[name] varchar(50)
)

-- Problem03
alter table [Minions] add [townId] int;
alter table [Minions] add constraint [refToTowns] foreign key([townId]) references [Towns]([id]);

-- Problem04
insert into [Towns]([id], [name])
values
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

insert into [Minions]([id], [name], [age], [townId])
values 
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', null, 2)

-- Problem05
truncate table [Minions];

-- Problem06
drop table [Towns];
drop table [Minions];

-- Problem07

create table [People](
	[id] int identity(1,1) primary key,
	[name] nvarchar(200) not null,
	[picture] varbinary(max),
	check (datalength([picture]) <= 2000000),
	[height] decimal(3, 2),
	[weight] decimal(5, 2),
	[gender] char(1) NOT NULL CHECK (gender IN('f', 'm')),
	[birthdate] date not null,
	[biography] nvarchar(2000)
);

Insert into [People] ([name], [height], [weight], [gender], [birthdate], [biography])
values('Gosho', 1.80, 75, 'm', '2000-12-05', 'bla bla'),
('Pesho', 1.90, 95.8, 'm', '1990-06-09', null),
('Maria', 1.60, 50, 'f', '2002-11-30', null),
('Stavri', 1.73, 75, 'm', '1975-08-31', 'bate stavri'),
('Vicky', 1.67, 56, 'f', '2004-03-13', null);

-- Problem08

create table [Users](
	[id] bigint identity(1,1),
	constraint PK_Users primary key(id),
	[username] varchar(30) not null unique,
	[password] varchar(26) not null,
	[ProfilePicture] varbinary(max),
	check (datalength([ProfilePicture]) <= 900000),
	[LastLoginTime] datetime2,
	[isDeleted] bit default 0
)

insert into [Users]([username], [password], [ProfilePicture], [LastLoginTime], [isDeleted])
values('user1', 'pass1', null, '2023-09-16 09:25:03', 0),
('user2', 'pass2', null, '2023-09-14 23:53:00', 0),
('user3', 'pass3', null, '2023-09-16 11:32:40', 0),
('user4', 'pass4', null, '2023-09-13 14:01:06', 0),
('user5', 'pass5', null, '2022-12-01 18:02:59', 1)

-- Problem09

alter table [Users] drop constraint PK_Users;
alter table [Users]
add constraint PK_Users primary key(id, username);

-- Problem10

alter table [Users] add constraint CK_Pass_Users
check (datalength([password]) >= 5);

-- Problem11

alter table [Users]
add default CURRENT_TIMESTAMP
for [LastLoginTime];

-- Problem12
go
alter table [Users]
drop constraint PK_Users;
go
alter table [Users]
add constraint PK_Users
primary key(id);
go
alter table [Users]
add constraint CK_Username_Users
check(datalength([username]) >= 3)
go

-- Problem13
go

create database [Movies]

go

use [Movies]

go

create table [Directors](
	[id] int identity(1,1),
	constraint PK_Directors primary key([id]),
	[directorName] varchar(150) not null,
	[notes] text
)

create table [Genres](
	[id] int identity(1,1),
	constraint PK_Genres primary key([id]),
	[genreName] varchar(100) not null,
	[notes] text,
)

create table [Categories](
	[id] int identity(1,1),
	constraint PK_Categories primary key([id]),
	[CategoryName] varchar(100) not null,
	[notes] text
)

go

create table [Movies](
	[id] int identity(1,1),
	constraint PK_Movies primary key(id),
	[Title] varchar(100) not null,
	[DirectorId] int not null foreign key references [Directors](id),
	[CopyrightYear] date,
	[Length] int not null,
	[GenreId] int not null foreign key references [Genres](id),
	[CategoryId] int not null foreign key references [Categories](id),
	[Rating] decimal,	
	Notes text
)

go

INSERT INTO Directors (directorName, notes) VALUES
('Christopher Nolan', 'Renowned director known for his work in the Dark Knight Trilogy.'),
('Quentin Tarantino', 'Famous for his unique storytelling and distinct style.'),
('Steven Spielberg', 'Iconic director behind classics like E.T. and Jurassic Park.'),
('Martin Scorsese', 'Known for his gritty crime dramas like Goodfellas.'),
('Greta Gerwig', 'Acclaimed director of Lady Bird and Little Women.');

INSERT INTO Genres (genreName, notes) VALUES
('Action', 'Movies filled with exciting action sequences.'),
('Drama', 'Films that focus on character development and emotions.'),
('Sci-Fi', 'Science fiction movies set in the future or alternate realities.'),
('Comedy', 'Movies designed to make you laugh.'),
('Thriller', 'Suspenseful films that keep you on the edge of your seat.');

INSERT INTO Categories (CategoryName, notes) VALUES
('Adventure', 'Movies that take you on epic journeys.'),
('Romance', 'Love stories that tug at your heartstrings.'),
('Horror', 'Films designed to scare and thrill audiences.'),
('Fantasy', 'Movies set in magical worlds with fantastical elements.'),
('Mystery', 'Puzzling films that challenge you to solve the mystery.');

go

INSERT INTO Movies (Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes) VALUES
('Inception', 1, '2010-07-16', 148, 3, 1, 8.8, 'Mind-bending science fiction.'),
('Pulp Fiction', 2, '1994-10-14', 154, 4, 5, 8.9, 'Quentin Tarantino classic.'),
('Jurassic Park', 3, '1993-06-11', 127, 1, 1, 8.1, 'Dinosaurs come to life.'),
('Goodfellas', 4, '1990-09-19', 146, 2, 5, 8.7, 'Crime drama masterpiece.'),
('Lady Bird', 5, '2017-11-03', 94, 2, 2, 7.4, 'Coming-of-age story.');

go

-- Problem14

create database [CarRental];
use [CarRental]

create table [Categories](
	[id] int identity(1,1),
	constraint PK_Categories primary key([id]),
	[CategoryName] varchar(100) not null,
	[DailyRate] decimal(6, 2) not null,
	[WeeklyRate] decimal(7, 2) not null,
	[MonthlyRate] decimal(8, 2) not null,
	[WeekendRate] decimal(6, 2)
)

create table [Employees](
	[id] int identity(1,1),
	constraint PK_Employees primary key([id]),
	[FirstName] varchar(50) not null,
	[LastName] varchar(50) not null,
	[Title] varchar(100) not null,
	[Notes] text
)

create table [Customers](
	[id] int identity(1,1),
	constraint PK_Customers primary key([id]),
	[DriverLicenceNumber] char(15),
	[FullName] varchar(100) not null,
	[Address] varchar(300) not null,
	[City] varchar(100) not null,
	[ZIPCode] char(4) not null,
	[Notes] text
)

create table [Cars](
	[id] int identity(1,1),
	constraint PK_Cars primary key([id]),
	[PlateNumber] char(8) not null,
	[Manufacturer] varchar(100),
	[Model] varchar(50) not null,
	[CarYear] int not null,
	constraint CK_Cars_CarYear check([CarYear] >= 1900 and [CarYear] <= year(CURRENT_TIMESTAMP)),
	[CategoryId] int null foreign key references [Categories](id),
	[Doors] tinyint not null,
	constraint CK_Cars_Doors check([Doors] = 2 or [Doors] = 4),
	[Picture] varbinary(max),
	constraint CK_Cars_Picture check(datalength([Picture]) <= 10000000),
	[Condition] text,
	[Available] bit default 1
)

create table [RentalOrders](
	[id] int identity(1,1),
	constraint PK_RentalOrders primary key([id]),
	[EmployeeId] int not null foreign key references [Employees](id),
	[CustomerId] int not null foreign key references [Customers](id),
	[CarId] int not null foreign key references [Cars](id),
	[TankLevel] decimal(5,2) not null,
	[KilometrageStart] decimal(9,2) not null,
	[KilometrageEnd] decimal(9,2) not null,
	[TotalKilometrage] decimal(9,2),
	[StartDate] date not null,
	[EndDate] date not null,
	[TotalDays] int,
	[RateApplied] int not null,
	[TaxRate] decimal(9,2) not null,
	[OrderStatus] varchar(50),
	[Notes] text
)

INSERT INTO Categories (CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
('Economy', 35.00, 200.00, 750.00, 40.00),
('Compact', 45.00, 250.00, 900.00, 50.00),
('SUV', 60.00, 350.00, 1200.00, 70.00);


INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES
('John', 'Doe', 'Manager', 'Experienced manager with 10 years in the industry.'),
('Jane', 'Smith', 'Sales Representative', 'Friendly and helpful sales representative.'),
('Mike', 'Johnson', 'Mechanic', 'Skilled mechanic specializing in car maintenance.');


INSERT INTO Customers (DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
VALUES
('DL12345', 'Alice Johnson', '123 Main St', 'Cityville', '1234', 'Frequent customer'),
('DL67890', 'Bob Davis', '456 Elm St', 'Townsville', '5678', 'Corporate account'),
('DL54321', 'Carol Wilson', '789 Oak St', 'Villagetown', '9012', 'Preferred customer');


INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES
('ABC1234', 'Toyota', 'Corolla', 2021, 5, 4, NULL, 'Excellent condition', 1),
('XYZ5678', 'Honda', 'Civic', 2022, 5, 4, NULL, 'Very good condition', 1),
('DEF9012', 'Ford', 'Escape', 2020, 6, 4, NULL, 'Good condition', 1);


INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
VALUES
(1, 1, 5, 0.75, 5000.00, 5050.00, '2023-09-10', '2023-09-15', 5, 200.00, 0.08, 'Completed', 'Satisfied customer'),
(2, 2, 6, 0.80, 3000.00, 3045.00, '2023-09-11', '2023-09-16', 5, 225.00, 0.08, 'Completed', 'Corporate rental'),
(3, 3, 7, 0.70, 7000.00, 7075.00, '2023-09-12', '2023-09-17', 5, 300.00, 0.08, 'Completed', 'Regular customer');

