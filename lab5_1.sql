use school_sport_clubs;    
#1. Изведете имената, класовете и телефоните на всички ученици, които тренират футбол.

create view TrainigFootball as
SELECT students.name as StudentName,students.class as Class,students.phone as Studentsphone
FROM students JOIN student_sport as ss ON students.id=ss.student_id
			  JOIN sportgroups as sg ON ss.sportGroup_id=sg.id
              JOIN sports sp ON sg.sport_id=sp.id
              WHERE sp.name='Football';
#2. Изведете имената на всички треньори по волейбол.

create view VolleyballTrainers as
SELECT coaches.name as Coach,sp.name as Sport
FROM coaches JOIN sportgroups as sg ON coaches.id=sg.coach_id
			 JOIN sports as sp ON sg.sport_id=sp.id
             WHERE sp.name='Volleyball';
              
#3. Изведете името на треньора и спорта, който тренира ученик с име Илиян Иванов.

create view IlianIvanov as
SELECT students.name as StudentName,sp.name as SportName
FROM students JOIN student_sport as ss ON students.id=ss.student_id
			  JOIN sportgroups as sg ON ss.sportGroup_id=sg.id
              JOIN sports as sp ON sg.id=sp.id
              WHERE students.name='Iliyan Ivanov';

#4 Извадете сумите от платените през годините такси на учениците по месеци, со само за ученици с такси по месец над 700 лева и с тренюр ЕГН 7509041245

create view Payments as
SELECT SUM(tp.paymentAmount) as SumOfAllPaymentPerGroup
FROM taxespayments as tp JOIN students ON tp.student_id = students.id
						JOIN student_sport as ss ON students.id=ss.student_id
						JOIN sportgroups as sg ON ss.sportGroup_id=sg.id
						JOIN coaches as c ON sg.coach_id=c.id
						JOIN sports as sp ON sg.id=sp.id
                        WHERE c.egn='7509041245'
                        group by month
						HAVING SumOfAllPaymentPerGroup >700;

#5 Изведете броя на студентите във всяка група

create view StudentsCountByGroups as
SELECT count(student_id) as CountOFStudentsinGroups
FROM students JOIN student_sport ss ON students.id = ss.student_id 
group by ss.sportgroup_id;

#6 Определете двойки ученици

create view StudentCouples as
SELECT firstpl.name as firstPlayer, secondpl.name as secondPlayer, sports.name as sportName
FROM students as firstpl JOIN students as secondpl
ON firstpl.id > secondpl.id 
JOIN sports ON (
		secondpl.id IN(
		SELECT student_id 
                FROM student_sport
		WHERE sportGroup_id IN(
		SELECT id 
                FROM sportgroups
		WHERE sport_id = sports.id
		) 
		)	
AND (firstPl.id IN( SELECT student_id 
FROM student_sport
WHERE sportGroup_id IN(
SELECT id 
FROM sportgroups WHERE sport_id = sports.id							) 
				)
    )
)
WHERE firstPL.id IN(
	  SELECT student_id
	  FROM student_sport
	  WHERE sportGroup_id IN(
			SELECT sportGroup_id
			FROM student_sport
			WHERE student_id = secondPl.id
            AND sports.name='Football'
		)
)
ORDER BY sportName;

#7. Изведете имената на учениците, класовете им, местата на тренировки и
#името на треньорите за тези ученици, чийто тренировки започват в 8.00 часа. 

create view TrainingIn8oclock as
SELECT students.name as StudentName,students.class as Class,sg.location as Location,c.name as Coach
FROM students JOIN student_sport as ss ON students.id=ss.student_id
			  JOIN sportgroups as sg ON ss.sportGroup_id=sg.id
              JOIN coaches as c ON sg.coach_id=c.id
              JOIN sports sp ON sg.sport_id=sp.id
              WHERE sg.hourOfTraining='8:00';
