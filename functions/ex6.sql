/*
Exercise 6 — Paginate sales
Create a function sales_page(page INT, page_size INT)
that returns TABLE (sale_id INT, salesperson TEXT, amount NUMERIC)
with sales ordered by sale_date descending
and returns the correct page based on inputs

*/

SET search_path TO functions_schema;

CREATE OR REPLACE FUNCTION sales_page(page INT, page_size INT)
RETURNS TABLE(sale_id INT, salesperson_id INT, amount NUMERIC) AS $$
BEGIN
	RETURN QUERY
	SELECT s.sale_id, s.salesperson_id, s.amount  
	FROM sales s
	ORDER BY sale_date DESC
	OFFSET (page - 1) * page_size
	LIMIT page_size; 
END;
$$ LANGUAGE plpgsql;

SELECT * FROM sales_page(1, 2); -- FIRST page WITH latest 2 sales)



