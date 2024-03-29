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
select Country from Customers where CustomerName like 'a%';
select Country from Customers where CustomerName like '%s';
select Country from Customers where City like '__%';
# % _
select Country from Customers where City like '_ondon';
select Price from Products where ProductName like '%ee%';

# IN
select * from Customers where Country in ('UK', 'Sweden', 'Norway');
select CustomerName, Address from Customers where Country not in ('Mexico');
select CustomerName from Customers where Country in(select Country from Customers where Country like '_exico');

# BETWEEN
select * from Products where Price between 10 and 20;
select ProductName from Products where Price not between 10 and 20;
select * from Products where Price not between 10 and 20 and CategoryID not in(1);
select * from Products where ProductName between 'Chais' and 'Aniseed Syrup' order by ProductName;

# ALIAS
select CustomerName as name, ContactName as contact from Customers;
# single or double qoutes if alias name contains space
select CustomerName as name, ContactName as 'Person Contact' from Customers;
# CONCAT_WS() function concatenate contation of several columns into a single text, using separator(first argument)
select CustomerName, concat_ws(', ', Address, PostalCode, City, Country) as address from Customers;
# example:
select c.CustomerName, p.ProductName
from Customers as c, Products as p
where c.Country = 'Sweden' and p.Price > 12;



create table Orders(
	OrderID int primary key auto_increment,
    CustomerID int null,
    ShipperID int null,
    OrderDate datetime,
    constraint foreign key(CustomerID) references Customers(CustomerID),
    constraint foreign key(ShipperID) references Shippers(ShipperID)
);

insert into Orders()
values(null, 4, 1, '1996-9-18'),
(null, 2, 2, '1996-9-19'),
(null, 3, 3, '1996-9-20');

create table Shippers(
	ShipperID int primary key auto_increment,
    ShipperName varchar(20)
);

insert into Shippers()
values(null, 'Ivcho'),
(null, 'Petko'),
(null, 'Ivan');

# JOIN
select c.CustomerName, c.CustomerID, o.OrderID, o.OrderDate from Orders as o
join Customers as c on o.CustomerID = c.CustomerID; 
# numerate all columns you need from both table then numerate all tables, then point the relation 
# Three table relation
select o.OrderID, c.CustomerID, s.ShipperID from
Orders as o join Customers as c on o.CustomerID = c.CustomerID
join Shippers as s on s.ShipperID = o.ShipperID;

# LEFT JOIN
select c.CustomerID ,c.CustomerName, o.OrderDate from customers as c
left join orders as o on c.CustomerID = o.CustomerID;

# RIGHT JOIN
select c.CustomerID, c.CustomerName, o.OrderDate from
customers as c right join orders as o on o.CustomerID = c.CustomerID;

# CROSS JOIN
select c.CustomerName, o.OrderDate from customers as c
cross join orders as o;

# UNION 
select CustomerName from customers
union
select ProductName from products
order by CustomerName;
# unites two columns in a single one

# GROUP BY
select count(CustomerName) from customers
group by Country;
select o.CustomerID, count(c.Country) as 'countries by count' from 
orders as o join customers as c on c.CustomerID = o.CustomerID
group by o.CustomerID;

# HAVING 	
select count(CustomerID), Country
from Customers
group by Country
having count(CustomerID) > 5;

# EXISTS
select CustomerName
from customers 
where exists(select CustomerName from customers 
where CustomerName = 'Ana Trujillo Emparedados y helados');

# ANY, ALL
# ANY - returns all records from table 'customers' which are equal to any of 'CategotyID' from table 'products'  
select CustomerName
from customers
where CustomerID = any (select CategoryID from products);
# ALL - returns all records from table 'customers' which are equal to all of 'CategoryID' from table 'products'
select CustomerName
from customers
where CustomerID = any (select CategoryID from products);

create table suppliers(
SupplierID int primary key auto_increment,
SupplierName varchar(50) not null,
SupplierContactName varchar(50),
SupplierAddress varchar(50) not null,
SupplierCity varchar(20) not null,
SupplierPostalCode varchar(10), 
SupplierCountry varchar(20)
);

# INSERT SELECT
# copy whole table into another
insert into suppliers
select * from customers;
# copy some columns from one to another table
insert into suppliers(SupplierName, SupplierCity, SupplierAddress)
select CustomerName, City, Address from customers;

# CASE
select ProductID, ProductName,
case
	when Price = 18 then 'Price is equal to 18.'
    when Price > 18 then 'Price is bigger than 18.'
    else 'Price is less than 18.'
end as PriceAmount
from products;
# CASE used like order by-then by
select * from products
order by(
	case
		when Price = null then ProductName
        when ProductName = null then SupplierID
        else Price
	end
);

# IFNULL(), COALESCE()
# IFNULL() - takes only two parameters (expresion, value)
select ifnull(supplierContactName, 'defoult value') from suppliers;
# COALESCE() - takes multiple parameters (expresion, [multiple number of values...])
select coalesce(supplierContactName, null, null, 'defoult value') from suppliers;

# comments
-- hello - '-- ' (note the space) make a comment for the given row
# - another way to comment the current row
/*
	comment everything inside
*/

show databases; -- look all created databases
# CREATE DATABASE dbName - create a new database
# DROP DATABASE dbName - remove a database
/* CREATE TABLE tableName( 
	column1 datatype,
    column2 datatype, 
    ...
) - create a new table
  -	first parameter on every row is the name of the column, 
	second one is the datatype that column will hold.
*/	
# DROP TABLE tableName - remove a table from the database
# TRUNCATE TABLE tableName - clear data from the table, but does not remove or delete the table

# ALTER TABLE tableName
-- used to add, delete or modify columns in a table 
# ADD - add new column with specific type of containing data
alter table Customers
add column DateOfBirth datetime;
# MODIFY - changes datatype of the data that given column contains
alter table Customers
modify column DateOfBirth year;
# DROP - drops(remove) a column from the table
alter table Customers
drop column DateOfBirth;

# Constraints - specify rules for data in the table
-- commonly used constraints:
# NOT NULL - Ensures that a column cannot have a null value
create table Persons(
	ID int not null,
    FName varchar(50) not null,
    LName varchar(50) not null,
    Age int
);
# UNIQUE - Ensures that all values in a column are different
create table Persons(
	ID int not null,
    FName varchar(50) not null,
    LName varchar(50),
    Age int,
    unique(ID, FName)
);
alter table Persons
add constraint unique(LName); -- make a field unique, using ALTER
insert into Persons(ID, FName, LName)
values(1, 'miro', 'ivanov'),
(2, 'shisho', 'pertov'),
(3, 'zahari', null); -- unique field can hold one null value
# PRIMARY KEY - Uniquely identifies each row in a table (combines NOT NULL and UNIQUE)
create table Persons(
	ID int,
    FName varchar(50) not null,
    LName varchar(50),
    Age int,
    primary key(ID)
); -- a table could have only one primary key!
create table Persons(
	ID int,
    FName varchar(50) not null,
    LName varchar(50),
    Age int,
    primary key(ID, FName)
); -- Here we have primary key, created by two columns (ID + FName)
   -- both fields combined make just one primary key
alter table Persons
drop primary key; -- remove primary key from the table (using ALTER)
alter table Persons
add primary key(ID); -- add a primary key, using ALTER
# FOREIGN KEY - a field in a table, that refers to another field to another table
			  -- used to prevent actoins that would destroy relations between tables
create table sales(
	SalesID int primary key,
    SaleNumber varchar(10), 
    PersonID int,
    constraint salesPersonLink -- this row is optional, it provides better control over the constraint
    foreign key(PersonID) references persons(ID) 
);
alter table sales
drop foreign key salesPersonLink; -- remove FOREIGN KEY constraint by ALTER
alter table sales
add constraint salesPersonLink -- naming FOREIGN KEY constraint is also optional here
foreign key(PersonID) references persons(ID);
# CHECK - limit possible values for a column in a table
		-- value must responce to condition for the given field
create table persons (
    ID int primary key,
    LName varchar(50) not null,
    FName varchar(50),
    Age int, 
    check(Age >= 18)
);
create table persons (
    ID int primary key,
    LName varchar(50) not null,
    FName varchar(50),
    Age int, 
    constraint ControlPerson -- naming CHECK constraint is optional
    check(Age >= 18 and FName <> null)
);
alter table persons
drop check ControlPerson; -- drop CHECK constraint using ALTER
alter table persons 
add constraint ControlPerson -- naming CHECK constraint is optional
check(Age >= 18 and FName <> null); -- create CHECK constraint, using ALTER
# DEFAULT - sets dafault value for all values in a column in the table
		  -- if no other value is set, then all records of the field will be fill with the default value
create table persons (
    ID int primary key,
    LName varchar(50) not null default '',
    FName varchar(50) default '',
    Age int default 0
);
alter table persons
alter Age drop default; -- drop DEFAULT constraint using ALTER
alter table persons
alter Age set default 0; -- set DEFAULT constraint using ALTER
# CREATE INDEX - used to create indexes in tables
			   -- indexes are used to retrieve data from table quicker than usual
create index lastname
on persons(LName); -- indexes is similar to primary key
show indexes from persons;
alter table persons
drop index lastname; -- drop indexes, using ALTER
create index lastname
on persons(FName, LName); -- it can be created a single index for more than one column in a table
create unique index age
on persons(Age); -- UNIQUE INDEX does not allow duplicated values
# AUTO_INCREMENT - generates an unique number automaticatilly for a given field in a table
				 -- it is not needed to set value for a number field with that constraint
create table persons (
    ID int primary key auto_increment,
    LName varchar(50) not null default '',
    FName varchar(50) default '',
    Age int default 0
); -- AUTO_INCREMENT sets different default values for every record, starting from 1
alter table person 
auto_increment = 100; -- by ALTER it is possible to change starting value 

# Dates
-- Datatypes in MySQL
/*
	DATE - YYYY-MM-DD
    DATETIME - YYYY-MM-DD HH:MI:SS
    TIMESTAMP - YYYY-MM-DD HH:MI:SS
    YEAR - YYYY or YY
*/
/*
	The most difficult part when working with dates is to be sure that the format of the date 
    you are trying to insert, matches the format of the date column in the database.
    
    Note: Two dates can easily be compared if there is no time component involved!
    
    Tip: To keep your queries simple and easy to maintain, 
		 do not use time-components in your dates, unless you have to!
*/

# VIEW
-- A VIEW contains rows and columns just like a real table
-- The fields in a VIEW are fields from one or more tables in the current database
-- Statements and functions can be applied to a VIEW just like to a real table
create view MyOwnView as
select c.CustomerName, p.ProductName 
from customers as c, products as p;
select * from MyOwnView;







