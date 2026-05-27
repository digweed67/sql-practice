/*
Scenario 6: Bonus Eligibility Flag

We want to flag employees who are eligible for a bonus based on two criteria:

1. Salary: must be less than 90,000 (latest salary)
2. Performance: must have a latest performance score of 4 or higher

Task:
- Use the latest salary per employee.
- Use the latest performance review per employee.
- Create a column called bonus_eligibility using CASE WHEN:
    - 'Eligible' if salary < 90000 AND performance_score >= 4
    - 'Not Eligible' otherwise
- Display employee_id, first_name, last_name, latest salary, latest performance score, and bonus_eligibility.
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
),
eligibility_label AS (
	SELECT 
		ls.employee_id,
		CASE 
			WHEN ls.salary < 90000 AND lp.performance_score >= 4 THEN 'Eligible'
			ELSE 'Not Eligible'
		END AS bonus_eligibility
	FROM latest_salary ls 
	JOIN latest_performance lp
	ON ls.employee_id = lp.employee_id
)

SELECT 
	e.employee_id, 
	e.first_name,
	e.last_name,
	ls.salary,
	lp.performance_score,
	el.bonus_eligibility
FROM employees e
JOIN latest_salary ls
ON e.employee_id = ls.employee_id
JOIN latest_performance lp
ON ls.employee_id = lp.employee_id
JOIN eligibility_label el
ON lp.employee_id = el.employee_id
WHERE el.bonus_eligibility = 'Eligible';


