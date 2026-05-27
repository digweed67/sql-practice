/*

Exercise 6
For each region, calculate a 2-sale moving average 
ordered by date.

*/ 

SELECT 
	sale_id,
	salesperson,
	region,
	amount,
	AVG(amount) OVER(PARTITION BY region ORDER BY sale_date 
	ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_avg_2
FROM sales;

