SET search_path TO public;


-- Clean slate (safe to re-run)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50)
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount NUMERIC(10,2),
    order_date DATE,
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- check existence 

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name IN ('customers', 'orders');


-- insert values 

INSERT INTO customers (customer_id, customer_name, country) VALUES
(1, 'Alice', 'USA'),
(2, 'Bob', 'Canada'),
(3, 'Carol', 'USA'),
(4, 'Dave', 'UK'),
(5, 'Eve', 'Canada');

INSERT INTO orders (order_id, customer_id, amount, order_date) VALUES
(101, 1, 250.00, '2026-01-01'),
(102, 1, 200.00, '2026-01-05'),
(103, 2, 100.00, '2026-01-03'),
(104, 3, 500.00, '2026-01-02'),
(105, 3, 300.00, '2026-01-06'),
(106, 4, 150.00, '2026-01-01'),
(107, 5, 450.00, '2026-01-04'),
(108, 5, 100.00, '2026-01-07');




INSERT INTO orders (order_id, customer_id, amount, order_date) VALUES
(109, 1, 120.00, '2025-12-15'),
(110, 1, 130.00, '2025-12-20');

INSERT INTO orders (order_id, customer_id, amount, order_date) VALUES
(111, 3, 600.00, '2025-12-10'),
(112, 3, 550.00, '2025-12-18');






SELECT * FROM customers; 
SELECT * FROM orders; 





