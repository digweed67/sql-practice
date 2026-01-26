/*
 * Exercise 3: Create an orders table
•	order_id as INT primary key defaulting to nextval
('order_seq')
•	product_id as foreign key referencing products
(product_id)
•	quantity as INT (not null)
Insert 3 orders without specifying order_id and verify
 IDs start at 1000.

*/

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP SEQUENCE IF EXISTS order_seq;


CREATE SEQUENCE order_seq
	START 1000
	INCREMENT 1
	NO MINVALUE 
	NO MAXVALUE
	CACHE 1;

CREATE TABLE products (
	product_id INT DEFAULT nextval('order_seq') PRIMARY KEY,
	product_name TEXT NOT NULL, 
	price NUMERIC (10,2) NOT NULL 
	
);


CREATE TABLE orders (
	order_id INT PRIMARY KEY DEFAULT nextval('order_seq'),
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY(product_id) REFERENCES products(product_id)

);


INSERT INTO products(product_name, price)
VALUES ('water', 1.99),
		('bread', 2.99)
RETURNING product_id; -- this gives me the id 


INSERT INTO orders(product_id, quantity)
VALUES (1000, 4),
		(1001, 5);-- the order id here is nos 1006 because of 
		-- some failed attempts at inserting 

SELECT * FROM products; 
SELECT * FROM orders; 



