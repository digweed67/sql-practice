/*
Scenario: Latest Performance Review Status

We want to determine whether each employee currently needs a performance review.

Definition:
- An employee is marked as 'Needs Review' if their latest performance_score is NULL.
- Otherwise, they are marked as 'Reviewed'.

Task:
- Use the performance_reviews table.
- Identify the latest performance review per employee (based on review_date).
- Ensure only one row per employee (no duplicates).
- Create a column called review_status using CASE WHEN:
    - 'Needs Review' if performance_score IS NULL
    - 'Reviewed' otherwise
- Return employee_id, latest performance_score, and review_status.
*/


WITH latest_performance AS (
	SELECT 
		employee_id,
		review_date,
		performance_score
	FROM (SELECT 
		employee_id,
		review_date,
		performance_score,
		ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rn
		FROM performance_reviews
	) p
	WHERE rn = 1 
)

SELECT
	lp.employee_id,
	lp.performance_score,
	CASE 
		WHEN lp.performance_score IS NULL THEN 'Needs Review'
		ELSE 'Reviewed'	
	END AS review_status
FROM latest_performance lp; 
	