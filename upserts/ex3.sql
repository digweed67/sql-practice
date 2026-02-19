/*
Your system receives product updates from an external 
service.

If product exists:
- Update name and price and updated at
- BUT ONLY if incoming updated_at is 
newer than existing updated_at

If product does not exist:
- Insert it

Incoming data:
product_id = 10
name = 'Mechanical Keyboard'
price = 70.00
updated_at = '2023-12-01'

IMPORTANT:
The existing updated_at for product 10 is '2024-01-01'


Write the UPSERT below.
*/


INSERT INTO products (product_id, name, price, updated_at)
VALUES (10, 'Mechanical Keyboard', 70.00, '2023-12-01')
ON CONFLICT (product_id)
DO UPDATE 
	SET 
		name = EXCLUDED.name,
		price = EXCLUDED.price,
		updated_at = EXCLUDED.updated_at
	WHERE products.updated_at < EXCLUDED.updated_at; 


SELECT * FROM products; 