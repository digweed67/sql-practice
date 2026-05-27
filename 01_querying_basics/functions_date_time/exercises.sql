/* ====================================================
Exercise 1 — Last 24 Hours
Task: Select all readings from the last 24 hours.

==================================================== */
SELECT 
	meter_id, 
	read_time
FROM meter_readings 
WHERE read_time >= NOW() - INTERVAL '24 hours'; 


/* ====================================================
Exercise 2 — Today’s Readings
Task: Select all readings since midnight today.

==================================================== */
SELECT 
	meter_id, 
	read_time
FROM meter_readings 
WHERE read_time >= CURRENT_DATE
ORDER BY meter_id, read_time;

/* ====================================================
Exercise 3 — Yesterday Only
Task: Select all readings that occurred yesterday.
 
==================================================== */
SELECT 
	meter_id,
	read_time
FROM meter_readings
WHERE read_time >= CURRENT_DATE - INTERVAL '1 day'
AND read_time < CURRENT_DATE
ORDER BY meter_id, read_time; 

/* ====================================================
Exercise 4 — Last 7 Days Rolling
Task: Select all readings in the last 7 days from now.

==================================================== */
SELECT 
	meter_id,
	read_time
FROM meter_readings
WHERE read_time >= NOW() - INTERVAL '7 days'
ORDER BY meter_id, read_time; 

/* ====================================================
Exercise 5 — Current Month and Previous Month
Task 5a: Select all readings for the current calendar month.
Task 5b: Select all readings for the previous calendar month.

==================================================== */
-- Current month readings
SELECT 
    meter_id,
    read_time,
    consumption
FROM meter_readings
WHERE read_time >= DATE_TRUNC('month', NOW())
  AND read_time < DATE_TRUNC('month', NOW()) + INTERVAL '1 month'
ORDER BY meter_id, read_time;

-- Previous month readings
SELECT 
    meter_id,
    read_time,
    consumption
FROM meter_readings
WHERE read_time >= DATE_TRUNC('month', NOW()) - INTERVAL '1 month'
  AND read_time < DATE_TRUNC('month', NOW())
ORDER BY meter_id, read_time;


/* ====================================================
Exercise 6 — Grouping by Day and Month
Task 6a: Aggregate total consumption per day.
Task 6b: Aggregate total consumption per month.

==================================================== */
SELECT 
	meter_id,
	DATE(read_time) AS day,
	SUM(consumption) AS total_consumption
FROM meter_readings
GROUP BY DATE(read_time)
ORDER BY day;

SELECT 
	meter_id,
	DATE_TRUNC('month', read_time) AS month,
	SUM(consumption) AS total_consumption
FROM meter_readings
GROUP BY DATE_TRUNC('month', read_time)
ORDER BY month;

/* ====================================================
Exercise 7 — Last 5 Minutes (Monitoring)
Task: Select all readings in the last 5 minutes.
Questions to think about:
  1. Which function and interval would you use?
  2. Why is this useful for real-time monitoring dashboards?
==================================================== */


SELECT 
    meter_id,
    read_time,
    consumption
FROM meter_readings
WHERE read_time >= NOW() - INTERVAL '5 minutes'
ORDER BY meter_id, read_time;

