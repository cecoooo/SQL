create database school_sports;
use school_sports;

create table students(
	id int primary key auto_increment,
    name varchar(50) not null,
    egn varchar(10) not null unique,
    address varchar(50) not null,
    phone varchar(10) not null,
    class varchar(20) not null
);

create table coaches(
	id int primary key auto_increment,
    name varchar(50) not null,
    egn varchar(10) not null unique
);

create table sports(
	id int primary key auto_increment,
    name varchar(50) not null
);

create table sportgroups(
	id int auto_increment,
    location varchar(20) not null,
    dayOfWeek varchar(10) not null,
    hourOfTraining varchar(2) not null,
    sport_id int not null,
    coach_id int not null,
    foreign key(sport_id) references sports(id),
    foreign key(coach_id) references coaches(id),
    primary key(id)
);

create table salarypayments(
	id int auto_increment,
    coach_id int,
	month varchar(10) not null,
    year varchar(4) not null check(length(year) = 4),
    salaryAmount double,
    dateOfPayment varchar(2) not null,
    primary key(id)
);

create table student_sport(
	student_id int,
    sportGroup_id int,
    foreign key(student_id) references students(id),
    foreign key(sportGroup_id) references sportgroups(id)
);

create table taxespayments(
	id int primary key auto_increment,
    student_id int,
    group_id int,
    paymentAmount double,
    month varchar(10) not null,
    year varchar(4) not null check(length(year) = 4),
    dateOfPayment varchar(2) not null,
    foreign key(student_id) references students(id),
    foreign key(group_id) references sportgroups(id)
);

insert into students(name, egn, address, phone, class)
values("Иван Иванов", "9207186371", "София-Сердика", "10", "0888892950");
insert into students(name, egn, address, phone, class)
values("Георги Тодоров", "0251033960", "Червен бряг, ул. Дядо Вълко 8", "12", "0888756645");

select id, name, egn, address, phone, class from students;

delete from students where id = 1;

insert into sports(name)
values("football"), 
("volleyball"), 
("handball"),
("tennis"),
("swimming"),
("box"),
("fitness"),
("trecking"),
("boating");

insert into coaches(name, egn)
values("Gosho", "1111111111"),
("Tosho", "222222222"),
("Pesho", "3333333333"),
("Misho", "4444444444"),
("Grisho", "5555555555");

insert into sportgroups(location, dayOfWeek, hourOfTraining, sport_id, coach_id)
values("Mladost 1", "Monday", "12", 1, 1),
("Mladost 2", "Tuesday", "13", 2, 2),
("Mladost 3", "Wednesday", "14", 2, 2),
("Mladost 4", "Thursday", "15", 2, 2),
("Mladost 1", "Friday", "16", 3, 1),
("Mladost 1", "Saturday", "17", 1, 5);

select students.name, sports.name
from student_sport
inner join students on students.id = student_sport.student_id
inner join sportgroups on sportgroups.sport_id = sport.id;