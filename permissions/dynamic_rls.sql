/*
Scenario 4: Dynamic RLS Based on Session Variable
- Modify RLS policy to use session variable myapp.current_dept to filter rows dynamically
- Simulate users with dept 10 and dept 20 by setting session variable accordingly
Tasks:
- Write SQL to create dynamic RLS policy using current_setting()
- Explain flexibility benefits over static filtering
- What happens if user forgets to set session variable?
*/


-- Clean everything
DROP TABLE IF EXISTS employees CASCADE;
DROP ROLE IF EXISTS read_only;
DROP ROLE IF EXISTS emily;

-- Create table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name TEXT,
    salary INT,
    dept_id INT
);

-- Enable RLS
ALTER TABLE employees ENABLE ROW LEVEL SECURITY;

-- Create policy
CREATE POLICY hr_policy
    ON employees
    FOR SELECT
    USING (dept_id = current_setting('myapp.current_dept')::INT);

-- RLS 
ALTER TABLE employees ENABLE ROW LEVEL SECURITY;

-- Create role and user
CREATE ROLE read_only;
CREATE USER emily WITH PASSWORD 'emily_pass';
GRANT SELECT ON employees TO read_only;
GRANT read_only TO emily;

-- Insert test data
INSERT INTO employees VALUES
(1,'Alice',50000,10),
(2,'Bob',60000,20),
(3,'Carol',55000,10);

-- Simulate Emily being in department 10
SET myapp.current_dept = '10';

-- Test what Emily sees - only shows people in dept = 10
SET ROLE emily;
SELECT * FROM employees;
RESET ROLE;

-- Simulate Emily being in department 20 - ONLY SHOWS people in dept=20
SET myapp.current_dept = '20';

-- Test what Emily sees
SET ROLE emily;
SELECT * FROM employees;
RESET ROLE;