/*
========================================
EXERCISE 6 — Limit Recursion Depth
========================================

GOAL:
Get employees under 'Alice' BUT only up to 2 levels deep.

REQUIREMENTS:
- Use recursive CTE
- Track level
- Prevent recursion beyond level 2
- Return employee_id, name, level

IMPORTANT:
- The depth filter must be placed correctly.
- Think carefully: should it be in the outer SELECT or inside the recursive member?

Bonus:
- What happens if you put the level filter only in the final SELECT?
it will still run and process all deeper employees even if we don't 
select them in the end, so we want to put it in the recursive member, so it stops
recursion at level 2
*/


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
	SELECT employee_id, name, manager_id, 0 AS level
	FROM employees
	WHERE name = 'Alice'
	
	UNION ALL
	
	-- recursive member 
	SELECT e.employee_id, e.name, e.manager_id, eh.level + 1
	FROM employees e
	JOIN employee_hierarchy eh 
	ON e.manager_id = eh.employee_id
	WHERE eh.level <= 2
)

SELECT * 
FROM employee_hierarchy
ORDER BY level, employee_id; 
