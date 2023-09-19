use Softuni;

-- 02
select * from Departments;

-- 03
select name from Departments;

-- 04
select firstName, MiddleName, LastName from Employees;

-- 05 
select CONCAT(firstName,'.', lastName, '@softuni.bg') as [Full Email Address] from Employees;

-- 07
select distinct salary from Employees;

-- 08
select * from Employees
where jobTitle = 'Sales Representative';

-- 09 
select firstName, lastName, jobTitle from Employees
where salary between 20000 and 30000;

-- 10
select CONCAT_WS(' ', firstName, middleName, lastName) as [Full Name] from Employees
where salary in(25000, 14000, 12500, 23600);


-- 11
select firstName, lastName from Employees
where ManagerID is null;

-- 12
select firstname, lastname, salary from Employees
where salary > 50000
order by salary desc;

-- 13
select top 5 firstname, lastname from Employees
where salary > 50000
order by salary desc;

-- 14
select firstName, lastName from Employees
where DepartmentId <> 4;

-- 15
select * from Employees
order by Salary desc, Firstname, LastName desc, MiddleName; 

-- 16
go
create view V_EmployeesSalaries as 
select firstName, lastName, salary from Employees;
go
select * from V_EmployeesSalaries;
go

-- 17
go
create view V_EmployeeNameJobTitle as
select CONCAT_WS(' ', firstname, middlename, lastname) as [Full Name],
jobTitle  as [Job Title]
from Employees;
go
select * from V_EmployeeNameJobTitle;
go

-- 18
select distinct jobTitle from Employees;

-- 19
select top 10 * from Projects
order by startDate, [name];

-- 20
select top 7 firstName, lastName, hireDate from Employees
order by hireDate desc;

-- 21
update e
	set e.Salary = e.Salary*1.12
	from Employees e join Departments d on e.DepartmentId = d.DepartmentId
	where d.name in ('Engineering', 'Tool Design', 'Marketing', 'Information Services');
select salary from Employees;

update e
	set e.Salary = e.Salary/1.12
	from Employees e join Departments d on e.DepartmentId = d.DepartmentId
	where d.name in ('Engineering', 'Tool Design', 'Marketing or Information Services');


use Geography;

-- 22
select PeakName from Peaks
order by PeakName;

-- 23
select top 30 c.CountryName, c.[Population] from Countries as c
join Continents as co on c.ContinentCode = co.ContinentCode
where co.ContinentName = 'Europe'
order by c.Population desc;

use Diablo

-- 25
select [name] as [Name] from Characters
order by [name];