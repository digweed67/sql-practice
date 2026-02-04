/*
EXERCISE 4 — DELETE trigger

Goal:
Track deleted sales.

Task:
Create an AFTER DELETE trigger that:
- inserts the old sale id into a deleted_sales table

Concept:
DELETE triggers only have OLD.
*/

-- create log table 
CREATE TABLE IF NOT EXISTS deleted_sales (
	delete_id SERIAL PRIMARY KEY,
	old_sale_id INT NOT NULL,
	changed_at TIMESTAMP DEFAULT NOW()
	-- no fk bc won't exist after delete
);


-- create function 
CREATE OR REPLACE FUNCTION log_deleted_sales() 
RETURNS TRIGGER AS $$ 
BEGIN

	INSERT INTO deleted_sales(old_sale_id) 
	VALUES(OLD.sale_id); 
	
	RETURN OLD; -- delete only accesses old

END; 
$$ LANGUAGE plpgsql; 



-- create trigger 
CREATE TRIGGER after_deleted_sales
AFTER DELETE ON sales 
FOR EACH ROW 
EXECUTE FUNCTION log_deleted_sales(); 




