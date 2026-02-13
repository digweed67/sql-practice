/*
 * 2️⃣ Find all users whose preferences indicate "dark" theme.
*/

SET search_path TO public;

SELECT u.name 
FROM users u
WHERE preferences ->> 'theme' = 'dark'; 