/* Exercise 4: JOIN with Hash Join
Tables: customers (~10,000 rows), orders (~1,000,000 rows)
Query:
EXPLAIN ANALYZE
SELECT c.city, COUNT(o.order_id)
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city;
*/

/* Questions to answer before running EXPLAIN ANALYZE:

1) What type of join will PostgreSQL choose for this query?
It could also be a hash join because one table is significantly smaller than the 
other. 

2) What kind of scan(s) will PostgreSQL likely perform on 'customers' and 'orders'?
Customers a sequential scan or index scan and orders a seq scan too

3) How does PostgreSQL combine rows from the two tables?
On the matching column customer_id 

4) Under what conditions would this join method become inefficient?
if both tables were small or if we didn't have an indexed / ordered key on
the join (for the merge join)
 
5) How does grouping by 'city' affect the execution plan?
Since the data is not ordered by city, then the query plan
will use Group Aggregate (sort then merge) to execute this part as 
there's only 5 cities.   
*/

-- Join type: hash join
-- scans: parallel seq scan on orders // seq scan on customers
-- aggregation: partial hashAggregate 
EXPLAIN ANALYZE
SELECT c.city, COUNT(o.order_id)
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city;

