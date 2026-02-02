

/*
 * Exercise 5:
 * Exercise 5 — Prevent Non-Repeatable Reads
Scenario: A report reads all active loans for a member. 
Meanwhile, another transaction updates return_date. 
Observe the effect under REPEATABLE READ isolation.

*/

UPDATE loans 
SET return_date = NULL 
WHERE member_id = 2;

-- Session 1


BEGIN ISOLATION LEVEL REPEATABLE READ;

SELECT *
FROM loans
WHERE member_id = 2
  AND return_date IS NULL;

-- transaction left open but bc repeatable read the rows
-- don't change 

