
/*
Scenario 4: COUNT employees by salary levels (simpler case)

We want to identify employees whose latest salary falls into two categories:
1. Very low: salary < 60,000
2. OK: salary >= 60,000

Task:
- Use the latest salary per employee (by effective_date).
- Create a column called salary_level using CASE WHEN.
- Count how many employees are in each salary level.
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
	sl.salary_level,
	COUNT(sl.employee_id) AS employee_count
FROM salary_label sl
JOIN latest_salary ls
ON sl.employee_id = ls.employee_id
GROUP BY sl.salary_level
ORDER BY employee_count DESC; 