-- types of trigger 
AFTER INSERT
AFTER DELETE 
AFTER UPDATE
BEFORE INSERT
BEFORE DELETE
BEFORE UPDATE
 -- Any thing happening with my table we can monitor our table using trigger and execute our logic with 
 -- the help of trigger 
 -- any thing we insert,we delete ,we pdate  in our table we can stored into our log table ,for recovery purpose 

create database trige;
use trige;
drop database trige;
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select CURRENT_TIMESTAMP;
select * from employees;
--  insert ----

whenever a new employee is added to the employees table, 
you want to automatically insert a row into the employees_audit table


CREATE TABLE employees_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    
    employee_name VARCHAR(100),
    on_column varchar(200),
    action VARCHAR(50),
        action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from employees_audit;
drop table employees_audit;


DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employees_audit (employee_name, on_column,action)
    VALUES (NEW.name, 'welcome','A NEW ENPLOYEE HAS BEEN INSERTED');
END;
//

INSERT INTO employees (name, position) VALUES ('ritu', 'Developer');
INSERT INTO employees (name, position) VALUES ('renu', 'ai');

select * from employees;
select * from employees_audit;

-- AFTER UPDATE Trigger

-- whenever we update in  the employees table, 
you want to automatically insert a updated row into the employees_audit table


DELIMITER //

CREATE TRIGGER after_employee_update1
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employees_audit (employee_name,on_column, action)
    VALUES (new.position,old.position,'UPDATE');
    
END;
//

DELIMITER ;
select * from employees;

drop trigger after_employee_update1;

UPDATE employees
SET position = 'ai'
WHERE name = 'renu';

select * from employees;
select * from employees_audit;
INSERT INTO employees (name, position) VALUES ('jashan', 'ai');
delete



-- AFTER DELETE Trigger

-- whenever we delete a row from  the employees table, 
you want to automatically add a deleted  row into the employees_audit table

DELIMITER //

CREATE TRIGGER after_employee_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employees_audit (employee_name,on_column, action)
    VALUES (OLD.name,'sucessful', 'DELETE');
END;
//

DELETE FROM employees
WHERE name = 'ritu';


-- The term "before trigger" usually refers to a database trigger that is executed before a  
like INSERT, UPDATE, or DELETE.
-- Before insert  

-- usecase You have a users table. 
-- You want to ensure that email addresses are always stored in lowercase before they're inserted into the database.

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
DELIMITER //

CREATE TRIGGER before_insert_users1
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    SET NEW.name =  LOWER( NEW.name  );
END;
//

DELIMITER ;
INSERT INTO users (name, email)
VALUES ('AliCE', 'ALICE@Example.COM');

SELECT * FROM users;
insert into users values(2,'ReNU','REnuGOEl@gMAIL.COM');

-- before update 
-- You have a products table. You want to:
-- Prevent the price from being updated to a negative value.
-- If someone tries to set a negative price, it will automatically reset to 0

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);
DELIMITER //

CREATE TRIGGER before_update_products1
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SET NEW.price =0;
    END IF;
END;
//

DELIMITER ;
drop trigger before_update_products1;

INSERT INTO products (name, price)
VALUES ('mobile', 5000.00);

DELIMITER //

CREATE TRIGGER before_insert_prod
BEFORE INSERT ON PRODUCTS
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SET NEW.price =0;
    END IF;
END;
//

DELIMITER ;


select * from products;

UPDATE products
SET price = 500.00
WHERE id=2;

select * from products;
UPDATE products
SET price = -5500.00
WHERE name = 'Laptop';

select * from products;

-- before delete 

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE archived_users (
    id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    deleted_at DATETIME
);
select * from users;
DELIMITER //

CREATE TRIGGER before_delete_users
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    INSERT INTO archived_users (id, name, email, deleted_at)
    VALUES (OLD.id, OLD.name, OLD.email, NOW());
END;
//

DELIMITER ;

INSERT INTO users (name, email)
VALUES ('John Doe', 'john@example.com');

delete from users
where id=2;

select * from users;
SELECT * FROM archived_users;



-- INDEX 

 
 1.An index is a data structure  that helps MySQL 
 find rows quickly without scanning the entire table
 2.1. Faster Searches
SELECT *
FROM employees
WHERE emp_name = 'Rahul';

Index on emp_name speeds up the search.

2. Faster Sorting
SELECT *
FROM employees
ORDER BY salary;

An index on salary can reduce sorting work.

3. Faster Filtering
SELECT *
FROM employees
WHERE department_id = 10;

Index on department_id helps locate matching rows quickly.

4. Faster Joins
SELECT e.emp_name, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

Indexes on join columns improve join performance.

5. Faster GROUP BY
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

An index on department_id can help grouping operations.

drop database indexdemo;
create database indexdemo;
use indexdemo;
drop table users;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10,2)
);                        -- Data is physically stored in the order of emp_id.

INSERT INTO employees VALUES
(5, 'Amit', 50000),
(1, 'Rohit', 60000),
(8, 'Neha', 55000),
(3, 'Priya', 70000),
(2, 'Rahul', 65000);

SELECT * FROM employees;
-- the data is physically organized by the PRIMARY KEY (emp_id), which is the clustered index.
-- This makes searches on the primary key very efficient:
EXPLAIN SELECT * 
FROM employees
WHERE emp_id = 3;

-- check only "type"
-- const	    Single row found using PK/unique	🟢 Excellent
-- ref	         Index used to find multiple rows	🟢 Good
-- range	     Index range scan (e.g. BETWEEN or >)	🟡 Okay
-- ALL	         Full table scan	🔴 Bad (usually)

-- Add a Non-Clustered Index
CREATE INDEX idx_name
ON employees(emp_name);

EXPLAIN SELECT emp_name
FROM employees
WHERE emp_name = 'Priya';



CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
INSERT INTO users (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Lee', 'charlie@example.com'),
('Diana Prince', 'diana@example.com'),
('Evan Turner', 'evan@example.com'),
('Fiona Davis', 'fiona@example.com'),
('George Brown', 'george@example.com'),
('Hannah Wilson', 'hannah@example.com'),
('Ian Clark', 'ian@example.com'),
('Jenna White', 'jenna@example.com'),
('Kyle Adams', 'kyle@example.com'),
('Laura Scott', 'laura@example.com'),
('Mike Harris', 'mike@example.com'),
('Nina Brooks', 'nina@example.com'),
('Oscar Reed', 'oscar@example.com'),
('Paula Green', 'paula@example.com'),
('Quinn Hayes', 'quinn@example.com'),
('Rachel Wood', 'rachel@example.com'),
('Steve Young', 'steve@example.com'),
('Tina Hall', 'tina@example.com');
select * from users;

explain SELECT * FROM users WHERE email = 'paula@example.com';



 select * from users where name='Charlie Lee';
explain SELECT * FROM users WHERE email = 'paula@example.com';
 SELECT * FROM users WHERE email = 'paula@example.com';

-- check only "type"
-- const	    Single row found using PK/unique	🟢 Excellent
-- ref	         Index used to find multiple rows	🟢 Good
-- range	     Index range scan (e.g. BETWEEN or >)	🟡 Okay
-- ALL	         Full table scan	🔴 Bad (usually)

CREATE INDEX idx_email3 ON users(email);

-- sql sever just jump into the index insted of scanning full table

explain SELECT * FROM users WHERE email = 'paula@example.com';
CREATE INDEX idx_id ON users(name);

explain SELECT * FROM users WHERE name='Evan Turner';




-- way to drop index
DROP INDEX idx_email1 ON users;


-- other example multiple index

CREATE INDEX idx_email1 ON users(email);

CREATE INDEX idx_customer_date ON orders(customer_id, order_date);

-
-- WHERE customer_id = 101 
-- WHERE customer_id = 101 AND order_date = '2025-10-01'
-- WHERE order_date = '2025-10-01'


-- HOW TO CHOOSE THE RIGHT COLUMNS TO INDEX

-- the column frequently use  in WHERE filters   (WHERE status = 'active')
-- column used in JOIN conditions      (ON users.id = orders.user_id)
-- column used in ORDER BY or GROUP BY  (ORDER BY created_at DESC)
-- the column with many unique values   (email,username)

-- ❌ Don't use index.

-- Columns with less category (e.g., gender: M/F)
-- Functions on indexed columns
CREATE INDEX idx_name ON users(name);
(SELECT * FROM users WHERE UPPER(name) = 'JOHN');

-- LIKE with wildcard at the start
CREATE INDEX idx_name ON users(name);

-- ❌ Index is not used efficiently
SELECT * FROM users WHERE name LIKE '%john';
