/* 
 *Exercise 4
For each region, show each sale and the region’s total sales.
*/ 

SELECT 
	sale_id,
	salesperson,
	region,
	amount,
	SUM(amount) OVER (PARTITION BY region) region_total_sales
FROM sales;