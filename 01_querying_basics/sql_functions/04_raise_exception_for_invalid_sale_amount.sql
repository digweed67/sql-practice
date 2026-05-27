/*
Exercise 5 — Raise error if sale amount is negative or equal to zero
Create a function check_positive_amount
that raises an EXCEPTION if amount negative
Hint:
- Use IF condition
- Use RAISE EXCEPTION
- RETURN type can be VOID (no return value)
*/

SET search_path TO functions_schema;

CREATE OR REPLACE FUNCTION check_positive_amount(p_amount NUMERIC)
RETURNS VOID AS $$
BEGIN
    IF p_amount <= 0 THEN 
		RAISE EXCEPTION 'Amount must be positive %', p_amount;	
	END IF; 
END;
$$ LANGUAGE plpgsql;


