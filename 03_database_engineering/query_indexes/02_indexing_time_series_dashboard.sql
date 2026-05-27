/* Scenario 2 — IoT Recent Data Dashboard

Dashboard query runs every 10 seconds:
SELECT *
FROM meter_readings
WHERE read_time >= NOW() - INTERVAL '5 minutes'
ORDER BY read_time DESC;
Questions:
•	What index would you create? single
•	Single column or composite? just single column for the read time
but DESC bc DESC is important to get latest 
•	Would a partial index make sense? no bc we 
dont want a subset of rows we want them all, we want 
a covering idx if the query always selects the same columns
•	Any performance tradeoffs? the query is really fast, 
but the index takes extra space and with frequent inserts it
becomes slower
*/ 

CREATE TABLE IF NOT EXISTS meter_readings (
  meter_id INT,
  read_time TIMESTAMP,
  consumption NUMERIC
);

INSERT INTO meter_readings (meter_id, read_time, consumption)
SELECT
    (random() * 1000)::INT,                                
    NOW() - (random() * INTERVAL '7 days'),               
    ROUND((random() * 10)::NUMERIC, 2)                               
FROM generate_series(1, 1000000);

-- before index: Execution Time: 400.708 ms
EXPLAIN ANALYZE
SELECT *
FROM meter_readings
WHERE read_time >= NOW() - INTERVAL '5 minutes'
ORDER BY read_time DESC;


-- after index: Execution Time: 0.463 ms
CREATE INDEX meter_readings_covering_idx
ON meter_readings(read_time DESC)
INCLUDE (meter_id, consumption);