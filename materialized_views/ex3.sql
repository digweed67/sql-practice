/* ====================================================
Exercise 3 — Daily Aggregation Table
Task: Create a table to store daily total consumption per meter and populate it.

Questions to think about:
  1. How is this different from a materialized view?
  this is a real table, a materialized view is a query. You control how and when it's updated and it 
  it does not auto recompute everything, unlike a mv that needs a refresh.
  2. How would you update this table incrementally without recalculating all data?
  by inserting days that don't exist or days newer than the max date on the table
==================================================== */
-- create a table to store daily consumption
SET search_path TO energy;

CREATE TABLE daily_meter_summary (
		meter_id INT, 
		date DATE, 
		total_consumption NUMERIC,
		PRIMARY KEY(meter_id, date)
);

-- insert into the table 
INSERT INTO daily_meter_summary(meter_id, date, total_consumption)
SELECT 
	meter_id,
	DATE(read_time) AS date,
	SUM(consumption) AS total_consumption
FROM meter_readings 
GROUP BY meter_id, DATE(read_time); 


-- create an index to access data faster 
CREATE INDEX idx_daily_meter_summary 
ON daily_meter_summary(date); 

SELECT * 
FROM daily_meter_summary 
WHERE date = '2026-01-15'; 	