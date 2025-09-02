-- 17_review_part1.sql

-- 161 Basic filtering review: Return employees hired after 2020
-- with salary between 50000 and 100000, ordered by hire_date.

SELECT * 
from EMPLOYEES
where EXTRACT(YEAR from hire_date) > 2020 and 
      SALARY BETWEEN 50000 AND 100000
ORDER BY HIRE_DATE;

-- 162 String pattern reinforcement: Find employees whose first_name
-- has 'a' as the 3rd character and last_name starts with 'S'.

SELECT *
from employees
where first_name ILIKE '__a%' AND last_name ILIKE 'S%';

-- 163 Aggregation fundamentals: For each department, show employee count,
-- average salary, and total payroll. Order by total payroll DESC.

SELECT DEPT, COUNT(*), AVG(SALARY), SUM(SALARY)
FROM EMPLOYEES
WHERE DEPT IS NOT NULL
GROUP BY DEPT
ORDER BY SUM(SALARY) DESC;

-- 164 HAVING clause practice: Return departments where the average salary
-- is above 70000 and employee count is at least 5.

SELECT DEPT, AVG(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPT 
HAVING AVG(SALARY) > 70000 AND COUNT(*) >= 5;

-- 165 Scalar subquery review: List employees earning more than
-- the company-wide average salary. Include their salary and the company avg.

SELECT * , (SELECT AVG(SALARY) FROM EMPLOYEES) AS company_avg
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);


-- 166 Self-join reinforcement: Show manager-employee pairs where
-- the employee earns more than their manager. Include salary gap.

SELECT e.first_name, e.last_name, e.salary, m.first_name, m.last_name, m.salary, (e.salary - m.salary) as salary_diff
from EMPLOYEES e
join employees m
on e.manager_id = m.id
where e.salary - m.salary > 0;

-- 167 LEFT JOIN mastery: Show all departments with their employee counts,
-- including departments with zero employees (show as 0, not NULL).

SELECT d.dname, count(e.id)
from departments d
LEFT JOIN EMPLOYEES e
on d.dname = e.dept
GROUP BY d.dname;

-- 168 CASE and conditional aggregation: For each department, count
-- employees in salary bands: <50k, 50k-80k, >80k. Use CASE in SUM().

SELECT DEPT, 
SUM(CASE WHEN SALARY < 50000 THEN 1 ELSE 0 END) AS under_50k,
SUM(CASE WHEN SALARY BETWEEN 50000 AND 80000 THEN 1 ELSE 0 END) AS between_50_80k,
SUM(CASE WHEN SALARY > 80000 THEN 1 ELSE 0 END) AS over_80k
FROM EMPLOYEES
where dept is not null
group by dept
order by dept;

-- 169 Window function fundamentals: For each employee, show their salary,
-- department average salary, and difference from dept average.

SELECT first_name, last_name, dept, salary, (AVG(SALARY) OVER(PARTITION BY DEPT)) as dept_avg, (salary - (AVG(SALARY) OVER(PARTITION BY DEPT))) as difference
from employees
where salary is not null
order by (salary-(AVG(SALARY) OVER(PARTITION BY DEPT)));

-- 170 CTE practice: Using a CTE, find departments with above-average
-- headcount, then list all employees in those departments with their rank by salary.

-- get average headcount
-- get dept headcount
-- merge 
-- filter for depts with higher than average headcounts

WITH avg_company_count AS (
      SELECT (count(*) / count(DISTINCT dept)) as avg_count
      from EMPLOYEES
      WHERE dept IS NOT NULL
),
dept_counts AS (
    SELECT dept, count(*) as headcount
    FROM employees
    WHERE dept IS NOT NULL
    GROUP BY dept
),
merged AS (
      SELECT * FROM dept_counts
      CROSS JOIN avg_company_count
)

select *, RANK() OVER(PARTITION BY E.DEPT ORDER BY E.SALARY DESC)
from merged m
join employees e 
on m.dept = e.dept
where headcount > avg_count ;