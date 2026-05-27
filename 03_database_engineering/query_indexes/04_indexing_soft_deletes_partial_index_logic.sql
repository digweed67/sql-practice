/*
 * 🔥 Scenario 4 — Soft Deletes (Very Common in Real Apps)
Table:
products (
  id SERIAL,
  name TEXT,
  price NUMERIC,
  deleted_at TIMESTAMP NULL
);
Most queries:
SELECT *
FROM products
WHERE deleted_at IS NULL;
95% of rows are NOT deleted.
Questions:
•	Should you create an index? if 95% of the rows are not null, 
then the index still would need to go through 95% of the rows, the filtering
is minimal, so it's probably pointless for how costly the index is
•	If yes, what kind?
•	Would a partial index help?no because a partial index
is useful when we need to filter further, when the subset we are filtering is small
then it is useful, but in this case is too large (95%). 
•	Why might a normal index not be very useful?
no, because we are hardly filtering, so not saving time and using extra storage 
and write overhead, so it's not worth it. 

*/