/*
Scenario 1 – Historical data by year
• The company wants to analyze historical orders by year.
• Common queries like:
SELECT SUM(amount) 
FROM orders 
WHERE order_date BETWEEN '2025-01-01' AND '2025-12-31';
 
*/

-- add partition to the table

SET search_path TO public;

CREATE TABLE orders (
    order_id BIGINT,
    customer_id INT,
    order_date DATE NOT NULL,
    country TEXT,
    status TEXT,
    amount NUMERIC(10,2),
    PRIMARY KEY (order_id, order_date)
) PARTITION BY RANGE(order_date);


-- create partitions: 

CREATE TABLE orders_2020 PARTITION OF orders 
FOR VALUES FROM('2020-01-01') TO ('2021-01-01'); 

CREATE TABLE orders_2021 PARTITION OF orders 
FOR VALUES FROM('2021-01-01') TO ('2022-01-01');

CREATE TABLE orders_2022 PARTITION OF orders 
FOR VALUES FROM('2022-01-01') TO ('2023-01-01');

CREATE TABLE orders_2023 PARTITION OF orders 
FOR VALUES FROM('2023-01-01') TO ('2024-01-01');

CREATE TABLE orders_2024 PARTITION OF orders 
FOR VALUES FROM('2024-01-01') TO ('2025-01-01');

CREATE TABLE orders_2025 PARTITION OF orders 
FOR VALUES FROM('2025-01-01') TO ('2026-01-01');

CREATE TABLE orders_2026 PARTITION OF orders 
FOR VALUES FROM('2026-01-01') TO ('2027-01-01');

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


-- check if partition is being used 
ANALYZE orders; -- scan some rows of each partition first

-- now it's using seq scan orders_2025
EXPLAIN ANALYZE 
SELECT SUM(amount) 
FROM orders 
WHERE order_date BETWEEN '2025-01-01' AND '2025-12-31';

