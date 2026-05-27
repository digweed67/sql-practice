/*
Create view v_latest_performance_and_salary showing each employee’s latest performance review and latest salary in one row.
Include employee_id, latest review_date, performance_score, current salary, and salary effective_date.
Use window functions to get the latest rows from both tables.
*/

DROP VIEW IF EXISTS v_latest_performance_and_salary CASCADE;



CREATE VIEW v_latest_performance_and_salary AS
SELECT 
	lp.employee_id,
	lp.review_date,
	lp.performance_score, 
	cs.salary,
	cs.effective_date
FROM v_latest_performance lp
LEFT JOIN v_current_salary cs
ON lp.employee_id = cs.employee_id; 
