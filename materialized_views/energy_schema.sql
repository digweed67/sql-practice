-- ⚠️ Drop existing schema if exists (including all tables, views, MVs)
DROP SCHEMA IF EXISTS energy CASCADE;

-- 1️⃣ Create schema
CREATE SCHEMA energy;

-- Use the schema
SET search_path TO energy;

-- 2️⃣ Create tables
CREATE TABLE meters (
    meter_id SERIAL PRIMARY KEY,
    location TEXT NOT NULL
);

CREATE TABLE meter_readings (
    reading_id SERIAL PRIMARY KEY,
    meter_id INT REFERENCES meters(meter_id),
    read_time TIMESTAMP NOT NULL,
    consumption NUMERIC NOT NULL
);

-- 3️⃣ Insert sample meters
INSERT INTO meters(location)
SELECT 'Location ' || i
FROM generate_series(1, 50) AS i;

-- 4️⃣ Insert sample readings (simulate 1 month of hourly readings per meter)
INSERT INTO meter_readings(meter_id, read_time, consumption)
SELECT 
    m.meter_id,
    timestamp '2026-01-01 00:00:00' + (i || ' hours')::interval,
    ROUND((random() * 10 + 1)::numeric, 2)
FROM meters m
CROSS JOIN generate_series(0, 24*30-1) AS i;  -- 30 days of hourly readings

-- ✅ Optional: verify data
SELECT COUNT(*) FROM meter_readings;
SELECT * FROM meters LIMIT 10;
SELECT * FROM meter_readings LIMIT 10;
