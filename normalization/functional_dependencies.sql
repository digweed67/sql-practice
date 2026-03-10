/*
Scenario 2: Functional Dependencies and Keys
Given this table Orders:
(order_id, product_id, product_name, customer_id, customer_name, quantity, price)
Tasks:
- Identify at least two functional dependencies in this table.
the product id determines the product name, the customer id determines the customer name.
- Explain why these dependencies indicate the table is not in 2NF or 3NF.
Because these functional dependencies do not depend on the order id which 
would have to be the primary key in this table, they are indirectly related
ie they are transitive dependencies and violate 3NF.
Order_id and product_id are composite keys but the other keys like product_name only depends 
on product_id (not order_id), that's partial dependency and violates 2NF.
- Suggest how to split this table into smaller tables to fix these problems.
- Identify primary keys and foreign keys in your new design.
*/
CREATE TABLE IF NOT EXISTS customers (
	customer_id SERIAL PRIMARY KEY,
	customer_name VARCHAR (100)
);

CREATE TABLE IF NOT EXISTS orders (
	order_id SERIAL PRIMARY KEY,
	customer_id INT REFERENCES customers(customer_id),
	order_date DATE,
	amount NOT NULL 
);


CREATE TABLE IF NOT EXISTS products (
	product_id SERIAL PRIMARY KEY,
	price NUMERIC(2,10)
);

CREATE TABLE IF NOT EXISTS order_details (
	order_id INT REFERENCES orders(order_id), 
	product_id INT REFERENCES products(product_id),
	quantity INT NOT NULL,
	price NUMERIC(2,10),
	PRIMARY KEY (order_id, product_id)
);

