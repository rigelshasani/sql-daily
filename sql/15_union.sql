-- 141 List each department once, tagging it as ACTIVE if employees exist or EMPTY if none.
SELECT d.dname,  'ACTIVE' 
from departments d
join employees e
on d.dname = e.dept
group by d.dname
having count(e.first_name) > 0
UNION
SELECT d.dname,  'EMPTY' 
from departments d
left join employees e
on d.dname = e.dept
where e.dept is null
order by dname;
-- 142 Create a roster that merges all employees with all distinct managers, labeling rows EMPLOYEE or MANAGER.
select e.id, e.first_name || ' ' || e.last_name as full_name, 'EMPLOYEE'
from employees e
UNION
select distinct m.id, m.first_name || ' ' || m.last_name as full_name, 'MANAGER'
from employees e
join employees m 
on m.id = e.manager_id;
-- 143 Produce a single‑column list of department names taken from EMPLOYEES plus the literal string 'UNASSIGNED' to represent NULL departments.
select e.dept 
from employees e
where e.dept is not null    
union 
select 'UNASSIGNED'
from employees e 
where e.dept is null;
-- 144 Return every employee, preserving duplicates, but substitute the text 'NO DEPT' for any NULL department values.
select e.first_name || ' ' || e.last_name as full_name, e.dept
from employees e 
where e.dept is not null 
union all 
select e.first_name || ' ' || e.last_name , 'NO DEPT'
from employees e 
where e.dept is null
order by full_name;
-- 145 Build a combined high‑value list: departments with budget > 300 000 and employees with salary > 80 000, each row tagged by its source.
select d.dname, d.budget, 'DEPT_BUDGET'
from departments d 
where d.budget > 300000 
union all 
select e.first_name || ' ' || e.last_name , e.salary, 'EMP_SALARY'
from employees e
where e.salary > 80000;

-- 143 can also be done like this:
-- select distinct case when e.dept is not null then e.dept else 'UNASSIGNED' end from employees e

-- 146 Produce a single‑column list of every numeric ID that appears either as EMPLOYEES.id or as EMPLOYEES.manager_id.  
-- Use two SELECT blocks—one pulls all employee IDs, the other pulls all non‑NULL manager IDs—then UNION them so each distinct number shows up once.
select distinct e.id
from employees e
where e.id is not null 
union 
select distinct m.manager_id 
from employees m
where m.manager_id is not null
order by 1;
-- 147 Build a two‑column roster that labels people as SUPERVISOR if their ID appears in someone else’s manager_id, otherwise NON_SUPERVISOR.  
-- One SELECT for supervisors, one for non‑supervisors, UNION them, then order by full name.
select e.first_name || ' ' || e.last_name as full_name, 'NON_SUPERVISOR'
from employees e 
where e.id NOT IN (select o.manager_id from employees o where o.manager_id is not null)
union
select s.first_name || ' ' || s.last_name, 'SUPERVISOR'
from employees s 
where s.id IN (select oe.manager_id from employees oe where oe.manager_id is not null);
-- 148 Return a list of all departments whose budget is at least 100 000, then append a constant row that reads 'BUDGET_PENDING' to represent any planned departments not yet funded.  
-- Use UNION to merge the real department names with that single literal.

SELECT D.DNAME
FROM DEPARTMENTS D 
WHERE D.BUDGET > 100000
UNION
SELECT 'BUDGET_PENDING';

-- 149 Create a three‑column report that shows department name, its budget, and the text 'OVER_BUDGET' for budgets > 400 000.  
-- UNION that with a second query that lists every employee whose salary exceeds 90 000, showing full name, salary, and the tag 'HIGH_SALARY'.  
-- End with ORDER BY the numeric amount descending.
SELECT d.dname, d.budget, 'OVER_BUDGET'
FROM DEPARTMENTS d 
where d.budget > 400000
UNION
SELECT e.first_name || ' ' || e.last_name, e.salary, 'HIGH_SALARY'
from employees e 
where e.salary > 90000
order by 2 DESC; 


-- 150 Produce a one‑column list of hire years extracted from EMPLOYEES.hire_date and add the literal year 2000 to the set in case no one was hired that year.  
-- Two SELECTs—one uses EXTRACT(YEAR FROM …) with DISTINCT, the other selects the constant 2000—then UNION and sort numerically.
SELECT DISTINCT EXTRACT(YEAR FROM E.HIRE_DATE)
FROM EMPLOYEES E 
union 
select 2000