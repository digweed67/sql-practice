/*
Scenario 3: Basic RLS with Static Department Filter
- Enable RLS on employees
- Create policy allowing users to only see rows with dept_id = 10
- Create user emily with role that has SELECT on employees
Tasks:
- Write SQL to enable RLS and create the policy
- Explain what happens when emily queries employees
- Why is RLS safer than WHERE dept_id = 10 filtering in app queries?
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
    USING (dept_id = 10);

-- Force RLS to apply even for table owner
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

-- Test as Emily
SET ROLE emily;
SELECT * FROM employees;
RESET ROLE;

SELECT current_user, session_user;

