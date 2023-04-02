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

insert into tournaments(name, year, num_of_competitors)
values('UEFA Champions League', '2023', 32),
('UEFA Europa League', '2023', 64),
('UEFA Conference League', '2023', 64),
('Premier League', '2023', 20),
('La Liga', '2023', 20),
('Seria A', '2023', 20),
('Bundesliga', '2023', 18),
('League 1', '2023', 20),
('FA Cup', '2023', null),
('Copa del Rey', '2023', null),
('Coppa Italia', '2023', null),
('DFB-Pokal', '2023', null),
('Coupe de France', '2023', null);

insert into locations(country, city)
values('Spain', 'Barcelona'),
('Spain', 'Madrid'),
('Italy', 'Milano'),
('Italy', 'Torino'),
('Italy', 'Neapol'),
('Germany', 'Munich'),
('Germany', 'Dortmund'),
('Germany', 'Leipzig'),
('UK', 'London'),
('UK', 'Manchester'),
('UK', 'Liverpool'),
('France', 'Paris'),
('France', 'Marsilya');

insert into stadiums(name, capacity, location_id)
values('Spotify Camp Nou', 99354, 1),
('Santiago Bernabéu', 81044, 2),
('Wanda Metropolitano', 68456, 2),
('San Siro', 75817, 3),
('Juventus Stadium', 41507, 4),
('Stadio Diego Armando Maradona', 54726, 5),
('Allianz Arena', 75024, 6),
('Signal Iduna Park', 81365, 7),
('Red Bull Arena', 47069, 8),
('Stamford Bridge', 42000, 9),
('Emirates Stadium', 60704, 9),
('Tottenham Hotspur Stadium', 62850, 9),
('Old Trafford', 74310, 10),
('Etihad', 53400, 10),
('Anfield', 54000, 11),
('Parc des Princes', 48583, 12),
('Stade Vélodrome', 67000, 13);

insert into contracts(renew_date, expire_date, salary)
values('2021-11-30', '2024-6-30', 4143000),
('2021-6-30', '2024-6-30', 12000000),
('2021-7-1', '2024-6-30', 30000000),
('2023-6-30', '2025-6-30', 19500000),
('2022-12-1', '2026-12-31', 15000000),
('2021-5-31', '2024-5-31', 9430000),
('2022-10-30', '2027-6-30', 11360000),
('2021-11-30', '2023-6-30', 18200000),
('2022-4-1', '2025-6-30', 10200000),
('2021-6-30', '2025-6-30', 9000000),
('2022-6-30', '2024-6-30', 5000000),
('2022-11-30', '2025-6-30', 3500000),
('2021-7-1', '2023-7-1', 3300000),
('2023-3-30', '2025-6-30', 20000000),
('2022-6-30', '2025-6-30', 1000000),
('2022-6-30', '2024-6-30', 7000000),
('2022-6-30', '2024-6-30', 14400000),
('2022-6-30', '2024-6-30', 3960000);

insert into coaches(fname, lname, age, nationality, contract_id)
values('Xavi', 'Hernandes', 43, 'Spain', 1),
('Carlo', 'Ancelotti', 63, 'Italy', 2),
('Diego', 'Simeone', 52, 'Argentina', 3),
('Pep', 'Guardiola', 52, 'Spain', 4),
('Jurgen', 'Klopp', 55, 'Germany', 5),
('Mikel', 'Arteta', 41, 'Spain', 6),
('Graham', 'Potter', 47, 'UK', 7),
('Antonio', 'Conte', 53, 'Italy', 8),
('Eric', 'Ten Hag', 53, 'Netherland', 9),
('Massimiliano', 'Allegri', 55, 'Italy', 10),
('Filippo', 'Inzaghi', 49, 'Italy', 11),
('Stefano', 'Pioli', 57, 'Italy', 12),
('Luciano', 'Spalletti', 64, 'Italy', 13),
('Thomas', 'Tuchel', 49, 'Germany', 14),
('Edin', 'Terzić', 40, 'Germany', 15),
('Marco', 'Rose', 46, 'Germany', 16),
('Christophe', 'Galtier', 56, 'France', 17),
('Igor', 'Tudor', 44, 'Croatia', 18);

insert into clubs(name, dateOfFound, coach_id, owner_id, stadium_id)
values('FC Barcelona', '1899-11-29', 1, 1, 1),
('Real Madrid', '1902-11-29', 2, 3, 2),
('Atletico Madrid', '1899-11-29', 3, 16, 3),
('Manchester City', '1899-11-29', 4, 6, 14),
('Liverpool FC', '1899-11-29', 5, 7, 15),
('Arsenal', '1899-11-29', 6, 9, 11),
('Chelsey', '1899-11-29', 7, 8, 10),
('Tothenhem Hotspurs', '1899-11-29', 8, 10, 12),
('Manchester United', '1899-11-29', 9, 11, 13),
('Juventus', '1899-11-29', 10, 5, 5),
('Inter Milano', '1899-11-29', 11, 13, 4),
('AC Milan', '1899-11-29', 12, 14, 4),
('Napoli', '1899-11-29', 13, 17, 6),
('FC Bayern Munich', '1899-11-29', 14, 4, 7),
('Borusia Dortmund', '1899-11-29', 15, 12, 8),
('Leipzig FC', '1899-11-29', 16, 15, 9),
('Paris Saint-Germain', '1899-11-29', 17, 2, 16),
('Olympique de Marseille', '1899-11-29', 18, 18, 17);





