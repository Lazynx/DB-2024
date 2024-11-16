-- 1. Create database called "lab8"
CREATE DATABASE lab8;

-- 2. Create tables "salesman", "customers", and "orders"
CREATE TABLE salesman (
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    commission NUMERIC(10, 2)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    grade INT,
    salesman_id INT REFERENCES salesman(salesman_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    amount NUMERIC(10, 2),
    customer_id INT REFERENCES customers(customer_id),
    salesman_id INT REFERENCES salesman(salesman_id)
);

-- 3. Create role named "junior_dev" with login privilege
CREATE ROLE junior_dev;

-- 4. Create a view for salesmen belonging to the city New York
CREATE VIEW salesman_new_york AS
SELECT *
FROM salesman
WHERE city = 'New York';

-- 5. Create a view that shows for each order the salesman and customer by name.
-- Grant all privileges to "junior_dev"
CREATE VIEW orders_with_salesman_and_customer AS
SELECT
    orders.order_id,
    orders.order_date,
    orders.amount,
    c.name AS customer_name,
    s.name AS salesman_name
FROM orders
JOIN customers c on orders.customer_id = c.customer_id
JOIN salesman s on c.salesman_id = s.salesman_id;

GRANT ALL PRIVILEGES ON orders_with_salesman_and_customer TO junior_dev;

-- 6. Create a view that shows all of the customers who have the highest grade.
-- Grant only SELECT privileges to "junior_dev"
CREATE VIEW highest_grade_customers AS
SELECT *
FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON highest_grade_customers TO junior_dev;

-- 7. Create a view that shows the number of salesmen in each city
CREATE VIEW salesman_count_by_city AS
SELECT
    city,
    COUNT(*) AS salesman_count
FROM salesman
GROUP BY city;

-- 8. Create a view that shows each salesman with more than one customer
CREATE VIEW salesman_with_multiple_customers AS
SELECT
    salesman.name AS salesman_name,
    COUNT(customers.customer_id) AS customer_count
FROM salesman
    JOIN customers ON salesman.salesman_id = customers.salesman_id
GROUP BY salesman.name
HAVING COUNT(customers.customer_id) > 1;

-- 9. Create role "intern" and give all privileges of "junior_dev"
CREATE ROLE intern;
GRANT junior_dev TO intern;