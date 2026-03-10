/*
Scenario 4: Transitive Dependency and 3NF
Given this table Employees:
(emp_id, emp_name, dept_id, dept_name, dept_location)
Tasks:

- Identify any transitive dependencies.
Department name and location depend on the department ID, 
not directly on the employee ID or employee name. 
Each employee’s ID uniquely identifies the employee, 
but the department information depends on the department ID, 
creating a transitive dependency.

- Explain why transitive dependencies violate 3NF.
These are transitive dependencies because the department attributes depend on dept_id 
rather than directly on the primary key emp_id, which violates 3NF.

- Propose how to redesign this table to meet 3NF.
- Describe the benefits of your redesign regarding update anomalies.
With the redesign, department information is stored in a separate 
table. If the department name or location changes, you only need 
to update it in one place, reducing the risk of update anomalies.
*/

CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name TEXT,
    dept_location TEXT
);

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name TEXT,
    dept_id INT REFERENCES departments(dept_id)
);

