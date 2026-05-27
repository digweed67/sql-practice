/*
 * EXERCISE 3
Incoming order info:

order_id = 101
user_id = 2
product = 'Mouse'
quantity = 1
status = 'shipped'
updated_at = '2024-02-05'

MERGE logic:
- If order exists → update quantity (add incoming quantity) and status if updated_at is newer
- If order does not exist → insert new order

Think: What will happen to order 101? Final quantity and status?
order 101 exists so gets updated with new quantity, status and updated at.
*/


MERGE INTO orders AS t
USING (
	VALUES (101, 2, 'Mouse', 1, 'shipped', TIMESTAMP '2024-02-05')
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


SELECT * FROM orders WHERE order_id = 101; 