/*
Scenario 5: Classifying employees by performance

We want to classify employees based on their latest performance review score:

1. Low: score <= 2
2. Medium: score = 3
3. High: score >= 4

Task:
- Use the latest performance review per employee (by review_date).
- Create a column called performance_level using CASE WHEN.
- Count how many employees fall into each performance_level.
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
),
performance_ranks AS (
	SELECT 
		employee_id, 
		CASE 
			WHEN performance_score <= 2 THEN 'Low'
			WHEN performance_score = 3 THEN 'Medium'
			WHEN performance_score >= 4 THEN 'High'
		END AS performance_level
	FROM latest_performance 
)

SELECT 
	pr.performance_level,
	COUNT(pr.employee_id) AS employee_count 
FROM performance_ranks pr
GROUP BY pr.performance_level
ORDER BY employee_count DESC; 
