/*
Exercise 1 — Normalize names
Create a function that 
- returns the name with first letter capitalized, rest lowercase
Hint:
- Use built-in functions LOWER() and INITCAP()
- Then apply it to your select to normalize names 
so they can be grouped together 

*/
-- update table with messy data 
UPDATE salespersons 
SET name = 'AlIcE'
WHERE salesperson_id = 1; 
SELECT * FROM salespersons WHERE salesperson_id = 1;

-- create function to normalize names 

CREATE OR REPLACE FUNCTION normalize_name(name TEXT)
RETURNS TEXT AS $$
BEGIN
	
    RETURN INITCAP(LOWER(name)); 
END;
$$ LANGUAGE plpgsql;
 

-- normalize names so AlIcE and Alice are grouped together:
SELECT 
	normalize_name(salesperson) AS formatted_name, 
	SUM(amount)
FROM sales
GROUP BY normalize_name(salesperson);


