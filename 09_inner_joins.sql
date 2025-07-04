DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    dname TEXT PRIMARY KEY,
    loc TEXT,
    budget INTEGER
);

INSERT INTO departments (dname, loc, budget) VALUES
    ('Tech', 'Building A', 500000),
    ('Sales', 'Building B', 300000),
    ('HR', 'Building C', 150000),
    ('Marketing', 'Building B', 250000);

-- 81 Show employee first names with their department location.
SELECT
    E.FIRST_NAME,
    D.LOC
FROM 
    EMPLOYEES E
INNER JOIN
    departments D
ON E.DEPT = D.DNAME;

-- 82 Show all employees with their department budget.
SELECT 
    E.FIRST_NAME,
    E.LAST_NAME,
    D.BUDGET
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPT = D.DNAME;

-- 83 Show employees in departments located in 'Building B'.
SELECT E.FIRST_NAME,
    E.LAST_NAME,
    D.LOC
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPT = D.DNAME
WHERE D.LOC = 'Building B';

-- 84 Show employee full names with department location and budget, ordered by budget descending.
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS FULL_NAME, D.BUDGET, D.LOC
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPT = D.DNAME
ORDER BY D.BUDGET DESC;

-- 85 Show departments that have more than one employee, including department name and employee count.
SELECT D.DNAME, COUNT(*) 
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPT = D.DNAME
GROUP BY D.DNAME
HAVING COUNT(*) > 1;

-- 86 Show employees who work in departments with budget > 200000. Display first name, last name, and the department budget.
SELECT E.FIRST_NAME, E.LAST_NAME, D.BUDGET 
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPT = D.DNAME
WHERE D.BUDGET > 200000;

-- 87 Find the total salary for each department. Show department name and total salary.
SELECT D.DNAME, SUM(E.SALARY) AS TOTAL_SALARY 
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPT = D.DNAME
GROUP BY D.DNAME;

-- 88 Show employees whose salary is greater than their department's average budget divided by the number of employees in that department.
-- Skipped: Requires subquery or window function. Will return later.

-- 89 List all employees in 'Building A' or 'Building C' with salary > 50000. Show first name, salary, and building location.
SELECT E.FIRST_NAME, E.SALARY, D.LOC
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPT = D.DNAME
WHERE E.SALARY > 50000 AND (D.LOC = 'Building A' OR D.LOC = 'Building C');

-- 90 Show department name, location, and the highest salary in each department. Order by highest salary descending.
SELECT D.DNAME, D.LOC, MAX(E.SALARY) AS MAX_SALARY
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPT = D.DNAME
GROUP BY D.DNAME, D.LOC
ORDER BY MAX_SALARY DESC;
