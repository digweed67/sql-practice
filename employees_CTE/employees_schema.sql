SET search_path TO public;

-- Drop tables if they already exist (for easy re-runs)
DROP TABLE IF EXISTS performance_reviews;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- ======================
-- Departments
-- ======================
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name TEXT NOT NULL
);

-- ======================
-- Employees
-- ======================
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

-- ======================
-- Salaries (historical)
-- ======================
CREATE TABLE salaries (
    salary_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    salary NUMERIC(10,2) NOT NULL,
    effective_date DATE NOT NULL,
    CONSTRAINT fk_employee_salary
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- ======================
-- Performance Reviews
-- ======================
CREATE TABLE performance_reviews (
    review_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    review_date DATE NOT NULL,
    performance_score INT CHECK (performance_score BETWEEN 1 AND 5),
    CONSTRAINT fk_employee_review
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- ======================
-- Seed Data
-- ======================

-- Departments
INSERT INTO departments (department_name) VALUES
('Engineering'),
('Sales'),
('HR');

-- Employees
INSERT INTO employees (first_name, last_name, department_id, hire_date) VALUES
('Alice', 'Smith', 1, '2020-03-15'),
('Bob', 'Johnson', 1, '2019-06-01'),
('Carol', 'White', 2, '2021-01-10'),
('David', 'Brown', 2, '2018-09-23'),
('Eve', 'Davis', 3, '2022-05-05');

-- Salaries (multiple records per employee)
INSERT INTO salaries (employee_id, salary, effective_date) VALUES
-- Alice
(1, 70000, '2020-03-15'),
(1, 85000, '2022-01-01'),

-- Bob
(2, 90000, '2019-06-01'),
(2, 95000, '2021-07-01'),

-- Carol
(3, 60000, '2021-01-10'),
(3, 65000, '2023-01-01'),

-- David
(4, 80000, '2018-09-23'),
(4, 88000, '2020-10-01'),

-- Eve
(5, 50000, '2022-05-05');

-- Performance Reviews
INSERT INTO performance_reviews (employee_id, review_date, performance_score) VALUES
-- Alice
(1, '2021-12-01', 4),
(1, '2022-12-01', 3),

-- Bob
(2, '2020-12-01', 2),
(2, '2021-12-01', 2),

-- Carol
(3, '2022-06-01', 5),
(3, '2023-06-01', 4),

-- David
(4, '2019-12-01', 3),
(4, '2020-12-01', 3),

-- Eve
(5, '2023-12-01', 5);


SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM performance_reviews;
