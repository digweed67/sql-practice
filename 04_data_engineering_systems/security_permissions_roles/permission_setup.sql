
/*
Scenario 1: Role and Permission Setup + Cascading Grants
- Create table employees(emp_id, name, salary, dept_id)
- Create roles: read_only, hr_role
- Create users: alice, bob, charlie
- read_only role: SELECT on employees only
- hr_role: SELECT and UPDATE on employees
- Assign read_only to alice, hr_role to bob
- bob grants SELECT with GRANT OPTION on employees to charlie
Tasks:
- Write all CREATE and GRANT statements to set up
- Revoke SELECT from bob — what happens to charlie's permissions? Explain
- Suggest improvements to reduce risk
*/
-- Clean setup
DROP TABLE IF EXISTS employees CASCADE;
DROP ROLE IF EXISTS read_only;
DROP ROLE IF EXISTS hr_role;
DROP ROLE IF EXISTS alice;
DROP ROLE IF EXISTS bob;
DROP ROLE IF EXISTS charlie;

-- Create table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name TEXT,
    salary INT,
    dept_id INT
);

-- Create roles
CREATE ROLE read_only;
CREATE ROLE hr_role;

-- Grant permissions to roles
GRANT SELECT ON employees TO read_only;
GRANT SELECT, UPDATE ON employees TO hr_role WITH GRANT OPTION;

-- Create users
CREATE USER alice WITH PASSWORD 'alice_pass';
CREATE USER bob WITH PASSWORD 'bob_pass' NOCREATEDB NOCREATEROLE;
CREATE USER charlie WITH PASSWORD 'charlie_pass';

-- Assign roles
GRANT read_only TO alice;
GRANT hr_role TO bob;

-- Simulate Bob executing the grant
SET ROLE bob;

GRANT SELECT ON employees TO charlie WITH GRANT OPTION;

RESET ROLE;
/*
 * Because the GRANT was executed while the role was set to bob,
 * PostgreSQL records bob as the grantor of Charlie's SELECT privilege.
 *
 * This creates a dependency chain:
 * hr_role → bob → charlie
 *
 * When attempting to revoke SELECT from hr_role without CASCADE,
 * PostgreSQL raises an error because Charlie's privilege depends
 * on Bob's grant, which in turn depends on hr_role.
 *
 * Therefore, the revoke must use CASCADE to remove all dependent
 * privileges in the chain.
 * Sometimes revoke works without cascade if the grantor is not in the 
 * depedency chain (Ie. Charlie was granted by postgres not by Bob)
 */
-- Revoke privilege from hr_role
REVOKE SELECT ON employees FROM hr_role CASCADE;

-- Check privileges
SELECT grantor, grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_name = 'employees';