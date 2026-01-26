-- Exercise 1: use serial to auto increment 
DROP TABLE IF EXISTS products; 

CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
	product_name TEXT NOT NULL, 
	price NUMERIC (10,2) NOT NULL 
	
);

INSERT INTO products (product_name, price)
VALUES ('water', 1.99),
		('bread', 2.99);

SELECT * FROM products; 