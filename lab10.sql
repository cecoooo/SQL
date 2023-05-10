DROP DATABASE IF EXISTS `cableCompany`;
CREATE DATABASE `cableCompany`;
USE `cableCompany`;

CREATE TABLE `cableCompany`.`customers` (
	`customerID` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
	`firstName` VARCHAR( 55 ) NOT NULL ,
	`middleName` VARCHAR( 55 ) NOT NULL ,
	`lastName` VARCHAR( 55 ) NOT NULL ,
	`email` VARCHAR( 55 ) NULL , 
	`phone` VARCHAR( 20 ) NOT NULL , 
	`address` VARCHAR( 255 ) NOT NULL ,
	PRIMARY KEY ( `customerID` )
) ENGINE = InnoDB;

CREATE TABLE `cableCompany`.`accounts` (
	`accountID` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
	`amount` DOUBLE NOT NULL ,
	`customer_id` INT UNSIGNED NOT NULL ,
	CONSTRAINT FOREIGN KEY ( `customer_id` )
		REFERENCES `cableCompany`.`customers` ( `customerID` )
		ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `cableCompany`.`plans` (
	`planID` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(32) NOT NULL,
	`monthly_fee` DOUBLE NOT NULL
) ENGINE = InnoDB;

CREATE TABLE `cableCompany`.`payments`(
	`paymentID` INT AUTO_INCREMENT PRIMARY KEY ,
	`paymentAmount` DOUBLE NOT NULL ,
	`month` TINYINT NOT NULL ,
	`year` YEAR NOT NULL ,
	`dateOfPayment` DATETIME NOT NULL ,
	`customer_id` INT UNSIGNED NOT NULL ,
	`plan_id` INT UNSIGNED NOT NULL ,		
	CONSTRAINT FOREIGN KEY ( `customer_id` )
		REFERENCES `cableCompany`.`customers`( `customerID` ) ,
	CONSTRAINT FOREIGN KEY ( `plan_id` ) 
		REFERENCES `cableCompany`.`plans` ( `planID` ) ,
	UNIQUE KEY ( `customer_id`, `plan_id`,`month`,`year` )
)ENGINE = InnoDB;

CREATE TABLE `cableCompany`.`debtors`(
	`customer_id` INT UNSIGNED NOT NULL ,
	`plan_id` INT UNSIGNED NOT NULL ,
	`debt_amount` DOUBLE NOT NULL ,
	FOREIGN KEY ( `customer_id` )
		REFERENCES `cableCompany`.`customers`( `customerID` ) ,
	FOREIGN KEY ( `plan_id` )
		REFERENCES `cableCompany`.`plans`( `planID` ) ,
	PRIMARY KEY ( `customer_id`, `plan_id` )
) ENGINE = InnoDB;

INSERT INTO customers (firstName, middleName, lastName, email, phone, address)
VALUES 
    ('John', 'Michael', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St'),
    ('Jane', 'Marie', 'Smith', 'jane.smith@example.com', '9876543210', '456 Elm St'),
    ('David', '', 'Johnson', 'david.johnson@example.com', '5555555555', '789 Oak Ave'),
    ('Sarah', 'Elizabeth', 'Brown', 'sarah.brown@example.com', '1111111111', '321 Maple Rd'),
    ('Robert', '', 'Williams', 'robert.williams@example.com', '2222222222', '555 Pine St'),
    ('Emily', 'Grace', 'Davis', 'emily.davis@example.com', '3333333333', '777 Cedar Ave'),
    ('Michael', 'James', 'Miller', 'michael.miller@example.com', '4444444444', '999 Oak St'),
    ('Olivia', '', 'Wilson', 'olivia.wilson@example.com', '5555555555', '222 Elm St'),
    ('Matthew', 'Thomas', 'Anderson', 'matthew.anderson@example.com', '6666666666', '444 Maple Ave'),
    ('Sophia', '', 'Taylor', 'sophia.taylor@example.com', '7777777777', '666 Pine Ave');
    
INSERT INTO accounts (amount, customer_id)
VALUES 
    (100.00, 1),
    (200.00, 2),
    (150.00, 3),
    (300.00, 4),
    (250.00, 5),
    (180.00, 6),
    (400.00, 7),
    (220.00, 8),
    (175.00, 9),
    (350.00, 10);
    
INSERT INTO `cableCompany`.`plans` (`name`, `monthly_fee`)
VALUES
    ('Basic Plan', 49.99),
    ('Standard Plan', 79.99),
    ('Premium Plan', 99.99),
    ('Family Plan', 129.99),
    ('Sports Plan', 89.99),
    ('Movie Plan', 109.99),
    ('Music Plan', 59.99),
    ('Business Plan', 149.99),
    ('Ultimate Plan', 199.99),
    ('Custom Plan', 69.99);
    
INSERT INTO `cableCompany`.`payments` (`paymentAmount`, `month`, `year`, `dateOfPayment`, `customer_id`, `plan_id`)
VALUES
    (100.00, 1, 2023, '2023-01-15 10:30:00', 1, 1),
    (150.00, 2, 2023, '2023-02-20 14:45:00', 2, 2),
    (120.00, 3, 2023, '2023-03-10 09:15:00', 3, 1),
    (200.00, 4, 2023, '2023-04-05 16:30:00', 1, 3),
    (180.00, 5, 2023, '2023-05-12 11:00:00', 4, 2),
    (250.00, 1, 2023, '2023-01-28 12:00:00', 2, 3),
    (300.00, 3, 2023, '2023-03-18 15:30:00', 5, 1),
    (170.00, 4, 2023, '2023-04-10 09:45:00', 3, 2),
    (220.00, 2, 2023, '2023-02-05 17:15:00', 6, 3),
    (190.00, 5, 2023, '2023-05-20 10:30:00', 7, 1);
    
select * from debtors;

#1
drop procedure if exists ex1;
delimiter \\
create procedure ex1(in customerId int, in sum double, out result bit)
	begin
		declare curSum double;
        
		start transaction;
		
			select amount into curSum 
			from accounts
			where customer_id = customerId;
			
			if curSum < sum then 
			set result = 0;
			rollback;
            else 
            update accounts
            set amount = amount - sum
            where customer_id = customerId;
            set result = 1;
			end if;
    commit;
end \\
delimiter ;


call ex1(1, 100, @res);
select @res;

select * from customers;
select * from accounts;

#2
drop procedure if exists ex2;
delimiter \\
create procedure ex2(in customerId int, in plan_id int)
	begin
		declare fee double;
        declare isThere bool default false;
		declare finished int;
        declare currCus, currPlan int;
        declare curDebts cursor for select customer_id, plan_id from debtors;
        declare continue handler for not found set finished = 1;
        set finished = 0;
		start transaction;
        
			select monthly_fee into fee from plans where planID = plan_id;
			
			if (select amount from accounts where customer_id = customerId) >= fee then
            update accounts
            set amount = amount - fee
            where customer_id = customerId;
            else
				open curDebts;
				getRecords: loop
					fetch curDebts into currCus, CurrPlan;
                    if finished = 1 then leave getRecords;
                    end if;
                    if currCus = customerId and currPlan = plan_id then set isThere = true;
                    update debtors
                    set debt_amount = debt_amount + fee
                    where currCus = customer_id and currPlan = plan_id;
                    end if;
                end loop getRecords;
                
                if isThere = false then 
                insert into debtors(customer_id, plan_id, debt_amount)
                values(customerId, plan_id, fee);
                end if;
			end if;
		commit;
end \\
delimiter ;

call ex2(1, 2);
call ex2(2, 1);
select * from customers;
select * from accounts;
select * from plans;
select * from debtors;




