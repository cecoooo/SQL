use uefa;

-- cursors

drop procedure if exists get_all_clubs;
delimiter $$
create procedure get_all_clubs(inout club_list varchar(4000))
begin 
	declare finished int;
    declare club varchar(50);
    declare currClub cursor for select name from clubs;
    declare continue handler for not found set finished = 1;
    
    open currClub;
    getClub: loop
		fetch currClub into club;
        if finished = 1 then leave getClub;
        end if;
        set club_list = concat(club, ';', club_list);
	end loop getClub;
    close currClub;
end 
$$
delimiter ;

set @list_c = "";
call get_all_clubs(@list_c);
select @list_c;


-- handlers

select * from clubs;
delimiter $$
create procedure pr()
begin
	declare er int;
	declare continue handler for sqlexception set er = 1;
end $$
delimiter ;

/*
	for handlers:
    declare action handler for consdition_value statement;
    
    - use declare for new handler
    - action:
		it can be 
		- continue (the execution of the enclosing code block ( BEGIN … END ) continues) or 
        - exit (the execution of the enclosing code block, where the handler is declared, terminates)
	- condition_value:
		it can be
		- A MySQL error code
        - sqlstate value such as sqlwarning, notfound, sqlexception
        - a named condition associated with either a MySQL error code or sqlstate value
	- statement:
		could be:
        - a simple statement
        - begin...end statement
*/














