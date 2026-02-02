/* 
 * Exercise 6 — Deadlock Simulation
Scenario: Two members trying to borrow books at the same time. 
Session 1 locks Book A then Book B. 
Session 2 locks Book B then Book A. 
Observe deadlock behavior.

*/


-- Session 1: lock book id 1, for update, no commit:

BEGIN; 

SELECT *
FROM books 
WHERE book_id = 1
FOR UPDATE; 

-- Now try to look book_id 2 , but it says execute query 
-- and keeps waiting, query blocked 

SELECT *
FROM books
WHERE book_id = 2
FOR UPDATE;
-- CANCEL THE TEST:
ROLLBACK;

-- CHECK BOTH TRANSACTIONS ARE IDLE:
SELECT 1; 