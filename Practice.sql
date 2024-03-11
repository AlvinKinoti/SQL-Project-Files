USE practice_databases;

-- Creating a new table
CREATE TABLE employee_summary AS
SELECT ï»¿Employee_Name AS employee_name, empid, Salary, PositionID,
CASE 
WHEN salary <= 55000 THEN "Junior Staff"
WHEN salary BETWEEN 55000 AND 80000 THEN "Mid-Level Staff" 
ELSE "Executive" 
END AS "Employee_Rank"
FROM practice_databases.hrdataset_v14;

-- Joining the two tables 
SELECT 
e.employee_name,
e.salary,
e.Employee_rank,
e.empid,
h.position,
h.department
FROM employee_summary e
LEFT JOIN hrdataset_v14 h
ON e.empid = h.empid;

-- Union
USE sakila;

SELECT 
city FROM city
WHERE city_id BETWEEN 100 AND 500
UNION ALL 
SELECT district FROM address
WHERE city_id BETWEEN 100 AND 500;

-- ALTERING DATA IN A TABLE
USE practice_databases;

ALTER TABLE hrdataset_v14
DROP COLUMN HispanicLatino;

ALTER TABLE hrdataset_v14
ADD PRIMARY KEY(positionid);

-- GRANTING $ REVOKING
GRANT SELECT, UPDATE
ON employee_summary
TO user1, user2;

REVOKE SELECT, UPDATE
ON employee_summary
TO user1, user2;

-- Inserting values in a table
INSERT INTO employee_summary (employee_name, empid, salary, positionID, employee_rank)
VALUES ("Mark Chester", 11000, 90000, 18, "Mid-Level Staff");


