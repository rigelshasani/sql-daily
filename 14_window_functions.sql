-- function_name() OVER (partition_clause order_clause)

-- Common Window Functions:

-- ROW_NUMBER() - Sequential numbers
-- RANK() - Same rank for ties, gaps after
-- DENSE_RANK() - Same rank for ties, no gaps
-- SUM(), AVG(), COUNT(), MAX(), MIN() - Aggregates as windows
-- LAG(), LEAD() - Previous/next row values
-- FIRST_VALUE(), LAST_VALUE() - First/last in window

-- OVER Clause Parts:

-- PARTITION BY column - Separate groups (like GROUP BY)
-- ORDER BY column [DESC] - Sort within partition
-- Can use both: OVER (PARTITION BY dept ORDER BY salary DESC)


-- 131 Add row numbers to all employees ordered by salary (highest to lowest).
SELECT E.FIRST_NAME, E.LAST_NAME, E.SALARY,
ROW_NUMBER() OVER(ORDER BY E.SALARY DESC)
FROM EMPLOYEES E
WHERE E.SALARY IS NOT NULL;

-- 132 Show each employee's salary along with the average salary of their department.
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME, E.SALARY, 
AVG(E.SALARY) OVER(PARTITION BY E.DEPT)
FROM EMPLOYEES E
WHERE E.SALARY IS NOT NULL;
-- 133 Rank employees by salary within their department (highest salary = rank 1).
SELECT E.FIRST_NAME, E.SALARY,
RANK() OVER(PARTITION BY E.DEPT ORDER BY E.SALARY DESC)
FROM EMPLOYEES E
WHERE E.SALARY IS NOT NULL;
-- 134 Find the salary difference between each employee and the highest paid person in their department.
SELECT E.FIRST_NAME, ((MAX(SALARY) OVER(PARTITION BY DEPT)) - E.SALARY)
FROM EMPLOYEES E
WHERE E.SALARY IS NOT NULL; 
-- 135 Show each employee with the count of people in their department (including themselves).
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME, E.DEPT,
COUNT(E.FIRST_NAME) OVER(PARTITION BY DEPT) 
FROM EMPLOYEES E
WHERE E.FIRST_NAME IS NOT NULL AND E.DEPT IS NOT NULL;
-- 136 Display each employee's salary as a percentage of their department's total salary.
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME, E.SALARY, (SUM(SALARY) OVER(PARTITION BY DEPT)) AS salary_as_percentage_of_total_dept_salary ,  (ROUND(E.SALARY::NUMERIC / (SUM(SALARY) OVER(PARTITION BY DEPT))::NUMERIC * 100 , 2) || '%')
FROM EMPLOYEES E 
WHERE E.SALARY IS NOT NULL AND E.FIRST_NAME IS NOT NULL AND E.DEPT IS NOT NULL;
-- 137 Show the cumulative sum of salaries ordered by hire_date.
select SUM(E.SALARY) OVER(ORDER BY hire_date)
FROM EMPLOYEES E;
-- 138 For each employee, show their salary and the salary of the next person hired after them.
SELECT E.FIRST_NAME, E.SALARY, 
LEAD(E.SALARY) OVER(order by hire_date)
FROM EMPLOYEES E
WHERE E.SALARY IS NOT NULL;
-- 139 Show the first and last hire date for each department alongside each employee.
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME, 
FIRST_VALUE(E.HIRE_DATE) OVER(PARTITION BY DEPT ORDER BY HIRE_DATE), LAST_VALUE(E.HIRE_DATE) OVER(PARTITION BY DEPT ORDER BY HIRE_DATE)
FROM EMPLOYEES E;
-- 140 Rank employees by hire_date (earliest = 1) and show only the first 2 hired in each department.

SELECT *
FROM (SELECT FIRST_NAME || ' ' || LAST_NAME, 
      RANK() OVER(PARTITION BY DEPT ORDER BY HIRE_DATE) as rk
      FROM EMPLOYEES E
      ) AS subquery
WHERE rk <= 2;