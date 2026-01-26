-- Exercise 2: Create a manual sequence named 
-- order_seq starting at 1000 and incrementing 2 
 

DROP TABLE IF EXISTS products; 


CREATE SEQUENCE order_seq
	START 1000
	INCREMENT 2
	NO MINVALUE 
	NO MAXVALUE
	CACHE 1;

CREATE TABLE products (
	product_id INT DEFAULT nextval('order_seq'),
	product_name TEXT NOT NULL, 
	price NUMERIC (10,2) NOT NULL 
	
);

INSERT INTO products (product_name, price)
VALUES ('water', 1.99),
		('bread', 2.99);

SELECT * FROM products; 


	