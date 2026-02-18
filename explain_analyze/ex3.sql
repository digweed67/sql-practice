/*
Exercise 3: 

-- Query:
EXPLAIN ANALYZE
SELECT o.order_id, c.name 
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_date >= '2026-01-01';
Questions:
•	When is Nested Loop used in a JOIN? It is used when both 
tables are small, but in this case, our tables are big (10,000 and 1,000,000) so
a nested loop won't be used because it generates a lot of wall
and I/0. Here, it will likely use a hash join because the customers
table is smaller. 
•	What determines whether it is efficient?
It is determined by the size of the tables that are being joined. It only works
well on small tables. 
The Bitmap index scan will be used on the where clause to filter rows. 

*/

-- Even though our query only filters on order_date and does not select status,
-- PostgreSQL may choose the composite index (status, order_date) over the single-column
-- order_date index. This happens because:
-- 1) The composite index is already partially sorted by order_date within each status,
--    which can reduce I/O when scanning large tables.
-- 2) The planner estimates this index scan will be cheaper than using idx_order_date,
--    even though the status column is not used in the SELECT or WHERE.

EXPLAIN ANALYZE
SELECT o.order_id, c.name 
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_date >= '2026-01-01';

