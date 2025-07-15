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

```

```python

```
***Exercise 27***
```sql

```

```python

```
***Exercise 28***
```sql

```

```python

```
***Exercise 29***
```sql

```

```python

```
***Exercise 30***
```sql

```

```python

```


---------------Exercise format
***Exercise ***
```sql

```

```python

```
---------------