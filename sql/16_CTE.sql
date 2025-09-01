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
ORDER BY DEPT ASC, SALARY DESC;

-- 156 Using a recursive CTE, generate a sequence from 1 to 10.
-- Return just one column called 'level_num'.
-- Order by level_num ascending.

WITH RECURSIVE countIt AS (
    SELECT 1 AS start_val
    UNION ALL 
    SELECT start_val+1 
    from countIt
    WHERE start_val < 10
)
SELECT start_val
FROM countIt
ORDER BY start_val ASC;


-- 157 Using a CTE with multiple aggregations, find departments where:
-- - Average salary > 60000 AND
-- - Total employees >= 3 AND  
-- - Highest salary >= 80000
-- Return dept, avg_salary, employee_count, max_salary.
-- Order by avg_salary descending.

WITH aggros AS (
    SELECT DEPT, AVG(salary) AS avg_sal, COUNT(*) AS cnt, MAX(salary) AS max_sal
    FROM EMPLOYEES
    GROUP BY DEPT 
    HAVING AVG(salary) > 60000 AND MAX(salary) > 80000 AND COUNT(*) >= 3
)
select *
from aggros 
order by avg_sal DESC;

-- 158 Using nested CTEs (CTE that references another CTE), first identify
-- departments with above-average headcount. Then from those departments only,
-- show each employee's name, salary, and rank by salary within their dept.
-- Order by dept ASC, rank ASC.

WITH high_hdc AS (
    SELECT DEPT, COUNT(*) AS cnt
    FROM EMPLOYEES
    WHERE dept is not null 
    GROUP BY DEPT
),
avg_hdc AS (
    SELECT AVG(cnt) as av
    FROM high_hdc
),
abv_avg_depts AS (
    SELECT h.dept, h.cnt, a.av
    FROM avg_hdc a
    CROSS JOIN high_hdc h
    WHERE a.av < h.cnt
)
SELECT E.DEPT, E.FIRST_NAME, E.LAST_NAME, E.SALARY, RANK() OVER(PARTITION BY(A.DEPT) ORDER BY E.SALARY DESC) AS SALARY_RANK
FROM abv_avg_depts A
JOIN employees E
ON A.dept = E.dept
ORDER BY A.DEPT ASC;


-- 159 Using a CTE with window functions, calculate a running total of salaries
-- within each department (ordered by employee ID). 
-- Return dept, emp_id, first_name, salary, running_total.
-- Order by dept ASC, emp_id ASC.

WITH running_total AS (
    SELECT ID, FIRST_NAME, SALARY, DEPT, SUM(SALARY) OVER(PARTITION BY(DEPT) ORDER BY ID ASC) AS running_total
    FROM employees
    WHERE DEPT IS NOT NULL AND SALARY IS NOT NULL
)
SELECT *
FROM running_total
ORDER BY DEPT ASC, ID ASC;


-- 160 Using a CTE, identify the department(s) with the highest total payroll.
-- Then return ALL employees from those top-spending departments,
-- showing dept, name, salary, and what percentage of the department's
-- total payroll each employee represents.
-- Order by dept ASC, salary_percentage DESC.

WITH ordered_payrolls AS (
    SELECT DEPT, SUM(SALARY) AS summed
    FROM EMPLOYEES
    WHERE DEPT IS NOT NULL
    GROUP BY DEPT
),
highest_payroll as (
    select MAX(summed) as max_sal
    from ordered_payrolls

),
departments_maxed as (
    select o.dept, h.max_sal
    from ordered_payrolls o
    join highest_payroll h
    on o.summed = h.max_sal
)
SELECT E.DEPT, E.FIRST_NAME, E.LAST_NAME, E.SALARY, H.max_sal, ROUND(((E.SALARY * 1.0/H.max_sal) * 100), 2) AS pct
FROM departments_maxed H
JOIN EMPLOYEES E 
ON h.dept = e.dept
ORDER BY DEPT ASC, PCT DESC;