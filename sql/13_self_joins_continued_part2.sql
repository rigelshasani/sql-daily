-- 121  Show each employee’s full name, their manager’s full name, and a column
--      same_dept flagging ‘Y’ if employee and manager share the same department,
--      otherwise ‘N’.  Order by employee last_name, first_name.
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS FULL_NAME,  
       M.FIRST_NAME || ' ' || M.LAST_NAME AS M_FULL_NAME,
       CASE WHEN E.DEPT = M.DEPT THEN 'Y' ELSE 'N' END AS SAME_DEPT
FROM EMPLOYEES E 
JOIN EMPLOYEES M 
ON E.MANAGER_ID = M.ID 
ORDER BY E.LAST_NAME, E.FIRST_NAME;

-- 122  List departments that have ≥ 3 employees reporting to the *same* manager.
--      Display dept, manager full name, and employee_count.
SELECT M.DEPT, M.FIRST_NAME || ' ' || M.LAST_NAME AS MANAGER_FULL_NAME, COUNT(*) as EMPLOYEE_COUNT
FROM EMPLOYEES M
JOIN EMPLOYEES E 
ON M.ID = E.MANAGER_ID
GROUP BY M.DEPT, MANAGER_FULL_NAME
HAVING count(*) >= 3;

-- 123  For every manager, show:
--          manager full name,
--          null_salary_reports   → count of direct reports whose salary IS NULL,
--          total_report_salary   → SUM of non-NULL salaries of direct reports.
--      Include managers with ZERO reports.  Order by manager full name.
SELECT M.FIRST_NAME || ' ' || M.LAST_NAME AS M_FULL_NAME, COUNT(CASE WHEN E.SALARY IS NULL THEN 1 ELSE NULL END), SUM(CASE WHEN E.SALARY IS NOT NULL THEN E.SALARY ELSE 0 END)
FROM EMPLOYEES M 
LEFT JOIN EMPLOYEES E 
ON M.ID = E.MANAGER_ID
GROUP BY M.FIRST_NAME || ' ' || M.LAST_NAME;

-- 124 *** Find employees whose salary equals the MAX salary *among their own manager’s
--      direct reports*.  Show employee name, salary, and manager name.
SELECT E.FIRST_NAME, E.SALARY, M.FIRST_NAME
FROM EMPLOYEES E 
JOIN EMPLOYEES M 
ON E.MANAGER_ID = M.ID
WHERE (SELECT MAX(EM.SALARY) FROM EMPLOYEES EM WHERE EM.MANAGER_ID = E.MANAGER_ID) = E.SALARY;

-- 125  List managers who have at least one direct report in a department
--      different from the manager’s.  One row per manager-dept pair:
--      manager full name, report_department.
SELECT M.FIRST_NAME || ' ' || M.LAST_NAME AS MANAGER_FULL_NAME, E.DEPT AS REPORTEE_DEPARTMENT
FROM EMPLOYEES M 
JOIN EMPLOYEES E 
ON M.ID = E.MANAGER_ID
WHERE M.DEPT <> E.DEPT;

-- 126  For each department, identify the manager whose team contains the
--      highest-paid employee *in that department*.
--      Show dept, manager full name, max_employee_salary.
--      (If a tie exists, return any one.)

--   max   |   dept
-- --------+-----------
--   72000 | Marketing
--   75000 | Finance
--  105000 | Tech
--   68000 | Sales
--   60000 | HR

SELECT E.DEPT, M.FIRST_NAME || ' ' || M.LAST_NAME AS FULL_NAME, D_MAX.MAX_SALARY AS max_employee_salary
FROM (SELECT MAX(SALARY) AS MAX_SALARY, DEPT FROM EMPLOYEES GROUP BY DEPT) AS D_MAX
JOIN EMPLOYEES E 
ON D_MAX.DEPT = E.DEPT 
JOIN EMPLOYEES M 
ON E.MANAGER_ID = M.ID 
WHERE E.SALARY = D_MAX.MAX_SALARY;

-- 127  Find pairs of coworkers in the SAME department, SAME manager,
--      where employee_A earns less than employee_B.
--      Show: employee_A name, salary_A, employee_B name, salary_B, shared_manager.

SELECT A.FIRST_NAME, A.SALARY, B.FIRST_NAME, B.SALARY, M.FIRST_NAME || ' ' || M.LAST_NAME AS SHARED_MANAGER
FROM EMPLOYEES A 
JOIN EMPLOYEES B 
ON A.DEPT = B.DEPT AND A.MANAGER_ID = B.MANAGER_ID
JOIN EMPLOYEES M 
ON A.MANAGER_ID = M.ID
WHERE A.SALARY < B.SALARY;

-- 128  Show managers whose average direct-report salary is *below* the overall
--      company average salary.  Display manager name and that average.

-- Find avg salary
-- Find 

SELECT M.FIRST_NAME || ' ' || M.LAST_NAME AS MANAGER_NAME, ROUND((SELECT AVG(SALARY) FROM EMPLOYEES)) AS AVERAGE
FROM EMPLOYEES M 
JOIN EMPLOYEES E 
ON M.ID = E.MANAGER_ID
GROUP BY M.FIRST_NAME || ' ' || M.LAST_NAME
HAVING AVG(E.SALARY) < (SELECT AVG(SALARY) FROM EMPLOYEES);


-- 129  For each manager, output:
--          manager name,
--          count_same_dept → # reports in SAME dept as manager,
--          count_diff_dept → # reports in DIFFERENT dept.
--      Include managers with zero reports (both counts = 0).
SELECT M.FIRST_NAME || ' ' || M.LAST_NAME AS MANAGER_NAME, SUM(CASE WHEN E.DEPT = M.DEPT THEN 1 ELSE 0 END )AS COUNT_SAME_DEPT, SUM(CASE WHEN E.DEPT <> M.DEPT THEN 1 ELSE 0 END) AS COUNT_DIFF_DEPT
FROM EMPLOYEES M
LEFT JOIN EMPLOYEES E
ON E.MANAGER_ID = M.ID
GROUP BY M.FIRST_NAME || ' ' || M.LAST_NAME;


-- 130  Identify employees who are set as their own manager (manager_id = id)
--      *and* also manage others.  Show their name and count_other_reports.
SELECT M.FIRST_NAME || ' ' || M.LAST_NAME, SUM(CASE WHEN OE.ID <> M.ID THEN 1 ELSE 0 END) AS COUNT_OTHER_REPORTS 
FROM EMPLOYEES M
JOIN EMPLOYEES OE 
ON OE.MANAGER_ID = M.ID
WHERE M.MANAGER_ID = M.ID
GROUP BY M.FIRST_NAME || ' ' || M.LAST_NAME;