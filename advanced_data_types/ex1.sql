/*
Advanced Practice Scenarios

1️⃣ Find all users who have both "Python" and "SQL" as skills.

*/
SET search_path TO public; 

SELECT 
	u.name
FROM users u
WHERE u.skills @> ARRAY['Python', 'SQL']; 
