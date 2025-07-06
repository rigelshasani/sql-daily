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