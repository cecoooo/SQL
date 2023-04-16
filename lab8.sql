use school_sport_clubs;
create view allInfozad1
as select coaches.name, sportgroups.location as groupInfo, sports.name as sport, salarypayments.year, salarypayments.month, salarypayments.salaryAmount
from coaches join sportgroups
on coaches.id = sportgroups.coach_id
join sports
on sports.id = sportgroups.sport_id
join salarypayments 
on salarypayments.coach_id = coaches.id;
 
INSERT INTO school_sport_clubs.`salarypayments` 
(coach_id, month, year, salaryAmount, dateOfPayment) 
VALUES ('4', '4', 2016, '-1450', '2016-04-22 11:45:08');
 
select * from allInfozad1;
 
 
 
 
 
DELIMITER &
CREATE TRIGGER salarypayments_delete_trigger
AFTER DELETE ON salarypayments
FOR EACH ROW
BEGIN
    INSERT INTO salarypayments_log (
        operation,
        old_coach_id,
        old_month,
        old_year,
        old_salaryAmount,
        old_dateOfPayment,
        dateOfLog
    )
    VALUES (
        'DELETE',
        OLD.coach_id,
        OLD.month,
        OLD.year,
        OLD.salaryAmount,
        OLD.dateOfPayment,
        NOW()
    );
END &
DELIMITER ;
 
 
 
 
DELETE from salarypayments where salarypayments.id = 2;
 
INSERT INTO salarypayments (coach_id, `month`, `year`, salaryAmount, dateOfPayment)
SELECT old_coach_id, old_month, old_year, old_salaryAmount, old_dateOfPayment
FROM salarypayments_log
WHERE operation = 'DELETE';
 
 
 
 
 
 
USE transaction_test;
 
DROP PROCEDURE IF EXISTS convert_currency;
 
DELIMITER //
 
CREATE PROCEDURE convert_currency(IN amount DOUBLE, IN currency_from VARCHAR(10), IN currency_to VARCHAR(10), OUT result DOUBLE)
BEGIN
    DECLARE rate_eur DOUBLE;
    DECLARE rate_bgn DOUBLE;
 
    IF currency_from = 'BGN' THEN
        SET result = amount / 0.51;
    ELSEIF currency_from = 'EUR' THEN
        SET result = amount * 1.96;
    END IF;
 
    IF currency_to = 'BGN' THEN
        SET result = result * 1.96;
    ELSEIF currency_to = 'EUR' THEN
        SET result = result / 0.51;
    END IF;
END//
 
DELIMITER ;
 
 
 
 
 
drop procedure transfer_money;
DELIMITER //
CREATE PROCEDURE transfer_money(IN sender_id INT, IN recipient_id INT, IN amount DECIMAL(10,2))
BEGIN
    DECLARE sender_currency VARCHAR(10);
    DECLARE recipient_currency VARCHAR(10);
    DECLARE exchange_rate DECIMAL(10,2);
    DECLARE MESSAGE_TEXT VARCHAR(256);
    SELECT currency INTO sender_currency FROM customer_accounts WHERE id = sender_id;
    IF sender_currency IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sender account not found';
    END IF;
 
    SELECT currency INTO recipient_currency FROM customer_accounts WHERE id = recipient_id;
    IF recipient_currency IS NULL THEN
        SET MESSAGE_TEXT = 'Recipient account not found';
    END IF;
 
    IF sender_currency = recipient_currency THEN
        SET exchange_rate = 1;
    ELSEIF sender_currency = 'BGN' AND recipient_currency = 'EUR' THEN
        SET exchange_rate = 1/1.96;
    ELSEIF sender_currency = 'EUR' AND recipient_currency = 'BGN' THEN
        SET exchange_rate = 1.96;
    ELSE
        SET MESSAGE_TEXT = 'Invalid currency exchange';
    END IF;
 
    UPDATE customer_accounts SET amount = amount - amount*exchange_rate WHERE id = sender_id AND amount >= amount*exchange_rate;
    IF ROW_COUNT() = 0 THEN
        SET MESSAGE_TEXT = 'Insufficient funds';
    END IF;
 
    UPDATE customer_accounts SET amount = amount + amount*exchange_rate WHERE id = recipient_id;
    IF ROW_COUNT() = 0 THEN
       SET MESSAGE_TEXT = 'Transaction failed';
    END IF;
 
    INSERT INTO transactions_log (sender_id, recipient_id, amount, exchange_rate, date_of_transaction)
    VALUES (sender_id, recipient_id, amount, exchange_rate, NOW());
 
    SELECT 'Transaction successful' AS result;
END//
DELIMITER ;