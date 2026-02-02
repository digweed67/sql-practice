/* 
 * Exercise 6 — Deadlock Simulation
Scenario: Two members trying to borrow books at the same time. 
Session 1 locks Book A then Book B. 
Session 2 locks Book B then Book A. 
Observe deadlock behavior.

*/


-- Session 2: lock book id 2, for update, no commit:

BEGIN; 

SELECT *
FROM books 
WHERE book_id = 2
FOR UPDATE; 

-- Now we try to lock book_id 1 and we get:
-- SQL Error [40P01]: ERROR: deadlock detected

SELECT *
FROM books
WHERE book_id = 1
FOR UPDATE;
-- CANCEL THE TEST: 
ROLLBACK; 

-- CHECK BOTH TRANSCTIONS ARE IDLE
SELECT 1; 