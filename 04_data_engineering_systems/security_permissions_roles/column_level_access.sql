/*
Scenario 2: Column-Level Access
- Create role analyst_role that can SELECT only emp_id and name from employees
- Create user dana and assign analyst_role
Tasks:
- Write SQL to restrict analyst_role to only see emp_id and name columns
- Describe a test query to show dana can only see allowed columns
- Explain why column-level security matters for privacy
*/
DROP TABLE IF EXISTS employees; 

-- Create table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name TEXT,
    salary INT,
    dept_id INT
);
-- create role 
CREATE ROLE analyst_role; 

-- restrict analyst role to only see emp id and name
GRANT SELECT (emp_id, name) ON employees TO analyst_role; 

-- create user 
CREATE USER dana WITH PASSWORD 'dana_pass' NOCREATEDB NOCREATEROLE;

-- assign analyst role
GRANT analyst_role TO dana; 

-- test query to see what dana can see


-- Connect as dana 
SET ROLE analyst_role;	

-- Allowed columns — works
SELECT emp_id, name FROM employees;

-- Disallowed columns — fails
SELECT salary FROM employees;
SELECT emp_id, name, salary FROM employees;  


