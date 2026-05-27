CREATE SCHEMA IF NOT EXISTS functions_schema;

SET search_path TO functions_schema;

DROP TABLE IF EXISTS customers CASCADE; 
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS salespersons CASCADE;
DROP TABLE IF EXISTS invoices CASCADE;


-- Customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    active BOOLEAN DEFAULT TRUE
);

-- Salespersons table
CREATE TABLE IF NOT EXISTS salespersons (
    salesperson_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- Sales table
CREATE TABLE IF NOT EXISTS sales (
    sale_id SERIAL PRIMARY KEY,
    salesperson_id INT REFERENCES salespersons(salesperson_id),
    customer_id INT REFERENCES customers(customer_id),
    amount NUMERIC CHECK (amount >= 0),
    sale_date DATE DEFAULT CURRENT_DATE
);

-- Invoices table (for invoice numbering)
CREATE TABLE IF NOT EXISTS invoices (
    invoice_id SERIAL PRIMARY KEY,
    sale_id INT REFERENCES sales(sale_id),
    invoice_no TEXT UNIQUE,
    invoice_date DATE DEFAULT CURRENT_DATE
);



INSERT INTO customers (name, active) VALUES 
('Alice', TRUE), ('Bob', FALSE), ('Charlie', TRUE);

INSERT INTO salespersons (name) VALUES 
('Alice'), ('Bob');

INSERT INTO sales (salesperson_id, customer_id, amount, sale_date) VALUES
(1, 1, 100, CURRENT_DATE - INTERVAL '10 days'),
(2, 2, 200, CURRENT_DATE - INTERVAL '40 days'),
(1, 3, 150, CURRENT_DATE - INTERVAL '5 days');


SELECT * FROM sales;
SELECT * FROM salespersons;
SELECT * FROM customers;
SELECT * FROM invoices;



