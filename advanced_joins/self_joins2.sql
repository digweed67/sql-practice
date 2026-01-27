/*
EXERCISE 2 — Coworkers (Same Manager)

Goal:
Return a list of all employees along with their coworkers (people who share the same manager).

Requirements:
- Include all employees
- Employees without coworkers (including top-level managers) should still appear
- Do not include the employee themselves as their own coworker
- Return the following columns:
    - employee_name
    - coworker_name
    - manager_name

*/

SELECT 
	e1.first_name || ' ' || e1.last_name AS employee, 
	e2.first_name || ' ' || e2.last_name AS coworker,
	m.first_name || ' ' || m.last_name AS manager
FROM  employees e1
LEFT JOIN employees e2 
ON e1.manager_id = e2.manager_id 
AND e1.employee_id != e2.employee_id
LEFT JOIN employees m
ON e1.manager_id = m.employee_id;
/*
 * this employees manager is is the employee id in the managers 
 * */

