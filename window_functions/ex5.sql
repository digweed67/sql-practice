/*
 * Exercise 5
For each salesperson, calculate a running total 
ordered by date.

*/


SELECT 
	sale_id,
	salesperson,
	region,
	amount,
	SUM(amount) OVER (PARTITION BY salesperson ORDER BY sale_date) AS running_total
FROM sales;