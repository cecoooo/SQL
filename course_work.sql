create database forum;
use forum;

create table customers(
	id int primary key auto_increment,
    username varchar(20) not null,
    password varchar(20) not null
);

create table admins(
	id int primary key auto_increment,
    username varchar(20) not null,
    password varchar(20) not null
);

create table articles(
	id int primary key auto_increment,
    title varchar(30) not null,
    content varchar(16000) not null
);

create table article_authors(
	article_id int not null,
    author_is int not null,
    primary key(article_id, author_is),
    foreign key(article_id) references articles(id),
    foreign key(author_is) references articles(id)
);

create table comments(
	id int primary key auto_increment,
    content varchar(1000) not null,
    author_id int,
    foreign key(author_id) references 
);