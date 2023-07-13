DROP DATABASE IF EXISTS consultingjvm;
CREATE DATABASE consultingjvm;
USE consultingjvm;


CREATE TABLE locations (
id INT AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(255),
url VARCHAR(255)
);

CREATE TABLE appointmentStatus(
id INT AUTO_INCREMENT PRIMARY KEY,
statusType VARCHAR(64) NOT NULL
);


CREATE TABLE departments(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
departmentName VARCHAR(64) NOT NULL
);

CREATE TABLE services(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
type VARCHAR(64) NOT NULL,
dep_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (dep_id) REFERENCES departments(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE employeeRoles(
id INT AUTO_INCREMENT PRIMARY KEY,
roleType VARCHAR(64) NOT NULL UNIQUE
);

CREATE TABLE employees (
id INT auto_increment PRIMARY KEY,
firstName VARCHAR(100) NOT NULL,
lastName VARCHAR(100) NOT NULL,
email VARCHAR (100) NOT NULL UNIQUE,
phone VARCHAR(14) NOT NULL UNIQUE,
emp_password VARCHAR(10) NOT NULL UNIQUE,
role_id INT NOT NULL,
dep_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (role_id) REFERENCES employeeRoles (id) ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (dep_id) REFERENCES departments (id) ON UPDATE CASCADE
);

CREATE TABLE appointments (
id INT AUTO_INCREMENT PRIMARY KEY,
firstName VARCHAR(100) NOT NULL,
lastName VARCHAR(100) NOT NULL,
email VARCHAR (100) NOT NULL UNIQUE,
phone VARCHAR(14) NOT NULL UNIQUE,
date_time DATETIME NOT NULL,
service_id INT NOT NULL,
location_id INT NOT NULL,
status_id INT NOT NULL,
employee_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (service_id) REFERENCES services (id) ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (location_id) REFERENCES locations (id) ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (status_id) REFERENCES appointmentStatus (id) ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (employee_id) REFERENCES employees (id) ON UPDATE CASCADE
);

INSERT INTO departments(departmentName) VALUES ('Administration');

INSERT INTO employeeRoles(roleType) VALUES ('admin');

INSERT INTO employees (firstName, lastName, email, phone, emp_password, role_id, dep_id) 
VALUES ('Ivan', 'Ivanov', 'ivanivanov@gmail.com', '0888888888', 'ivanIvan00', 1, 1);

SELECT employees.*, roleType, departmentName FROM employees 
JOIN employeeRoles ON employeeRoles.id = employees.role_id 
JOIN departments ON departments.id = employees.dep_id;