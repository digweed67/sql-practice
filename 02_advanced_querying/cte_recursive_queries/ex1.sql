/*
========================================
EXERCISE 1 — Descendants (Basic Org Chart)
========================================

GOAL:
Write a recursive CTE to get ALL employees under 'Alice'.

REQUIREMENTS:
- Start from Alice (anchor member)
- Include a level column (Alice = 0)
- Return employee_id, name, manager_id, level
- Order results so hierarchy is readable
- Do NOT hardcode employee_id — use name = 'Alice'

Think:
- What is the anchor?
- What is the recursive join condition?
- Where do you increment level?
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
)

SELECT * 
FROM employee_hierarchy
ORDER BY level, employee_id; 



