/*
 * 5️⃣ Find all pending 
 * orders that include at least 
 * one product tagged "gift".
*/
SET search_path TO public; 

SELECT *
FROM orders o
JOIN products p
ON p.id = ANY(o.product_ids) 
WHERE status = 'pending'
AND p.tags @> ARRAY['gift'];