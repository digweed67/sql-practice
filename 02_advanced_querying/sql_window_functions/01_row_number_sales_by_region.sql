/*
 * Exercise 1: For each region, assign a 
 * sequential number to sales ordered by sale_date.
*/

SELECT 
	sale_id,
	salesperson,
	region,
	sale_date,
	amount,
	ROW_NUMBER() OVER (PARTITION BY region ORDER BY sale_date) AS row_num
FROM sales; 
