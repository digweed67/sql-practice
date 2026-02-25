/*
========================================
EXERCISE 4 — Path-Based Tree Ordering
========================================

GOAL:
Create a recursive CTE that:
- Tracks hierarchy using an ARRAY path column
- Orders results correctly using the path
- Produces properly structured tree output

REQUIREMENTS:
- Anchor starts from 'Alice'
- Add ARRAY as path in anchor
- Append employee_id in recursive member 
- Order final result by path
- Include level column as well


*/

-- Use the employees table from Exercise 1

DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    manager_id INT REFERENCES employees(employee_id)
);

INSERT INTO employees VALUES
(1, 'Alice', NULL),
(2, 'Bob', 1),
(3, 'Charlie', 1),
(4, 'David', 2),
(5, 'Eva', 2),
(6, 'Frank', 3);



WITH RECURSIVE employee_hierarchy AS (
	-- anchor member: this selects Alice 
	SELECT 
		employee_id, 
		name,
		manager_id, 
		0 AS LEVEL,
		ARRAY[employee_id] AS path
	FROM employees
	WHERE name = 'Alice'
	
	UNION ALL
	
	-- recursive member 
	SELECT 
		e.employee_id, 
		e.name, 
		e.manager_id, 
		eh.level + 1,
		eh.path || e.employee_id
	FROM employees e
	JOIN employee_hierarchy eh 
	ON e.manager_id = eh.employee_id
	WHERE NOT e.employee_id = ANY(path) -- prevent cycles
)
-- we use repeat for readability 
SELECT 
	employee_id,
	repeat('  ', LEVEL) || name AS indented_name,
	manager_id, 
	level 
FROM employee_hierarchy
ORDER BY path; 