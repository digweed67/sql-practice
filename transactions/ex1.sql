/*
 * Exercise 1 — Basic Transaction
Scenario: John Doe borrows "Moby Dick". 
Update loans and decrease copies_available by 1. Ensure changes are atomic: 
if either step fails, nothing should be changed.

*/

BEGIN;

UPDATE books
SET copies_available = copies_available - 1
WHERE book_id = 3; 

INSERT INTO loans (member_id, book_id, loan_date, return_date)
VALUES(1, 3, CURRENT_DATE, NULL); 
  

COMMIT; 

SELECT * FROM books WHERE book_id = 3; 
SELECT * FROM loans WHERE member_id = 1 AND book_id = 3;


/*
Added a constraint on books to check amount of copies available first 

*/