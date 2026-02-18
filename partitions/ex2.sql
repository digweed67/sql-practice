/* Scenario 2 – Filtering by country
• The company has dashboards by country.
• Typical queries:
SELECT COUNT(*) 
FROM orders 
WHERE country = 'ES';
*/ 
DROP TABLE IF EXISTS orders CASCADE; 


-- add partition to the table

SET search_path TO public;


CREATE TABLE orders (
    order_id BIGINT,
    customer_id INT,
    order_date DATE NOT NULL,
    country TEXT,
    status TEXT,
    amount NUMERIC(10,2),
    PRIMARY KEY (order_id, country)
) PARTITION BY LIST(country);


-- create partitions: 

CREATE TABLE orders_es PARTITION OF orders 
FOR VALUES IN ('ES');

CREATE TABLE orders_fr PARTITION OF orders 
FOR VALUES IN ('FR');

CREATE TABLE orders_de PARTITION OF orders 
FOR VALUES IN ('DE');

CREATE TABLE orders_us PARTITION OF orders 
FOR VALUES IN ('US');


CREATE TABLE orders_default PARTITION OF orders DEFAULT; 

-- Insert 1 million rows of simulated data
-- Using generate_series for order_id and order_date
-- Randomly assign country, status, customer_id and amount

INSERT INTO orders (order_id, customer_id, order_date, country, status, amount)
SELECT
    gs AS order_id,
    (random() * 10000)::INT + 1 AS customer_id,
    ('2020-01-01'::date + (random() * 2556)::int) AS order_date,  -- random date between 2020-01-01 and 2026-12-31 (7 years approx)
    CASE
        WHEN r < 0.2 THEN 'US'
        WHEN r < 0.4 THEN 'ES'
        WHEN r < 0.6 THEN 'FR'
        WHEN r < 0.8 THEN 'DE'
        ELSE 'MX'
    END AS country,
    CASE
        WHEN s < 0.25 THEN 'pending'
        WHEN s < 0.6 THEN 'shipped'
        WHEN s < 0.95 THEN 'delivered'
        ELSE 'cancelled'
    END AS status,
    round((random() * 990 + 10)::numeric, 2) AS amount  -- amount between 10 and 1000
FROM
    generate_series(1, 1000000) gs,
    LATERAL (SELECT random() as r, random() as s) r_s;


-- explain analyze to see if it's being used 

EXPLAIN ANALYZE 
SELECT COUNT(*) 
FROM orders 
WHERE country = 'ES'; 
