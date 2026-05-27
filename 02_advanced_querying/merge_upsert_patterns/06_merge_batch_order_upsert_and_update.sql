/*
 * EXERCISE 6 
Incoming batch:

order_id | user_id | product  | quantity | status  | updated_at
100      | 1       | Keyboard | 2        | shipped | 2024-02-10
103      | 3       | Mouse    | 1        | pending | 2024-02-11

MERGE logic:
- Update existing orders if updated_at is newer
- Insert new orders if they don’t exist

Think: Which orders are updated, which inserted, final table state?
order 100 gets updated and order 103 gets inserted 
*/


MERGE INTO orders AS t
USING (
	VALUES 
		(100, 1, 'Keyboard', 2, 'shipped', TIMESTAMP '2024-02-10'),
		(103, 3, 'Mouse', 1, 'pending', TIMESTAMP '2024-02-11')
) AS s (order_id, user_id, product, quantity, status, updated_at)
ON t.order_id = s.order_id 

WHEN MATCHED AND t.updated_at < s.updated_at THEN 
	UPDATE SET  
	user_id = s.user_id,
	product = s.product,
	quantity = s.quantity,
	status = s.status,
	updated_at = s.updated_at 

WHEN NOT MATCHED THEN 
	INSERT (order_id, user_id, product, quantity, status, updated_at)
	VALUES (s.order_id, s.user_id, s.product, s.quantity, s.status, s.updated_at);


SELECT * FROM orders;


