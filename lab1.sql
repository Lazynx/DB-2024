-- 1. Create database called «lab1»
CREATE DATABASE lab1;

\c lab1;


DROP TABLE IF EXISTS users;

-- 2. Create table «users» with following fields
-- • id (autoincrementing integer)
-- • firstname (string max length 50)
-- • lastname (string max length 50)
CREATE TABLE users (
       id SERIAL,
       firstname VARCHAR(50),
       lastname VARCHAR(50)
);

-- 3. Add integer column (0 or 1) «isadmin» to «users» table
ALTER TABLE users ADD COLUMN isadmin INTEGER;

-- 4. Change type of «isadmin» column to boolean
ALTER TABLE users ALTER COLUMN isadmin TYPE BOOLEAN USING isadmin::BOOLEAN;

-- 5. Set default value as false to «isadmin» column
ALTER TABLE users ALTER COLUMN isadmin SET DEFAULT FALSE;

-- 6. Add primary key constraint to id column
ALTER TABLE users ADD CONSTRAINT users_pk PRIMARY KEY (id);

-- 7. Create table «tasks» with following fields
-- • id (autoincrementing integer)
-- • name (string max length 50)
-- • user_id (integer)
CREATE TABLE tasks (
       id SERIAL,
       name VARCHAR(50),
       user_id INTEGER,
       PRIMARY KEY (id)
);

-- 8. Delete «tasks» table
DROP TABLE tasks;

\c postgres;

-- 9. Delete «lab1» database
DROP DATABASE lab1;