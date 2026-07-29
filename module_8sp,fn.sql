
-- sp
 It is mainly used to automate repetitive tasks,
 improve performance, and enforce business rules.
You create a procedure


Here are some real-life scenarios where stored procedures are commonly used:

1. Banking System (Money Transfer) ⭐ Most Common

Scenario: A customer transfers ₹10,000 from one account to another.

Instead of running multiple SQL queries from the application, a stored procedure
 performs all the steps together:

1.Check if the sender has sufficient balance.
2.Deduct the amount from the sender's account.
3.Add the amount to the receiver's account.
4.Insert a transaction record.
5.Commit the transaction if everything succeeds; otherwise, roll back.

Benefit: Ensures data consistency and prevents partial updates.

2. E-Commerce Website (Place Order)

Scenario: A customer places an order on an online shopping website.

A stored procedure can:

1.Verify product availability.
2.Create the order.
3.Reduce inventory.
4.Calculate the total bill and discount.
5.Generate an invoice.

Benefit: All operations happen together, reducing errors and improving performance.

3. Payroll System

Scenario: A company processes monthly salaries.

A stored procedure:

1.Calculates gross salary.
2.Deducts taxes and PF.
3.Adds bonuses.
4.Calculates net salary.
5.Updates employee salary records.

Benefit: Salary processing becomes automatic and consistent for every employee.

4. Data Warehouse (ETL Process)

Scenario: Every night, sales data is loaded into a reporting database.

A stored procedure:

Reads data from staging tables.
Cleans invalid records.
Removes duplicates.
Loads data into the warehouse.
Logs the number of records processed.

Benefit: ETL jobs can be automated and scheduled.

5. Student Management System

Scenario: Publish semester results.

A stored procedure:

Calculates total marks.
Computes percentage.
Assigns grades.
Updates the result table.

-- Benefit: Every student's result is calculated using the same logic.


delimeter
CREATE PROCEDURE GetEmp()
BEGIN
    SELECT * FROM employees;
    insert  ;
    update   ;
END;


call getemp();


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

select jobtitle from employees where departmentid=3; -- input
SELECT SLEEP(2);
update employees
set firstname='renu'
where  departmentid=3;
SELECT SLEEP(2);
select * from employees where departmentid=3


DELIMITER $$

CREATE PROCEDURE GetUpdateEmployee1()
BEGIN

    -- Step 1: Get Job Title
    SELECT JobTitle
    FROM Employees
    WHERE DepartmentID = 3;
	DO SLEEP(2);
    -- Step 2: Update First Name
    UPDATE Employees
    SET FirstName = 'Renu'
    WHERE DepartmentID = 3;
   DO SLEEP(2);
    -- Step 3: Display Updated Employee
    SELECT *
    FROM Employees
    WHERE DepartmentID = 3;

END $$

DELIMITER ;

CALL GetUpdateEmployee1();

DELIMITER $$

CREATE PROCEDURE GetUpdateEmployee(
    IN pDepartmentID INT,
    IN pFirstName VARCHAR(50)
)
BEGIN

    -- Step 1: Get Job Title
    SELECT JobTitle
    FROM Employees
    WHERE DepartmentID = pDepartmentID;

    -- Step 2: Update First Name
    UPDATE Employees
    SET FirstName = pFirstName
    WHERE DepartmentID = pDepartmentID;

    -- Step 3: Display Updated Employee
    SELECT *
    FROM Employees
    WHERE DepartmentID = pDepartmentID;

END $$

DELIMITER ;

CALL GetUpdateEmployee(3, 'Renu');


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

Without changing the delimiter, 
the SQL parser might think the procedure ends at the first
 semicolon it encounters, leading to syntax errors.
 Defining the boundary for the sp


q1-- Create a stored procedure
 to get employee details by EmployeeID.


select * from employees where employeeid=3;


-- sp
DROP PROCEDURE IF EXISTS GetEmployeeDetails;

DELIMITER $$

CREATE PROCEDURE GetEmployeeDetails (IN a INT)
BEGIN
    SELECT 
        *
    FROM Employees
    WHERE EmployeeID = a;
    
END $$

DELIMITER ;


call GetEmployeeDetails(2);



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
-- insert into table values (empid,name,lname,title,deptid);
insert into employees values(5,'renu','jindal','trainer',6);

delimiter $$
create procedure insertvalues (in a int ,
                                in b varchar(20),
                                in c varchar(20),
                                in d varchar(20),
                                in e int )
begin
insert into employees values (a,b,c,d,e) ;
end $$ 
delimiter ;   

call insertvalues(6,'ritu','jindal','trainer',6)                           

select * from employees;
DELIMITER //
CREATE PROCEDURE InsertNewEmployee(
    IN a INT,   -- 5
    IN b VARCHAR(50), -- alice
    IN last_name VARCHAR(50),
    IN job_title VARCHAR(50),
    IN dept_id INT
)
BEGIN
    INSERT INTO Employees (EmployeeID, firstName, LastName, JobTitle, DepartmentID)
    VALUES (a, b , last_name, job_title, dept_id);
END //

DELIMITER ;

call insertnewemployee(8, 'Alice', 'Williams', 'HR Manager', 102);
select * from employees;

-- q3--Create a stored procedure to update the 
JobTitle of an employee based on EmployeeID.
update employees
set jobtitle='manager'
where employeeid= 3


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

CALL UpdateJobTitle(4, 'Senior QA Analyst');
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

-- q1--Count Customers by City using stored procedure
DELIMITER //

CREATE PROCEDURE CountCustomersByCity3 (
    IN CityParam VARCHAR(50),
    OUT TotalCount INT
)
BEGIN
    SELECT COUNT(*) INTO TotalCount
    FROM Customers
    WHERE City = CityParam;
END //

DELIMITER ;

CALL CountCustomersByCity3('chicago',@x); 
 -- @count Output variable 
                                -- (stores the result from the OUT parameter).
SELECT @x AS CustomerCount;


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

SELECT  @email;



-- FUNCTON 

Stored Procedures and Functions are related because both store SQL code in the database for reuse, 
but they serve different purposes.

Think of it this way:

Stored Procedure = performs a task or process.
Function = calculates and returns a value.

 Example: Employee Salary
Stored Procedure

Process monthly payroll.

1. Calculate salary
2. Calculate bonus
3. Deduct tax
4. Update salary table
5. Generate payslip
CALL ProcessSalary(101);



It performs multiple operations.

Function

Calculate tax for one employee.

SELECT CalculateTax(50000);

Step 1: Create Employee Table
CREATE TABLE employees34 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    basic_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    tax DECIMAL(10,2),
    net_salary DECIMAL(10,2)
);
Step 2: Insert Sample Data
INSERT INTO employees34
VALUES
(101,'Amit',50000,NULL,NULL,NULL),
(102,'Neha',70000,NULL,NULL,NULL),
(103,'Ravi',30000,NULL,NULL,NULL);

select * from employees34;

annual salary = monthly salary × 12.

DELIMITER $$

CREATE FUNCTION GetAnnualSalary(
    pMonthlySalary DECIMAL(10,2)
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN pMonthlySalary * 12;
END $$

DELIMITER ;

SELECT
    EmployeeID,
    EmployeeName,
    GetAnnualSalary(Salary) AS AnnualSalary
FROM employees34;

-- Functions can be used in SELECT, WHERE, ORDER BY, etc.
-- Everyone uses the same calculation logic.
SELECT emp_name,emp_id,basic_salary, GetAnnualSalary3(basic_salary) AS 
annual_salary FROM employees34  where GetAnnualSalary3(basic_salary) >500000;




Step 3: Create Function (Calculate Tax)
DELIMITER //

CREATE FUNCTION CalculateTax(salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE tax DECIMAL(10,2);

    SET tax = salary * 0.10;

    RETURN tax;
END //

DELIMITER ;

Step 4: Create Stored Procedure

The stored procedure will:

-- 1.Read the employee's salary.
2.Calculate a 10% bonus.
3.Call the CalculateTax() function.
4.Calculate the net salary.
5.Update the employee record.
6.Display a payslip.



DELIMITER //

CREATE PROCEDURE ProcessSalary(IN p_emp_id INT)
BEGIN

    DECLARE v_salary DECIMAL(10,2);
    DECLARE v_bonus DECIMAL(10,2);
    DECLARE v_tax DECIMAL(10,2);
    DECLARE v_net_salary DECIMAL(10,2);

    -- Get Employee Salary
    SELECT basic_salary
    INTO v_salary
    FROM employees
    WHERE emp_id = p_emp_id;

    -- Calculate Bonus (10%)
     SET v_bonus = v_salary * 0.10;

    -- Call Function
    SET v_tax = CalculateTax(v_salary);

    -- Calculate Net Salary
    SET v_net_salary = v_salary + v_bonus - v_tax;

    -- Update Employee Table
    UPDATE employees
    SET
        bonus = v_bonus,
        tax = v_tax,
        net_salary = v_net_salary
    WHERE emp_id = p_emp_id;

    -- Generate Payslip
    SELECT
        emp_id,
        emp_name,
        basic_salary,
        bonus,
        tax,
        net_salary
    FROM employees
    WHERE emp_id = p_emp_id;

END //

DELIMITER ;


Step 5: Execute the Procedure


CALL ProcessSalary(101);






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

select name,salary,salary*12 as yearly from employees4
where salary*12 >500000;

SELECT name,salary ,getannualsalary()FROM employees4 ;
45000*12
50.34*12  -- a is input int 435.566778

DELIMITER $$
CREATE FUNCTION GetAnnualSalary3(a DECIMAL(10,2)) -- input variable
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN a* 12;
END $$
DELIMITER ;

SELECT  GetAnnualSalary3(salary) AS 
annual_salary FROM employees4 ;

-- DETERMINISTIC is a keyword used in MySQL
 for functions (not procedures) to indicate that for
--  the same input values, the function will 
always return the same output.




DROP PROCEDURE IF EXISTS addemployee;


