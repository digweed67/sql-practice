/*
 Leadership wants to identify departments that have a performance consistency problem.
 
Definition
A department is considered inconsistent if:
1.	It has at least 2 employees
2.	At least one employee in the department has an average performance score ≥ 4
3.	At least one different employee in the same department has an average performance score ≤ 2
(So: high performer and low performer co-exist in the same department.)

*/

WITH employee_count AS (
    SELECT
        department_id,
        COUNT(employee_id) AS emp_count
    FROM employees
    GROUP BY department_id
    HAVING COUNT(employee_id) >= 2
),
employee_avg_performance AS (
    -- CTE 2: Average performance per employee
    SELECT
        employee_id,
        AVG(performance_score) AS avg_perf
    FROM performance_reviews
    GROUP BY employee_id
),
dept_perf_summary AS (
    SELECT
        e.department_id,
        COUNT(CASE WHEN eap.avg_perf >= 4 THEN 1 END) AS high_perf_count,
        COUNT(CASE WHEN eap.avg_perf <= 2 THEN 1 END) AS low_perf_count
    FROM employees e
    JOIN employee_avg_performance eap
        ON e.employee_id = eap.employee_id
    GROUP BY e.department_id
)
SELECT
    d.department_name,
    dps.high_perf_count,
    dps.low_perf_count,
    ec.emp_count
FROM dept_perf_summary dps
JOIN employee_count ec
    ON dps.department_id = ec.department_id
JOIN departments d
    ON d.department_id = dps.department_id
WHERE dps.high_perf_count >= 1
  AND dps.low_perf_count >= 1;
