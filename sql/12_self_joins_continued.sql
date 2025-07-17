-- 111 Count how many employees work in the same department as their manager.
SELECT COUNT(*)
FROM EMPLOYEES E
JOIN EMPLOYEES M
ON E.MANAGER_ID = M.ID
WHERE E.DEPT = M.DEPT;

-- 112 Show each manager's name and their team's total salary (sum of all their direct reports' salaries). 
SELECT M.FIRST_NAME, SUM(E.SALARY)
FROM EMPLOYEES E
JOIN EMPLOYEES M
ON E.MANAGER_ID = M.ID
GROUP BY M.FIRST_NAME;

-- 113 Find departments where at least 2 employees have the same manager. Show department and manager name.
SELECT E.DEPT, M.FIRST_NAME
FROM EMPLOYEES M
JOIN EMPLOYEES E 
ON E.MANAGER_ID = M.ID
GROUP BY E.DEPT, M.FIRST_NAME
HAVING COUNT(*) >= 2;
-- 114 List each manager with their highest-paid and lowest-paid direct report's salary. Show manager name, max salary, min salary.
SELECT M1.FIRST_NAME, MAX(E1.SALARY), MIN(E1.SALARY)
FROM EMPLOYEES E1 
JOIN EMPLOYEES M1
ON E1.MANAGER_ID = M1.ID
GROUP BY M1.FIRST_NAME;
-- 115 Show managers whose average direct report salary is above 70000. Display manager name and the average.
SELECT M1.FIRST_NAME, AVG(E.SALARY)
FROM EMPLOYEES M1 
JOIN EMPLOYEES E 
ON M1.ID = E.MANAGER_ID
GROUP BY M1.FIRST_NAME
HAVING AVG(E.SALARY) > 70000;

-- 116 Show all employees and their manager's name. Include employees without managers (show NULL).
SELECT E.FIRST_NAME, E.LAST_NAME, COALESCE(M.FIRST_NAME || ' ' || M.LAST_NAME, NULL)
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES M
ON E.MANAGER_ID = M.ID;
-- 117 Find pairs of employees where one manages the other AND they have different salaries. Show both names and salaries.
SELECT E.FIRST_NAME, E.LAST_NAME, E.SALARY, M.FIRST_NAME, M.LAST_NAME, M.SALARY
FROM EMPLOYEES E
JOIN EMPLOYEES M 
ON E.MANAGER_ID = M.ID
WHERE E.SALARY <> M.SALARY;
-- 118 Count employees per department who have the same manager as 'Ben'. Don't include Ben herself.
SELECT COUNT(E2.FIRST_NAME), E2.DEPT
FROM EMPLOYEES E
JOIN EMPLOYEES E2 
ON E2.MANAGER_ID = E.MANAGER_ID
WHERE E.FIRST_NAME = 'Ben' AND E2.FIRST_NAME <> 'Ben'
GROUP BY E2.DEPT;
-- 119 List managers who have at least one direct report in a different department than themselves.
SELECT M.FIRST_NAME, M.LAST_NAME
FROM EMPLOYEES M 
JOIN EMPLOYEES E 
ON M.ID = E.MANAGER_ID 
WHERE M.DEPT <> E.DEPT
GROUP BY M.FIRST_NAME, M.LAST_NAME;
-- 120 Show each employee with a count of how many other people share their manager (not including themselves).
SELECT E.FIRST_NAME, E.LAST_NAME, COUNT(E2.FIRST_NAME)
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2 
ON E.MANAGER_ID = E2.MANAGER_ID AND E.ID <> E2.ID
GROUP BY E.FIRST_NAME, E.LAST_NAME;