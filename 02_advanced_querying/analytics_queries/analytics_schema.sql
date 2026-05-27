DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS orders CASCADE;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name TEXT,
    signup_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    product TEXT,
    amount NUMERIC(10,2)
);

INSERT INTO customers VALUES
(1, 'Alice', '2024-12-15'),
(2, 'Bob', '2025-01-10'),
(3, 'Charlie', '2025-01-20'),
(4, 'Diana', '2025-02-05');

INSERT INTO orders VALUES
(1, 1, '2025-01-01', 'Widget', 100),
(2, 1, '2025-01-05', 'Widget', 200),
(3, 2, '2025-01-07', 'Gadget', 150),
(4, 1, '2025-02-01', 'Widget', 300),
(5, 2, '2025-02-03', 'Gadget', 250),
(6, 3, '2025-02-10', 'Widget', 400),
(7, 1, '2025-03-01', 'Widget', 500),
(8, 2, '2025-03-05', 'Gadget', 100);


