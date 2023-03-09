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
    sportGroup int,
    foreign key(student_id) references students(id)
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