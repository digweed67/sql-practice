/*
A user generates a new API key.

If the key already exists:
- Set revoked = FALSE
- Update created_at to NOW()

If the key does not exist:
- Insert it with revoked = FALSE

New key: 'abc123'
user_id = 1

Write the UPSERT below.
*/

INSERT INTO api_keys(api_key, user_id, revoked, created_at)
VALUES ('abc123', 1, FALSE, NOW())
ON CONFLICT 
DO UPDATE 
	SET 
		revoked = EXCLUDED.revoked,
		created_at = EXCLUDED.created_at;
	
-- since it exists, the update runs.	
SELECT * FROM api_keys; 