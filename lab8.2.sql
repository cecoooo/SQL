use school_sport_clubs;

#1
create view ex1 as
select c.name as 'coach', sp.name as 'sport', concat(sg.id, sg.location) as 'groupInfo', p.year, p.month, p.salaryAmount
from coaches as c join sportgroups as sg on sg.coach_id = c.id
join sports as sp on sp.id = sg.sport_id
join salarypayments as p on c.id = p.coach_id;

select * from ex1;

#2
create table salarypayments_log like salarypayments;

drop trigger rewrite_after_delete;
delimiter $
create trigger rewrite_after_delete
after delete
on salarypayments for each row
begin
	if not exists(select id from salarypayments_log where id = old.id) then
		insert into salarypayments_log(id, coach_id, month, year, salaryAmount, dateOfPayment)
		values(old.id, old.coach_id, old.month, old.year, old.salaryAmount, old.dateOfPayment);
	end if;
end $
delimiter ;



select * from salarypayments_log;
select * from salarypayments;

delete from salarypayments
where id = 1;

#3
insert into salarypayments select * from salarypayments_log;

#4
drop procedure convert_currency;
use transaction_test;
delimiter $
create procedure convert_currency(amount double, currency varchar(3))
begin
	set @res = 0;
	if currency = 'BGN' then set @res := amount/2;
    elseif currency = 'EUR' then set @res := amount*2;
    else select 'Invalid currency.';
    end if;
    select @res;
end $
delimiter ;

call convert_currency(20, 'EUR');





