/*
 * EXERCISE 4
Incoming order:

order_id = 102
user_id = 1
product = 'Monitor'
quantity = 1
status = 'pending'
updated_at = '2024-02-06'

MERGE logic:
- If order exists → update
- If order does not exist → insert

Think: INSERT or UPDATE? What will the row look like?
doesn't exist so it will create a new row with the new values
*/


MERGE INTO orders AS t
USING (
	VALUES (102, 1, 'Monitor', 1, 'pending', TIMESTAMP '2024-02-06')
) AS s (order_id, user_id, product, quantity, status, updated_at)
ON t.order_id = s.order_id 

WHEN MATCHED THEN 
	UPDATE SET  
	user_id = s.user_id,
	product = s.product,
	quantity = s.quantity,
	status = s.status,
	updated_at = s.updated_at 

WHEN NOT MATCHED THEN 
	INSERT (order_id, user_id, product, quantity, status, updated_at)
	VALUES (s.order_id, s.user_id, s.product, s.quantity, s.status, s.updated_at);


SELECT * FROM orders WHERE order_id = 102; 
