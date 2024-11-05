-- 1. Create database called «lab6»
CREATE DATABASE lab6;

-- 2. Create following tables:
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
('123 Main St', '12345', 'Almaty', 'Alm'),
('456 Oak St', '23456', 'Nur-Sultan', 'Nur'),
('789 Pine St', '34567', 'Shymkent', 'Shy'),
('101 Maple St', '45678', 'Aktobe', 'Akt'),
('102 Birch St', '56789', 'Atyrau', 'Aty'),
('103 Cedar St', '67890', 'Karaganda', 'Kar'),
('104 Elm St', '78901', 'Pavlodar', 'Pav'),
('105 Willow St', '89012', 'Kostanay', 'Kos'),
('106 Aspen St', '90123', 'Taraz', 'Tar'),
('107 Spruce St', '01234', 'Semey', 'Sem');

INSERT INTO departments (department_name, budget, location_id) VALUES
('HR', 50000, 1),
('Finance', 70000, 2),
('IT', 150000, 3),
('Marketing', 60000, 4),
('Sales', 80000, 5),
('Logistics', 90000, 6),
('Legal', 75000, 7),
('Support', 55000, 8),
('Development', 160000, 9),
('Operations', 100000, 10);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', 50000, 1),
('Jane', 'Smith', 'jane.smith@example.com', '555-2345', 60000, 2),
('James', 'Brown', 'james.brown@example.com', '555-3456', 80000, 3),
('Emily', 'Davis', 'emily.davis@example.com', '555-4567', 75000, 4),
('Michael', 'Wilson', 'michael.wilson@example.com', '555-5678', 85000, 5),
('Sarah', 'Moore', 'sarah.moore@example.com', '555-6789', 70000, 6),
('Robert', 'Taylor', 'robert.taylor@example.com', '555-7890', 90000, 7),
('Olivia', 'Anderson', 'olivia.anderson@example.com', '555-8901', 65000, 8),
('William', 'Thomas', 'william.thomas@example.com', '555-9012', 95000, 9),
('Sophia', 'Jackson', 'sophia.jackson@example.com', '555-0123', 100000, 10);

-- 3. Select the first name, last name, department id, and department name for each employee.
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e
JOIN departments d on e.department_id = d.department_id;

-- 4. Select the first name, last name, department id and department name, for all employees for departments 80 or 40.
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id = 80 or e.department_id = 40;

-- 5. Select the first and last name, department, city, and state province for each employee.
SELECT
e.first_name,
e.last_name,
d.department_name,
l.city,
l.state_province
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

-- 6. Select all departments including those where does not have any employee.
SELECT
d.department_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- 7. Select the first name, last name, department id and name, for all employees who have or have not any department.
SELECT
e.first_name,
e.last_name,
d.department_id,
d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;