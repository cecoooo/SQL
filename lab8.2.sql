use school_sport_clubs;

create view ex1 as
select c.name as 'coach', sp.name as 'sport', concat(sg.id, sg.location) as 'groupInfo', p.year, p.month, p.salaryAmount
from coaches as c join sportgroups as sg on sg.coach_id = c.id
join sports as sp on sp.id = sg.sport_id
join salarypayments as p on c.id = p.coach_id;

select * from ex1;

