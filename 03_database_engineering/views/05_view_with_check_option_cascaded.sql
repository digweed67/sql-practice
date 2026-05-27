/*
Exercise 5 — Cascaded WITH CHECK OPTION

Scenario:

1. HR can only manage employees in Engineering (department_id = 1).
2. Create two layered views:
   - View 1: v_engineering_employees
       * Selects all employees in Engineering
       * Uses LOCAL CHECK OPTION
   - View 2: v_hr_engineering
       * Built on top of v_engineering_employees
       * Filters only employees hired after 2021
       * Uses CASCADED CHECK OPTION

3. Test INSERTs through the views :

*/

-- First, drop views safe for re-runs 
DROP VIEW IF EXISTS  v_engineering_employees CASCADE;
DROP VIEW IF EXISTS v_hr_engineering CASCADE; 

-- Create view 1 

CREATE VIEW v_engineering_employees AS 
SELECT employee_id, first_name, last_name, department_id, hire_date 
FROM employees
WHERE department_id = 1
WITH CHECK OPTION; 

-- Create view 2

CREATE VIEW v_hr_engineering AS 
SELECT * 
FROM v_engineering_employees
WHERE hire_date > '2021-12-31'
WITH CASCADED CHECK OPTION; 


-- insert tests 
-- This should work bc the only check here is the dpt
INSERT INTO v_engineering_employees (first_name, last_name, department_id, hire_date)
VALUES ('Ana', 'Martín', 1, '2022-02-02');

-- this should fail because the dpt is wrong 
INSERT INTO v_engineering_employees (first_name, last_name, department_id, hire_date)
VALUES ('Ana', 'Vazquez', 2, '2022-02-02');

-- this should fail bc date is prior to 2021, but dept would pass the check
INSERT INTO v_hr_engineering (first_name, last_name, department_id, hire_date)
VALUES ('Ana', 'Martín', 1, '2020-02-02');

-- this works because date is after 2021 and dept is 1 
INSERT INTO v_hr_engineering (first_name, last_name, department_id, hire_date)
VALUES ('Ana', 'Martín', 1, '2023-02-02');


-- selects 
SELECT * FROM v_engineering_employees;
SELECT * FROM v_hr_engineering;


