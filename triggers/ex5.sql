/*
EXERCISE 5 — Statement-level trigger (easy)

Goal:
Count how many sales exist.

Setup:
Create a table sales_count with:
- total_sales

Task:
Create an AFTER INSERT
FOR EACH STATEMENT trigger
that updates total_sales.

Concept:
Statement-level triggers run once per statement.
*/

-- create table 
CREATE TABLE IF NOT EXISTS sales_count (
    total_sales INT NOT NULL,
    changed_at TIMESTAMP DEFAULT NOW()
);

-- seed it once
INSERT INTO sales_count (total_sales)
VALUES (0)
ON CONFLICT DO NOTHING;


-- create function 

CREATE OR REPLACE FUNCTION update_sales_count()
RETURNS TRIGGER AS $$
-- declare variable to store the count
DECLARE
    v_total INT;
BEGIN
    -- count all current rows and save them into the variable
    SELECT COUNT(*) INTO v_total
    FROM sales;

    -- store the result
    UPDATE sales_count
    SET total_sales = v_total,
        changed_at = NOW();

    -- statement-level triggers return nothing
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
 

-- create trigger 

CREATE TRIGGER after_insert_sales_count
AFTER INSERT ON sales 
FOR EACH STATEMENT 
EXECUTE FUNCTION update_sales_count(); 


SELECT * FROM sales_count;

