/*
EXERCISE 7 — BEFORE UPDATE validation

Goal:
Protect existing data.

Rule:
Once a sale is created, its sale_date cannot change.

Task:
Create a BEFORE UPDATE trigger that:
- raises an error if previous sale date is smaller or bigger than
new sale date 

Concept:
Comparing OLD vs NEW.
*/

CREATE OR REPLACE FUNCTION check_date()
RETURNS TRIGGER AS $$
BEGIN
	IF OLD.sale_date <> NEW.sale_date THEN 
		RAISE EXCEPTION 'Cannot change sale date: % -> %', OLD.sale_date, NEW.sale_date;
	END IF; 

	RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 




CREATE TRIGGER before_update_check_date 
BEFORE UPDATE ON sales 
FOR EACH ROW 
EXECUTE FUNCTION check_date(); 


-- test 
/*
 * SQL Error [P0001]: ERROR: 
 * Cannot change sale date: 2023-01-01 -> 2026-01-01
 */

UPDATE sales
SET sale_date = '2026-01-01'
WHERE sale_id = 1;


