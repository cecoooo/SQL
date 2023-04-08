use school_sport_clubs;
#1
DELIMITER $
CREATE PROCEDURE zad1(IN coachName VARCHAR(255))
BEGIN
SELECT sp.name as sportName, sg.location, sg.hourOfTraining, sg.dayOfWeek, st.name, st.phone
FROM coaches as co
JOIN sportGroups as sg ON sg.coach_id = co.id
JOIN sports as sp ON sp.id = sg.sport_id
JOIN student_sport as stsp ON stsp.sportGroup_id = sg.id
JOIN students as st ON st.id = stsp.student_id
WHERE co.name = coachName;
END $
DELIMITER ;

call zad1("Ivan Todorov Petkov");

#2
DELIMITER $
CREATE PROCEDURE zad2(IN sportId INT)
BEGIN
SELECT sp.name as sportName, st.name as studentName, co.name as coachName
FROM coaches as co
JOIN sportGroups as sg ON sg.coach_id = co.id
JOIN sports as sp ON sp.id = sg.sport_id
JOIN student_sport as stsp ON stsp.sportGroup_id = sg.id
JOIN students as st ON st.id = stsp.student_id
WHERE sp.id = sportId;
END $
DELIMITER ;

call zad2(1);

#3
DELIMITER $
CREATE PROCEDURE zad3(IN studentName VARCHAR(255), IN yeari VARCHAR(4))
BEGIN
SELECT avg(tp.paymentAmount) FROM students as st
JOIN taxesPayments as tp on tp.student_id = st.id
WHERE tp.year = yeari
AND st.name = studentName;
END $
DELIMITER ;

call zad3("Iliyan Ivanov",2021);

#4 
DELIMITER $
CREATE PROCEDURE zad4(IN coachName VARCHAR(255))
BEGIN
DECLARE result VARCHAR(255);
SET result = "";
IF((SELECT count(sg.id) as cnt FROM coaches as co
JOIN sportGroups as sg ON sg.coach_id = co.id
WHERE co.name = coachName) IS NOT NULL)
THEN
	SET result = (SELECT count(sg.id) as cnt FROM coaches as co
JOIN sportGroups as sg ON sg.coach_id = co.id
WHERE co.name = coachName);
ELSE
	SET result = "NO RES";
END IF;
SELECT result;
END $
DELIMITER ;

call zad4("Ivan Todorov Petkov");