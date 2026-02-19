/*
A user logs in.

If user exists:
- Increase total_logins by 1
- Update last_login to NOW()

If user does not exist:
- Insert them with total_logins = 1
- last_login = NOW()
- highest_score = 0

User logging in: user_id = 1

Write the UPSERT below.
*/


INSERT INTO user_stats (user_id, total_logins, last_login, highest_score)
VALUES (1, 1, NOW(), 0)
ON CONFLICT (user_id)
DO UPDATE 
SET total_logins = user_stats.total_logins + 1,
	last_login = EXCLUDED.last_login; 


SELECT * FROM user_stats; 