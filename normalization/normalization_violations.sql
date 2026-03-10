/*
Scenario 1: Identify Normalization Violations
You have a table Employees:
(emp_id, name, salary, dept_id, dept_name, projects)
where projects is a comma-separated list of project names (e.g., "Alpha, Beta, Gamma").
Tasks:

- Restructure the data into normalized tables
*/


CREATE TABLE IF NOT EXISTS departments (
	dept_id SERIAL PRIMARY KEY,
	dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS employees (
	emp_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	salary INT,
	dept_id INT,
	FOREIGN KEY dept_id REFERENCES departments(dept_id)
);


CREATE TABLE IF NOT EXISTS projects (
	p_id SERIAL PRIMARY KEY,
	project_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS employee_projects (
	project_id INT REFERENCES projects(p_id), 
	emp_id INT REFERENCES employees(emp_id), 
	PRIMARY KEY (project_id, emp_id)
);


