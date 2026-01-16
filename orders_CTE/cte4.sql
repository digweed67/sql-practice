/*
Scenario 4: Customers with Increasing Recent Spending
- Identify customers whose spending is improving.
- Compare the average of their last 2 orders with the average of all previous orders.
- Return customers where the average of the last 2 orders is greater than the average of their earlier orders.
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
avg_recent AS (
SELECT
  customer_id,
  AVG(amount) AS avg_recent_amount
FROM orders_by_date
WHERE order_rank <= 2
GROUP BY customer_id 
),

avg_previous AS (
SELECT
  customer_id,
  AVG(amount) AS avg_previous_amount
FROM orders_by_date
WHERE order_rank > 2
GROUP BY customer_id 
)

SELECT 
ap.customer_id,
ap.avg_previous_amount,
ar.avg_recent_amount
FROM avg_previous ap
JOIN avg_recent ar
ON ap.customer_id = ar.customer_id
WHERE ar.avg_recent_amount > ap.avg_previous_amount;



