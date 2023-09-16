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