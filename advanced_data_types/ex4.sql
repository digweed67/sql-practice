/* 4️⃣ Find all users who 
 * have a newsletter preference AND have at least one 
 * skill that includes data analysis.
*/
SET search_path TO public; 

SELECT u.name 
FROM users u
WHERE u.preferences ->> 'newsletter' = 'true'
AND u.skills @> ARRAY['Data Analysis']; 