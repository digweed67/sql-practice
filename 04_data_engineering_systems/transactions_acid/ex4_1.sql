/*
 * Exercise 4 — Simulate Dirty Read
Scenario: Two sessions:
- Session 1 updates a loan but does not commit
- Session 2 reads the same loan with different isolation levels
Observe what values are seen in READ UNCOMMITTED vs READ COMMITTED.


*/

-- Session 1

BEGIN;
UPDATE loans 
SET return_date = CURRENT_DATE 
WHERE member_id = 2; 


-- Now I commit it:
COMMIT;  
