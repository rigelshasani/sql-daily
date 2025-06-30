-- 21	Show all employees whose department names contain the letter 'e' (case-insensitive).
SELECT FIRST_NAME, LAST_NAME, DEPT FROM EMPLOYEES WHERE DEPT ILIKE '%E%';
-- 22	Show employees earning more than the average salary of their department.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPT=EMPLOYEES.DEPT);
-- 23	Show all employees who do not belong to Marketing, HR, or Sales.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES where dept <> 'Marketing' AND dept <> 'HR' AND dept <> 'Sales';
-- 24	Show employees whose last names have exactly seven characters and start with 'S'.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES where length(LAST_NAME) = 7 AND LAST_NAME ILIKE 'S%';
-- 25	Show the minimum salary per department, sorted by department name ascending.
SELECT DEPT, MIN(SALARY) FROM EMPLOYEES GROUP BY DEPT ORDER BY DEPT ASC;
    -- 26	Show all employees whose salary is equal to the maximum salary in the company.
    SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES);
-- 27	Show departments that have more than two employees.
SELECT DEPT, COUNT(*) FROM EMPLOYEES GROUP BY DEPT HAVING COUNT(*)>2;
-- 28	Show employees with NULL values in either first name or last name, return first name, last name, and department.
SELECT FIRST_NAME, LAST_NAME, DEPT FROM EMPLOYEES WHERE FIRST_NAME IS NULL OR LAST_NAME IS NULL;
-- 29	Show all distinct salary values that are below the average salary of the entire company.
SELECT DISTINCT SALARY FROM EMPLOYEES WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);
-- 30	Show employees whose first names contain the letter 'a' as the third character.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE FIRST_NAME ILIKE '___a%';

-- WILDCARD MATCHING!

-- Starts with 'A' → 'A%'
-- Ends with 'z' → '%z'
-- Contains 'ana' anywhere → '%ana%'
-- Exactly 4-letter words starting with 'S' → 'S___' (three underscores)
-- Case-insensitive last names ending with 'z' → ILIKE '%z'