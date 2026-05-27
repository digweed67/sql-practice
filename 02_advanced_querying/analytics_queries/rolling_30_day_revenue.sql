/* ============================================================
SCENARIO 4: Rolling 30-Day Revenue

Business Question:
For each order, show total revenue in the previous 30 days.


Expected Output:
order_id | order_date | amount | revenue_last_30_days



Write your query below:
============================================================ */

SELECT 
    order_id,
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date
        RANGE BETWEEN INTERVAL '30 days' PRECEDING AND CURRENT ROW
    ) AS revenue_last_30_days
FROM orders
ORDER BY order_date;
	