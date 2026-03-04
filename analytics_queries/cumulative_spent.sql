/* ============================================================
SCENARIO 3: Customer Lifetime Value (Running Total)

Business Question:
For each customer, show cumulative amount spent over time.

Requirements:
- Use window function


Expected Output:
customer_id | order_date | amount | cumulative_spent

============================================================ */ 

SELECT 
	customer_id,
	order_date,
	amount, 
	SUM(AMOUNT) OVER(
		PARTITION BY customer_id 
		ORDER BY order_date 
		-- although order by already starts from beginning
		-- of the partition until current row by default
		-- we make it explicit and production ready by using rows between
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		) AS cumulative_spent
FROM orders;






