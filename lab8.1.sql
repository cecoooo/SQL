use school_sport_clubs;

start transaction;

insert into students(id, name, egn, address, phone, class)
values(8, 'Martin', 'Georgiev', 'Barcelona, Spain', '0888533917', '11');

savepoint mySavePoint;

delete from students
where phone = '0888533917';

rollback to savepoint mySavePoint;

-- commit;
-- rollback;

select * from students;