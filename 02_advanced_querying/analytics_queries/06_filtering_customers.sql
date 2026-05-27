/* ============================================================
SCENARIO 6: Customers Who Ordered in February But Not January

Business Question:
Which customers placed an order in February 2025
but did NOT place an order in January 2025?


Expected Output:
customer_id


Write your query below:
============================================================ */
 
SELECT DISTINCT customer_id
FROM orders
WHERE DATE_TRUNC('month', order_date) = DATE '2025-02-01'
AND customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE DATE_TRUNC('month', order_date) = DATE '2025-01-01'
);

