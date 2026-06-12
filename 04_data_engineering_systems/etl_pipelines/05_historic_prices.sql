/*
Exercise 5: Product Prices ETL
- Load new product prices from staging.
- Backup existing prices in a history table.
- Upsert new prices into the products table.
*/
DROP TABLE products CASCADE;
DROP TABLE  staging_product_prices CASCADE; 
DROP TABLE historic_product_prices CASCADE;

CREATE TABLE staging_product_prices (
    product_id INT PRIMARY KEY,
    new_price NUMERIC(10,2)
);

INSERT INTO staging_product_prices VALUES
(1, 19.99),
(2, 29.99),
(3, 24.99);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10,2)
);

INSERT INTO products VALUES
(1, 'Widget', 18.50),
(2, 'Gadget', 27.50),
(3, 'Thingamajig', 22.00);

-- 1. Create backup first, create a new table that gets upserts 
-- if prices change 
CREATE TABLE historic_product_prices (
    product_id INT,
    name VARCHAR(100),
    old_price NUMERIC(10,2),
    backup_date TIMESTAMP DEFAULT NOW()
);

-- 2. Insert into history only if price changes 

INSERT INTO historic_product_prices (product_id, name, old_price)
SELECT p.product_id, p.name, p.price
FROM products p
JOIN staging_product_prices s ON p.product_id = s.product_id
 -- only backup if the price actually changes
WHERE p.price <> s.new_price; 

-- 3. Now upsert into products the staging products with new prices
INSERT INTO products (product_id, name, price)
SELECT s.product_id, p.name, s.new_price
FROM staging_product_prices s
JOIN products p ON s.product_id = p.product_id
	ON CONFLICT (product_id)
	DO UPDATE SET price = EXCLUDED.price; 


SELECT * FROM products; 
SELECT * FROM historic_product_prices;
