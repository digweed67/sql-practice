/* 
Scenario 5 — Analytics / Reporting
Table:
sales (
  id SERIAL,
  store_id INT,
  sale_date DATE,
  amount NUMERIC
);
Very common query:
SELECT SUM(amount)
FROM sales
WHERE store_id = 10
AND sale_date BETWEEN '2026-01-01' AND '2026-01-31';
Questions:
•	What index would you create?  
•	Composite or single?
•	Column order?
•	Why?
Bonus:
Would indexing amount help here?
I would create a composite index on store_id and sale_date, in that 
order, since store_id is the preferential/most important one, 
I don't think indexing amount would help because it's part of an aggregate
so that needs computing anyway first, it doesn't speed up
aggregates. We could use a covering index and add amount to speed things up slightly.

Indexes alone don't help, we would need materialized views or pre-aggregated
summary tables. 

*/

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    store_id INT,
    sale_date DATE,
    amount NUMERIC
);

INSERT INTO sales (store_id, sale_date, amount)
SELECT
    (random() * 1000)::INT + 1,
    CURRENT_DATE - (random() * INTERVAL '730 days'),
    ROUND((random() * 500)::NUMERIC, 2)
FROM generate_series(1, 1000000);



--- before index: Execution Time: 80.946 ms
EXPLAIN ANALYZE
SELECT SUM(amount)
FROM sales
WHERE store_id = 10
AND sale_date BETWEEN '2026-01-01' AND '2026-01-31';

-- after index: Execution Time: 0.228 ms
CREATE INDEX idx_sales_store_date
ON sales(store_id, sale_date);

-- drop index to try a covering one
DROP INDEX IF EXISTS idx_sales_store_date; 

-- after running this: Execution Time: 0.208 ms
CREATE INDEX idx_sales_store_date
ON sales(store_id, sale_date)
INCLUDE (amount);
