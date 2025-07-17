**SQL to Pandas exercises**

***Exercise 1***
```sql
SELECT first_name, dept, salary 
FROM employees 
WHERE dept IN ('Tech', 'Sales') 
ORDER BY salary DESC;
```

```python
emp = employees[employees['dept'].isin(['Tech', 'Sales'])][['first_name', 'dept','salary']]
emp.sort_values('salary', ascending=False)
```

***Exercise 2***
```sql
SELECT dept, COUNT(*) as emp_count, AVG(salary) as avg_salary
FROM employees
WHERE salary IS NOT NULL
GROUP BY dept
ORDER BY avg_salary DESC;
```

```python
yummi = employees[employees['salary'].notna()]
result = yummi.groupby('dept')['salary'].agg(['count', 'mean'])
result.sort_values('mean', ascending=False)
```

***Exercise 3***
```sql
SELECT dept, MAX(salary) as max_sal, MIN(salary) as min_sal
FROM employees
WHERE dept IS NOT NULL
GROUP BY dept;
```

```python
no_empty_depts = employees[employees['dept'].notna()]
result = no_empty_depts.groupby('dept')['salary'].agg(['max', 'min'])
result
```

***Exercise 4***
```sql
# Add a column that categorizes salaries
# 'Low': < 70000
# 'Mid': 70000-90000  
# 'High': > 90000

# How many employees in each salary range?
employees.groupby('ranged').size()
```

```python
employees['ranged'] = np.where(employees['salary'] > 90000, 'High', np.where(employees['salary'] < 70000, 'Low', 'Medium'))
employees

# How many employees in each salary range?
employees.groupby('ranged').size()
```

***Exercise 5***
```sql
# For each department, calculate:
# (department's total salary / company's total salary) * 100
# Add this as a new column called 'dept_salary_pct'
```

```python
salary_by_dept = employees.groupby('dept')[['salary']].agg('sum') # get the grouped salaries
totalSalary = employees['salary'].sum() # get total salary
salary_by_dept['dept_pct'] = ((salary_by_dept['salary'] / totalSalary)* 100).round() #add column of pct
salary_by_dept #print
```
***Exercise 6***
```sql
Task: Your company wants to give raises. Create a new column 'new_salary' where:

Everyone gets a 10% raise
If someone's current salary is NULL (like Jack), set their new salary to 65000 (company minimum)
```

```python
employees['new_salary'] = np.where(employees['salary'].isna(), 65000, employees['salary'] * 1.1)
employees
```
***Exercise 7***
```sql
Task: Create a summary table showing for each department:

Number of employees
Average salary (excluding NULLs)
Highest salary
Lowest salary

Name the columns: 'count', 'avg_salary', 'max_salary', 'min_salary'
```

```python
new_table = employees.groupby('dept')['salary'].agg(count='count', avg_salary='mean', max_salary='max', min_salary='min')
new_table
```

***Exercise 8***
```sql
Task: Now merge your new_table back with the original employees to add department statistics to each employee row.
After merging, each employee should see their department's avg_salary alongside their own salary.
Hint: You'll need:

.merge() or .join()
Think about what column connects the two tables
```

```python
merged = pd.merge(employees, new_table, on='dept')
merged
# or
merged = pd.merge(employees, new_table[['avg_salary']], on='dept')
merged
```

***Exercise 9***
```sql
Task: Identify employees who are salary outliers in their department. An outlier is someone whose salary is more than 20% above or below their department average.
Create a new column 'salary_status' with values:

'High outlier' if salary > avg_salary * 1.2
'Low outlier' if salary < avg_salary * 0.8
'Normal' otherwise

Hint: You'll need the merged DataFrame with avg_salary, then use np.where() or np.select() for multiple conditions.
```

```python
merged['salary_status'] = np.where(merged['salary'] > 1.2 * merged['avg_salary'], 'High Outlier', np.where(merged['salary'] < 0.8 * merged['avg_salary'], 'Low Outlier','Normal'))
merged
```

***Exercise 10***
```sql
Exercise P010: Date Operations
Task: The hire_date column is currently a string. Convert it to datetime and create these new columns:

'years_employed' - how many years since hire date (assume today is 2025-07-11)
'hire_quarter' - which quarter they were hired (Q1, Q2, Q3, Q4)

Hint:

Use pd.to_datetime() to convert strings to dates
For years: (today - hire_date).dt.days / 365.25
For quarters: .dt.quarter
```

```python
import datetime
merged['hire_date'] = pd.to_datetime(merged['hire_date'])
merged['years_employed'] = round((datetime.datetime.today() - merged['hire_date']).dt.days / 365.25)
merged['hire_quarter'] = merged['hire_date'].dt.quarter
merged
```

---------------Exercise format
***Exercise ***
```sql

```

```python

```
---------------