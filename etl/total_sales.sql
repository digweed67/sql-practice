/*
Exercise 2: Sales Data ETL
- Load raw sales data with sale dates stored as text.
- Convert sale dates to proper DATE type.
- Calculate total sale amount per row.
- Insert cleaned data into a final sales table.
*/

CREATE TABLE source_sales (
    sale_id SERIAL PRIMARY KEY,
    product VARCHAR(50),
    quantity INT,
    price NUMERIC(10,2),
    sale_date_text VARCHAR(20)
);

INSERT INTO source_sales (product, quantity, price, sale_date_text) VALUES
('Widget', 10, 19.99, '2023-01-15'),
('Gadget', 5, 99.50, '2023-01-16'),
('Widget', 7, 19.99, 'invalid-date');

-- 1.Load staging table   
CREATE TABLE staging_sales AS
SELECT * FROM source_sales; 

-- 2. Transform using temp table 
CREATE TEMP TABLE temp_sales AS
SELECT 
    sale_id,
    product,
    quantity,
    (quantity * price) AS total_amount,
    /* we need to use nullif because case when can compute to_date first,
     * so it doesn't work. Nullif handles invalid date and if not, converts 
     * to date. 
     */
    TO_DATE(NULLIF(sale_date_text, 'invalid-date'), 'YYYY-MM-DD') AS sale_date
FROM staging_sales; 

-- 3. create clean table 
CREATE TABLE sales_clean (
    sale_id INT PRIMARY KEY,
    product VARCHAR(50),
    quantity INT,
    total_amount NUMERIC(10,2),
    sale_date date
);

-- 4. Insert into clean table 
INSERT INTO sales_clean 
SELECT * FROM temp_sales;

SELECT * FROM sales_clean; 