 lets see how sql will process  view
-- view is created over sql query
--  view is just represent the data returned by  sql query
-- not store the data
-- but every time you call the view it just fetch the data from base table 
-- it is like a virtual table

Always up-to-date because it fetches from base table
with check option 

-- syntax 
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;


How Base Table Changes Affect a View
✔️ 1. Data Changes → Immediately Visible in View
Base Table Change	Effect on View
INSERT	Reflected instantly
UPDATE	Reflected instantly
DELETE	Reflected instantly

❌ 2. Structural Changes → NOT Visible Automatically
Base Table Change	Effect on View
ADD column	Not visible in existing view
DROP column	View breaks or needs recreation
MODIFY column (datatype change)	View may break
RENAME column	View will break (invalid reference)

If you later add new column:
ALTER TABLE employees1 ADD COLUMN department VARCHAR(50);
The view will not automatically pick it because the original definition did not include it.
🛠 How to Update the View After Structural Changes?

Use:

CREATE OR REPLACE VIEW hr_employees1 AS
SELECT id, name, department FROM employees1;

CREATE TABLE employees2 (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);
INSERT INTO employees2 (emp_id, name, department, salary)
VALUES 
(101, 'Alice Johnson', 'HR', 60000.00),
(102, 'Bob Smith', 'IT', 75000.50),
(103, 'Charlie Lee', 'Finance', 68000.75);
INSERT INTO employees2(emp_id, name, department, salary)
VALUES 
(104, 'Diana Clark', 'Marketing', 72000.00),
(105, 'Ethan Wright', 'Sales', 67000.25),
(106, 'Fiona Adams', 'IT', 80000.00),
(107, 'George Patel', 'HR', 59000.75),
(108, 'Hannah Kim', 'Finance', 71000.50);

DROP VIEW view_employees_admin , view_employees_report;
CREATE VIEW emp_view AS
SELECT employee_id, name, department, salary
FROM employees;


Use the View
SELECT * FROM emp_view;

📍 Update View
ALTER VIEW emp_view AS
SELECT employee_id, name, salary 
FROM employees WHERE salary > 50000;

📍 Drop View
DROP VIEW emp_view;


Materialized Views in MySQL

🚫 MySQL does NOT support Materialized Views natively

However, you can simulate a materialized view using a table + refresh mechanism.

Create a Table to Store the Results

CREATE TABLE emp_mv AS
SELECT emp_id, name, department, salary
FROM employees3;

Query Materialized View Table

SELECT * FROM emp_mv;
select * from employees3;

insert into employees3 values(222,'anshika','hr',2000); -- base 

Manual Refresh
TRUNCATE TABLE emp_mv;

INSERT INTO emp_mv
SELECT employee_id, name, department, salary
FROM employees;


or simply:

REPLACE INTO emp_mv
SELECT emp_id, name, department, salary
FROM employees3;
SELECT * FROM emp_mv;
























SELECT CURRENT_USER();
SELECT User, Host FROM mysql.user;
DROP USER 'admin3_user'@'localhost';

CREATE USER 'report_user'@'localhost' IDENTIFIED BY 'renujindal@89';

CREATE USER: Command to add a new user to the MySQL server.
-- 'report_user'@'localhost': The username and host from which the user can connect.
user: 'report_user'The username.
host: The host or IP address the user is allowed to connect from.
-- '%' means any host (i.e. any IP).
-- 'localhost' means same machine where the MySQL server is running.
-- '192.168.1.100' means only from that specific IP.
IDENTIFIED BY 'renujindal@89': Sets the user's password to renujindal@89.

-- Admin gets access to full view
GRANT SELECT ON view_employees_admin TO 'admin_user'@'localhost';
-- not able to insert delete or update the values 
-- GRANT SELECT,insert,update ON view_employees_admin TO 'admin_user'@'localhost';

