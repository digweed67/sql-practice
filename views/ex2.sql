/*
Create view v_current_salary showing each employee's latest salary (by effective_date).
*/

DROP VIEW IF EXISTS v_current_salary CASCADE;


CREATE VIEW v_current_salary AS
SELECT employee_id, salary, effective_date
FROM (
    SELECT employee_id, salary, effective_date,
           ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY effective_date DESC) AS rn
    FROM salaries
) s
WHERE rn = 1;
