/*
EXERCISE 3 — Using OLD vs NEW (UPDATE)

Goal:
Log when a sale amount changes.

Task:
Create an AFTER UPDATE trigger that:
- logs sale_id, OLD.amount, NEW.amount
- only for updates


*/

CREATE TABLE IF NOT EXISTS sales_amount_log (
	log_id SERIAL PRIMARY KEY,
	sale_id INT NOT NULL,
	old_amount INT NOT NULL,
	new_amount INT NOT NULL,
	changed_at TIMESTAMP DEFAULT NOW()
);


-- function 

CREATE OR REPLACE FUNCTION log_amounts() 
RETURNS TRIGGER AS $$ 
BEGIN 
	INSERT INTO sales_amount_log(sale_id, old_amount, new_amount)
	VALUES(NEW.sale_id, OLD.amount, NEW.amount);
	
	RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 


-- trigger 
CREATE TRIGGER after_amount_change
AFTER UPDATE ON sales 
FOR EACH ROW 
WHEN (OLD.amount IS DISTINCT FROM NEW.amount)
EXECUTE FUNCTION log_amounts(); 


-- test it

-- Update one row's amount
UPDATE sales
SET amount = 500
WHERE sale_id = 1;

-- Update a row but the amount stays the same
UPDATE sales
SET amount = 800
WHERE sale_id = 2;

SELECT * FROM sales;
SELECT * FROM sales_amount_log;

