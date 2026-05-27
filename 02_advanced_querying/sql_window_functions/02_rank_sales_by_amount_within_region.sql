/*
 * Within each region, rank 
 * each individual sale from 
 * highest to lowest amount.
 */


SELECT 
	salesperson,
	region,
	amount,
	RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS sales_rank
FROM sales; 