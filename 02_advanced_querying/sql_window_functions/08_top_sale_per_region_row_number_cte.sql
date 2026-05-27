/* Exercise 8 — Top-N per group
For each region:
•	return the single highest sale amount
•	if there are ties, pick one deterministically (you choose how)
Requirements:
•	must use window function
•	must use a CTE
•	no GROUP BY
*/

WITH ordered_sales AS ( 
	SELECT 
		sale_id,
		salesperson,
		region,
		amount,
		ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC, sale_id) AS row_rank
	FROM sales
)

SELECT *
FROM ordered_sales
WHERE row_rank = 1; 
