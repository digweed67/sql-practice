/*
A shipment arrives.

If inventory row exists:
- Increase quantity by incoming amount

If it does not exist:
- Insert with that quantity

Shipment:
product_id = 10
quantity = 3

Write the UPSERT below.
*/

INSERT INTO inventory(product_id, quantity)
VALUES (10, 3)
ON CONFLICT (product_id)
DO UPDATE 
	SET quantity = inventory.quantity + EXCLUDED.quantity;

-- it exits so quantity has been updated to 8 (5+3).
SELECT * FROM inventory; 
