/*
Finance wants to identify employees whose latest salary is below their department’s average salary, despite having strong performance.

Definitions
Use the latest salary per employee
“Strong performance” = employee’s average performance score is above the company average
Compare salary within the employee’s department

Expected Output (conceptually)

Department name
Employee name
Latest salary
Department average salary
Employee average performance
Company average performance
*/


WITH latest_salary AS (
    SELECT 
        employee_id, 
        salary
    FROM (
        SELECT 
            employee_id, 
            salary,
            ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY effective_date DESC) AS row_latest
        FROM salaries
    ) s
    WHERE row_latest = 1
),
dept_avg_salary AS (
	SELECT 
		d.department_id,
		AVG(l.salary) AS latest_avg_salary
	FROM 
		departments d
	JOIN employees e
	ON d.department_id = e.department_id
	JOIN latest_salary l
	ON	e.employee_id = l.employee_id
	GROUP BY  d.department_id
),
company_avg_performance AS(
SELECT 
	ROUND(AVG(performance_score), 2) AS avg_company_performance
FROM performance_reviews
),
employee_avg_performance AS (
    SELECT 
        employee_id, 
        AVG(performance_score) AS avg_employee_performance
    FROM performance_reviews
    GROUP BY employee_id
)

SELECT 
	d.department_name,
	e.first_name || ' ' || e.last_name AS employee_name,
	l.salary,
	das.latest_avg_salary,
	eap.avg_employee_performance,
	cap.avg_company_performance
FROM employees e
JOIN departments d 
ON d.department_id = e.department_id
JOIN latest_salary l
ON	e.employee_id = l.employee_id
JOIN dept_avg_salary das
ON d.department_id = das.department_id 
JOIN employee_avg_performance eap
ON e.employee_id = eap.employee_id 
CROSS JOIN company_avg_performance cap 

WHERE l.salary < das.latest_avg_salary 
AND eap.avg_employee_performance > cap.avg_company_performance;


