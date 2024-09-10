CREATE DATABASE lab1;

\c lab1;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
       id SERIAL,
       firstname VARCHAR(50),
       lastname VARCHAR(50),
       PRIMARY KEY (id)
);

ALTER TABLE users ADD COLUMN isadmin INTEGER;

ALTER TABLE users ALTER COLUMN isadmin TYPE BOOLEAN USING isadmin::BOOLEAN;

ALTER TABLE users ALTER COLUMN isadmin SET DEFAULT FALSE;

CREATE TABLE tasks (
       id SERIAL,
       name VARCHAR(50),
       user_id INTEGER,
       PRIMARY KEY (id)
);

DROP TABLE tasks;

\c postgres;

DROP DATABASE lab1;