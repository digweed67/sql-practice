
-- Reset schema
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS members CASCADE;
DROP TABLE IF EXISTS loans CASCADE;

-- Members
CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    join_date DATE NOT NULL
);

-- Books
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    copies_available INT NOT NULL
);

-- Loans
CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    member_id INT NOT NULL REFERENCES members(member_id),
    book_id INT NOT NULL REFERENCES books(book_id),
    loan_date DATE NOT NULL,
    return_date DATE
);

-- Seed data
INSERT INTO members (name, join_date) VALUES
('John Doe', '2020-01-15'),
('Jane Smith', '2021-06-20'),
('Alice Green', '2022-03-10');

INSERT INTO books (title, author, copies_available) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 3),
('1984', 'George Orwell', 2),
('Moby Dick', 'Herman Melville', 1);

INSERT INTO loans (member_id, book_id, loan_date, return_date) VALUES
(1, 1, '2023-01-01', '2023-01-20'),
(2, 2, '2023-02-15', NULL);


ALTER TABLE books
ADD CONSTRAINT copies_non_negative
CHECK (copies_available >= 0);

SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM loans;