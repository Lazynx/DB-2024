-- 1. Create database called «lab5»
CREATE DATABASE lab5;

-- 2. Create following table «customers» and «orders»:
CREATE TABLE CUSTOMERS (
    customer_id INT primary key,
    cust_name varchar(50),
    city varchar(50),
    grade INT,
    salesman_id INT
);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

CREATE TABLE ORDERS (

);