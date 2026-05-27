/*
 * Exercise 9 — Row vs Group
(Compare sale to group average)
For each sale:
•	show the amount
•	show the region’s average sale amount
•	show a column:
o	'Above Average'
o	'Below Average'
o	'Equal to Average'
Requirements:
•	use AVG() OVER
•	use CASE
•	no subqueries

*/

WITH avg_by_region AS (
	SELECT 
		sale_id,
		salesperson,
		region,
		amount,
		AVG(amount) OVER (PARTITION BY region) AS region_avg
	FROM sales 
)

SELECT 
		sale_id,
		salesperson,
		region,
		amount,
		region_avg,
	CASE 
		WHEN amount > region_avg THEN 'Above average'
		WHEN amount < region_avg THEN 'Below average'
		WHEN amount = region_avg THEN 'Equal to average'
	END AS comparison
FROM avg_by_region;