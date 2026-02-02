/*
 * Exercise 5:
 * Exercise 5 — Prevent Non-Repeatable Reads
Scenario: A report reads all active loans for a member. 
Meanwhile, another transaction updates return_date. 
Observe the effect under REPEATABLE READ isolation.

*/


-- Session 2

BEGIN;

UPDATE loans
SET return_date = CURRENT_DATE
WHERE member_id = 2
AND return_date IS NULL;

COMMIT; 


-- Inside this session the update is completed 
SELECT * FROM loans WHERE return_date = CURRENT_DATE; 




