-- 20_review_part2.sql

-- 171  For each department, return the 2nd-highest salary (distinct values).
--      Use a CTE with a window function (DENSE_RANK).



-- 172  Show departments where the 2nd-highest salary > 80000.
--      Use ROW_NUMBER() with salary DESC and employee id as tie-breaker.



-- 173  For each manager, count how many direct reports earn above
--      the manager’s average report salary. Output manager and count.



-- 174  Re-do the “at least 2 above dept average” problem correctly (#75).
--      Show department and count of employees above their dept average.



-- 175  Compute per-capita budget for each department (budget ÷ headcount),
--      then list employees whose salary exceeds that per-capita figure.



-- 176  Within each department, rank employees by salary using both RANK()
--      and DENSE_RANK(). Output both side-by-side for comparison.



-- 177  LEFT JOIN departments with employees. Return two counts:
--      COUNT(first_name) vs COUNT(*) to illustrate the NULL trap.



-- 178  Re-write the supervisor roster: label each person SUPERVISOR/NON_SUPERVISOR
--      using EXISTS / NOT EXISTS instead of IN / NOT IN.



-- 179  For each department, show every employee’s hire_date plus dept_first_hire
--      and dept_last_hire using FIRST_VALUE and LAST_VALUE with a full frame clause.



-- 180  For each department, return the top 3 earners.
--      Use ROW_NUMBER() with salary DESC and employee id as a tie-breaker.
