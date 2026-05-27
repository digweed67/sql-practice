/*
EXERCISE 1 — Manager Hierarchy (Warm-up)

Goal:
Return a list of all employees with:
- employee full name
- manager full name
- department name

Requirements:
- Include ALL employees
- Employees without a manager must still appear
- Manager name should be NULL when there is no manager

*/





SELECT 
    e.first_name || ' ' || e.last_name AS employee_name,
    m.first_name || ' ' || m.last_name AS manager_name,
    d.department_name AS department_name
FROM employees e
LEFT JOIN employees m 
    ON e.manager_id = m.employee_id
LEFT JOIN departments d
    ON d.department_id = e.department_id;
