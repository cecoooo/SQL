-- 1
go
create table Passports(
	passportId int primary key identity(101,1),
	passportNumber char(8) not null
);
go
create table Persons(
	personId int primary key identity(1,1),
	firstName varchar(50) not null,
	salary decimal(9,2),
	passportId int foreign key references Passports(passportId)
);
go

insert into Passports(passportNumber)
values
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2')
go
insert into Persons(firstName, salary, passportId)
values
('Roberto', 43300.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101)
go

-- 2
create table Models(
	ModelId int identity(101,1),
	[Name] varchar(50),
	ManufacturerID int
);

create table Manufacturers(
	ManufacturerID int identity(1,1),
	[Name] varchar(50),
	EstablishedOn date
);

alter table Models 
add constraint PK_Models primary key(ModelId);

alter table Manufacturers 
add constraint PK_Manufacturers primary key(ManufacturerId); 

alter table Models 
add constraint FK_Manufacturers foreign key(ManufacturerID) references Manufacturers(ManufacturerID);


insert into Manufacturers([Name], EstablishedOn)
values
('BMW', '07/03/1916')
,('Tesla','01/01/2003')
,('Lada', '01/05/1966')
;

insert into Models([Name], ManufacturerID)
values
('X1', 1)
,('i6', 1)
,('Model S', 2)
,('Model X', 2)
,('Model 3', 2)
,('Nova', 3)
;

-- 3
create table Students(
	StudentID int primary key identity(1,1),
	[Name] varchar(50) not null
);

create table Exams(
	ExamID int primary key identity(101,1),
	[Name] varchar(50) not null
);

create table StudentsExams(
	StudentID int foreign key references Students(StudentID),
	ExamID int foreign key references Exams(ExamID),
	constraint PK_StudentsExams primary key(StudentID, ExamID)
)


insert into Students([Name])
values
('Mila')
,('Toni')
,('Ron');

insert into Exams([Name])
values
('SpringMVC')
,('Neo4j')
,('Oracle 11g');

insert into StudentsExams(StudentID, ExamID)
values
(1, 101)
,(1, 102)
,(2, 101)
,(3, 103)
,(2, 102)
,(2, 103)

-- 4
create table Teachers(
	TeacherID int primary key identity(101, 1),
	[Name] varchar(50) not null,
	ManagerID int foreign key references Teachers(TeacherID) 
);

insert into Teachers([Name], ManagerID)
values
('John', NULL)
,('Maya', 106)
,('Silvia', 106)
,('Ted', 105)
,('Mark', 101)
,('Greta', 101)
;

-- 5
go
create database ex_5;
go
use ex_5;
go

create table Cities(
	CityID int primary key identity(1,1)
	,[Name] varchar(50) not null
);
go
create table Customers(
	CustomerID int primary key identity(1,1)
	,[Name] varchar(50) not null
	,Birthday date not null
	,CityID int foreign key references Cities(CityID)
);
go
create table ItemTypes(
	ItemTypeID int primary key identity(1, 1)
	,[Name] varchar(50) not null
);
go
create table Items(
	ItemID int primary key identity(1,1)
	,[Name] varchar(50) not null
	,ItemTypeID int foreign key references ItemTypes(ItemTypeID)
);
go
create table Orders(
	OrderID int primary key identity(1,1)
	,CustomerID int foreign key references Customers(CustomerID)
);
go
create table OrderItems(
	OrderId int
	,ItemId int
	constraint PK_OrderItems primary key(OrderID, ItemID)
);
go

-- 6
go
create database ex_6;
go
use ex_6;
go
create table Majors(
	MajorId int primary key identity(1,1)
	,[Name] varchar(50) not null
);
 
create table Subjects(
	SubjectID int primary key identity(1,1)
	,[Name] varchar(50) not null
);
go
create table Students(
	StudentID int primary key identity(1,1)
	,StudentNumber varchar(12)
	,StidentName varchar(50)
	,MajorID int foreign key references Majors(MajorID)
)
go
create table Payments(
	PaymentID int primary key identity(1,1)
	,PaymentDate date not null
	,PaymentAmount decimal(1,1) not null,
	StudentId int foreign key references Students(StudentID)
);
go
create table Agenda(
	StudentID int not null 
	,SubjectID int not null
	,constraint PK_Agenda primary key(StudentID, SubjectID)
);
go

-- 9 
go
use Geography;
go
select m.MountainRange, p.PeakName, p.Elevation from Peaks as p
join Mountains as m on m.Id = p.MountainId
where m.MountainRange = 'Rila'
order by p.Elevation desc;
go