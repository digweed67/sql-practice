/*
Scenario 1:
We want to classify employees into salary levels based on their latest salary:
1.	Low: salary < 70,000
2.	Medium: 70,000 ≤ salary < 90,000
3.	High: salary ≥ 90,000
Task:
•	Use the employees table joined with the latest salary per employee.
•	Create a new column called salary_level that shows Low, Medium, or High depending on the employee’s salary.
•	Count how many employees are in each salary level.
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
salary_level AS(
	SELECT 
		employee_id,
		CASE 
		WHEN ls.salary < 70000 THEN 'Low'
		WHEN ls.salary >= 70000 AND ls.salary < 90000  THEN 'Medium'
		WHEN ls.salary >= 90000 THEN 'High'
		END AS salary_level
	FROM latest_salary ls
)

SELECT 
	salary_level,
	COUNT(employee_id) AS employee_count
FROM salary_level
GROUP BY salary_level 
ORDER BY employee_count DESC; 




