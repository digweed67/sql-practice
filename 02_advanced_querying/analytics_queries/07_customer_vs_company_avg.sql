/* ============================================================
SCENARIO 7: Customer Average vs Company Average

Business Question:
Show each customer's average order value
and compare it to the overall company average.

Requirements:
- Compute customer AVG
- Compute overall AVG using window function
- Show both in same row

Expected Output:
customer_id | customer_avg | company_avg

Hint:
Company average should be the same for all rows.

Write your query below:
============================================================ */
-- we need to use 2 window functions because if we use an aggregate + group by 
-- it will collapse rows and the window function will calculate average
-- based on that first computed aggregation.
SELECT DISTINCT
    customer_id,
    ROUND(AVG(amount) OVER (PARTITION BY customer_id), 2) AS customer_avg,
    ROUND(AVG(amount) OVER (), 2) AS company_avg
FROM orders
ORDER BY customer_id;



-- another option without window functions, with cte, separating
-- levels of aggregation: 

WITH company_avg AS (
    SELECT AVG(amount) AS company_avg
    FROM orders
)
SELECT
    o.customer_id,
    AVG(o.amount) AS customer_avg,
    c.company_avg
FROM orders o
CROSS JOIN company_avg c -- cross join necessary because cte returns
-- one scalar value only 
GROUP BY o.customer_id, c.company_avg;

