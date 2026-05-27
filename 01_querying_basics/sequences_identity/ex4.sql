/*
 * Exercise 4 — Practice sequence manipulation and retrieving current values
 *
 * Goal:
 * Understand how to use sequences beyond just nextval — getting the current value,
 * resetting sequences, and manually setting values.
 *
 * Tasks:
 * 1. Create a new sequence manually (if not already done in Exercise 3).
 * 2. Insert a few rows into a table using the sequence (with nextval).
 * 3. Retrieve the current value of the sequence without incrementing (currval).
 * 4. Manually set the next value of the sequence (setval).
 * 5. Demonstrate what happens if you insert after manually setting it.
 *
 * Example instructions:
 * - Create a customers table with customer_id using a sequence starting at 5000.
 * - Insert 3 customers without specifying customer_id.
 * - Use currval to see the last generated ID.
 * - Use setval to set the next customer_id to 6000.
 * - Insert another customer and verify the ID is now 6000.
 */


DROP TABLE IF EXISTS customers; 
DROP SEQUENCE IF EXISTS customers_seq;

CREATE SEQUENCE customers_seq
	START 5000
	INCREMENT 1
	NO MINVALUE 
	NO MAXVALUE
	CACHE 1; 

CREATE TABLE customers (
	customer_id INT DEFAULT nextval('customers_seq') PRIMARY KEY,
	customer_name TEXT NOT NULL,
	birth_date DATE
); 



INSERT INTO customers (customer_name, birth_date)
VALUES ('Alice Bronson', '1988-08-29'),
		('Bob Jhonson', '1990-02-14'),
		('Carol Clarkson', '1990-04-19');

SELECT nextval('customers_seq'); -- generates 5003
SELECT currval('customers_seq'); -- returns 5003, current value 
SELECT setval('customers_seq', 6000); -- resets to 6000, so daniel is 60001

INSERT INTO customers (customer_name, birth_date)
VALUES ('Daniel Craig', '1986-04-22');

SELECT* FROM customers; 
