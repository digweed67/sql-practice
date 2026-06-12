/*
 * Exercise 2 — Basic Transaction
Scenario: Jane Smith wants to borrow "Moby Dick". 
Observe what happens after John Doe has borrowed it and copies are 0.

*/

BEGIN;

UPDATE books
SET copies_available = copies_available - 1
WHERE book_id = 3; 

INSERT INTO loans (member_id, book_id, loan_date, return_date)
VALUES(2, 3, CURRENT_DATE, NULL); 
  

COMMIT; 

/*
 * SQL Error [23514]: 
 * ERROR: new row for relation "books" violates check constraint "copies_non_negative"
  Detail: Failing row contains (3, Moby Dick, Herman Melville, -1).
 */


/* when trying to run this, I get another error: 
 SQL Error [25P02]: ERROR: current transaction is aborted, 
commands ignored until end of transaction block
*/ 
-- so I add: 
ROLLBACK; 

SELECT * FROM books WHERE book_id = 3; 
SELECT * FROM loans WHERE member_id = 2 AND book_id = 3;



/*
Added a constraint on books to check amount of copies available first 

*/