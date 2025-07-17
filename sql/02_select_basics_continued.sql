-- 11	Show last names longer than 6 characters.
SELECT LAST_NAME FROM EMPLOYEES WHERE length(last_name) > 6;
-- 12	Show first and last names concatenated into one full name column (alias: full_name).
select first_name || ' ' || last_name as full_name from employees;
-- 13	Employees not in the Tech department earning over €60 000.
SELECT first_name, last_name, salary, dept from employees where dept <> 'Tech' and salary > 60000;
-- 14	Employees in Marketing or HR with salary below €70 000.
SELECT first_name, last_name, salary, dept from employees where (dept = 'Marketing' or dept = 'HR') and salary < 70000;
-- 15	Show all employees whose last names end with 'z' (case-insensitive).
SELECT first_name, last_name, salary, dept from employees where LAST_NAME ILIKE '%Z';
-- 16	Show all distinct departments excluding 'HR'.
SELECT DISTINCT DEPT FROM EMPLOYEES WHERE DEPT <> 'HR';
-- 17	Show the top 2 highest-paid employees in Sales.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE DEPT = 'SALES' ORDER BY SALARY DESC LIMIT 2;
-- 18	Show employees where the second letter of their first name is 'a'.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE FIRST_NAME ILIKE '_a%';
-- 19	Show all employees whose first names are exactly 4 characters long.
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE LENGTH(FIRST_NAME) = 4;
-- 20	Show the average salary per department (rounded to 0 decimals), ordered by average descending.
SELECT DEPT, ROUND(AVG(SALARY)) AS AVGE FROM EMPLOYEES GROUP BY DEPT ORDER BY AVGE DESC;

-- WILDCARD MATCHING!

-- Starts with 'A' → 'A%'
-- Ends with 'z' → '%z'
-- Contains 'ana' anywhere → '%ana%'
-- Exactly 4-letter words starting with 'S' → 'S___' (three underscores)
-- Case-insensitive last names ending with 'z' → ILIKE '%z'