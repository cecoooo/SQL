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
use transaction_test;
drop procedure convert_currency;
delimiter $
create procedure convert_currency(amount double, currency varchar(3), out res double)
begin
	if currency = 'BGN' then set res = amount/2;
    elseif currency = 'EUR' then set res = amount*2;
    else select 'Invalid currency.';
    end if;
end $
delimiter ;

set @result = 0;
call convert_currency(20, 'EUR', @result);
select @result;


#5
drop procedure ex5;
delimiter $
create procedure ex5(idProvider int, idRecipient int, sumAmount double)
begin
	start transaction;
		select @initialValue := amount from customer_accounts where id = IdProvider;
		update customer_accounts
        set amount = case when
			amount < sumAmount then amount
            else amount - sumAmount end
        where id = idProvider;
        select @changedValue := amount from customer_accounts where id = IdProvider;
        if @initialValue = @changedValue then 
        signal sqlstate '45000' set message_text = 'Not enough money in the discount.';
        end if;
        select @currencyProvider := currency from customer_accounts where id = IdProvider;
        select @currencyRecipient := currency from customer_accounts where id = IdRecipient;
        set @sumToAdd = sumAmount;
        if @currencyProvider not like @currencyRecipient then 
        set @sumToAdd = 0;
        call convert_currency(sumAmount, @currencyProvider, @sumToAdd);
        end if;
        update customer_accounts
        set amount = amount + @sumToAdd
        where id = idRecipient;
	commit;
end $
delimiter ;

call ex5(2, 1, 5000);

update customer_accounts
set amount = 8850
where id = 2;
update customer_accounts
set amount = 4500
where id = 1;
select * from customer_accounts;