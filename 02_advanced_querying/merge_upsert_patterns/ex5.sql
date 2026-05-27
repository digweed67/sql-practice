/*
 * EXERCISE 5 — 
 *
 * Business rule:
 * 1. Remove users who haven’t logged in since '2023-12-31' (target table only)
 * 2. Update existing users with latest login info from external system
 * 3. Insert new users if they don’t exist
 *
 * Source data from external system:
 *  user_id = 2, name = 'Bob', email = 'bob@email.com', last_login = '2024-01-05', login_count = 6
 *  user_id = 4, name = 'David', email = 'david@email.com', last_login = '2024-02-01', login_count = 1
 *
 * MERGE logic:
 * - WHEN MATCHED AND t.last_login < '2024-01-01' THEN DELETE
 * - WHEN MATCHED THEN UPDATE with latest source info
 * - WHEN NOT MATCHED THEN INSERT new users
 *
 * Think:
 * - Which users will be deleted? none because they are all 2024 onwards
 * - Which users will be updated? Bob with a login count of 6
 * - Which users will be inserted? David 
 */


MERGE INTO users AS t
USING (
	VALUES 
		(2, 'Bob', 'bob@email.com', TIMESTAMP '2024-01-05', 6),
		(4, 'David', 'david@email.com', TIMESTAMP '2024-02-01', 1)
) AS s (user_id, name, email, last_login, login_count)
ON t.user_id = s.user_id 

WHEN MATCHED AND t.last_login < TIMESTAMP '2024-01-01' THEN 
	DELETE

WHEN MATCHED THEN 
	UPDATE SET 
		name = s.name,
		email = s.email,
		last_login = s.last_login,
		login_count = s.login_count

WHEN NOT MATCHED THEN 
		INSERT (user_id, name, email, last_login, login_count)
		VALUES (s.user_id, s.name, s.email, s.last_login, s.login_count); 


SELECT * FROM users; 
