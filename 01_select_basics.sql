SELECT * FROM EMPLOYEES;

-- Tech Dept Only
SELECT * FROM EMPLOYEES WHERE DEPT='Tech';

-- Employees earning >= 80 000
SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY>= 80000;

-- Full name column
SELECT FIRST_NAME || ' ' || LAST_NAME as full_name FROM employees;

-- Count per department
SELECT dept, COUNT(*) FROM EMPLOYEES GROUP BY DEPT;


-- #	Task spec	Hints (only if stuck)
-- 1	List every column, all rows.	SELECT * …
SELECT * FROM EMPLOYEES;
-- 2	Show just first_name, last_name, sorted A→Z by last name.	ORDER BY default is ascending.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES ORDER BY LAST_NAME ASC;
-- 3	Display first_name and annual salary € increased by 5 % (call the new column raised_salary). Keep decimals.	Use an alias: … AS raised_salary.
SELECT FIRST_NAME, SALARY*1.05 AS RAISED_SALARY FROM EMPLOYEES;
-- 4	Employees earning ≥ €90 000. Show first_name, salary.	WHERE salary >= 90000
SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY >= 90000;
-- 5	Tech-dept employees below €100 000, ordered by salary DESC.	Multiple predicates → AND.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE SALARY < 100000 AND DEPT='Tech' ORDER BY SALARY DESC;
-- 6	Employees whose last name starts with “S”. Case-insensitive match.	ILIKE 'S%' works in Postgres.
SELECT LAST_NAME, FIRST_NAME FROM EMPLOYEES WHERE LAST_NAME ILIKE 'S%';
-- 7	Return the highest salary only.	ORDER BY salary DESC LIMIT 1 or aggregation.
SELECT SALARY FROM EMPLOYEES ORDER BY SALARY DESC LIMIT 1;
-- 8	Count of employees per department. Return dept, cnt, order by count DESC.	GROUP BY dept.
SELECT DEPT, COUNT(*) AS CNT FROM EMPLOYEES GROUP BY DEPT ORDER BY CNT DESC;
        -- 9	Any employee with NULLs in any column? Return a row count (0 or >0).	WHERE first_name IS NULL OR …
SELECT COUNT(*) AS CNT
FROM EMPLOYEES 
WHERE FIRST_NAME IS NULL 
OR LAST_NAME IS NULL
OR SALARY IS NULL
OR DEPT IS NULL;
-- 10	Distinct department names. Alphabetical.	SELECT DISTINCT dept …
SELECT DISTINCT DEPT FROM EMPLOYEES ORDER BY DEPT ASC;