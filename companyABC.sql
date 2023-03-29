create database company;
use company;

create table departments(
	id int primary key auto_increment,
    name varchar(20) not null,
    manager_id int
);

create table employees(
	id int primary key auto_increment,
    fname varchar(20) not null,
    lname varchar(20) not null,
    salary double, 
    salary_per_hour double,
    department_id int not null,
    manager_id int,
    foreign key(department_id) references departments(id)
    #check(salary is null or salary_per_hour is null),
    #check(salary is not null or salary_per_hour is not null),
    #check(manager_id <> id)
);

alter table departments add constraint foreign key(manager_id) references employees(id);
alter table employees add constraint foreign key(manager_id) references employees(id);

create table projects(
	id int primary key auto_increment,
    name varchar(20) not null, 
    budjet double not null, 
    department_id int not null,
    coordinator_id int not null,
    foreign key(department_id) references departments(id),
    foreign key(coordinator_id) references employees(id)
);

create table project_employee(
	project_id int not null,
    employee_id int not null,
    hours_per_day_by_employee int not null,
    foreign key(project_id) references projects(id),
    foreign key(employee_id) references employees(id),
    primary key(project_id, employee_id)
);

insert into departments(name)
values('HR'),
('front-end'),
('back-end'),
('databases');

insert into employees(fname, lname, salary, salary_per_hour, department_id, manager_id)
values('Ivan', 'Kostov', 2000, null, 8, null),
('Nikolay', 'Petrov', 3000, null, 7, null);

insert into employees(fname, lname, salary, salary_per_hour, department_id, manager_id)
values('Martina', 'Qnkova', 1500, null, 5, 21),
('Stoyan', 'Georgiev', null, 15, 6, 22);


insert into projects(name, budjet, department_id, coordinator_id)
values('AmericaZaBulgaria', 100000000.00, 6, 3),
('Highway Hemus', 234231534, 5, 4);

alter table employees add experience int not null;

update employees
set experience = 1
where id = 21;

update employees
set experience = 5
where id = 22; 

update employees
set experience = 10
where id = 27; 

update employees
set experience = 15
where id = 28; 

#1
select fname, lname from employees
where experience = (select max(experience) from employees);

#2
select * from projects
where budjet > 1000000;

#3
update employees
set salary = salary*1.1
where experience >= 10;

#4
alter table projects add status varchar(20);
update projects 
set status = 'completed'
where status is null;

select * from projects
where status <> 'completed';

#5
select distinct d.id from departments as d
join projects as p on p.department_id = d.id;

insert into departments(name)
values('Apartment');

#6
select * from departments 
where name like 'A%';

#7
select * from Employees
order by salary desc
limit 5;

#8
delete from employees where id=1;

#9
alter table projects add starting_date date;
update projects
set starting_date = '2020-09-12';

update projects
set starting_date = '2021-09-12'
where id =2;

select * from projects 
order by starting_date desc
limit 5;

#10
select * from employees
order by lname, fname;







