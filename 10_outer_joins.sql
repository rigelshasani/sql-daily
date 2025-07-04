-- 91 Show ALL employees with their department names. Include employees without departments. Order by employee name.
SELECT E.FIRST_NAME, E.LAST_NAME, D.DNAME FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPT=D.DNAME ORDER BY E.LAST_NAME
-- 92 List ALL departments with employee count. Include departments with zero employees. Order by department name.
SELECT D.DNAME, COUNT(E.FIRST_NAME) FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON E.DEPT=D.DNAME GROUP BY D.DNAME ORDER BY D.DNAME;
-- 93 Show ALL employees with their department location. Display 'No Department' for employees without departments. Order by location.
SELECT E.FIRST_NAME, E.LAST_NAME, (CASE WHEN D.LOC IS NOT NULL THEN D.LOC ELSE 'No Department' END) AS LOCA FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPT=D.DNAME ORDER BY LOCA;
-- 94 Find ALL departments and their total salary expense. Show 0 for departments with no employees. Order by total salary descending.
SELECT D.DNAME, CASE WHEN SUM(E.SALARY) IS NOT NULL THEN SUM(E.SALARY) ELSE 0 END AS SUMSALARY FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.DNAME = E.DEPT GROUP BY D.DNAME ORDER BY SUMSALARY DESC
-- 95 List ALL employees with their department name and location. For employees without departments, show 'Unassigned' for both department name and location.
SELECT E.FIRST_NAME, E.LAST_NAME, COALESCE(D.DNAME, 'Unassigned') AS DNAME, COALESCE(D.LOC, 'Unassigned') AS LOC FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPT = D.DNAME
-- 96 Show ALL departments with the name of the highest-paid employee in each department. Include departments with no employees.

-- 97 Display ALL employees with their department's average salary. Include employees without departments (show NULL for average).

-- 98 List ALL departments with count of employees earning above 60000. Include departments where no employees earn above 60000.

-- 99 Show ALL employees with their department name. Also include a column showing how many other employees are in their department.

-- 100 Find ALL departments and list them with their lowest salary. For departments with no employees, show 'No employees' instead of a salary value.