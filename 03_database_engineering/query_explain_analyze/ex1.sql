/*
 * Exercise 1:
Table: orders (order_id PK, order_date, amount)
Index: idx_order_date ON orders(order_date)
-- Query:
EXPLAIN ANALYZE
SELECT SUM(amount) 
FROM orders 
WHERE order_date BETWEEN '2025-01-01' AND '2025-12-31';
Questions:
•	What type of scan do you expect? Postgres can use bitmap heap or index scan
depending on the amount of rows that will be selected. If it's a small amount, 
just index scan, if its between 20-40% of the rows, bitmap scan, if it's 
most of the rows then it could also be a sequential scan.
•	Why is using an index better for this query? Because it will allow
postgres to jump directly to that date range
•	What happens if you remove the index? postgres will do a sequential scan directly

*/

SET search_path TO public; 

/*
 * 1. Bitmap index scan (uses index and builds a bitmap of their locations) 
 * 2. Bitmap heap scan (uses bitmap to read the heap pages and get the matching rows)
 * 3. Aggregate returns a single row (since no group by).
 */
EXPLAIN ANALYZE
SELECT SUM(amount) 
FROM orders 
WHERE order_date BETWEEN '2025-01-01' AND '2025-12-31';

