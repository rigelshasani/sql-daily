***Exercise 11***
```sql
Task: Find all employees who meet ALL these criteria:

Work in Tech OR Marketing
Salary between 70000 and 100000 (inclusive)
Hired after 2017

Display only: first_name, dept, salary, hire_date
```

```python
# Step by step (my solution)
filter1 = employees[employees['dept'].isin(['Tech', 'Marketing'])]
filter2 = filter1[filter1['hire_date'] > '2017-12-31']
filter3 = filter2[(filter2['salary'] <= 100000) & (filter2['salary'] >= 70000)]
filter3[['first_name', 'dept', 'salary', 'hire_date']]
#or
result = employees[
    (employees['dept'].isin(['Tech', 'Marketing'])) & 
    (employees['hire_date'] > '2017-12-31') & 
    (employees['salary'] >= 70000) & 
    (employees['salary'] <= 100000)
][['first_name', 'dept', 'salary', 'hire_date']]
```
***Exercise 12***
```sql
Task: Create a new column 'email' for each employee using this format:

first_name.last_name@company.com
All lowercase
If first_name or last_name is missing (NULL), use 'unknown'

Example: Ana Gonzalez → ana.gonzalez@company.com
Hint:

Use .str.lower() for lowercase
Use .fillna('unknown') for NULL handling
Use + to concatenate strings
```

```python
employees['email'] = np.where(employees['first_name'].isna(), 'Unknown', employees['first_name'].str.lower())+ '.' + 
                     np.where(employees['last_name'].isna(), 'Unknown', employees['last_name'].str.lower())  + '@company.com'
employees
```
***Exercise 13***
```sql
Exercise P013: Pivot Tables
Task: Create a pivot table showing:

Rows: department
Values: average salary
Also show the count of employees per department

This will reshape your data to see departments summary in a different format.
Hint:

Use pd.pivot_table()
You''ll need values=, index=, and aggfunc=
To get both mean and count, pass a list to aggfunc
```

```python
pd.pivot_table(
    data=employees,
    values='salary',
    index='dept',
    aggfunc=['mean', 'count'])
```
***Exercise 14***
```sql
Task: Create a second DataFrame with employee bonuses:
bonus_data = {
    'first_name': ['Ana', 'Dave', 'Cara', 'Frank'],
    'bonus': [5000, 15000, 12000, 3000]
}
bonuses = pd.DataFrame(bonus_data)
Now merge this with employees to show all employees and their bonuses (NULL if no bonus).
Hint: Think about which type of merge/join you need to keep ALL employees.
```

```python
employees.merge(bonuses, on= 'first_name', how='left')
```
***Exercise 15***
```sql
Exercise P015: Summary Statistics by Group
Task: For each department, calculate:

Total salary paid (sum)
Average salary
Number of employees
Salary range (max - min)

Create this as a new DataFrame called dept_summary.
Challenge: Can you do this in one line using .agg() with custom names?
```

```python
summary = employees.groupby('dept')['salary'].agg(['sum', 'mean', 'count', 'max', 'min'])
summary['range'] = summary['max'] - summary['min']
dept_summary = summary.drop(columns=['min', 'max'])
dept_summary
```
***Exercise 16***
```sql

```

```python

```
***Exercise 17***
```sql

```

```python

```
***Exercise 18***
```sql

```

```python

```
***Exercise 19***
```sql

```

```python

```
***Exercise 20***
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