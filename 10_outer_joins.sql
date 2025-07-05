-- 91 Show ALL employees with their department names. Include employees without departments. Order by employee name.
SELECT E.FIRST_NAME, E.LAST_NAME, D.DNAME 
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D 
ON E.DEPT=D.DNAME 
ORDER BY E.LAST_NAME;
-- 92 List ALL departments with employee count. Include departments with zero employees. Order by department name.
SELECT D.DNAME, COUNT(E.FIRST_NAME) 
FROM DEPARTMENTS D 
LEFT JOIN EMPLOYEES E 
ON E.DEPT=D.DNAME 
GROUP BY D.DNAME 
ORDER BY D.DNAME;
-- 93 Show ALL employees with their department location. Display 'No Department' for employees without departments. Order by location.
SELECT 
E.FIRST_NAME, 
E.LAST_NAME, 
(CASE WHEN D.LOC IS NOT NULL THEN D.LOC ELSE 'No Department' END) AS LOCA 
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D 
ON E.DEPT=D.DNAME 
ORDER BY LOCA;
-- 94 Find ALL departments and their total salary expense. Show 0 for departments with no employees. Order by total salary descending.
SELECT 
D.DNAME, 
CASE WHEN SUM(E.SALARY) IS NOT NULL THEN SUM(E.SALARY) ELSE 0 END AS SUMSALARY 
FROM DEPARTMENTS D 
LEFT JOIN EMPLOYEES E 
ON D.DNAME = E.DEPT 
GROUP BY D.DNAME 
ORDER BY SUMSALARY DESC;
-- 95 List ALL employees with their department name and location. For employees without departments, show 'Unassigned' for both department name and location.
SELECT E.FIRST_NAME, 
E.LAST_NAME, 
COALESCE(D.DNAME, 'Unassigned') AS DNAME, 
COALESCE(D.LOC, 'Unassigned') AS LOC 
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D 
ON E.DEPT = D.DNAME;
-- 96 Show ALL departments with their total salary expense. Include departments with no employees (show 0).
SELECT D.DNAME, 
COALESCE(SUM(E.SALARY), 0)
FROM DEPARTMENTS D 
LEFT JOIN EMPLOYEES E 
ON D.DNAME = E.DEPT
GROUP BY D.DNAME;

-- 97 List ALL employees with their department location. Show 'No Location' for employees without departments.
SELECT E.FIRST_NAME, E.LAST_NAME,
COALESCE(D.LOC, 'No Location') AS LOCA
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D 
ON D.DNAME = E.DEPT;
-- 98 Show ALL departments and count how many employees each has. Include empty departments.
SELECT D.DNAME, COUNT(E.FIRST_NAME)
FROM DEPARTMENTS D 
LEFT JOIN EMPLOYEES E 
ON E.DEPT = D.DNAME
GROUP BY D.DNAME;
-- 99 Display ALL employees with their department name and department budget. Include employees without departments.
SELECT (E.FIRST_NAME || ' ' || E.LAST_NAME) AS FULL_NAME,
COALESCE(D.DNAME, 'NULL'), COALESCE(D.BUDGET,0)
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D 
ON E.DEPT = D.DNAME;
-- 100 Find ALL departments and their average salary. Show NULL for departments with no employees.
SELECT D.DNAME, COALESCE(ROUND(AVG(E.SALARY)), NULL) -- i cant coalesce with 'null' as a string here because they are different types
FROM DEPARTMENTS D 
LEFT JOIN EMPLOYEES E 
ON E.DEPT = D.DNAME
GROUP BY D.DNAME;