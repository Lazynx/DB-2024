
-- 1. Создание базы данных «lab4»
CREATE DATABASE lab4;

-- Переключаемся на базу данных lab4
\c lab4;

-- 2. Создание таблиц «Warehouses» и «Boxes»

CREATE TABLE Warehouses (
    code INTEGER PRIMARY KEY,
    location VARCHAR(255),
    capacity INTEGER
);

CREATE TABLE Boxes (
    code CHAR(4) PRIMARY KEY,
    contents VARCHAR(255),
    value REAL,
    warehouse INTEGER,
    FOREIGN KEY (warehouse) REFERENCES Warehouses(code)
);

-- Вставка данных в таблицу Warehouses
INSERT INTO Warehouses (code, location, capacity) VALUES
(1, 'Chicago', 3),
(2, 'Chicago', 4),
(3, 'New York', 7),
(4, 'Los Angeles', 2),
(5, 'San Francisco', 8);

-- Вставка данных в таблицу Boxes
INSERT INTO Boxes (code, contents, value, warehouse) VALUES
('0MN7', 'Rocks', 180, 3),
('4HBP', 'Rocks', 250, 1),
('4RT3', 'Scissors', 190, 4),
('7G3H', 'Rocks', 200, 1),
('8JN6', 'Papers', 75, 1),
('8Y6U', 'Papers', 50, 3),
('9J6F', 'Papers', 175, 2),
('LL08', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P2T6', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);

-- 3. Запрос всех складов
SELECT * FROM Warehouses;

-- 4. Запрос всех коробок, у которых значение больше 150
SELECT * FROM Boxes WHERE value > 150;

-- 5. Запрос всех уникальных содержимых коробок
SELECT DISTINCT contents FROM Boxes;

-- 6. Запрос кода склада и количества коробок на каждом складе
SELECT warehouse, COUNT(*) AS number_of_boxes
FROM Boxes
GROUP BY warehouse;

-- 7. Запрос тех складов, где количество коробок больше 2
SELECT warehouse, COUNT(*) AS number_of_boxes
FROM Boxes
GROUP BY warehouse
HAVING COUNT(*) > 2;

-- 8. Создание нового склада в Нью-Йорке с вместимостью 3 коробки
INSERT INTO Warehouses (code, location, capacity) VALUES
(6, 'New York', 3);

-- 9. Создание новой коробки с кодом «H5RT», содержащей «Papers», стоимостью $200 и расположенной на складе 2
INSERT INTO Boxes (code, contents, value, warehouse) VALUES
('H5RT', 'Papers', 200, 2);

-- 10. Уменьшение стоимости третьей по величине коробки на 15%
UPDATE Boxes
SET value = value * 0.85
WHERE code = (SELECT code FROM Boxes ORDER BY value DESC LIMIT 1 OFFSET 2);

-- 11. Удаление всех коробок со стоимостью меньше 150
DELETE FROM Boxes WHERE value < 150;

-- 12. Удаление всех коробок, расположенных в Нью-Йорке, с возвратом всех удаленных данных
DELETE FROM Boxes
WHERE warehouse = (SELECT code FROM Warehouses WHERE location = 'New York')
RETURNING *;
