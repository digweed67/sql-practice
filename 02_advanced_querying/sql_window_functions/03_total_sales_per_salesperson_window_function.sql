/*
 * Exercise 3
Calculate total sales within each region per salesperson.

*/

SELECT 
	salesperson,
	region,
	SUM(amount) OVER (PARTITION BY salesperson) total_sales
FROM sales;