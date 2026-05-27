/* Scenario 1 — Login System

Query executed on every login:
SELECT id, password_hash
FROM users
WHERE email = 'user@email.com';
Questions:
•	What index would you create? see below
•	Would it be unique? yes
•	Why? bc emails can't be duplicated
Bonus:
What if you also frequently query:
WHERE email = 'user@email.com'
AND is_active = true;
Would that change your index design? no
because email is already unique, so it wouldn't really add 
much value to create a composite index here
*/

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  email TEXT,
  password_hash TEXT,
  created_at TIMESTAMP,
  is_active BOOLEAN
);

INSERT INTO users (email, password_hash, created_at, is_active)
SELECT 
    'user' || g || '@email.com',
    md5(random()::text),
    NOW() - (random() * INTERVAL '365 days'),
    (random() > 0.1)
FROM generate_series(1, 1000000) g;

-- before index Execution Time: 230.244 ms
EXPLAIN ANALYZE
SELECT id, password_hash
FROM users
WHERE email = 'user500000@email.com';

-- after index Execution Time: 0.445 ms
CREATE UNIQUE INDEX idx_users_email 
ON users(email); 


