/*
Exercise 4 — Return recent sales for salesperson
Create a function sales_last_30_days
that returns TABLE of sale_id, amount, sale_date for sales in last 30 days.

*/

SET search_path TO functions_schema;

CREATE OR REPLACE FUNCTION sales_last_30_days(p_salesperson_id INT)
RETURNS TABLE(sale_id INT, amount NUMERIC) AS $$
BEGIN
    RETURN QUERY 
    SELECT s.sale_id, s.amount
    FROM sales s
    WHERE salesperson_id = p_salesperson_id 
	AND sale_date >= CURRENT_DATE - INTERVAL '30 days';
END;
$$ LANGUAGE plpgsql;


SELECT * FROM sales_last_30_days(1);


