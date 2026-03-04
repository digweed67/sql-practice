/* ============================================================
SCENARIO 2: Month-over-Month Growth

Business Question:
How did total company revenue change month-over-month?

Requirements:
- Aggregate FIRST
- Then use LAG
- Calculate percentage growth

Expected Output:
month | total_revenue | prev_month | mom_growth_pct


Write your query below:
============================================================ */

-- calculate monthly sales 
WITH monthly_sales AS (
	SELECT 
		DATE_TRUNC('month', o.order_date) AS month,
		SUM(amount) AS total_revenue
	FROM orders o
	GROUP BY 1
	ORDER BY 1 
),
-- compare to previous month
prev_monthly_sales AS (
	SELECT 
		month,
		total_revenue,
		LAG(total_revenue) OVER(ORDER BY month) AS prev_month
	FROM monthly_sales ms
)

SELECT 
	MONTH,
	total_revenue,
	prev_month,
	ROUND(
	    ((total_revenue - prev_month) / NULLIF(prev_month, 0)) * 100,
	    2
	) AS growth_pct
FROM prev_monthly_sales 
ORDER BY month; 


