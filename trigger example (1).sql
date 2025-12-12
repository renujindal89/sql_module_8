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

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from employees;
--  insert ----

whenever a new employee is added to the employees table, 
you want to automatically insert a row into the employees_audit table


CREATE TABLE employees_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100),
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
    INSERT INTO employees_audit (employee_name, action)
    VALUES (NEW.name, 'A NEW ENPLOYEE HAS BEEN INSERTED');
END;
//

INSERT INTO employees (name, position) VALUES ('ritu', 'Developer');

select * from employees;
select * from employees_audit;

-- AFTER UPDATE Trigger

-- whenever we update in  the employees table, 
you want to automatically insert a updated row into the employees_audit table


DELIMITER //

CREATE TRIGGER after_employee_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employees_audit (employee_name, action)
    VALUES (NEW.name, 'UPDATE');
END;
//

DELIMITER ;

UPDATE employees
SET position = 'HR'
WHERE name = 'Alice';

select * from employees;
select * from employees_audit;



-- AFTER DELETE Trigger

-- whenever we delete a row from  the employees table, 
you want to automatically add a deleted  row into the employees_audit table

DELIMITER //

CREATE TRIGGER after_employee_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employees_audit (employee_name, action)
    VALUES (OLD.name, 'DELETE');
END;
//

DELETE FROM employees
WHERE name = 'renu';


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
    SET NEW.email = upper(NEW.email);
END;
//

DELIMITER ;
INSERT INTO users (name, email)
VALUES ('Alice', 'ALICE@Example.COM');

SELECT * FROM users;

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

CREATE TRIGGER before_update_products
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SET NEW.price =0;
    END IF;
END;
//

DELIMITER ;

INSERT INTO products (name, price)
VALUES ('Laptop', 1000.00);

select * from products;
UPDATE products
SET price = 500.00
WHERE name = 'Laptop';

select * from products;
UPDATE products
SET price = -500.00
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



select * from users;
SELECT * FROM archived_users;