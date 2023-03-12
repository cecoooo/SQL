create database tutorial;
use tutorial;

create table Customers(
	CustomerID int primary key auto_increment,
	CustomerName varchar(50) not null,
	ContactName varchar(50) not null,
	Address varchar(50) not null,
	City varchar(20) not null,
	PostalCode varchar(10) not null,
	Country varchar(20) not null
);

insert into Customers(CustomerName, ContactName, Address, City, PostalCode, Country)
values("Alfreds Futterkiste", "Maria Anders", "Obere Str. 57", "Berlin", "12209", "Germany"), 
("Ana Trujillo Emparedados y helados", "Ana Trujillo", "Avda. de la Constitución 2222", "México D.F.", "05021", "Mexico"),
("Antonio Moreno Taquería", "Antonio Moreno", "Mataderos 2312", "México D.F.", "05023", "Mexico"), 
("Around the Horn", "Thomas Hardy", "120 Hanover Sq.", "London", "WA1 1DP", "UK"),
("Berglunds snabbköp", "Christina Berglund", "Berguvsvägen 8", "Luleå", "S-958 22", "Sweden");

# SELECT 
# show some colomns
select CustomerName, Address, City from Customers;
# show whole table
select * from Customers;
# distinct - show only different values
select distinct Country from Customers;
# return the different countries in the table
select count(distinct Country) from Customers;

# WHERE
# - used to filter records.
select CustomerName from Customers where Country = 'Mexico';
select CustomerName from Customers where CustomerID > 1;
select CustomerName from Customers where CustomerID <= 3;
select CustomerName from Customers where CustomerID <> 5;
# AND, OR, NOT
select CustomerName from Customers where CustomerID between 2 and 4;
select CustomerName from Customers where Country = 'Mexico' and City = 'México D.F.';
select CustomerName from Customers where Country = 'Sweden' or Country = 'Mexico';
select CustomerName from Customers where not City = 'Berlin';
select CustomerName from Customers where ContactName = 'Ana Trujillo' and (Country = 'Mexico' or Country = 'Germany');

# ORDER BY
select CustomerName, Country from Customers order by Country;
select CustomerName, Country from Customers order by Country desc;
select CustomerName, Country from Customers order by Country, CustomerName;
select CustomerName, Country from Customers order by Country asc, CustomerName desc;

# INSERT INTO
insert into Customers
values(6, 'Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');
insert into Customers(CustomerName, ContactName, Address, City, PostalCode, Country)
values("Wolski", "Zbyszek", "ul. Filtrowa 68", "Walla", "01-012", "Poland");

# IS NULL, IS NOT NULL
select CustomerName, City from Customers
where Address is null;
select CustomerName, City from Customers
where Address is not null;

# UPDATE
update Customers
set ContactName = 'Alfred Schmidt', City = 'Frankfurt'
where CustomerID = 1;
update Customers
set PostalCode = '0000000'
where City = 'Mexico';

# DELETE
delete from Customers where ContactName = 'Alfred Schmidt';
# delete all records without deleting table
delete from Customers;

# LIMIT
select ContactName from Customers limit 3;
select ContactName from Customers where Country = 'Mexico' limit 3;

create table Products(
	ProductID int primary key auto_increment,
    ProductName varchar(50), 
    SupplierID int,
    CategoryID int, 
    Unit varchar(50),
    Price double
);	

insert into Products(ProductName, SupplierID, CategoryID, Unit, Price)
values('Chais',	1, 1, '10 boxes x 20 bags',	18),
('Chang', 1, 1, '24 - 12 oz bottles',	19),
('Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10), 
("Chef Anton's Cajun Seasoning", 2, 2,	'48 - 6 oz jars', 22),
("Chef Anton's Gumbo Mix", 2, 2, '36 boxes', 21.35);


# MIN, MAX
select min(Price) from Products where Price > 12;
select max(City) from Customers;
select min(Price) as cheapestProduct from Products;
select max(Price) as mostExpensiveProductUnder22 from Products where Price < 22;

# COUNT, AVG, SUM
select count(ProductName) from Products where SupplierID = 2;
select count(ProductName) from Products;
select avg(Price) as averagePrice from Products;
select sum(Price) as totalSum from Products;

# LIKE





