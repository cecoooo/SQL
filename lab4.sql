CREATE DATABASE IF NOT EXISTS transaction_test;  
	USE transaction_test;  
	  
	DROP TABLE IF EXISTS customer_accounts;  
	  
	DROP TABLE IF EXISTS customers;  
	  
	CREATE TABLE customers(  
	id int AUTO_INCREMENT PRIMARY KEY ,  
	name VARCHAR(255) NOT NULL ,  
	address VARCHAR(255)  
	)ENGINE=InnoDB;  
	  
	CREATE TABLE IF NOT EXISTS customer_accounts(  
	id INT AUTO_INCREMENT PRIMARY KEY ,  
	amount DOUBLE NOT NULL ,  
	currency VARCHAR(10),  
	customer_id INT NOT NULL ,  
	CONSTRAINT FOREIGN KEY (customer_id)   
	    REFERENCES customers(id)   
	    ON DELETE RESTRICT ON UPDATE CASCADE  
	)ENGINE=InnoDB;  
	  
	INSERT INTO `transaction_test`.`customers` (`name`, `address`)   
	VALUES ('Ivan Petrov Iordanov', 'Sofia, Krasno selo 1000');  
	INSERT INTO `transaction_test`.`customers` (`name`, `address`)   
	VALUES ('Stoyan Pavlov Pavlov', 'Sofia, Liuylin 7, bl. 34');  
	INSERT INTO `transaction_test`.`customers` (`name`, `address`)   
	VALUES ('Iliya Mladenov Mladenov', 'Sofia, Nadezhda 2, bl 33');  
	  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('5000', 'BGN', '1');  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('10850', 'EUR', '1');  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('1450000', 'BGN', '2');  
	INSERT INTO `transaction_test`.`customer_accounts` (`amount`, `currency`, `customer_id`)   
	VALUES ('17850', 'EUR', '2');
    
use school_sport_clubs;    
#1. Изведете имената, класовете и телефоните на всички ученици, които тренират футбол.

SELECT students.name as StudentName,students.class as Class,students.phone as Studentsphone
FROM students JOIN student_sport as ss ON students.id=ss.student_id
			  JOIN sportgroups as sg ON ss.sportGroup_id=sg.id
              JOIN sports sp ON sg.sport_id=sp.id
              WHERE sp.name='Football';
#2. Изведете имената на всички треньори по волейбол.

SELECT coaches.name as Coach,sp.name as Sport
FROM coaches JOIN sportgroups as sg ON coaches.id=sg.coach_id
			 JOIN sports as sp ON sg.sport_id=sp.id
             WHERE sp.name='Volleyball';
              
#3. Изведете името на треньора и спорта, който тренира ученик с име Илиян Иванов.

SELECT students.name as StudentName,sp.name as SportName
FROM students JOIN student_sport as ss ON students.id=ss.student_id
			  JOIN sportgroups as sg ON ss.sportGroup_id=sg.id
              JOIN sports as sp ON sg.id=sp.id
              WHERE students.name='Iliyan Ivanov';

#4 Извадете сумите от платените през годините такси на учениците по месеци, со само за ученици с такси по месец над 700 лева и с тренюр ЕГН 7509041245
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
SELECT count(student_id) as CountOFStudentsinGroups
FROM students JOIN student_sport ss ON students.id = ss.student_id 
group by ss.sportgroup_id;

#6 Определете двойки ученици
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
SELECT students.name as StudentName,students.class as Class,sg.location as Location,c.name as Coach
FROM students JOIN student_sport as ss ON students.id=ss.student_id
			  JOIN sportgroups as sg ON ss.sportGroup_id=sg.id
              JOIN coaches as c ON sg.coach_id=c.id
              JOIN sports sp ON sg.sport_id=sp.id
              WHERE sg.hourOfTraining='8:00';


    
    
    