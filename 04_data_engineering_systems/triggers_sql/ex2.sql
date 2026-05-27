/*
EXERCISE 2 — BEFORE trigger (very basic)

Goal:
Change data before it’s saved.

Rule:
Salesperson names must be uppercase.

Task:
Create a BEFORE INSERT trigger that:
- converts NEW.salesperson to UPPERCASE
- allows the insert to continue

Concept:
BEFORE triggers can modify NEW.

*/

-- create function 
CREATE OR REPLACE FUNCTION to_uppercase() 
RETURNS TRIGGER AS $$ 
BEGIN
	NEW.salesperson = UPPER(NEW.salesperson); 
	RETURN NEW; 		
END;
$$ LANGUAGE plpgsql; 

-- create trigger 
CREATE TRIGGER before_insert_salesperson
BEFORE INSERT ON sales 
FOR EACH ROW 
EXECUTE FUNCTION to_uppercase();


INSERT INTO sales(sale_id, salesperson, region, amount, sale_date)
VALUES (101, 'alice', 'North', 500, '2026-02-03');

SELECT * FROM sales;


