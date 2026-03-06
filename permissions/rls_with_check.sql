/*
Scenario 5: RLS on Inserts and Updates
- Add policy to restrict INSERT/UPDATE so user can only insert/update rows where dept_id matches session variable
- User frank tries to insert row with dept_id = 15, but session variable is set to 20
Tasks:
- Write SQL for INSERT/UPDATE policy with WITH CHECK
- Explain if frank’s insert will succeed or fail and why
- How does this protect data integrity?
*/

DROP TABLE IF EXISTS employees CASCADE;
DROP ROLE IF EXISTS read_insert;
DROP ROLE IF EXISTS frank;

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
-- true = return NULL if variable doesn’t exist yet
-- This allows PostgreSQL to parse the policy even if the variable hasn’t been set yet
CREATE POLICY dept_insert 
    ON employees
    FOR INSERT  
    WITH CHECK (dept_id = current_setting('myapp.current_dept')::INT);

-- Force RLS to apply even for table owner
ALTER TABLE employees ENABLE ROW LEVEL SECURITY;

-- Create role and user
CREATE ROLE read_insert;
CREATE USER frank WITH PASSWORD 'frank_pass';
GRANT SELECT, INSERT ON employees TO read_insert;
GRANT read_insert TO frank;

-- Insert test data
INSERT INTO employees VALUES
(1,'Alice',50000,10),
(2,'Bob',60000,20),
(3,'Carol',55000,10);

-- Test as Frank
SET myapp.current_dept = '20';

SET ROLE frank;
INSERT INTO employees VALUES 
(4,'Laura', 50000,15); -- fails
INSERT INTO employees VALUES 
(5,'Tom', 50000,20); -- succeeds
RESET ROLE;

SELECT * FROM employees; 
SELECT current_user, session_user;
