-- clean reset 
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- customers table 
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name TEXT,
    city TEXT
);

-- insert 10,000 random customers 
INSERT INTO customers (name, city)
SELECT 
    'Customer_' || gs AS name,
    CASE
        WHEN r < 0.2 THEN 'New York'
        WHEN r < 0.4 THEN 'Los Angeles'
        WHEN r < 0.6 THEN 'Chicago'
        WHEN r < 0.8 THEN 'Houston'
        ELSE 'Phoenix'
    END AS city
FROM generate_series(1, 10000) gs,
LATERAL (SELECT random() as r) r_s;

-- orders table 
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE NOT NULL,
    status TEXT,
    amount NUMERIC(10,2)
);

-- Insert 1,000,000 random rows in orders
INSERT INTO orders (customer_id, order_date, status, amount)
SELECT
    (random() * 9999 + 1)::INT AS customer_id,
    ('2020-01-01'::date + (random() * 2556)::int) AS order_date,  -- fechas entre 2020 y finales 2026
    CASE
        WHEN r < 0.25 THEN 'pending'
        WHEN r < 0.6 THEN 'shipped'
        WHEN r < 0.95 THEN 'delivered'
        ELSE 'cancelled'
    END AS status,
    round((random() * 990 + 10)::numeric, 2) AS amount
FROM generate_series(1, 1000000) gs,
LATERAL (SELECT random() as r) r_s;

-- useful indexes 
CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_status_order_date ON orders(status, order_date);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
