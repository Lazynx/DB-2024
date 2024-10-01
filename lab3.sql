DROP DATABASE if exists lab3;
DROP TABLE if exists departments;

-- Task 1: Create database called «lab3»
CREATE DATABASE lab3;

-- Task 2: Download lab3.sql file from intranet. Copy content and run using Query Tool
CREATE TABLE departments (
    code INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL ,
    budget DECIMAL NOT NULL
);

CREATE TABLE employees (
    ssn INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL ,
    lastname VARCHAR(255) NOT NULL ,
    department INTEGER NOT NULL ,
    city VARCHAR(255),
    FOREIGN KEY (department) REFERENCES departments(code)
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL ,
    lastname VARCHAR(255) NOT NULL ,
    city VARCHAR(255)
);

INSERT INTO departments(code,name,budget) VALUES(14,'IT',65000);
INSERT INTO departments(code,name,budget) VALUES(37,'Accounting',15000);
INSERT INTO departments(code,name,budget) VALUES(59,'Human Resources',240000);
INSERT INTO departments(code,name,budget) VALUES(77,'Research',55000);
INSERT INTO departments(code,name,budget) VALUES(45,'Management',155000);
INSERT INTO departments(code,name,budget) VALUES(11,'Sales',85000);

INSERT INTO employees(ssn,name,lastname,department, city) VALUES('123234877','Michael','Rogers',14, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('152934485','Anand','Manikutty',14, 'Shymkent');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('222364883','Carol','Smith',37, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('326587417','Joe','Stevens',37, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('332154719','Mary-Anne','Foster',14, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('332569843','George','ODonnell',77, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('546523478','John','Doe',59, 'Shymkent');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('631231482','David','Smith',77, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('654873219','Zacary','Efron',59, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('745685214','Eric','Goldsmith',59, 'Atyrau');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('845657245','Elizabeth','Doe',14, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('845657246','Kumar','Swamy',14, 'Almaty');

INSERT INTO customers(name,lastname, city) VALUES('John','Wills', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Garry','Foster', 'London');
INSERT INTO customers(name,lastname, city) VALUES('Amanda','Hills', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('George','Doe', 'Tokyo');
INSERT INTO customers(name,lastname, city) VALUES('David','Little', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Shawn','Efron', 'Astana');
INSERT INTO customers(name,lastname, city) VALUES('Eric','Gomez', 'Shymkent');
INSERT INTO customers(name,lastname, city) VALUES('Elizabeth','Tailor', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Julia','Adams', 'Astana');

-- Task 3: Select the last name of all employees
SELECT lastname FROM employees;

-- Task 4: Select the last name of all employees, without duplicates
SELECT DISTINCT lastname FROM employees;

-- Task 5: Select all the data of employees whose last name is «Smith»
SELECT * FROM employees WHERE lastname = 'Smith';

-- Task 6: Select all the data of employees whose last name is "Smith" or «Doe»
SELECT * FROM employees WHERE lastname IN ('Smith', 'Doe');

-- Task 7: Select all the data of employees that work in department 14
SELECT * FROM employees WHERE department = 14;

-- Task 8: Select all the data of employees that work in department 37 or department 77
SELECT * FROM employees WHERE department IN (37, 77);

-- Task 9: Select the sum of all the departments' budgets
SELECT SUM(budget) FROM departments;

-- Task 10: Select the number of employees in each department
SELECT department, COUNT(*) FROM employees GROUP BY department;

-- Task 11: Select the department code with more than 2 employees
SELECT department FROM employees GROUP BY department HAVING COUNT(*) > 2;

-- Task 12: Select the name of the department with second highest budget
SELECT name FROM departments
ORDER BY budget DESC
LIMIT 1 OFFSET 1;

-- Task 13: Select the name and last name of employees working for departments with lowest budget
SELECT name, lastname FROM employees
WHERE department IN (SELECT code FROM departments
WHERE budget = (SELECT MIN(budget) FROM departments));

-- Task 14: Select the name of all employees and customers from Almaty
SELECT name, lastname FROM employees WHERE city = 'Almaty'
UNION
SELECT name, lastname FROM customers WHERE city = 'Almaty';

-- Task 15: Select all departments with budget more than 60000, sorted by increasing budget and decreasing code
SELECT * FROM departments WHERE budget > 60000
ORDER BY budget ASC;

-- Task 16: Reduce the budget of department with lowest budget by 10%
UPDATE departments
SET budget = budget * 0.9
WHERE budget = (SELECT MIN(budget) FROM departments);

-- Task 17: Reassign all employees from the Research department to the IT department
UPDATE employees
SET department = (SELECT code FROM departments WHERE name = 'IT')
WHERE department = (SELECT code FROM departments WHERE name = 'Research');

-- Task 18: Delete from the table all employees in the IT department
DELETE FROM employees
WHERE department = (SELECT code FROM departments WHERE name = 'IT');

-- Task 19: Delete from the table all employees
DELETE FROM employees;