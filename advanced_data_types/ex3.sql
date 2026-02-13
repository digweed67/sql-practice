/*
3️⃣ Find all orders placed in the last 7 days 
for users who have "JavaScript" skill.
*/

SET search_path TO public;
 
SELECT u.name, o.id
FROM orders o
JOIN users u
ON o.user_id = u.id 
WHERE u.skills @> ARRAY['JavaScript']
AND o.order_date >= NOW() - INTERVAL '7 days'; 