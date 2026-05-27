/*
Scenario 5: Customers with Multiple Large Orders in Recent Orders
- Identify customers who had at least 2 orders with amount greater than 200
  in their last 3 orders (ranked by order date descending).
- Use CTEs to:
    1. Rank orders per customer by order date (newest first)
    2. Select the last 3 orders per customer
    3. Count how many of these orders have amount > 200
- Return only customers meeting the condition (num_large_orders >= 2)
- Columns returned can include customer_id, num_large_orders, or other customer info.
*/
 



WITH orders_by_date AS (
  SELECT
    order_id,
    customer_id,
    amount,
    order_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS order_rank
  FROM orders
),

last_3_orders AS (
  SELECT *
  FROM orders_by_date 
  WHERE order_rank <= 3
),

large_orders AS (
  SELECT 
    customer_id,
    COUNT(order_id) AS num_large_orders
  FROM last_3_orders
  WHERE amount > 200
  GROUP BY customer_id 
) 

SELECT 
  customer_id,
  num_large_orders
FROM large_orders
WHERE num_large_orders >= 2;
 