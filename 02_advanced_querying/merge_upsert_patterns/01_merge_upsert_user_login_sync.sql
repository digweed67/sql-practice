/*
 * EXERCISE 1
An external system sends updated login info:

User: user_id = 1
last_login = '2024-02-01'
login_count = 10

MERGE logic:
- If user exists → update last_login and login_count
- If user does not exist → insert new row

Think: will it UPDATE or INSERT? What will the final login_count be for Alice?
Alice updates the login count to 10.
*/

MERGE INTO users AS t
USING (
    VALUES (
        1,
        'Alice',
        'alice@gmail.com',
        TIMESTAMP '2024-02-01', -- cast type 
        10
    )
) AS s (user_id, name, email, last_login, login_count)
ON t.user_id = s.user_id
WHEN MATCHED THEN 
    UPDATE SET 
        last_login = s.last_login,
        login_count = s.login_count
WHEN NOT MATCHED THEN
    INSERT (user_id, name, email, last_login, login_count)
    VALUES (s.user_id, s.name, s.email, s.last_login, s.login_count);



SELECT * FROM users WHERE user_id = 1; 