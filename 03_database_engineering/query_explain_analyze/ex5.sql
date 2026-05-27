/* Exercise 5:

Query:
EXPLAIN ANALYZE
SELECT * 
FROM orders 
WHERE status IN ('pending', 'delivered')
AND order_date >= '2026-01-01';
*/

/* Questions to answer before running EXPLAIN ANALYZE:
1) What type of scan will PostgreSQL likely use for this query?
We have a range of data we need to retrieve (different dates, different statuses)
so it might use bitmap heap index scan, since we have a composite
index on status and order_date which are the 2 conditions we
are filtering by.

2) How does PostgreSQL use the index when filtering rows?
It uses a b-tree index which makes it faster to fetch the required
rows.
3) How might the size of the result set affect the scan choice?
If a large portion of the table matches the conditions 
a sequential scan could be faster because it avoids extra overhead.

*/

-- Bitmap Heap scan or orders 
EXPLAIN ANALYZE
SELECT * 
FROM orders 
WHERE status IN ('pending', 'delivered')
AND order_date >= '2026-01-01';




