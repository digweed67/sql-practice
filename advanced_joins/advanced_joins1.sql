/*
EXERCISE 3 — Latest Salary & Performance Review

Goal:
For each employee, return:
- employee full name
- department name
- latest salary (most recent effective_date)
- latest performance score (most recent review_date)

Requirements:
- Include all employees

*/

WITH latest_performance AS (
	SELECT 
		employee_id,
		review_date,
		performance_score
	FROM (SELECT 
		employee_id,
		review_date,
		performance_score,
		ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rn
		FROM performance_reviews
	) p
	WHERE rn = 1 
),

latest_salary AS ( 
	SELECT 
		employee_id, 
		salary, 
		effective_date
	FROM (SELECT 
		employee_id,
		salary,
		effective_date,
		ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY effective_date DESC) AS rn
		FROM salaries ) s 
	WHERE rn = 1
)

SELECT 
	e.first_name || ' ' || e.last_name AS full_name,
	d.department_name AS department_name,
	ls.salary AS salary,
	lp.performance_score AS performance_score
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id 
LEFT JOIN latest_salary ls
ON e.employee_id = ls.employee_id
LEFT JOIN latest_performance lp
ON e.employee_id = lp.employee_id; 

	
