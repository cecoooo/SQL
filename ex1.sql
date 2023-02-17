create database students;

use students;

# Numeric Functions

select abs(-13412) as module;
select exp(2.72);

create table info(
id int primary key,
name varchar(20),
age int,
town varchar(20)
);

select * from info;

insert into info values
(1, "Niki", 12, 'Sofia'),
(2, "Gosho", 14, 'Plovdiv'),
(3, "Tosho", 19, 'Sofia'),
(4, "Pesho", 11, 'Varna'),
(5, "Petko", 19, 'Ruse'),
(6, "Ivan", 20, 'Sofia');

select * from info;