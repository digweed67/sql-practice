/* ============================================================
SCENARIO 5: Rank Customers by Number of Orders

Business Question:
Rank customers by total number of orders (highest first).

Requirements:
- GROUP BY customer_id
- Use RANK()
- Order descending

Expected Output:
customer_id | num_orders | rank

Trap:
Window functions execute AFTER aggregation.

============================================================ */

SELECT 
	customer_id,
	COUNT(order_id) AS num_orders, 
	RANK() OVER (ORDER BY COUNT(order_id) DESC) AS rank
FROM orders 
GROUP BY customer_id; 



