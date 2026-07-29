lets see how sql will process  view
-- view is created over sql query
--  view is just represent the data returned by  sql query
-- not store the data
-- but every time you call the view it just fetch the data from base table 
-- it is like a virtual table

Important Point

A view can provide some level of data security by:

Hiding sensitive columns  salary
Hiding unnecessary columns
Restricting rows using WHERE
Giving users access to the view instead of the base table

Always up-to-date because it fetches from base table

1. Create Database and Tables
CREATE DATABASE CompanyDB1;
USE CompanyDB1;

drop database CompanyDB1;
Department Table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    Location VARCHAR(50)
);
Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Salary DECIMAL(10,2),
    DepartmentID INT,
    Email VARCHAR(100)
    
);
2. Insert Sample Data
INSERT INTO Department
(DepartmentID, DepartmentName, Location)
VALUES
(101, 'IT', 'Delhi'),
(102, 'HR', 'Mumbai'),
(103, 'Finance', 'Bangalore'),
(104, 'Sales', 'Chennai');
INSERT INTO Employee
(EmployeeID, EmployeeName, Salary, DepartmentID, Email)
VALUES
(1, 'Amit', 75000, 101, 'amit@company.com'),
(2, 'Neha', 60000, 101, 'neha@company.com'),
(3, 'Rahul', 55000, 102, 'rahul@company.com'),
(4, 'Priya', 80000, 103, 'priya@company.com'),
(5, 'Rohit', 50000, 103, 'rohit@company.com'),
(6, 'Sneha', 65000, 104, 'sneha@company.com');

-- 3. Create a Simple View

-- Suppose we don't want users to directly access the entire Employee table
select * from employee;

CREATE VIEW EmployeeBasicInfo AS
SELECT
    EmployeeID,
    EmployeeName,
    DepartmentID
FROM Employee;

SELECT *
FROM EmployeeBasicInfo;  -- don't see Salary and Email



-- controlled data access.
CREATE USER 'himanshu'@'localhost'
IDENTIFIED BY '123456';


GRANT SELECT
ON CompanyDB1.EmployeeBasicInfo
TO 'himanshu'@'localhost';   -- Give access only to the view:

GRANT SELECT,insert,update,delete ON CompanyDB1.EmployeeBasicInfo
TO 'himanshu'@'localhost';

GRANT ALL PRIVILEGES ON CompanyDB1.*
TO 'himanshu'@'localhost'
WITH GRANT OPTION;


ALL PRIVILEGES on a table includes 
permissions such as SELECT, INSERT, UPDATE, DELETE,INDEX, ALTER

GRANT SELECT, INSERT, UPDATE, DELETE
ON my_database.it_view1
TO 'shubham_user'@'localhost'
WITH GRANT OPTION;  -- Shubham can give these permissions to other users


4. View with JOIN (This provides reusability.Instead of writing the JOIN every time):

A view can combine multiple tables.

CREATE VIEW EmployeeDepartmentView AS
SELECT
    e.EmployeeID,
    e.EmployeeName,
    e.Salary,
    d.DepartmentName,
    d.Location
FROM Employee e
JOIN Department d
    ON e.DepartmentID = d.DepartmentID;
    
    select * from EmployeeDepartmentView;
    
    -- one drawback
   CREATE VIEW ITEmployeesOnly AS 
   SELECT EmployeeID, EmployeeName, Salary, DepartmentID 
   FROM Employee 
   WHERE DepartmentID = 101;
   
   select * from ITEmployeesOnly;

-- You can potentially update: The underlying Employee table will be updated.
UPDATE ITEmployeesOnly
SET Salary = 85000
WHERE EmployeeID = 1;  -- (emp table updated)

select * from employee;
UPDATE ITEmployeesOnly
SET EmployeeName = 'Amit Sharma'
WHERE EmployeeID = 1;  --  -- (emp table updated)

UPDATE ITEmployeesOnly
SET DepartmentID = 102
WHERE EmployeeID = 1;  -- Change Department Through the View

select * from ITEmployeesOnly;

-- If you want to ensure that users cannot change an IT employee to another department through the view,
    
    5.Controlling Modification Using WITH CHECK OPTION
    WITH CHECK OPTION adds a rule:
-- Any INSERT or UPDATE performed through the view must continue to satisfy the view's WHERE condition.
    
    CREATE OR REPLACE VIEW ITEmployeesOnly AS
SELECT
    EmployeeID,
    EmployeeName,
    Salary,
    DepartmentID
FROM Employee
WHERE DepartmentID = 101
WITH CHECK OPTION;

UPDATE ITEmployeesOnly
SET DepartmentID = 102
WHERE EmployeeID = 2;   -- not allowed

select * from ITEmployeesOnly;

UPDATE ITEmployeesOnly
SET Salary = 85000
WHERE EmployeeID = 2;  -- allowed
