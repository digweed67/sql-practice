/*
 * Exercise 10 — (Running metric + ranking)
For each salesperson:
•	show each sale
•	show their running total ordered by date
•	rank their sales by that running total (highest running total = rank 1)
Requirements:
•	must use a CTE
•	must use at least two window functions
•	no GROUP BY
*/

WITH running_total_sales AS (
	SELECT 
		sale_id,
		salesperson,
		region,
		amount,
		SUM(amount) OVER (PARTITION BY salesperson ORDER BY sale_date) AS running_sales
	FROM sales
)
	SELECT 
		sale_id,
		salesperson,
		region,
		amount,
		running_sales,
		ROW_NUMBER() OVER (PARTITION BY salesperson ORDER BY running_sales DESC, sale_id) AS ranked_sales
	FROM running_total_sales;