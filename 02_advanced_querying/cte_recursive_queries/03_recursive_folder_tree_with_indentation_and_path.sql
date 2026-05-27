/*
========================================
EXERCISE 3 — Folder Structure + Indentation
========================================

GOAL:
Print the full folder hierarchy starting from 'root'.

REQUIREMENTS:
- Use a recursive CTE
- Start from folder_name = 'root'
- Include level column
- Return folder_id, folder_name(indented), parent_id, level
- Print an indented version using repeat('  ', level)
- Order results properly


*/

DROP TABLE IF EXISTS folders;

CREATE TABLE folders (
    folder_id INT PRIMARY KEY,
    folder_name TEXT NOT NULL,
    parent_id INT REFERENCES folders(folder_id)
);

INSERT INTO folders VALUES
(1, 'root', NULL),
(2, 'home', 1),
(3, 'documents', 2),
(4, 'pictures', 2),
(5, 'downloads', 1),
(6, 'work', 3);



WITH RECURSIVE folder_hierarchy AS (
	-- ANCHOR MEMBER 
	SELECT folder_id, folder_name, parent_id, 0 AS level
	FROM folders
	WHERE folder_name = 'root'
	
	
	UNION ALL 
	
	-- RECURSIVE MEMBER 
	SELECT f.folder_id, f.folder_name, f.parent_id, fh.level + 1 
	FROM folders f
	JOIN folder_hierarchy fh
		ON f.parent_id = fh.folder_id

)


SELECT 
	folder_id,
	repeat('  ', level) || folder_name AS indented_name,
	parent_id,
	level	
FROM folder_hierarchy 
ORDER BY level, folder_id; 


-- level by itself doesn't show ancestry well, just depth, to 
-- do this we will use a path array to improve the visual result

WITH RECURSIVE folder_hierarchy AS (
	-- ANCHOR MEMBER 
	SELECT 
		folder_id, 
		folder_name, 
		parent_id, 
		0 AS LEVEL,
		ARRAY[folder_id] AS path -- add a path array to store visited nodes 
	FROM folders
	WHERE folder_name = 'root'
	
	
	UNION ALL 
	
	-- RECURSIVE MEMBER 
	SELECT 
		f.folder_id, 
		f.folder_name, 
		f.parent_id, 
		fh.level + 1,
		fh.path || f.folder_id -- concatenate current id to path
	FROM folders f
	JOIN folder_hierarchy fh
		ON f.parent_id = fh.folder_id
		WHERE NOT f.folder_id = ANY(fh.path)   -- cycle protection

)


SELECT 
	folder_id,
	repeat('  ', level) || folder_name AS indented_name,
	parent_id,
	level	
FROM folder_hierarchy 
ORDER BY path; -- order by path 

-- now work appears directly under documents
-- ORDER BY path ensures parent rows appear before their children