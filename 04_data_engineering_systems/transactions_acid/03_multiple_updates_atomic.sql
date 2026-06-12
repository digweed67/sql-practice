/* 
 * Exercise 3 — Multiple Updates in One Transaction
Scenario: Jane Smith returns "1984" and John Doe borrows it in the same transaction. 
Update return_date for Jane and insert a new loan for John. Ensure atomicity.

*/

BEGIN; 

-- Jane returns book so we register it
UPDATE loans
SET return_date = CURRENT_DATE
WHERE member_id = 2
AND book_id = 2; 

-- So there's +1 books now in the library 
UPDATE books 
SET copies_available = copies_available + 1
WHERE book_id = 2; 

-- John borrows book  so register that
INSERT INTO loans (member_id, book_id, loan_date, return_date)
VALUES(1, 2, CURRENT_DATE, NULL);


-- So there's -1 book 
UPDATE books
SET copies_available = copies_available - 1
WHERE book_id = 2;


COMMIT; 

SELECT * FROM loans;
SELECT * FROM books; 

