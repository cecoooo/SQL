create database movies;
use movies;

create table movies(
	id int primary key auto_increment,
    title varchar(20),
    premiereYear year not null,
    lenght time not null,
    studio_id int,
    producer_id int,
    budget double not null,
    foreign key(studio_id) references studios(id),
    foreign key(producer_id) references producers(id)
);

create table actors(
	id int primary key auto_increment,
    address varchar(50) not null,
    gender enum('M', 'W') not null,
    dateOfBirth date not null,
    name varchar(30) not null
);



create table studios(
	id int primary key auto_increment,
    address varchar(50) not null,
    bulstat varchar(9) not null,
    name varchar(30) not null
);

create table producers(
	id int primary key auto_increment,
    address varchar(50) not null,
    bulstat varchar(9) not null unique,
    name varchar(30) not null
);

create table movie_actors(
	actor_id int,
    movie_id int,
    foreign key(actor_id) references actors(id),
    foreign key(movie_id) references movies(id)
);

insert into studios(address, bulstat, name)
values('Serdika, Sofia', '123456678', 'studio1'),
('Center, Plovdiv', '987654332', 'studio2'),
('serdika, Sofia', '675849301', 'studio3');

insert into producers(address, bulstat, name)
values('London, England', '123256678', 'John Smith'),
('Center, Plovdiv', '987657332', 'Magardich Halvadjian'),
('New York , USA', '175849301', 'Fridlie Scott');

insert into actors(address, gender, dateOfBirth, name)
values('Los Angeles, California, USA', 'M', '1974-11-11', 'Leonardo DiCaprio'),
('Sevilla, Spain', 'W', '1974-4-28', 'Penélope Cruz'),
('Lansing, Michigan, USA', 'M', '1952-4-10', 'Steven Seagal'),
('Melbourne, Victoria, Australia', 'W', '1969-5-14', 'Cate Blanchett');

insert into movies(title, premiereYear, lenght, studio_id, producer_id, budget)
values('Titanic', '1997', '3:15:00', 1, 2, 200.2),
('Armageddon ', '1998', '2:22:00', 3, 2, 140),
('Shawshank Redemption', '1994', '3:15:10', 1, 3, 25.5),
('The Green Mile', '1999', '3:09:00', 1, 2, 60.3),
('Psycho', '1960', '1:49:00', 3, 1, 0.8);

insert into movie_actors() 
values(9, 4),
(10, 4),
(11, 1),
(9, 2),
(11, 1),
(12, 3),
(10, 2);

select a.name  from actors as a
where a.address like '%Los Angeles%' 
and a.gender = 'M';

select * from movies as m
where m.premiereYear between '1990' and '2000'
order by m.budget desc
limit 3;

select m.title as films, a.name as actors
from movies as m 
join movie_actors as ma on ma.movie_id = m.id
join actors as a on a.id = ma.actor_id
join producers as p on p.id = m.producer_id
where p.name = 'John Smith';

select avg(m.lenght) as avLenBefore2000 from movies as m
where m.premiereYear < 2000 in(
select a.name, avg(m.lenght) as avLen from actors as a
join movie_actors as ma on ma.actor_id = a.id
join movies as m on m.id = ma.movie_id
where avLen > avLenBefore2000
);

