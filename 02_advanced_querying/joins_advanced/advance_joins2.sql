/*
EXERCISE 4 — Multi-Condition Join (Engineering High Reviews)

Goal:
Return all employees along with their performance reviews, but only include reviews where the score is 4 or higher.  

Requirements:
- Include all employees, even if they have no matching review
- Return:
    - employee full name
    - department name
    - review_date
    - performance_score
- Tables involved:
    - employees(employee_id, first_name, last_name, department_id)
    - departments(department_id, department_name)
    - performance_reviews(employee_id, review_date, performance_score)
*/


SELECT 
	e.first_name || ' ' || e.last_name AS full_name,
	d.department_name AS department_name, 
	pr.review_date AS review_date,
	pr.performance_score AS performance_score 
FROM employees e 
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN performance_reviews pr
ON e.employee_id = pr.employee_id 
AND pr.performance_score >= 4; 

-- LEFT JOIN ON+AND = filters both on and and, but the word left keeps the nulls 
-- left join on + where = where filters AFTER, even the nulls, converts left join in an inner join