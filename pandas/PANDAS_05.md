## Pandas Exercises 41-50

# Exercise 41
```
/* Average salary per department, including those with no staff */
SELECT d.dname                AS dept,
       COALESCE(AVG(e.salary),0) AS avg_salary
FROM   departments d
LEFT JOIN employees e
       ON e.dept = d.dname
GROUP  BY d.dname
ORDER  BY avg_salary DESC;
```
```python
avg_sal = employees[['salary', 'dept']]
avg_sal = avg_sal.groupby('dept').agg({'salary':'mean'})
departments.fillna(0)
avg_sal = departments.merge(avg_sal, 
                            left_on='dname',
                            right_on='dept', 
                            how='left').fillna({'salary_y': 0, 'salary_x': 0}).drop_duplicates('dname')
avg_sal = avg_sal.drop(['salary_x'], axis=1)
avg_sal = avg_sal.rename(columns={'salary_y': 'salary_mean'})
avg_sal = avg_sal.sort_values('salary_mean', ascending=False)
avg_sal
```

# Exercise 42
```
/* For each department:
   1. Calculate its median salary (excluding NULLs)
   2. Count how many employees earn ABOVE that median
   3. Count how many earn BELOW (or equal to) that median
   Output: dept | above_median | below_or_equal_median
*/
```
```python
empsal = employees[['salary', 'dept']]
empsal = empsal[(empsal['dept'].notna()) & (empsal['salary'].notna())]
empsal2 = empsal.groupby('dept').agg({'salary':'median'})
empsal = empsal.merge(empsal2, on='dept')
empsal['relation_to_median'] = np.where(empsal['salary_x'] > empsal['salary_y'], 'Above', 'Below OR Equal Median')
empsal = empsal.groupby(['dept', 'relation_to_median']).agg({'relation_to_median':'count'})
empsal = empsal.unstack('relation_to_median')
empsal = (empsal
          .fillna(0)
          .reset_index())
empsal.columns = ['dept', 'above_median', 'below_or_equal_median']
empsal
```

# Exercise 43
```
/* 3-hire rolling average salary by department, ordered by hire_date */
SELECT id, first_name, last_name, dept, salary, hire_date,
       AVG(salary) OVER (
         PARTITION BY dept
         ORDER BY hire_date
         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS rolling_avg_3
FROM   employees
ORDER  BY dept, hire_date;
```
```python
emp = employees[['id', 'first_name', 'last_name', 'dept', 'salary', 'hire_date']].copy()
emp = emp[(emp['dept'].notna()) & (emp['salary'].notna())]
emp['hire_date'] = pd.to_datetime(emp['hire_date'])
emp = emp.sort_values(['dept', 'hire_date'])

rolling_avg = (emp
    .groupby('dept')['salary']
    .rolling(window=3, min_periods=1)
    .mean()
    .reset_index(level=0, drop=True))

emp['rolling_avg_3'] = rolling_avg.values
emp
```

# Exercise 44
```
/* Departments whose total salary exceeds 50 % of their budget */
SELECT d.dname                              AS dept,
       SUM(e.salary)                        AS total_salary,
       d.budget,
       SUM(e.salary) / d.budget * 100       AS utilization_pct,
       COUNT(e.id)                          AS employee_count
FROM   departments d
JOIN   employees   e ON e.dept = d.dname
GROUP  BY d.dname, d.budget
HAVING SUM(e.salary) > 0.50 * d.budget
ORDER  BY utilization_pct DESC;
```
```python
sd = employees[['salary', 'dept']]
sd = sd.groupby('dept').agg({'salary':'sum', 'dept':'count'}).rename(columns={'salary':'sum_salaries', 'dept': 'emp_count'}).reset_index()
departments2 = departments.merge(sd, left_on='dname', right_on='dept')
departments2['utilization_pct'] = (departments2['sum_salaries'] / departments2['budget']) * 100
departments2 = departments2[departments2['utilization_pct'] > 50]
departments2
```

# Exercise 45
```
/* Hire heat-map: rows = dept, cols = hire_year, values = hires */
SELECT dept,
       EXTRACT(YEAR FROM hire_date) AS hire_year,
       COUNT(*)                     AS hires
FROM   employees
GROUP  BY dept, EXTRACT(YEAR FROM hire_date)
ORDER  BY dept, hire_year;
```
```python
# your code
```

# Exercise 46
```
/* Running cumulative salary within each dept with lag + crossing flag */
WITH cume AS (
  SELECT id, first_name, dept, salary,
         SUM(salary) OVER (PARTITION BY dept
                           ORDER BY hire_date)              AS dept_cumsum
  FROM   employees
  WHERE  salary IS NOT NULL
)
SELECT *,
       LAG(dept_cumsum) OVER (PARTITION BY dept
                              ORDER BY dept_cumsum) AS dept_cumsum_lag1,
       CASE WHEN dept_cumsum >= 250000
            AND COALESCE(LAG(dept_cumsum) OVER (
                          PARTITION BY dept ORDER BY dept_cumsum),0) < 250000
            THEN 1 ELSE 0 END                         AS crossed_250k
FROM   cume
ORDER  BY dept, dept_cumsum;
```
```python
# your code
```

# Exercise 47
```
/* Attach each employee’s department budget two different ways */
-- A) merge
SELECT e.*, d.budget
FROM   employees   e
JOIN   departments d ON d.dname = e.dept;

-- B) map via lookup table (Series)
```
```python
# A) merge
with_budget = employees.merge(departments[['dname', 'budget']], 
                              left_on='dept', right_on='dname', how='left')

# B) map
budget_map = departments.set_index('dname')['budget']
employees['budget'] = employees['dept'].map(budget_map)
```

# Exercise 48
```
/* Top-3 earners per department aggregated into one row */
WITH ranked AS (
  SELECT e.*,
         ROW_NUMBER() OVER (PARTITION BY dept ORDER BY salary DESC) AS rn
  FROM   employees e
  WHERE  salary IS NOT NULL
)
SELECT dept,
       STRING_AGG(first_name, ', ')         AS top3_names,
       SUM(salary)                          AS top3_total
FROM   ranked
WHERE  rn <= 3
GROUP  BY dept
ORDER  BY top3_total DESC;
```
```python
# your code
```

# Exercise 49
```
/* Coworker counts hired in same quarter and previous quarter */
WITH qtrs AS (
  SELECT id, first_name, dept, hire_date,
         DATE_TRUNC('quarter', hire_date) AS qtr_start
  FROM   employees
)
SELECT e.id,
       e.first_name,
       e.dept,
       COUNT(CASE WHEN q.qtr_start = e.qtr_start         THEN 1 END) - 1 AS same_qtr_count,
       COUNT(CASE WHEN q.qtr_start = e.qtr_start - INTERVAL '3 months'
                  THEN 1 END)        AS prev_qtr_count
FROM   qtrs e
JOIN   qtrs q ON q.dept = e.dept
GROUP  BY e.id, e.first_name, e.dept, e.qtr_start
ORDER  BY e.dept, e.first_name;
```
```python
employees['hire_date'] = pd.to_datetime(employees['hire_date'])
employees['hire_qtr'] = employees['hire_date'].dt.to_period('Q')
counts = employees.groupby(['dept', 'hire_qtr'])['id'].count()
employees['same_qtr_count'] = employees.set_index(['dept', 'hire_qtr']).index.map(counts)
employees['prev_qtr'] = (employees['hire_qtr'] - 1).astype(str)
```

# Exercise 50
```
/* Managers whose highest-paid report earns more than the manager */
WITH reports AS (
  SELECT m.id              AS manager_id,
         m.first_name      AS manager_name,
         m.salary          AS manager_salary,
         r.first_name      AS report_name,
         r.salary          AS report_salary,
         r.dept
  FROM   employees r
  JOIN   employees m ON r.manager_id = m.id
  WHERE  r.salary IS NOT NULL
)
SELECT manager_name,
       manager_salary,
       report_name         AS top_report_name,
       report_salary       AS top_report_salary,
       report_salary - manager_salary AS salary_gap,
       dept
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY manager_id ORDER BY report_salary DESC) AS rn
  FROM   reports
) t
WHERE  rn = 1
  AND  report_salary > manager_salary
ORDER BY salary_gap DESC;
```
```python
manager_salary = employees.set_index('id')['salary']
employees['manager_salary'] = employees['manager_id'].map(manager_salary)
# Then you can filter where employee's salary > manager_salary
```
