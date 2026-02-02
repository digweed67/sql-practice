/*
 * Exercise 4 — Simulate Dirty Read
Scenario: Two sessions:
- Session 1 updates a loan but does not commit
- Session 2 reads the same loan with different isolation levels
Observe what values are seen in READ UNCOMMITTED vs READ COMMITTED.


*/


-- Session 2
-- Postgres doesn't allow dirty reads, so won't allow this:

BEGIN ISOLATION LEVEL READ UNCOMMITTED;

SELECT *
FROM loans 
WHERE return_date = CURRENT_DATE 
AND member_id = 2; 

COMMIT; 

-- Nothing shows, the table is empty 

-- Once I have committed session 1, it does show here. 


-- Read committed behaves the same as uncommitted, is the default.
BEGIN ISOLATION LEVEL READ COMMITTED;

SELECT *
FROM loans 
WHERE return_date = CURRENT_DATE 
AND member_id = 2; 

COMMIT; 
