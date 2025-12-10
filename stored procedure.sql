-- by using a stored procedure we can save our query or set of SQL statements  in the database and run when needed.
all the query that we have written in sp is Stored in the database and executed on the server.
it Can accept input/output parameter
WHY WE USE SP
To perform operations (like insert, update, delete, logic)
 A Stored Procedure is a precompiled collection of one or more SQL statements that are stored in the database and executed as a single unit.
WHY WE USE VIEW 
To simplify complex queries or provide a secure way to access data 
SO THAT NO THIRD USER OR UNAUTHORISED USER ASSESS MY DATA 


A stored procedure can have multiple SQL statements,
Without changing the delimiter, the SQL parser might think the procedure ends at the first
 semicolon it encounters, leading to syntax errors.
 Defining the boundary of the procedure
 

🔍 Key Points

Precompiled: SQL code gets compiled and optimized once, so repeated execution is faster.

Stored in Database:

Reusable: Can be called multiple times by apps or users.

Accept Parameters: You can pass values (IN, OUT, INOUT).

Security: Users can execute the procedure without having direct access to underlying tables.


You create a procedure

CREATE PROCEDURE GetEmp()
BEGIN
    SELECT * FROM employees;
END;


Database compiles it

Checks syntax

Resolves table names, column names

Creates an execution plan (best way to run the query)

Stores the compiled plan in memory / data dictionary

⚙️ Execution Later (What makes it faster?)

When you run:

CALL GetEmp();


The DB does NOT recompile the whole SQL.

It directly uses the pre-stored execution plan.

✔ No need to check syntax again


Difference Between Stored Procedure & Function
Feature /  Point             Stored Procedure	                                        Function
Return Type             	May or may not return a value	                          Must return a value (single)
Usage	               Used to perform operations (insert, update, delete, calculations)	Mainly used for calculations & returning values
Execution	                   Executed using CALL	                                           Called within SQL (SELECT/WHERE/HAVING)
Select Statement Usage         Cannot be directly used in a SELECT query	                    Can be called inside SELECT
Parameters	                   Can have IN, OUT, INOUT parameters	                       Only IN parameters
Transactions (Commit/Rollback)	     Allowed	                                                  Not allowed
DML Operations (Insert/Update/Delete)	 Allowed	                                      Generally not recommended / limited
Stored Location                           	Stored in database	                            Stored in database
Compilation	                           Compiled once and stored	                           Compiled once and store
Purpose	                                 Perform business logic                        	Perform calculations and return result
Return Keyword	                       RETURN optional                                   RETURN mandatory
















create database storeddemo;
use storeddemo;
drop database storeddemo;



CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    JobTitle VARCHAR(50),
    DepartmentID INT
);
INSERT INTO Employees (EmployeeID, FirstName, LastName, JobTitle, DepartmentID) VALUES
(1, 'John', 'Doe', 'Software Engineer', 5),
(2, 'Jane', 'Smith', 'Project Manager', 3),
(3, 'Emily', 'Johnson', 'QA Analyst', 5),
(4, 'Michael', 'Brown', 'Business Analyst', 2);
select * from employees;


-- SYNTEX
DELIMITER ??

CREATE PROCEDURE procedure_name(IN param1 datatype, IN param2 datatype)
BEGIN
    select * from table;
    update table 
    set col=''
    where col-'';
END ??

DELIMITER ;

A stored procedure can have multiple SQL statements,
Without changing the delimiter, the SQL parser might think the procedure ends at the first
 semicolon it encounters, leading to syntax errors.
 Defining the boundary for the sp


--q1-- Create a stored procedure to get employee details by EmployeeID.


select * from employees where employeeid=2;


-- sp
DROP PROCEDURE IF EXISTS GetEmployeeDetails;

DELIMITER $$

CREATE PROCEDURE GetEmployeeDetails (IN EmpID INT)
BEGIN
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        JobTitle,
        DepartmentID
    FROM Employees
    WHERE EmployeeID = EmpID;
END $$

DELIMITER ;


call GetEmployeeDetails(3);

DELIMITER $$
create procedure  p1 (in id int)     -- emp variable 
begin 
     select * from employees where employeeid=id;
end $$
DELIMITER ;



call p1 (1);
call p1 (5);

-- self practice 
call job_title('hr manager');



-- q2-Create a stored procedure to insert a new employee.
select * from employees;
insert into table values (empid,name,lname,title,deptid);
insert into employees values();

DELIMITER //
CREATE PROCEDURE InsertNewEmployee(
    IN emp_id INT,   -- 5
    IN first_name VARCHAR(50), -- alice
    IN last_name VARCHAR(50),
    IN job_title VARCHAR(50),
    IN dept_id INT
)
BEGIN
    INSERT INTO Employees (EmployeeID, firstName, LastName, JobTitle, DepartmentID)
    VALUES (emp_id, first_name, last_name, job_title, dept_id);
END //

DELIMITER ;

call insertnewemployee(8, 'Alice', 'Williams', 'HR Manager', 102);
select * from employees;

-- q3--Create a stored procedure to update the JobTitle of an employee based on EmployeeID.
update employees
set jobtitle=''
where employeeid= ''


DELIMITER //

CREATE PROCEDURE UpdateJobTitle(
    IN emp_id INT,
    IN new_job_title VARCHAR(50)
)
BEGIN
    UPDATE Employees
    SET JobTitle = new_job_title
    WHERE EmployeeID = emp_id;
END //

DELIMITER ;

CALL UpdateJobTitle(3, 'Senior QA Analyst');
select * from employees;


-- q4--Create a stored procedure to delete an employee by EmployeeID.
delete from employee where employeeid=''

-- q5-Create a stored procedure to get all employees belonging to a specific DepartmentID.
select * from employees where departmentid='101'



DELIMITER //

CREATE PROCEDURE DeleteEmployee(IN emp_id INT)
BEGIN
    DELETE FROM Employees
    WHERE EmployeeID = emp_id;
END //

DELIMITER ;
CALL DeleteEmployee(4);

-- q6-Create a stored procedure to count the number of employees in each department.
select count(*) as employeecount,departmentid from employees
group by departmentid;
select count(*) from employees groupby department

DELIMITER //

CREATE PROCEDURE CountEmployeesByDepartment()
BEGIN
    SELECT DepartmentID, COUNT(*) AS EmployeeCount
    FROM Employees
    GROUP BY DepartmentID;
END //

DELIMITER ;

CALL CountEmployeesByDepartment();

--- q7-- Stored procedure to get annual salary for all employees:

CREATE TABLE employees1 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    monthly_salary DECIMAL(10,2)
);
INSERT INTO employees1 VALUES
(1, 'Alice', 3000),
(2, 'Bob', 2500),
(3, 'Charlie', 4000);
--- q7-- Stored procedure to get annual salary for all employees:
select monthly_salary,monthly_salary*12 as yearly_salary from employees1;


DELIMITER //
CREATE PROCEDURE GetAnnualSalaries()
BEGIN
    SELECT id,name,monthly_salary,monthly_salary * 12 AS annual_salary
    FROM employees;
END //
DELIMITER ;
CALL GetAnnualSalaries();




-- q8--get the high salary employees >3000

select * from employees where salary>3000;

DELIMITER //

CREATE PROCEDURE GetHighSalaryEmployees()
BEGIN
    SELECT *
    FROM employees
    WHERE monthly_salary > 3000;
END //

DELIMITER ;
CALL get_high_salary_employee(3000);

-- q1--Select customers by City and PostalCode


DELIMITER //

CREATE PROCEDURE SelectCustomersByCityAndPostalCode (
    IN CityParam VARCHAR(50),
    IN PostalCodeParam VARCHAR(20)
)
BEGIN
    SELECT *
    FROM Customers
    WHERE City = CityParam
      AND PostalCode = PostalCodeParam;
END //

DELIMITER ;
CALL SelectCustomersByCityAndPostalCode('New York', '10001');


-- OUT EXAMPLE


 CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20)
);
INSERT INTO Customers (Name, City, PostalCode, Email, Phone) VALUES
('Alice Johnson', 'New York', '10001', 'alice@example.com', '555-1234'),
('Bob Smith', 'Los Angeles', '90001', 'bob@example.com', '555-5678'),
('Charlie Davis', 'New York', '10002', 'charlie@example.com', '555-8765'),
('Diana Ross', 'Chicago', '60601', 'diana@example.com', '555-4321');

select * from customers;
-- --Count Customers by City
select city,count(*) from customers
group by city 
having  city= 'chicago';

-- q2--Count Customers by City using stored procedure
DELIMITER //

CREATE PROCEDURE CountCustomersByCity1 (
    IN CityParam VARCHAR(50),
    OUT TotalCount INT
)
BEGIN
    SELECT COUNT(*) INTO TotalCount
    FROM Customers
    WHERE City = CityParam;
END //

DELIMITER ;
CALL CountCustomersByCity('chicago', @a);  -- @count Output variable (stores the result from the OUT parameter).
SELECT @a AS CustomerCount;


-- q3 Stored Procedure to Get Customer Name by CustomerID (OUT parameter)
DELIMITER $$

CREATE PROCEDURE GetCustomerNameByID (
    IN CustID INT,         -- input
    OUT CustName VARCHAR(100)   -- output
)
BEGIN
    SELECT Name INTO CustName
    FROM Customers
    WHERE CustomerID = CustID;
END $$

DELIMITER ;

CALL GetCustomerNameByID(2, @name);
SELECT @name AS CustomerName;

-- q2 OUT More Than One Value (Optional Example)

DELIMITER $$

CREATE PROCEDURE GetCustomerDetails (
    IN CustID INT,
    OUT CustName VARCHAR(100),
    OUT CustCity VARCHAR(50),
    OUT CustEmail VARCHAR(100)
)
BEGIN
    SELECT Name, City, Email
    INTO CustName, CustCity, CustEmail
    FROM Customers
    WHERE CustomerID = CustID;
END $$

DELIMITER ;

CALL GetCustomerDetails(3, @name, @city, @email);

SELECT @name, @city, @email;

-- q3 out 
DELIMITER //

CREATE PROCEDURE GetMaxSalary(OUT max_sal DECIMAL(10,2))
BEGIN
    SELECT MAX(salary) INTO max_sal
    FROM employees;
END //

DELIMITER ;

-- Call the procedure
CALL GetMaxSalary(@highest_salary); -- -- -- @count Output variable (stores the result from the OUT parameter).


-- See the result
SELECT @highest_salary AS MaxSalary;


-- INOUT EXAMPLE 

DELIMITER //

CREATE PROCEDURE DoubleValue1(INOUT num INT)
BEGIN
    SET num = num * 2;
END //

SET @myNumber = 10;   --      This line declares and initializes a session variable in MySQL.

-- Call the procedure
CALL DoubleValue(@myNumber);

-- Check the result
SELECT @myNumber AS Result;

-- FUNCTON 


-- SECOND EXAMPLE 
CREATE TABLE employees4 (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);
 
INSERT INTO employees4 VALUES
(1, 'Amit', 30000),
(2, 'Neha', 40000),
(3, 'Ravi', 50000);

SELECT * FROM EMPLOYEES4;

select salary,salary*12 as yearly from employees4;

DELIMITER $$
CREATE FUNCTION GetAnnualSalary(monthly_salary DECIMAL(10,2)) -- input variable
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END $$
DELIMITER ;
SELECT name,salary, GetAnnualSalary(salary) AS annual_salary FROM employees4 ;

-- DETERMINISTIC is a keyword used in MySQL for functions (not procedures) to indicate that for
--  the same input values, the function will always return the same output.



DROP PROCEDURE IF EXISTS addemployee;





