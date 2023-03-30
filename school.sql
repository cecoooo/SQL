create database school;
use school;

create table teachers(
	id int primary key auto_increment,
    username varchar(20) not null,
    password varchar(20) not null,
    name varchar(20) not null,
    surname varchar(20) not null
);

create table schools(
	id int primary key auto_increment,
    name varchar(20) not null,
    city varchar(20) not null
);

create table classes(
	id varchar(3) primary key,
    school_id int not null,
    foreign key(school_id) references schools(id)
);

create table students(
	id int primary key auto_increment,
    name varchar(20) not null,
    surname varchar(20) not null,
    class_id varchar(3) not null,
    foreign key(class_id) references classes(id)
);

create table exercises(
	id int primary key auto_increment,
    description varchar(100) not null,
    answer varchar(100) not null,
    wrong_answers varchar(300),
    author_id int not null,
    foreign key(author_id) references teachers(id)
);

create table class_exercise(
	ex_id int not null,
    class_id varchar(3) not null,
    primary key(ex_id, class_id)
);



