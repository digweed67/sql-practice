/* EXERCISE 1

TASK:
Create a VIEW named v_latest_performance
that returns ONE row per employee,
containing only the MOST RECENT performance review.
*/

DROP VIEW IF EXISTS v_latest_performance CASCADE;


CREATE VIEW v_latest_performance AS 
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
	WHERE rn = 1;

