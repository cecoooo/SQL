create database UEFA;
use UEFA;

create table owners(
	id int primary key auto_increment,
    fname varchar(20) not null,
    lname varchar(20) not null,
    age int not null,
    nationality varchar(30) not null,
    net_worth double
);

create table contracts(
	id int primary key auto_increment,
    renew_date date not null,
    expire_date date,
    salary double not null
);

create table tournaments(
	id int primary key auto_increment,
    name varchar(40) not null,
    year year not null,
    num_of_competitors int not null
);

create table coaches(
	id int primary key auto_increment,
    fname varchar(20) not null,
    lname varchar(20) not null,
    age int not null,
    nationality varchar(30) not null,
    contract_id int not null,
    foreign key(contract_id) references contracts(id)
);

create table locations(
	id int primary key auto_increment,
	country varchar(56) not null,
    city varchar(30) not null
);

create table stadiums(
	id int primary key auto_increment,
    name varchar(40) not null,
    capacity int not null,
    location_id int not null,
    foreign key(location_id) references locations(id)
);

create table clubs(
	id int primary key auto_increment,
    name varchar(30) not null,
    dateOfFound date,
    coach_id int,
    owner_id int not null,
    stadium_id int not null,
    foreign key(coach_id) references coaches(id),
    foreign key(owner_id) references owners(id),
    foreign key(stadium_id) references stadiums(id)
);

create table players(
	id int primary key auto_increment,
    fname varchar(20) not null,
    lname varchar(20) not null,
    age int not null,
    nationality varchar(30) not null,
    position varchar(10) not null,
    weight double,
    height double,
    club_id int,
    contract_id int,
    foreign key(club_id) references clubs(id),
    foreign key(contract_id) references contracts(id)
);

create table tournament_club(
	club_id int not null,
    tournament_id int not null,
    foreign key(club_id) references clubs(id),
    foreign key(tournament_id) references tournaments(id),
    primary key(club_id, tournament_id)
);

insert into owners(fname, lname, age, nationality, net_worth)
values('Joan', 'Laporta', 60, 'Spain', null),
('Nasser', 'Al-Khelaifi', 49, 'Qatar', 8000000000),
('Florentino', 'Perez', 72, 'Spain', 2200000000),
('Herbert', 'Hainer', 68, 'Germany', null),
('Andrea', 'Agnelli', 47, 'Italy', 19200000000),
('Mansour', 'Sultan Al Nahyan', 52, 'Trucial States', 30000000000),
('Tom', 'Werner', 72, 'USA', 1700000000),
('Todd', 'Boehly', 49, 'USA', 5300000000),
('Stan', 'Kroenke', 75, 'USA', 12900000000),
('Daniel', 'Levy', 61, 'USA', 1000000000),
(null, 'Glazers', null, 'USA', 3900000000),
('Reinhard', 'Rauball', 76, 'USA', 300000000),
('Zhang', 'Jindong', 60, 'China', 7400000000),
('Gerry', 'Cardinale', 56, 'Italy', null),
('Chalerm', 'Yoovidhya', 72, 'Thailand', 20200000000),
('Miguel', 'Gil Marín', 60, 'Spain', 240000000),
('Aurelio', 'de Laurentiis', 73, 'Italy', 50000000),
('Frank', 'McCourt', 69, 'USA', 1200000000);








