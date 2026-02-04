DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    salesperson TEXT NOT NULL,
    region TEXT NOT NULL,
    sale_date DATE NOT NULL,
    amount INT NOT NULL
);

INSERT INTO sales (salesperson, region, sale_date, amount) VALUES
('Alice', 'North', '2023-01-01', 500),
('Alice', 'North', '2023-01-05', 700),
('Alice', 'North', '2023-01-10', 400),

('Bob', 'North', '2023-01-02', 300),
('Bob', 'North', '2023-01-08', 900),

('Carol', 'South', '2023-01-03', 800),
('Carol', 'South', '2023-01-07', 600),
('Dave', 'South', '2023-01-09', 1000);

SELECT * FROM sales; 
