/*
EXERCISE 6 — BEFORE trigger that blocks bad data

Goal:
Prevent invalid sales.

Rule:
Sale amount must be greater than 0.

Task:
Create a BEFORE INSERT trigger that:
- raises an exception if NEW.amount <= 0

Concept:
Triggers can reject rows.

Note: a check constraint would be best, cleaner and more explicit
for a simple check like this, but for the purpose of triggers practice
we will do it with a trigger.

*/

CREATE OR REPLACE FUNCTION check_amount()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.amount <= 0 THEN 
		RAISE EXCEPTION 'Invalid amount: %', NEW.amount;
	END IF; 

	RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 




CREATE TRIGGER before_insert_check_amount 
BEFORE INSERT ON sales 
FOR EACH ROW 
EXECUTE FUNCTION check_amount(); 

/* THE INSERT NOW GETS THIS RESULT:
 * SQL Error [P0001]: ERROR: Invalid amount: -50
  Where: PL/pgSQL function check_amount() line 4 at RAISE
 */
INSERT INTO sales (sale_id, salesperson, region, sale_date, amount)
VALUES (201, 'Frank', 'South', '2026-02-04', -50);



