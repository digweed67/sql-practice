/*
 * EXERCISE 2
User: user_id = 3
name = 'Charlie'
email = 'charlie@email.com'
last_login = '2024-02-10'
login_count = 1

MERGE logic:
- If user exists → update
- If user does not exist → insert

Think: UPDATE or INSERT? What happens to the users table?
doesn't exist so it creates it 
*/


MERGE INTO users AS t
USING (
	VALUES (3, 'Charlie', 'charlie@email.com', TIMESTAMP '2024-01-10', 1)
) AS s (user_id, name, email, last_login, login_count)
ON t.user_id = s.user_id

WHEN MATCHED THEN 
	UPDATE SET 
		name = s.name,
		email = s.email,
		last_login = s.last_login,
		login_count = s.login_count


WHEN NOT MATCHED THEN 
	INSERT (user_id, name, email, last_login, login_count)
	VALUES (s.user_id, s.name, s.email, s.last_login, s.login_count);


SELECT * FROM users WHERE user_id = 3; 