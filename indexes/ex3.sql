/* Scenario 3 — Customer Orders Page

Common query:
SELECT *
FROM orders
WHERE customer_id = 42
ORDER BY order_date DESC
LIMIT 20;
Questions:
•	What index design is optimal? I THINK composite
because we need both the customer_id but to get the latest
orders we need order_date too.
•	Why does column order matter?
because in composite indexes the leftmost column is the one
that is more important, where even if order by is missing
the index is going to work on customer_id 
•	Why is LIMIT important here? if we don't get all 
the results, only the 20 latest, the query runs faster, because
Postgres doesn't need to scan all the rows.  
*/ 
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders (
  id SERIAL,
  customer_id INT,
  order_date TIMESTAMP,
  status TEXT,
  total NUMERIC
);

INSERT INTO orders (customer_id, order_date, status, total)
SELECT
    (random() * 10000)::INT + 1,                             
    NOW() - (random() * INTERVAL '365 days'),               
    CASE WHEN random() < 0.7 THEN 'completed' ELSE 'pending' END,  
    ROUND((random() * 500)::NUMERIC, 2)                     
FROM generate_series(1, 1000000);

-- before index: Execution Time: 132.757 ms
EXPLAIN ANALYZE 
SELECT *
FROM orders
WHERE customer_id = 42
ORDER BY order_date DESC
LIMIT 20;

-- after index: Execution Time: 0.081 ms
CREATE INDEX idx_orders_customer_date 
ON orders(customer_id, order_date DESC); 
