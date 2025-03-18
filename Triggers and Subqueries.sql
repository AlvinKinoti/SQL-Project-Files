-- Triggers and Subqueries

-- 1. Creating a database
CREATE DATABASE IF NOT EXISTS parks_and_recreations;
USE parks_and_recreations;

-- Create the Employee salary table
CREATE TABLE employee_salary (
employee_id INT PRIMARY KEY auto_increment,
first_name VARCHAR (50),
last_name VARCHAR (50),
occupation VARCHAR(50),
salary DECIMAL (10, 2),
dept_id INT NULL);

-- Create the employee demographics table 
CREATE TABLE employee_demographics(
employee_id INT PRIMARY KEY auto_increment,
first_name VARCHAR (50),
last_name VARCHAR (50)
);

-- Insert some sample data in the employee salary to create the trigger
INSERT INTO employee_salary(employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES 
(1, "Leslie", "Knope", "Deputy Director", 80000, 1),
(2, "Ron", "Samson", "Director", 120000, 2),
(3, "Tom", "Haverford", "Enterpreneur", 75000, NULL);

-- 	Inserting some sample data in the employee demographics to create the trigger
INSERT INTO employee_demographics( employee_id, first_name, last_name)
VALUES
(1, "Leslie", "Knope"),
(2, "Ron", "Samson");

-- Creating the  Eemployee insert trigger based on the salary column
DELIMETER $$

CREATE TRIGGER employee_insert 
    AFTER INSERT ON employee_salary -- (table name)
    FOR EACH ROW
    
BEGIN
    -- Insert the new employer's details into employee demographics 
    INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$

DELIMETER ;





