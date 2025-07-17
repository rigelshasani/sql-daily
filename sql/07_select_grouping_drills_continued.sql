-- 61 Show departments where more than 2 employees earn between €60,000 and €80,000.
SELECT DEPT FROM EMPLOYEES WHERE SALARY BETWEEN 60000 AND 80000 GROUP BY DEPT HAVING COUNT(*) > 2;
-- 62 Show departments where the average salary of employees earning over €70,000 exceeds €85,000.
SELECT DEPT FROM EMPLOYEES WHERE SALARY > 70000 GROUP BY DEPT HAVING AVG(SALARY) > 85000;
-- 63 Show departments that have at least 2 employees, where the lowest salary is above €65,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING MIN(SALARY) > 65000 AND COUNT(*) >= 2;
-- 64 Show departments where employees with names starting with 'A' or 'E' have an average salary above €75,000.
SELECT DEPT FROM EMPLOYEES WHERE FIRST_NAME ILIKE 'A%' OR FIRST_NAME ILIKE 'E%' GROUP BY DEPT HAVING AVG(SALARY) > 75000;
-- 65 Show departments where the department's total salary exceeds €250,000
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(SALARY) > 250000;
-- 66 Show departments where no employee earns exactly €60,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(CASE WHEN SALARY = 60000 THEN 1 ELSE 0 END) = 0;
-- 67 Show departments where the salary range (max - min) is greater than €40,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING MAX(SALARY) - MIN(SALARY) > 40000;
-- 68 Show departments where more than 75% of employees earn above the company average salary.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(CASE WHEN SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) > 0.75;
-- 69 Show departments that have both: someone earning above €90,000 AND someone earning below €70,000.
SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(CASE WHEN SALARY > 90000 THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN SALARY<70000 THEN 1 ELSE 0 END) > 0;
-- 70 Show departments where the second-highest salary is above €80,000.
-- SKIPPED REQUIRES ADVANCED TECHNIQUES
-- best try: SELECT DEPT FROM EMPLOYEES GROUP BY DEPT HAVING SUM(CASE WHEN SALARY < MAX(SALARY) AND SALARY > 80000 THEN 1 ELSE 0 END) > 0;