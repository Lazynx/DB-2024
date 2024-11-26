CREATE DATABASE lab10;

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (name, position, salary)
VALUES
    ('John Doe', 'Manager', 5000.00),
    ('Jane Smith', 'Developer', 4000.00),
    ('Alice Johnson', 'Analyst', 4500.00);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category VARCHAR(100)
);

INSERT INTO products (name, price, category)
VALUES
    ('Laptop', 1200.00, 'Electronics'),
    ('Phone', 800.00, 'Electronics'),
    ('Desk', 150.00, 'Furniture');

-- Task 1: Increase Value by 10
CREATE OR REPLACE PROCEDURE increase_value(IN input_value INT, OUT result_value INT)
LANGUAGE plpgsql AS $$
BEGIN
    result_value := input_value + 10;
END;
$$;

CALL increase_value(10, 0);

-- Task 2: Compare Numbers
CREATE OR REPLACE PROCEDURE compare_numbers(IN num1 INT, IN num2 INT, OUT comparison_result VARCHAR)
LANGUAGE plpgsql AS $$
BEGIN
    IF num1 > num2 THEN
        comparison_result := 'Greater';
    ELSIF num1 = num2 THEN
        comparison_result := 'Equal';
    ELSE
        comparison_result := 'Lesser';
    END IF;
END;
$$;

CALL compare_numbers(5, 10, '');

-- Task 3: Generate Number Series
CREATE OR REPLACE PROCEDURE number_series(IN n INT, OUT series VARCHAR)
LANGUAGE plpgsql AS $$
DECLARE
    i INT := 1;
BEGIN
    series := '';
    WHILE i <= n LOOP
        series := series || i || CASE WHEN i < n THEN ',' ELSE '' END;
        i := i + 1;
    END LOOP;
END;
$$;

CALL number_series(5, '');

-- Task 4: Find Employee
CREATE OR REPLACE PROCEDURE find_employee(IN employee_name VARCHAR)
LANGUAGE plpgsql AS $$
BEGIN
    PERFORM * FROM employees WHERE name = employee_name;
END;
$$;

CALL find_employee('John Doe');


-- Task 5: List Products by Category
CREATE OR REPLACE PROCEDURE list_products(IN category_name VARCHAR)
LANGUAGE plpgsql AS $$
BEGIN
    PERFORM * FROM products WHERE category = category_name;
END;
$$;

CALL list_products('Electronics');

-- Task 6: Nested Procedures - Calculate Bonus and Update Salary
CREATE OR REPLACE PROCEDURE calculate_bonus(IN salary DECIMAL, OUT bonus DECIMAL)
LANGUAGE plpgsql AS $$
BEGIN
    bonus := salary * 0.1;
END;
$$;

CREATE OR REPLACE PROCEDURE update_salary(IN employee_id INT)
LANGUAGE plpgsql AS $$
DECLARE
    current_salary DECIMAL;
    bonus DECIMAL;
BEGIN
    SELECT salary INTO current_salary FROM employees WHERE id = employee_id;
    CALL calculate_bonus(current_salary, bonus);
    UPDATE employees SET salary = salary + bonus WHERE id = employee_id;
END;
$$;

CALL update_salary(1);

-- Task 7: Complex Calculation
CREATE OR REPLACE PROCEDURE complex_calculation(IN num1 INT, IN str1 VARCHAR, OUT result VARCHAR)
LANGUAGE plpgsql AS $$
DECLARE
    numeric_result INT;
    string_result VARCHAR;
BEGIN
    -- Subblock 1: Numeric Computation
    BEGIN
        numeric_result := num1 * 2;
    END;

    -- Subblock 2: String Manipulation
    BEGIN
        string_result := 'Processed: ' || str1;
    END;

    -- Combine Results
    result := string_result || ' | Numeric Result: ' || numeric_result;
END;
$$;

CALL complex_calculation(5, 'Test String', '');