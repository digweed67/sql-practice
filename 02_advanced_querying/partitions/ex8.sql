/*
Scenario 8 – Reporting by status within countries
• The company wants to quickly analyze orders grouped by country AND status.
• Typical queries:
SELECT country, status, COUNT(*)
FROM orders
WHERE country = 'ES' AND status = 'cancelled'
GROUP BY country, status;
• Only countries ES, US, FR are relevant for fast queries; other countries are rare.
*/

DROP TABLE IF EXISTS orders CASCADE;

SET search_path TO public;

-- Create main table partitioned by country
CREATE TABLE orders (
    order_id BIGINT,
    customer_id INT,
    order_date DATE NOT NULL,
    country TEXT,
    status TEXT,
    amount NUMERIC(10,2),
    PRIMARY KEY(order_id, country, status)-- don't forget to add the columns we're going to partition by in the pk
) PARTITION BY LIST(country);

-- Create partitions by country AND partition by status
CREATE TABLE orders_us PARTITION OF orders 
FOR VALUES IN ('US')
PARTITION BY LIST(status);

CREATE TABLE orders_es PARTITION OF orders 
FOR VALUES IN ('ES')
PARTITION BY LIST(status);

CREATE TABLE orders_fr PARTITION OF orders 
FOR VALUES IN ('FR')
PARTITION BY LIST(status);

CREATE TABLE orders_default PARTITION OF orders DEFAULT;

-- Create subpartitions for US
CREATE TABLE orders_us_pending PARTITION OF orders_us FOR VALUES IN ('pending');
CREATE TABLE orders_us_shipped PARTITION OF orders_us FOR VALUES IN ('shipped');
CREATE TABLE orders_us_delivered PARTITION OF orders_us FOR VALUES IN ('delivered');
CREATE TABLE orders_us_cancelled PARTITION OF orders_us FOR VALUES IN ('cancelled');
CREATE TABLE orders_us_default PARTITION OF orders_us DEFAULT;

-- Create subpartitions for ES
CREATE TABLE orders_es_pending PARTITION OF orders_es FOR VALUES IN ('pending');
CREATE TABLE orders_es_shipped PARTITION OF orders_es FOR VALUES IN ('shipped');
CREATE TABLE orders_es_delivered PARTITION OF orders_es FOR VALUES IN ('delivered');
CREATE TABLE orders_es_cancelled PARTITION OF orders_es FOR VALUES IN ('cancelled');
CREATE TABLE orders_es_default PARTITION OF orders_es DEFAULT;

-- Create subpartitions for FR
CREATE TABLE orders_fr_pending PARTITION OF orders_fr FOR VALUES IN ('pending');
CREATE TABLE orders_fr_shipped PARTITION OF orders_fr FOR VALUES IN ('shipped');
CREATE TABLE orders_fr_delivered PARTITION OF orders_fr FOR VALUES IN ('delivered');
CREATE TABLE orders_fr_cancelled PARTITION OF orders_fr FOR VALUES IN ('cancelled');
CREATE TABLE orders_fr_default PARTITION OF orders_fr DEFAULT;

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



-- Test query to see if pruning is used 
EXPLAIN ANALYZE
SELECT country, status, COUNT(*)
FROM orders
WHERE country = 'ES' AND status = 'cancelled'
GROUP BY country, status;

