use school_sport_clubs;

#1
create view TrainingFootball as
select s.name, s.class, s.phone
from students as s join student_sport as ss
on s.id = ss.student_id join sportgroups as sg
on sg.id = ss.sportGroup_id join sports as sp
on sp.id = sg.sport_id where sp.name = 'Football';

select * from TrainingFootball;

#2
create view VolleyballCoaches as
select c.name from coaches as c
join sportgroups as sg on
sg.coach_id = c.id join
sports as sp on sp.id = sg.sport_id
where sp.name = 'Volleyball';

select * from VolleyballCoaches;

#3
create view IlianIvalov as
select c.name as 'Coach Name', sp.name as 'Sport Name' from coaches as c
join sportgroups as sg on c.id = sg.coach_id
join sports as sp on sg.sport_id = sp.id
join student_sport as ss on ss.sportGroup_id = sg.id
join students as s on s.id = ss.student_id
where s.name = 'Илиян Иванов';

select * from IlianIvalov;

#4
create view Payments as
select sum(t.paymentAmount) as sumAll , t.month from taxespayments as t
join students as s on s.id = t.student_id
join student_sport as ss on ss.student_id = s.id
join sportgroups as sg on sg.id = ss.sportGroup_id
join coaches as c on c.id = sg.coach_id
join sports as sp on sg.sport_id = sp.id
where c.egn = '7509041245' 
group by month
having sumAll > 700;

select * from Payments;

#5
create view StudentByGroups as
select count(s.name) from students as s
join student_sport as ss on s.id = ss.student_id
join sportgroups as sg on sg.id = ss.sportGroup_id
group by sg.sport_id; 

select * from StudentsCountByGroup;

#6


#7
create view startAtEightOClock as
select s.name as 'Student name', s.class, sg.location, c.name as 'Coach name' from students as s
join student_sport as ss on ss.student_id = s.id
join sportgroups as sg on sg.id = ss.sportGroup_id
join coaches as c on c.id = sg.coach_id
where sg.hourOfTraining = '8:00';

select * from startAtEightOClock;








