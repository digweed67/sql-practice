/*
Exercise 5 — Sum sales amounts for a region
Create a function total_sales(region_name TEXT)
that returns NUMERIC with the sum of amounts in sales table for that region.

*/


SET search_path TO functions_schema;

CREATE OR REPLACE FUNCTION total_sales(region_name TEXT)
RETURNS NUMERIC AS $$
DECLARE 
	v_total_sales NUMERIC; 
BEGIN
	SELECT COALESCE(SUM(amount), 0) 
	INTO v_total_sales 
	FROM sales 
	WHERE region = region_name; 
    RETURN v_total_sales;
END;
$$ LANGUAGE plpgsql;

SELECT total_sales('North');

