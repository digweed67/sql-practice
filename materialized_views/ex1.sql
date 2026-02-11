/* ====================================================
Exercise 1 — Regular View
Task: Create a view that shows total consumption per meter.
  * Think about performance with millions of rows 
  Performance with millions of rows would be expensive
  * Think about how up-to-date it is with continuous inserts
  Since it's a regular view it would be up to date, but for faster queries with large
  datasets a materialized view could be best (with slight delays in data freshness)
==================================================== */
SET search_path TO energy;

CREATE VIEW total_consumption_v AS
SELECT 
	meter_id,
	SUM(consumption) AS total_consumption
FROM meter_readings
GROUP BY meter_id;


SELECT * FROM total_consumption_v ORDER BY meter_id LIMIT 10; 