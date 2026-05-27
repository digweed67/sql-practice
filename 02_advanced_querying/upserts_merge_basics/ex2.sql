/*
A user finishes a game.

If user exists:
- Update highest_score ONLY IF the new score is greater
- Do NOT overwrite with lower score

If user does not exist:
- Insert user with:
    total_logins = 0
    last_login = NULL
    highest_score = new score

User: user_id = 1
New score: 50

Write the UPSERT below.
*/

INSERT INTO user_stats (user_id, total_logins, last_login, highest_score)
VALUES (1, 0, NULL, 50)
ON CONFLICT (user_id)
DO UPDATE 
	SET highest_score = EXCLUDED.highest_score
	WHERE user_stats.highest_score < EXCLUDED.highest_score;


-- upsert fails and nothing happens because condition failed
SELECT * FROM user_stats; 