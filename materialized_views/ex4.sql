/* Exercise 4 — Recent Data Query
Task: Query the last 24 hours of readings per meter.

Questions to think about:
  1. Which approach is faster: querying the raw table, using a materialized view, or using a daily summary table?
  querying the raw table because we get the latest/current data
  with a mv we would have to constantly refresh it 
  with a daily summary table, we wouldn't have the hourly, just the daily.
  2. Would a materialized view make sense for continuously updated recent data?
  no, because it creates a snapshot of data in time, if you need it to be up to date
  you need to refresh it, and with ever changing data, the refresh would have 
  to be constant.
  */

SET search_path TO energy;
-- create an index on reading time DESC so latest data gets scanned first
CREATE INDEX idx_meter_readings_read_time 
ON meter_readings(read_time DESC);

SELECT 
	meter_id,
	read_time,
	consumption
FROM meter_readings
WHERE read_time >= NOW() - INTERVAL '1 day'; 

 

