-- 1. Create database called «lab2»
CREATE DATABASE lab2;

-- 2. Create a simple table countries
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255),
    region_id INT,
    population INT
);

-- 3. Insert a row with any data into the table countries
INSERT INTO countries (country_name, region_id, population)
VALUES ('Canada', 2, 38000000);

-- 4. Insert one row into the table countries (country_id and country_name only)
INSERT INTO countries (country_id, country_name)
VALUES (1, 'USA');

-- 5. Insert NULL value to region_id column for a row in countries table
INSERT INTO countries (country_name, region_id, population)
VALUES ('Mexico', NULL, 126000000);

-- 6. Insert 3 rows by a single insert statement
INSERT INTO countries (country_name, region_id, population)
VALUES
('Germany', 3, 83000000),
('France', 3, 67000000),
('Italy', 3, 60000000);

-- 7. Set default value ‘Kazakhstan’ to country_name column
ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

-- 8. Insert default value to country_name column for a row in countries table
INSERT INTO countries (region_id, population)
VALUES (4, 18500000);

-- 9. Insert only default values against each column of countries table
INSERT INTO countries DEFAULT VALUES;

-- 10. Create duplicate of countries table named countries_new using LIKE
CREATE TABLE countries_new (LIKE countries INCLUDING ALL);

-- 11. Insert all rows from countries table to countries_new table
INSERT INTO countries_new
SELECT * FROM countries;

-- 12. Change region_id of country to «1» if it equals NULL
UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

-- 13. Increase population of each country by 10% and return updated population with alias "New Population"
SELECT country_name, population * 1.10 AS "New Population"
FROM countries;

-- 14. Remove all rows from countries table with less than 100k population
DELETE FROM countries
WHERE population < 100000
RETURNING *;

-- 15. Remove all rows from countries_new if country_id exists in countries table
DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;

-- 16. Remove all rows from countries table and return all deleted data
DELETE FROM countries
RETURNING *;
