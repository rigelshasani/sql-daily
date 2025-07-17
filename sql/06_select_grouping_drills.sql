-- 51	Show departments where the maximum salary exceeds €100,000.
SELECT DEPT, MAX(SALARY) FROM EMPLOYEES GROUP BY DEPT HAVING MAX(SALARY) > 100000;
-- 52	Show departments where the average salary is less than €70,000.
SELECT DEPT, AVG(SALARY) FROM EMPLOYEES GROUP BY DEPT HAVING AVG(SALARY) < 70000;
-- 53	Show departments where the sum of all salaries is less than €200,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(SALARY) < 200000;
-- 54	Show departments where the minimum salary is greater than €50,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING MIN(SALARY) > 50000;
-- 55	Show departments that have exactly two employees.
SELECT DEPT, COUNT(*) FROM EMPLOYEES GROUP BY DEPT HAVING COUNT(*) = 2;
-- 56 Show departments where the average salary is between €70,000 and €90,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING AVG(SALARY) >= 70000 AND AVG(SALARY) <= 90000;
-- 57 Show departments that have more than one employee earning above €80,000.
SELECT DEPT, COUNT(*) FROM EMPLOYEES WHERE SALARY > 80000 GROUP BY DEPT HAVING COUNT(*) > 1;
-- 58 Show departments where the total salary bill exceeds €150,000 AND the average salary is above €75,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(SALARY) > 150000 AND AVG(SALARY) > 75000;
-- 59 Show departments where the highest-paid employee earns more than twice the lowest-paid employee in that department.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING MAX(SALARY) > 2* MIN(SALARY);
-- 60 Show departments where at least half the employees earn above €70,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(CASE WHEN SALARY>70000 THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) >= 0.5;


-- 56 Could also be HAVING AVG(SALARY) BETWEEN 70000 AND 90000;