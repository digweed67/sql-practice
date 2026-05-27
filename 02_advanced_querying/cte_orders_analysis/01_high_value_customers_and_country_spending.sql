
/*
Scenario 1: 
Find high-value customers (those who have spent more than 400 in total) 
and show both their total spending and the total spending for their country 
(but only counting high-value customers in the country total).
*/ 

WITH customer_total AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
    HAVING SUM(amount) > 400
),

country_total AS (
    SELECT c.country, SUM(ct.total_spent) AS country_total_spent
    FROM customers c
    JOIN customer_total ct ON c.customer_id = ct.customer_id
    GROUP BY c.country
)

SELECT c.customer_name,
       c.country,
       ct.total_spent,
       ctry.country_total_spent
FROM customers c
JOIN customer_total ct ON c.customer_id = ct.customer_id
JOIN country_total ctry ON c.country = ctry.country;





	




