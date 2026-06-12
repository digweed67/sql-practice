/*
Exercise 1: User Skills ETL
- Load raw user skills data into a staging table.
- Clean names and remove rows with null or empty skills.
- Insert cleaned data into a final users table.
*/

CREATE TABLE source_users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    skills TEXT[]
);

INSERT INTO source_users (name, skills) VALUES
(' Alice ', ARRAY['SQL', 'Python']),
('Bob', NULL),
('Charlie', ARRAY[]),
('Diana', ARRAY['Java', 'SQL']);

-- create staging table 
CREATE TABLE staging_users AS
SELECT * FROM source_users; 


-- create temp table to clean 
CREATE TEMP TABLE temp_clean_users AS
	SELECT 
		id,
		TRIM(name) AS name,
		skills
	FROM staging_users
	WHERE skills IS NOT NULL 
	AND ARRAY_LENGTH(skills,1) > 0; 

-- create final clean table 
 
CREATE TABLE users_clean (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    skills TEXT[]
);

-- insert cleaned data into final table 

INSERT INTO users_clean (id, name, skills)
SELECT * FROM temp_clean_users; 
	


