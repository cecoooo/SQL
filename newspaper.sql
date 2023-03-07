create database newspaper;
use newspaper;

create table news(
	id int auto_increment primary key,
	title varchar(20) not null,
	content text not null,
	category_id int
);

create table categories(
	id int auto_increment primary key,
    description1 text not null
);

create table comments(
	id int auto_increment primary key,
    comment1 text not null,
    news_id int,
    reader_id int
);

create table reader(
	id int auto_increment primary key,
	name varchar(20) not null
);

insert into news(title, content)
values("SHitNews", "alabala");

insert into categories(description1)
values("hi");

insert into comment(description1)
values("fgrthe");

insert into reader(name)
values("SHitNews");

update news
Set title = "ceco", news_id = 1,  reader_id = 3
where id=1;

update commnets
Set comment1 = "com", news_id = 3, reader_id = 2
where id = 1;

update reader
Set name = "reader"
where id = 1;

delete from news where id = 1;
delete from categories where id = 1;
delete from comments where id = 1;
delete from reader where id = 1;