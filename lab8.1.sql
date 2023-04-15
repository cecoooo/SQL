use school_sport_clubs;

-- TRANSACTIONS
start transaction;

insert into students(id, name, egn, address, phone, class)
values(8, 'Martin Georgiev', '0546235497', 'Barcelona, Spain', '0888533917', '11');

savepoint mySavePoint;

delete from students
where phone = '0888533917';

rollback to savepoint mySavePoint;

-- commit;
-- rollback;

select * from students;

-- EVENTS
create event add_student
on schedule at current_timestamp
do
insert into students(id, name, egn, address, phone, class)
values(9, 'Nikolai Petrov', '0443213650', 'Pleven, Bulgaria', '0874536490', '12');
/*
	this event:
    - is one-time event
    - executes on time of its creation
    - expires after execution
*/

create event add_student1
on schedule at current_timestamp + interval 1 minute
on completion preserve
do
	insert into students(id, name, egn, address, phone, class)
    values(10, 'Ivaylo Penchev', '0651135023', 'Pleven, Bulgaria', '0888123443', '10');
    
/*
	this event:
    - is one-time event
    - executes 1 minute after its creation
    - do not expire after execution (on completion preserve)
*/

show events from school_sport_clubs;

create table massages(
	id int, 
    content varchar(30),
    date_hour datetime
);

create event full_messages
on schedule every 1 minute
starts current_timestamp 
ends current_timestamp() + interval 1 hour
do 
	insert into massages(content, date_hour)
    values('message', current_time());
/*
	this event:
    - is recuring event
    - executes a per 1 minute
    - starts on time of its creation
    - ends 1 hour later
    - expires after execution
*/

select * from massages;

