/*
Exercise 2 — Check if customer is active
Create a function 
that returns BOOLEAN indicating if the customer is active.
Hint:
- Query the customers table for 'active' status (boolean or 'Y'/'N')
- Use SELECT INTO to store query result in a variable
- Return TRUE or FALSE accordingly
*/


CREATE OR REPLACE FUNCTION is_customer_active(p_customer_id INT)
RETURNS BOOLEAN AS $$
DECLARE 
	is_active BOOLEAN;
BEGIN
    SELECT active INTO is_active 
	FROM customers 
	WHERE customer_id = p_customer_id;
	-- handle nulls safely, returns false if null:
	RETURN COALESCE(is_active, FALSE);
   
END;
$$ LANGUAGE plpgsql;


-- get active customers 

SELECT c.customer_id, c.name
FROM customers c
WHERE is_customer_active(customer_id);




