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

#



