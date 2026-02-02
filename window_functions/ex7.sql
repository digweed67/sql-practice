/*
 * Exercise 1 — 
For each region:
•	compute each salesperson’s total sales
•	rank salespeople within the region by that total (highest first)

 */


WITH total_sales AS (

	SELECT  
		salesperson,
		region,
		amount,
		SUM(amount) OVER (PARTITION BY salesperson, region) AS total_amount
	FROM sales
)

SELECT DISTINCT 
	salesperson,
	region,
	total_amount,
	DENSE_RANK() OVER (PARTITION BY region ORDER BY total_amount DESC) AS sales_rank
FROM total_sales
ORDER BY region, sales_rank; 


	
