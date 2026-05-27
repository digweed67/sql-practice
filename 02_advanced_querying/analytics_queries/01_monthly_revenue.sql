/* ============================================================
SCENARIO 1: Monthly Company Revenue

Business Question:
Show total revenue per month.

Requirements:
- Use DATE_TRUNC
- Aggregate correctly
- Order chronologically

Expected Output Columns:
month | total_revenue

Write your query below:
============================================================ */

SELECT 
	DATE_TRUNC('month', o.order_date) AS month,
	SUM(amount) AS monthly_revenue
FROM orders o 
GROUP BY 1 -- 1 refers to the 1st column in select
ORDER BY 1; -- directly defaults to ASC


