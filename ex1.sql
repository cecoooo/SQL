create database students;

use students;

# Numeric Functions
select abs(-13412) as module;
select exp(2.72);
select floor(2.8);
select ceil(2.8);
select format(2.45946, 2);
select greatest(2, 5, 3, 19.78 ,7.9, 8);
select interval(2, 5, 7,8) as expression;
select least(2, 4 ,5, 1.2, 5.2);
select log10(100);
select ln(2.72);
select log(exp(1));
select mod(1432134, 543543674848) as mod_must_be_1432134;
select oct(123);
select pow(2, 4);
select power(2, 6);
select radians(57);
select round(2.6, 2);
select cos(radians(60));
select sqrt(4);
select truncate(2.75637, 2);


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

# String Functions
select ascii('a');
select char(65) as must_return_A;
select concat('S', 'Q', 'L');
select 'S'+'Q'+'L';
select concat_ws(' ', 'vsichki', 'sa', 'na' ,'Sen', 'Trope');
select left('WhiskeyWithCola', 7) as Whiskey;
select lower('SQL');
select ltrim('     habibi     ');
select rtrim('     habibi     ');
select replace('Azis ne e gay', 'ne e', 'e');
select reverse('olanim e bet muk im qtuP');
select right('shte spra alocohola, ama edva li', 11) as shte_spra_da_piq;
select soundex('Azis'), soundex('Preslava');
select substring('Ochila slojete zaslepqvam', 8, 7) as slojete;
select trim('     habibi     ');
select upper('sql');