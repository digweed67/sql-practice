/* Scenario 1: HR wants to identify departments where employees are currently overpaid relative to performance.
Definition of “Overpaid”
An employee is considered overpaid if:
•	Their latest salary
•	AND their average performance score
•	Meets both conditions:
o	Salary is above the department average salary
o	Performance score is below the company average performance
*/

WITH latest_salary AS (
    SELECT 
        employee_id, 
        salary,
        effective_date
    FROM (
        SELECT 
            employee_id, 
            salary,
            effective_date,
            ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY effective_date DESC) AS row_latest
        FROM salaries
    ) s
    WHERE row_latest = 1
),
employee_avg_performance AS (
    SELECT 
        employee_id, 
        AVG(performance_score) AS avg_employee_performance
    FROM performance_reviews
    GROUP BY employee_id
),
dept_avg_salary AS (
    SELECT 
        e.department_id,
        AVG(ls.salary) AS avg_salary
    FROM employees e
    JOIN latest_salary ls
        ON e.employee_id = ls.employee_id
    GROUP BY e.department_id
),
company_avg_performance AS(
SELECT 
	ROUND(AVG(performance_score), 2) AS avg_company_performance
FROM performance_reviews
)

SELECT
    d.department_name,
    e.first_name || ' ' || e.last_name AS employee_name,
    eap.avg_employee_performance,
    ls.salary AS latest_salary,
    das.avg_salary,
    cap.avg_company_performance
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN latest_salary ls ON e.employee_id = ls.employee_id
JOIN employee_avg_performance eap ON e.employee_id = eap.employee_id
JOIN dept_avg_salary das ON e.department_id = das.department_id
CROSS JOIN company_avg_performance cap
WHERE ls.salary > das.avg_salary
  AND eap.avg_employee_performance < cap.avg_company_performance;

