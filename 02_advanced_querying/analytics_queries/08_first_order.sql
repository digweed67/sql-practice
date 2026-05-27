/* ============================================================
SCENARIO 8: First Order Per Customer

Business Question:
Return only each customer's first order.

Requirements:
- Use ROW_NUMBER()
- PARTITION BY customer_id
- ORDER BY order_date
- Filter row_number = 1

Expected Output:
customer_id | order_id | order_date | amount

Trap:
Using MIN(order_date) alone will lose other columns.

Write your query below:
============================================================ */

WITH orders_rows AS (
	SELECT 
		customer_id,
		order_id,
		order_date,
		amount,
		/* always add a tie breaker for deterministic results in order by
		 * because we could have 2 orders with the same order date for one 
		 * customer, in which cause SQL would look at the order_id
		 */
		ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date, order_id) AS row_num
	FROM orders 
)

SELECT *
FROM orders_rows
WHERE row_num = 1; 
	