-- 151 Using a CTE named high_paid that filters employees to salary > 70000, return each
-- department_id with the count of high-paid employees, ordered by count descending.
WITH high_paid AS (
    SELECT * 
    FROM EMPLOYEES
    WHERE SALARY > 70000
)
SELECT DEPT, COUNT(*) AS COUNTIT
FROM high_paid 
GROUP BY DEPT 
ORDER BY COUNTIT DESC, DEPT ASC;

-- 152 Using two CTEs, return a report that shows for each department:
-- dept, total number of employees, number of high-paid employees (salary > 70000),
-- and the percentage of high-paid employees.
-- Order the results by percentage descending, then department ascending.

WITH high_paid AS (
    SELECT * 
    from employees 
    where salary > 70000
),
pct_hp AS (
    SELECT DEPT, COUNT(*) AS HP_COUNT
    FROM high_paid
    GROUP BY DEPT 
)
    SELECT e.DEPT, COUNT(*) AS COUNTALL, COALESCE(p.hp_count, 0) AS hp_count, ((COALESCE(p.hp_count, 0) * 1.0 / COUNT(*))*100) as PCTG
FROM EMPLOYEES e 
LEFT JOIN PCT_HP p
ON e.dept = p.dept 
GROUP BY e.dept, p.hp_count
ORDER BY PCTG DESC, DEPT ASC;

-- 153 Using one CTE, rank employees within each department by salary (highest first).
-- Return only the top earner per department: dept, full_name, salary.
-- Break ties by higher emp_id. Order the final results by dept ascending.

WITH ranked AS (
    SELECT FIRST_NAME, LAST_NAME, DEPT, SALARY, 
    ROW_NUMBER() OVER(
        PARTITION BY DEPT 
        ORDER BY SALARY DESC, id desc
        ) as rn
    FROM employees
)
SELECT
  COALESCE(NULLIF(TRIM(dept), ''), '(Unknown)') AS dept_label,
  first_name,
  last_name,
  COALESCE(salary, 0) AS salary
FROM ranked
WHERE rn <= 2
ORDER BY dept_label ASC;

-- 154 Using one CTE, calculate the average salary per department.
-- Then in the main query, return each employee’s dept, name, salary,
-- and a column showing how much their salary is above or below
-- their department’s average.
-- Order the results by dept ascending, then salary descending.
with dept_avg AS (
    SELECT DEPT, AVG(SALARY) AS AVGSAL
    FROM EMPLOYEES 
    GROUP BY DEPT  
)
SELECT E.DEPT, E.FIRST_NAME, E.LAST_NAME, E.SALARY, A.AVGSAL AS "AVERAGE DEPT SALARY", (E.SALARY - A.AVGSAL) AS DIFFERENCE
FROM EMPLOYEES E 
LEFT JOIN dept_avg A
ON E.DEPT = A.DEPT
ORDER BY DEPT ASC, SALARY DESC;


-- 155 Without using a CTE, show each employee’s dept, name, salary,
-- the department’s average salary, and (salary - dept_avg).
-- Use a window function so every row keeps its detail.
-- Order by dept ASC, salary DESC.

SELECT DEPT, FIRST_NAME, LAST_NAME, SALARY, 
AVG(SALARY) OVER(PARTITION BY DEPT) AS AVG_SAL, (SALARY - AVG(SALARY) OVER(PARTITION BY DEPT)) AS DIFFERENCE
FROM EMPLOYEES E 
ORDER BY DEPT ASC, SALARY DESC