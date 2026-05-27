/*
Exercise 3: Customer Addresses ETL
- Load new customer addresses from staging.
- If the customer exists in the final table, update the address.
- If the customer does not exist, insert a new record.
*/

CREATE TABLE staging_customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    address TEXT
);

INSERT INTO staging_customers VALUES
(1, 'Alice', '123 Main St'),
(2, 'Bob', '456 Oak Ave'),
(3, 'Carol', '789 Pine Rd');

CREATE TABLE customers_clean (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    address TEXT
);

INSERT INTO customers_clean VALUES
(1, 'Alice', 'Old Address'),
(4, 'David', '321 Elm St');


-- update or insert the current staging table into the final table 
INSERT INTO customers_clean(customer_id, name, address)
SELECT customer_id, name, address
FROM staging_customers 
ON CONFLICT (customer_id)
DO UPDATE SET 
	name = EXCLUDED.name,
	address = EXCLUDED.address;


	
