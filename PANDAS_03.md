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

```
***Exercise 23***
```sql

```

```python

```
***Exercise 24***
```sql

```

```python

```
***Exercise 25***
```sql

```

```python

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