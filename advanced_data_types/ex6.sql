/* 6️⃣ Count how many orders each user has that are 
"delivered" and include a 
product with "color" = "blue".
*/

SET search_path TO public; 
-- we use distinct to count each order once
--even if it contains various blue items 
SELECT 
	u.name, 
	COUNT(DISTINCT o.id) AS delivered_blue_orders
FROM orders o
JOIN users u ON u.id = o.user_id
JOIN products p ON p.id = ANY(o.product_ids)
WHERE status = 'delivered'
AND p.attributes ->> 'color' = 'blue'
GROUP BY u.name; 