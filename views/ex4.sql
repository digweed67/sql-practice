-- Ex4: LOCAL WITH CHECK OPTION


DROP VIEW IF EXISTS v_engineering_local CASCADE;


CREATE VIEW v_engineering_local AS
SELECT employee_id, first_name, last_name, department_id, hire_date
FROM employees
WHERE department_id = 1
WITH CHECK OPTION;


-- Should succeed
INSERT INTO v_engineering_local (first_name, last_name, department_id, hire_date)
VALUES ('Grace', 'Hopper', 1, CURRENT_DATE);

-- Should fail
INSERT INTO v_engineering_local (first_name, last_name, department_id, hire_date)
VALUES ('Henry', 'Ford', 2, CURRENT_DATE);

-- 4️⃣ Select to verify
SELECT * FROM v_engineering_local;
