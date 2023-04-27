use uefa;

-- cursors

delimiter $
drop procedure if exists get_all_clubs;
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
end $
delimiter ;

set @list_c = "";
call get_all_clubs(@list_c);
select @list_c;


select * from clubs;
