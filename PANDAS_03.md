***Exercise 21***
```sql
rn = employees[['dept', 'salary']] # dataframe
rn = rn[rn['salary'].notna()] # filtered dataframe
rn = rn.sort_values(['dept', 'salary'], ascending=[True, False]).groupby('dept')['salary'] # grouped object after sorting
rn.nth(1)
```

```python
rn = employees[['dept', 'salary']] # dataframe
rn = rn[rn['salary'].notna()] # filtered dataframe
rn = rn.sort_values(['dept', 'salary'], ascending=[True, False]).groupby('dept')['salary'] # grouped object after sorting
rn.nth(1)
```
***Exercise 22***
```sql
Find all employees whose salary is within 10% of the maximum salary in their department.

SELECT e.first_name, e.last_name, e.salary, e.dept
FROM employees e
JOIN (
    SELECT dept, MAX(salary) * 0.9 as min_threshold
    FROM employees
    WHERE salary IS NOT NULL
    GROUP BY dept
) thresholds ON e.dept = thresholds.dept
WHERE e.salary >= thresholds.min_threshold;
```

```python
df2 = employees[['first_name', 'last_name', 'dept', 'salary']] # select columns
df2 = df2[df2['salary'].notna() & df2['dept'].notna()] # filter nulls
df3 = df2.groupby('dept')['salary'].agg('max'); # group by dept and salary, calculate max.
df2 = df2.merge(df3, on='dept')
df2 = df2[df2['salary_x'] >= 0.9 * df2['salary_y']]
df2
```
***Exercise 23***
```sql
SELECT DISTINCT e1.first_name, e1.last_name, e1.salary, e1.dept
FROM employees e1
JOIN employees e2 ON e1.salary = e2.salary AND e1.dept != e2.dept
WHERE e1.salary IS NOT NULL;
```

```python
emp_filtered = employees[['first_name','last_name', 'salary', 'dept']].dropna()
emp2 = emp_filtered
merged = emp_filtered.merge(emp2, on='salary')
merged = merged[merged['dept_x'] != merged['dept_y']]
merged
```
***Exercise 24***
```sql
SELECT dept, COUNT(*) as employee_count
FROM employees
WHERE dept IS NOT NULL
GROUP BY dept
ORDER BY employee_count DESC
LIMIT 1;
```

```python
emp_depts = employees.groupby('dept')['id'].agg('count')
emp_depts = emp_depts.sort_values(ascending=False)
emp_depts.head(1)
```
***Exercise 25***
```sql
SELECT e.first_name, e.last_name, e.dept, e.hire_date
FROM employees e
JOIN (
    SELECT dept, MIN(hire_date) as earliest_date
    FROM employees
    WHERE dept IS NOT NULL
    GROUP BY dept
) earliest ON e.dept = earliest.dept AND e.hire_date = earliest.earliest_date;
```

```python
emp_gr = employees[['first_name', 'last_name', 'dept', 'hire_date']]
emp2 = emp_gr
emp_gr = emp_gr[emp_gr['dept'].notna()]
emp_gr = emp_gr.groupby('dept')['hire_date'].agg('min').reset_index()
emp2 = emp2.merge(emp_gr, on=['dept','hire_date'])
emp2
```
***Exercise 26***
```sql
SELECT first_name, last_name, dept, hire_date,
       EXTRACT(YEAR FROM AGE('2025-07-15', hire_date)) as years_employed
FROM employees
WHERE EXTRACT(YEAR FROM AGE('2025-07-15', hire_date)) >= 5
ORDER BY hire_date;
```

```python
emp = employees[['first_name', 'last_name', 'hire_date']].copy()
today = pd.Timestamp('2025-07-15')
emp['years_hired'] = round((today - pd.to_datetime(emp['hire_date'])).dt.days / 365)
filtered = emp[emp['years_hired'] >= 5]
filtered
```
***Exercise 27***
```sql
SELECT d.dname, 
       COALESCE(AVG(e.salary), 0) as avg_salary,
       COUNT(e.id) as employee_count
FROM departments d
LEFT JOIN employees e ON d.dname = e.dept AND e.salary IS NOT NULL
GROUP BY d.dname
ORDER BY avg_salary DESC;
```

```python
depts = departments[departments['dname'].notna()]
emps = employees[['dept','salary', 'id']].groupby('dept').agg({'salary': 'mean','id' : 'count'})
depts = depts.merge(emps, left_on='dname', right_on='dept', how='left').fillna(0)
depts.sort_values(by='salary', ascending=False)
```
***Exercise 28***
```sql
Find employees whose salary is above their department's median salary.
Convert to pandas. You'll need to calculate median salary per department, then merge back and filter.

SELECT e.first_name, e.last_name, e.salary, e.dept
FROM employees e
JOIN (
    SELECT dept, 
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) as median_salary
    FROM employees
    WHERE salary IS NOT NULL
    GROUP BY dept
) medians ON e.dept = medians.dept
WHERE e.salary > medians.median_salary;
```

```python
emp = employees[['first_name', 'last_name', 'dept', 'salary']].copy()
emp = emp[emp['salary'].notna()]
emppie = emp.groupby('dept')['salary'].agg('median')
df = emppie.to_frame().reset_index()
emp = emp.merge(df, on='dept')
final = emp[emp['salary_x'] > emp['salary_y']]
final
#or
emp = employees[['first_name', 'last_name', 'dept', 'salary']].copy()
#skip np.where, just filter nulls directly.
emp = emp[emp['salary'].notna()]
# Calculate median per department
dept_medians = emp.groupby('dept')['salary'].median()
# Merge back with employee data
result = emp.merge(dept_medians, left_on='dept', right_index=True, suffixes=('', '_median'))

final = emp[emp['salary'] > emp[emp['salary_median']]]
```
***Exercise 29***
```sql
Find the top 2 highest-paid employees in each department.
SELECT first_name, last_name, dept, salary
FROM (
    SELECT first_name, last_name, dept, salary,
           ROW_NUMBER() OVER (PARTITION BY dept ORDER BY salary DESC) as rn
    FROM employees
    WHERE salary IS NOT NULL
) ranked
WHERE rn <= 2
ORDER BY dept, salary DESC;
```

```python
emp = employees[['first_name', 'last_name', 'dept', 'salary']]
emp = emp[emp['salary'].notna()]
emp = emp.sort_values(['dept', 'salary']).groupby('dept')
emp.head(2)
```
***Exercise 30***
```sql
Find employees who have the same manager but work in different departments.
SELECT DISTINCT e1.first_name, e1.last_name, e1.dept, e1.manager_id
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.manager_id 
                  AND e1.dept != e2.dept
                  AND e1.id != e2.id
WHERE e1.manager_id IS NOT NULL
ORDER BY e1.manager_id, e1.dept;
```

```python
e1 = employees[['first_name', 'last_name', 'dept', 'manager_id', 'id']]
e1 = e1[e1['manager_id'].notna() & e1['dept'].notna()]
e2 = e1.copy()
result = e1.merge(e2, on='manager_id', suffixes=['_e1', '_e2'])
result = result[(result['dept_e1'] != result['dept_e2']) & (result['id_e1'] != result['id_e2'])]
result
```


---------------Exercise format
***Exercise ***
```sql

```

```python

```
---------------