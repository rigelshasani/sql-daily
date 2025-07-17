-- 31	Show all employees whose department names end with 't' (case-insensitive).
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE DEPT ILIKE '%T';
-- 32	Show all employees earning less than the minimum salary in the Sales department.
SELECT FIRST_NAME, LAST_NAME, SALARY, (SELECT MIN(SALARY) FROM EMPLOYEES WHERE DEPT = 'Sales') AS MIN_SALARY_SALES FROM EMPLOYEES WHERE SALARY < (SELECT MIN(SALARY) FROM EMPLOYEES WHERE DEPT = 'Sales');
-- 33	Show employees not in 'Tech' or 'Marketing'.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE DEPT <> 'Tech' and DEPT <> 'Marketing';
-- 34	Show employees whose first names are exactly 5 characters long and end with 'a'.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE FIRST_NAME ILIKE '____a';
-- 35	Show the maximum salary per department, sorted by maximum salary descending.
SELECT DEPT, MAX(SALARY) AS MAXSAL FROM EMPLOYEES GROUP BY DEPT ORDER BY MAXSAL DESC;
-- 36	Show employees whose salary is equal to the minimum salary in their own department.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES WHERE DEPT=EMPLOYEES.DEPT);
-- 37	Show departments that have fewer than three employees.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING COUNT(*) < 3;
-- 38	Show employees where either the first name or the last name is NULL, but not both.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE ((FIRST_NAME IS NULL OR LAST_NAME IS NULL) AND NOT(FIRST_NAME IS NULL AND LAST_NAME IS NULL));
-- 39	Show all distinct salary values above the company-wide average salary.
SELECT DISTINCT SALARY FROM EMPLOYEES WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);
-- 40	Show employees whose first names contain the letter 'o' as the second character.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE FIRST_NAME ILIKE '_o%';



-- 32 can also be done like this(more efficient on big data sets)

-- Common Table Expression (CTE)

    -- WITH SalesMin AS (
    --     SELECT MIN(SALARY) AS MIN_SALES_SALARY
    --     FROM EMPLOYEES
    --     WHERE DEPT = 'Sales'
    -- )
    -- SELECT 
    --     E.FIRST_NAME, 
    --     E.LAST_NAME, 
    --     E.SALARY, 
    --     S.MIN_SALES_SALARY
    -- FROM EMPLOYEES E, SalesMin S
    -- WHERE E.SALARY < S.MIN_SALES_SALARY;

-- 33 can also be improved like this:

-- ORIGINAL
-- WHERE DEPT <> 'Tech' and DEPT <> 'Marketing';
---- IMPROVED
---- WHERE DEPT NOT IN ('Tech', 'Marketing')
