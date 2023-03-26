create database hospital;
use hospital;

create table patients(
	id int primary key auto_increment,
	egn varchar(10) not null unique,
    name varchar(30) not null
);

create table threatments(
	id int primary key auto_increment,
    price double default 0
);

create table doctors(
	id int primary key auto_increment,
    name varchar(30) not null
);

create table procedures(
	id int primary key auto_increment,
    time time not null,
    room_number int not null
);

create table doctor_patient(
	doctor_id int not null,
    patient_id int not null,
    foreign key(doctor_id) references doctors(id),
    foreign key(patient_id) references patients(id),
    primary key(doctor_id, patient_id)
);

create table patient_threatment(
	patient_id int not null,
    threatment_id int not null,
    foreign key(patient_id) references patients(id),
    foreign key(threatment_id) references threatments(id),
    primary key(patient_id, threatment_id)
);

create table patient_procedure(
	patient_id int not null,
    procedure_id int not null,
    foreign key(patient_id) references patients(id),
    foreign key(procedure_id) references procedures(id),
    primary key(patient_id, procedure_id)
);

insert into patients(egn, name)
values('1234567890', 'Ivan Ivanov'),
('0987654321', 'Petar Petrov'),
('6543217890', 'George Dimitrov'),
('6789054321', 'Nikola Atanasov');

insert into threatments(price)
values(213.21),
(423.23),
(42.23),
(984.10);

insert into doctors(name)
values('Nikolay Kostadinov'),
('Spas Delev'),
('Ivelin Popov'),
('Todor Nedelev'),
('George Milanov'),
('Станимир Стоилов'),
('Валентин Антов'),
('Иван Турицов'),
('Иван Иванов');

insert into procedures(time, room_number)
values('10:00:00', 12),
('11:00:00', 9),
('12:00:00', 3),
('13:00:00', 17),
('14:00:00', 24);

insert into doctor_patient()
values(1, 1),
(2, 3),
(3, 4),
(4, 2),
(1, 3),
(6, 4);

insert into patient_threatment()
values(1, 10),
(2, 10),
(3, 11),
(4, 14);

insert into patient_procedure()
values(1, 3),
(2, 5),
(3, 5),
(4, 1);

select p.name, d.id, pr.room_number, pr.time
from patients as p
join doctor_patient as dp on dp.patient_id = p.id
join doctors as d on d.id = dp.doctor_id
join patient_procedure as pp on pp.patient_id = p.id
join procedures as pr on pr.id = pp.procedure_id
join patient_threatment as pt on pt.patient_id = p.id
join threatments as t on t.id = pt.threatment_id
where t.id = 10 and d.name = 'Иван Иванов';

select p.name, t.price from patients as p
join patient_threatment as pt on pt.patient_id = p.id
join threatments as t on t.id = pt.threatment_id
join patient_procedure as pp on pp.patient_id = p.id
join procedures as pr on pr.id = pp.procedure_id
join doctor_patient as dp on dp.patient_id = p.id
join doctors as d on d.id = dp.doctor_id
where d.id = 10 and pr.room_number = 15;




