CREATE DATABASE Lab10;

CREATE TABLE Books (
                       book_id INT PRIMARY KEY,
                       title VARCHAR(255),
                       author VARCHAR(255),
                       price DECIMAL(10, 2),
                       quantity INT
);

CREATE TABLE Customers (
                           customer_id INT PRIMARY KEY,
                           name VARCHAR(255),
                           email VARCHAR(255)
);

CREATE TABLE Orders (
                        order_id INT PRIMARY KEY,
                        book_id INT,
                        customer_id INT,
                        order_date DATE,
                        quantity INT,
                        FOREIGN KEY (book_id) REFERENCES Books(book_id),
                        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


INSERT INTO Books (book_id, title, author, price, quantity)
VALUES
    (1, 'Database 101', 'A. Smith', 40.00, 10),
    (2, 'Learn SQL', 'B. Johnson', 35.00, 15),
    (3, 'Advanced DB', 'C. Lee', 50.00, 5);

INSERT INTO Customers (customer_id, name, email)
VALUES
    (101, 'John Doe', 'johndoe@example.com'),
    (102, 'Jane Doe', 'janedoe@example.com');


-- 1
BEGIN;

INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, CURRENT_DATE, 2);

UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;

-- 2
BEGIN;

DO $$
BEGIN
    IF (SELECT quantity FROM Books WHERE book_id = 3) < 10 THEN
        RAISE EXCEPTION 'Not enough stock';
ELSE
        INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
        VALUES (2, 3, 102, CURRENT_DATE, 10);

UPDATE Books
SET quantity = quantity - 10
WHERE book_id = 3;
END IF;
END $$;

ROLLBACK;

-- 3

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN;

UPDATE Books
SET price = price + 5
WHERE book_id = 2;

-- Не завершайте транзакцию сразу
-- COMMIT;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN;

-- До коммита первой сессии
SELECT price FROM Books WHERE book_id = 2;

-- После коммита
-- SELECT price FROM Books WHERE book_id = 2;

COMMIT;

-- 4

BEGIN;

UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;

COMMIT;

-- После перезапуска сервера:
SELECT * FROM Customers WHERE customer_id = 101;