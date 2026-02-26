/*
Exercise 4: Monthly Sales Summary ETL
- Load raw daily sales data into staging.
- Aggregate total sales per product per month.
- Insert the aggregated data into a monthly summary table.
*/

CREATE TABLE source_daily_sales (
    sale_id SERIAL PRIMARY KEY,
    product VARCHAR(50),
    sale_date DATE,
    amount NUMERIC(10,2)
);

INSERT INTO source_daily_sales VALUES
(DEFAULT, 'Widget', '2023-01-01', 199.90),
(DEFAULT, 'Widget', '2023-01-15', 99.95),
(DEFAULT, 'Gadget', '2023-01-10', 499.50),
(DEFAULT, 'Widget', '2023-02-05', 299.85);

-- 1. load staging table 
CREATE TABLE staging_monthly_sales AS 
SELECT * FROM source_daily_sales; 

-- 2.Transform in the temp table 
CREATE TEMP TABLE temp_monthly_sales AS
SELECT  
	product,
	SUM(amount) AS total_amount,
	DATE_TRUNC('month', sale_date)::DATE AS month
FROM staging_monthly_sales
GROUP BY product, DATE_TRUNC('month', sale_date)
ORDER BY product, month;

-- 3. create the final table 
CREATE TABLE monthly_summary_sales (
	product VARCHAR(50),
	total_amount NUMERIC (12,2),
	month DATE,
	PRIMARY KEY (product, month)
);

-- 4. Insert into final table
INSERT INTO monthly_summary_sales
SELECT * FROM temp_monthly_sales; 

SELECT * FROM monthly_summary_sales; 
	
	