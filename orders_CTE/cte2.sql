/*
Scenario 2: Big Orders

- Identify customers who have at least one order greater than their own average order amount.
- First CTE: avg_order
    Calculates average order per customer.
- Second CTE: big_orders
    Finds orders exceeding the customer's average and counts them.
- Final SELECT:
    Shows each customer's name, country, and the number of big orders they have.
*/





WITH avg_order AS (
SELECT 
	o.customer_id, AVG(o.amount) AS avg_amount
FROM 
	orders o 
GROUP BY o.customer_id
),
big_orders AS (
SELECT 
	o.customer_id, o.order_id 
FROM orders o
JOIN avg_order ao
	ON o.customer_id = ao.customer_id 
WHERE o.amount > ao.avg_amount 
)

SELECT 
	c.customer_id,
	c.customer_name,
	c.country,
	COUNT(bo.customer_id)
FROM customers c
JOIN big_orders bo
ON c.customer_id = bo.customer_id
GROUP BY c.customer_id, c.customer_name, c.country; 



