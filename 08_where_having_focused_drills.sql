-- 71 Show departments where more than 3 employees have last names starting with 'S'.
SELECT DEPT FROM EMPLOYEES WHERE LAST_NAME ILIKE 'S%' GROUP BY DEPT HAVING COUNT(*) > 3;
-- 72 Show departments where employees earning over €75,000 have an average salary above €85,000.
SELECT DEPT FROM EMPLOYEES WHERE SALARY > 75000 GROUP BY DEPT HAVING AVG(SALARY) > 85000;
-- 73 Show departments that have at least one employee in each salary bracket: below €70k, €70k-€90k, and above €90k.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING (SUM(CASE WHEN SALARY < 70000 THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN SALARY BETWEEN 70000 AND 90000 THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN SALARY > 90000 THEN 1 ELSE 0 END) > 0); 
-- 74 Show departments where employees NOT in Tech have a combined salary over €100,000.
SELECT DEPT FROM EMPLOYEES WHERE DEPT <> 'Tech' GROUP BY DEPT HAVING SUM(SALARY) > 100000;
-- 75 Show departments where the number of employees earning above department average exceeds 2.
-- SKIPPED, COMPLEX CURRENTLY
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(CASE WHEN SALARY > AVG(SALARY) THEN 1 ELSE 0 END) > 2;
-- 76 Show departments where all employees earn more than €55,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING NOT(SUM(CASE WHEN SALARY < 55000 THEN 1 ELSE 0 END) > 0);
-- 77 Show departments where employees with names containing 'a' make up more than 60% of the department.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(CASE WHEN FIRST_NAME ILIKE '%A%' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) > 0.6;
-- 78 Show departments that have exactly 1 employee earning between €65,000 and €75,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(CASE WHEN SALARY BETWEEN 65000 AND 75000 THEN 1 ELSE 0 END) = 1;
-- 79 Show departments where the highest-paid non-Tech employee earns more than €70,000.
SELECT DEPT FROM EMPLOYEES WHERE DEPT <> 'Tech' GROUP BY DEPT HAVING MAX(SALARY) > 70000;
-- 80 Show departments where fewer than half the employees earn below €80,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(CASE WHEN SALARY < 80000 THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) < 0.5;

-- 71 Could also be done like this
-- SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(CASE WHEN LAST_NAME ILIKE 'S%' THEN 1 ELSE 0 END) > 3;

-- 76 Could also be done like this (better)
-- SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING NOT(SUM(CASE WHEN SALARY < 55000 THEN 1 ELSE 0 END) > 0);