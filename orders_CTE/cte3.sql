/*
Scenario 3: Customers with Recent Large Orders
- Identify customers who had their last 2 orders above 100.
*/

WITH recent_orders AS (
SELECT
    order_id,
    customer_id,
    amount,
    order_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS order_rank
FROM orders
),

big_recent_orders AS (
SELECT 
	customer_id,
	COUNT(order_id) AS num_big_orders
FROM recent_orders
WHERE amount > 100 AND order_rank <= 2 
GROUP BY customer_id  
)

SELECT 
c.customer_name,
c.country,
bro.num_big_orders
FROM customers c
JOIN big_recent_orders bro
ON c.customer_id = bro.customer_id 
WHERE bro.num_big_orders = 2; 

