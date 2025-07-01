-- 41	Show employees whose department names start with 'T' and end with 'h' (case-insensitive).
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE DEPT ILIKE 'T%' and DEPT ILIKE '%h';
-- 42*	Show employees earning less than the maximum salary in their own department.
SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEES WHERE DEPT=EMPLOYEES.DEPT)
-- 43	Show departments that have exactly two employees.
SELECT DEPT, COUNT(*) FROM EMPLOYEES GROUP BY DEPT HAVING COUNT(*) = 2;
-- 44	Show all employees not in HR or Sales and whose salary is above €60,000.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE (DEPT <> 'Sales' and DEPT <> 'HR') AND SALARY > 60000;
-- 45	Show employees whose first names have 'a' as the third character and end with 'n'.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE FIRST_NAME ILIKE '___a%' and FIRST_NAME ILIKE '%N';
-- 46	Show all distinct salaries above the average salary of the Tech department.
SELECT DISTINCT SALARY FROM EMPLOYEES WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPT = 'Tech');
-- 47*	Show the minimum salary per department where that minimum salary is below €70,000.
SELECT DEPT, MIN(SALARY) FROM EMPLOYEES GROUP BY DEPT HAVING MIN(SALARY) < 70000;
-- 48	Show employees where exactly one of first name or last name is NULL.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE (FIRST_NAME IS NULL OR LAST_NAME IS NULL) AND NOT (FIRST_NAME IS NULL AND LAST_NAME IS NULL);
-- 49	Show departments that have no employees earning above €90,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING MAX(SALARY) < 90000;
-- 50	Show employees earning exactly the minimum salary in the company.
SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES);
