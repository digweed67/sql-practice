/*
 Scenario 2: Identify employees with “very low” salaries
Goal:
•	Mark employees whose latest salary is below 60,000 as 'Very Low'.
•	Everyone else is 'OK'.
•	Return employee_id, first_name, last_name, salary, salary_label.

 */

WITH latest_salary AS ( 
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
),
salary_label AS(
	SELECT 
		employee_id,
		CASE 
		WHEN salary < 60000 THEN 'Very low'
		ELSE 'OK'
		END AS salary_level
	FROM latest_salary
)

SELECT 
	e.employee_id, 
	e.first_name,
	e.last_name, 
	ls.salary,
	sl.salary_level
FROM employees e
JOIN latest_salary ls
ON e.employee_id = ls.employee_id
JOIN salary_label sl
ON e.employee_id = sl.employee_id;

	



