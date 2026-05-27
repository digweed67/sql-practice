
/*
========================================
EXERCISE 2 — Ancestors (Reverse Hierarchy)
========================================

GOAL:
Write a recursive CTE to get ALL managers above 'David'.

REQUIREMENTS:
- Start from David (anchor member)
- Move upward using manager_id
- Include level column (David = 0)
- Return employee_id, name, manager_id, level
- Order results from bottom to top

Think:
- How is the join direction different from Exercise 1?
In Exercise 1, the join finds all employees whose manager_id equals a current employee in the CTE — moving down the hierarchy.
In Exercise 2, the join finds the employee whose employee_id equals the current employee’s manager_id — moving up the hierarchy.

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
	SELECT employee_id, name, manager_id, 0 AS level
	FROM employees
	WHERE name = 'David'
	
	UNION ALL
	
	-- recursive member 
	SELECT e.employee_id, e.name, e.manager_id, eh.level + 1
	FROM employees e
	JOIN employee_hierarchy eh 
	ON e.employee_id = eh.manager_id
)

SELECT * 
FROM employee_hierarchy
ORDER BY level, employee_id; 