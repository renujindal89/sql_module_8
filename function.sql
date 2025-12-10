select * from employees4;
use module11;
select * from employees;
-- DETERMINISTIC  it specifies whether the function always returns the same result for the same input parameters.

DETERMINISTIC	Same inputs → same outputs always. No randomness, time, or external data.
NOT DETERMINISTIC	Output may vary even with same inputs. Depends on data/time/etc.

DELIMITER $$
CREATE FUNCTION GetAnnualSalary2(monthly_salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END $$
DELIMITER ;
SELECT GetAnnualSalary2(200);

SELECT GetAnnualSalary1(salary) FROM CUSTORS;
SELECT GETANNUALSALARY2(20);


select * from employees4 where GetAnnualSalary(salary)>400000;

SELECT getannualsalary(3000);  -- Returns 36000.00




-- other example 
DELIMITER //

CREATE FUNCTION get_bonus(score INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(5,2);
    
    IF score >= 90 THEN
        SET bonus = 0.10; -- 10%
    ELSEIF score >= 85 THEN
        SET bonus = 0.05; -- 5%
    ELSE
        SET bonus = 0.02; -- 2%
    END IF;

    RETURN bonus;
END;
//

DELIMITER ;

SELECT name, salary, get_bonus(performance_score) AS bonus_rate, salary * get_bonus(performance_score) AS bonus
FROM employees;

SELECT salary, get_bonus(PERFORMANCE_score) AS bonus_rate
FROM employees;



-- SCOPE 
SELECT queries	    SELECT name, get_bonus(score) FROM employees;
WHERE clauses	    SELECT * FROM employees WHERE get_bonus(score) > 0.05;
ORDER BY	       SELECT * FROM employees ORDER BY get_bonus(score) DESC;
INSERT / UPDATE	   UPDATE employees SET salary = salary + (salary * get_bonus(score));
Stored procedures / triggers	You can call functions inside them
					

select salary,salary*12 as yearly from empoyees4;



--IN  STORED PROCEDURE WE CAN USE THIS FUNCTION 
DELIMITER $$

CREATE PROCEDURE ShowAnnualSalaries1()
BEGIN
    SELECT 
        emp_id,
        name,
        salary AS monthly_salary,
        GetAnnualSalary(salary) AS annual_salary
    FROM employees4;
END $$

DELIMITER ;

CALL ShowAnnualSalaries1();

-- -- string function 
Function to Concatenate First and Last Name

DELIMITER $$

CREATE FUNCTION get_full_name(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS VARCHAR(101)
DETERMINISTIC
BEGIN
    RETURN CONCAT(first_name, ' ', last_name);
END$$
SELECT get_full_name('Jane', 'Smith');  -- Returns 'Jane Smith'
SELECT get_full_name('John', 'Doe');  