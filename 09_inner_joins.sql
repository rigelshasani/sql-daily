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

    -- Now your first 4 JOIN drills:

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
    D.budget
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
SELECT D.DNAME, COUNT(*) FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPT = D.DNAME
GROUP BY D.DNAME
HAVING COUNT(*) > 1;
