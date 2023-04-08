use school_sport_clubs;

delimiter && 
create procedure ex1(nameOfCoach varchar(30))
begin
select sp.name as 'sport', sg.location, hourOfTraining, sg.dayOfWeek, s.name, s.phone
from students as s join student_sport as ss on ss.student_id = s.id
join sportgroups as sg on sg.id = ss.sportGroup_id
join sports as sp on sg.sport_id = sp.id
join coaches as c on c.id = sg.coach_id
where c.name = nameOfCoach;
end &&
delimiter ;

call ex1('Ivan Todorov Petkov');