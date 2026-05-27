


/* Scenario 2:
 Goal: Label employees as “High Earner” if their latest salary ≥ 90,000, else “Normal”.
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
)

SELECT 
	employee_id,
	salary,
	CASE 
		WHEN salary >= 90000 THEN 'High Earner'
	ELSE 'Normal'
	END AS salary_label
FROM latest_salary; 

	