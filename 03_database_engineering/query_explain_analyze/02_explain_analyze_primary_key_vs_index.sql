/*
 * Exercise 2:
Table: customers (customer_id PK, name, city)
-- Query:
EXPLAIN ANALYZE
SELECT * 
FROM customers 
WHERE customer_id = 12345;
Questions:
•	What scan will it use? Index scan using the primary key index  
•	Why is it so fast? Because the where clause is in a column which
has an index and it's a primary key, which makes it unique too which allows
PostgreSQL to quickly find the matching row without scanning the full table.
•	Which index is being used? The primary key index on customer_id  

*/


EXPLAIN ANALYZE
SELECT * 
FROM customers 
WHERE customer_id = 12345;

