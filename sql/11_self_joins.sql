-- 101 List all employees with their manager's name. Show employee first name, last name, and manager's first name. Order by employee last name.
SELECT E.FIRST_NAME AS EMP_FIRST, E.LAST_NAME AS EMP_LAST, M.FIRST_NAME AS MANAGER_FIRST
FROM EMPLOYEES E 
JOIN EMPLOYEES M 
ON E.MANAGER_ID = M.ID
ORDER BY EMP_LAST;
-- 102 Show all employees who report to Ana. Display employee name and department.
SELECT E.FIRST_NAME AS EMP_FIRST, E.LAST_NAME AS EMP_LAST, 
E.DEPT 
FROM EMPLOYEES E 
JOIN EMPLOYEES M 
ON E.MANAGER_ID = M.ID
WHERE M.FIRST_NAME = 'Ana';
-- 103 Find all employees who have the same manager. Show employee1 name, employee2 name, and their shared manager's name.
SELECT E1.FIRST_NAME, E2.FIRST_NAME, M.FIRST_NAME
FROM EMPLOYEES E1
JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.MANAGER_ID AND E1.ID < E2.ID
JOIN EMPLOYEES M 
ON E1.MANAGER_ID = M.ID;
-- 104 List all employees who work in the same department. Show employee1 name, employee2 name, and department name (exclude matching an employee with themselves).
SELECT E1.FIRST_NAME, E2.FIRST_NAME, E1.DEPT
FROM EMPLOYEES E1
JOIN EMPLOYEES E2 
ON E1.DEPT = E2.DEPT AND E1.ID < E2.ID;
-- 105 Show employees who earn more than their manager. Display employee name, employee salary, manager name, and manager salary.
SELECT E1.FIRST_NAME, E1.SALARY, M.FIRST_NAME, M.SALARY
FROM EMPLOYEES E1 
JOIN EMPLOYEES M 
ON E1.MANAGER_ID = M.ID
WHERE E1.SALARY > M.SALARY;
-- 106 Count how many direct reports each manager has. Include managers with zero reports. Order by count descending.
SELECT M.FIRST_NAME, COUNT(E.ID)
FROM EMPLOYEES M 
LEFT JOIN EMPLOYEES E 
ON M.ID = E.MANAGER_ID 
GROUP BY M.FIRST_NAME
ORDER BY COUNT(E.ID) DESC;
-- 107 Find all employees in Tech department who have different managers. Show both employees and their respective managers.
SELECT E1.FIRST_NAME, E2.FIRST_NAME, M1.FIRST_NAME, M2.FIRST_NAME
FROM EMPLOYEES E1 
JOIN EMPLOYEES E2 
ON E1.DEPT = E2.DEPT 
JOIN EMPLOYEES M1 
ON M1.ID = E1.MANAGER_ID
JOIN EMPLOYEES M2 
ON M2.ID = E2.MANAGER_ID
WHERE E1.DEPT = 'Tech' AND M1.ID <> M2.ID AND E1.ID < E2.ID;
-- 108 List employees with their manager's department. Show cases where employee and manager are in different departments.
SELECT E1.FIRST_NAME, E1.DEPT, M1.FIRST_NAME, M1.DEPT 
FROM EMPLOYEES E1 
JOIN EMPLOYEES M1
ON E1.MANAGER_ID = M1.ID
WHERE E1.DEPT <> M1.DEPT;
-- 109 Show the salary difference between each employee and their manager. Display employee name, salary difference (positive if employee earns more).
SELECT E1.FIRST_NAME, (E1.SALARY-M1.SALARY) AS SALARYDIFF
FROM EMPLOYEES E1 
JOIN EMPLOYEES M1 
ON E1.MANAGER_ID = M1.ID;
-- 110 Find all employees who are managers. Show their name, department, and how many people report to them.
SELECT M1.FIRST_NAME, M1.DEPT, COUNT(M2.ID)
FROM EMPLOYEES M1 
JOIN EMPLOYEES M2
ON M1.ID = M2.MANAGER_ID
GROUP BY M1.FIRST_NAME, M1.DEPT;