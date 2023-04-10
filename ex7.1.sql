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

delimiter //
create procedure ex2(spId int)
begin 
select sp.name as 'sport', s.name as 'students', c.name as 'coaches'
from sports as sp join sportgroups as sg on sp.id = sport_id
join coaches as c on c.id = sg.coach_id
join student_sport as ss on ss.sportgroup_id = sg.id
join students as s on s.id = ss.student_id
where sp.id = spId;
end //
delimiter ;

call ex2(2);


delimiter &&
create procedure ex3(nameOfStudent varchar(255), yearOfPayment year, out res double)
begin
select avg(t.paymentAmount) from taxespayments as t
join students as s on s.id = t.student_id
where s.name = nameOfStudent and t.year = yearOfPayment;
end &&
delimiter ;

drop procedure ex3;

set @res = 0;
call ex3('Iliyan Ivanov', '2022', @res);
select @res;


select * from students;
select * from taxespayments;

use transaction_test;

delimiter //
create procedure ex4(idProvider int, idRecipient int, sumAmount double)
begin

select @check := amount from customer_accounts
where id = idProvider;

update customer_accounts
set amount = case 
when amount - sumAmount >= 0 then amount - sumAmount
else amount
end
where id = idProvider;

update customer_accounts
set amount = case 
when @check >= sumAmount then amount + sumAmount
else amount
end
where id = idRecipient;
select if(row_count() = 0, 'Some error occured. Possible not enough money.', 'Successsfull.') as Massage;

end //
delimiter ;

drop procedure ex4;

call ex4(1, 3, 500);

select * from customers;
select * from customer_accounts;

