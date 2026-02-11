/*
•	Create a materialized view with aggregated consumption per meter per hour, 
then test refreshing it incrementally using CONCURRENTLY.

*/

 

SET search_path TO energy;


--create mview 
CREATE MATERIALIZED VIEW hourly_total_consumption_mv AS
SELECT 
	meter_id,
	DATE_TRUNC('hour', read_time) AS hour_bucket,
	SUM(consumption) AS total_consumption
FROM meter_readings 
GROUP BY meter_id, DATE_TRUNC('hour', read_time)
ORDER BY meter_id, DATE_TRUNC('hour', read_time); 

-- create a unique idx so there's no two meter ids with the same hour bucket
CREATE UNIQUE INDEX idx_hourly_total_unique
ON hourly_total_consumption_mv (meter_id, hour_bucket);


-- refresh  

REFRESH MATERIALIZED VIEW CONCURRENTLY hourly_total_consumption_mv; 

SELECT * FROM hourly_total_consumption_mv LIMIT 100; 