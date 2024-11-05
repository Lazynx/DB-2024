-- 1. Create database called «lab5»
CREATE DATABASE lab5;

-- 2. Create following table «customers» and «orders»:
CREATE TABLE customers (
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

CREATE TABLE orders (
    ord_no INT primary key,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);

CREATE TABLE salesman (
      salesman_id INT PRIMARY KEY,
      name VARCHAR(50),
      city VARCHAR(50),
      commission DECIMAL(4, 2)
);

INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

select cust_name from customers c join orders o on c.customer_id = o.customer_id join salesman s on c.salesman_id = s.salesman_id where c.city != s.city;

-- 3. Select the total purchase amount of all orders.
SELECT SUM(purch_amt) FROM orders;

-- 4. Select the average purchase amount of all orders.
SELECT AVG(purch_amt) FROM orders;

-- 5. Select how many customer have listed their names.
SELECT COUNT(*) AS customer_name
FROM CUSTOMERS
WHERE cust_name IS NOT NULL;

-- 6. Select the minimum purchase amount of all the orders.
SELECT MIN(purch_amt) FROM orders;

-- 7. Select customer with all information whose name ends with the
-- letter 'b'.
SELECT * FROM customers WHERE cust_name LIKE '%b';

-- 8. Select orders which made by customers from ‘New York’.
SELECT orders.* FROM orders JOIN customers ON orders.customer_id = customers.customer_id WHERE customers.city = 'New York';

-- 9.Select customers with all information who has order with
-- purchase amount more than 10.
SELECT customers.* FROM customers JOIN orders ON customers.customer_id = orders.customer_id WHERE orders.purch_amt > 10;

-- 10. Select total grade of all customers.
SELECT SUM(grade) FROM customers;

-- 11. Select all customers who have listed their names.
SELECT * FROM CUSTOMERS WHERE cust_name IS NOT NULL;

-- 12. Select the maximum grade of all the customers.
SELECT MAX(grade) FROM customers;