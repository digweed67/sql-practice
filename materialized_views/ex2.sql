/* ====================================================
Exercise 2 — Materialized View
Task: Create a materialized view for total consumption per meter for January.

Questions to think about:
  1. How often should you refresh this materialized view?
  never because once the month has passed it won't update again
  2. What happens if new readings are inserted after the last refresh?
  they won't appear because the last refresh is like a snapshot (unless we refresh again)
==================================================== */
SET search_path TO energy;

CREATE MATERIALIZED VIEW jan_total_consumption_mv AS
SELECT 
	meter_id,
	SUM(consumption) AS total_consumption
FROM meter_readings
WHERE read_time >= '2026-01-01 00:00:00'
  AND read_time <  '2026-02-01 00:00:00'
GROUP BY meter_id;

SELECT * 
FROM jan_total_consumption_mv
ORDER BY total_consumption DESC
LIMIT 10;

