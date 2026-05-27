/*
Scenario 5 – Bulk deletion of old data
• The company regularly deletes data older than 2021.
• Query:
DELETE FROM orders 
WHERE order_date < '2021-01-01';
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
    PRIMARY KEY (order_id, order_date)
) PARTITION BY RANGE(order_date);


-- create partition for 2020: 

CREATE TABLE orders_2020 PARTITION OF orders 
FOR VALUES FROM('2020-01-01') TO('2021-01-01');

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


 
-- delete from is slow, uses a lot of WAL AND I/O, 
-- so for big deletes we will use drop table orders_2020:
-- this took 0.022s 
DROP TABLE orders_2020;

-- this took 0.338s
DELETE FROM orders 
WHERE order_date < '2021-01-01';

