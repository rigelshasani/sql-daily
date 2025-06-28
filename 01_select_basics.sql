SELECT * FROM EMPLOYEES;

-- Tech Dept Only
SELECT * FROM EMPLOYEES WHERE DEPT='Tech';

-- Employees earning >= 80 000
SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY>= 80000;

-- Full name column
SELECT FIRST_NAME || ' ' || LAST_NAME as full_name FROM employees;

-- Count per department
SELECT dept, COUNT(*) FROM EMPLOYEES GROUP BY DEPT;
