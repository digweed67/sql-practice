/*
EXERCISE 1 — What does a trigger even do?

Goal:
Log every new sale.

Task:
Create a table called sales_log with:
- log_id
- sale_id
- logged_at

Then create:
- an AFTER INSERT trigger on sales
- row-level
- that inserts the sale_id into sales_log

Concept:
Triggers run automatically after something happens.
*/

-- create audit table 

CREATE TABLE IF NOT EXISTS sales_log (
	log_id SERIAL PRIMARY KEY,
	sale_id INT NOT NULL, 
	logged_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(sale_id) REFERENCES sales(sale_id)
);
-- create function to call
CREATE OR REPLACE FUNCTION log_sales()
RETURNS TRIGGER AS $$ 

BEGIN 
	INSERT INTO sales_log (sale_id)
	VALUES(NEW.sale_id); 

	RETURN NEW; 

END; 

$$ LANGUAGE plpgsql; 


-- create trigger 
CREATE TRIGGER after_insert_sales
AFTER INSERT ON sales
FOR EACH ROW 
EXECUTE FUNCTION log_sales(); 

INSERT INTO sales(salesperson, region, amount, sale_date)
VALUES ('Alice', 'North', 500, '2026-02-03');

SELECT * FROM sales_log; 
