# Pandas Consolidation Exercises 31-40
*Bridging Current Skills to Intermediate Level*

## Setup
```python
import pandas as pd
import numpy as np

employees = pd.DataFrame({
    'id': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    'first_name': ['Ana', 'Bob', 'Cara', 'Dave', 'Eve', 'Frank', 'Grace', 'Hank', 'Iris', 'Jack'],
    'last_name': ['Smith', 'Jones', 'Brown', 'Wilson', 'Davis', 'Miller', 'Moore', 'Taylor', 'Anderson', 'Thomas'],
    'dept': ['Tech', 'Sales', 'Tech', 'Marketing', 'Tech', 'Sales', 'Marketing', 'Tech', 'Sales', None],
    'salary': [95000, 80000, 92000, 75000, 98000, 82000, 77000, 91000, 79000, None],
    'manager_id': [None, 1, 1, 2, 1, 2, 4, 3, 6, 7],
    'hire_date': ['2018-01-15', '2019-03-22', '2018-06-30', '2020-01-10', '2017-09-01', '2019-11-15', '2020-08-20', '2018-04-12', '2021-02-28', '2022-05-16']
})

departments = pd.DataFrame({
    'dname': ['Tech', 'Sales', 'Marketing', 'HR'],
    'budget': [500000, 300000, 200000, 150000]
})
```

---

## Exercise 31: Multiple Aggregations with Complex Filtering
```sql
-- Find departments where:
-- 1. Average salary > 85000 OR total salary > 250000
-- 2. Show: dept name, avg salary, total salary, employee count, salary range (max-min)
-- 3. Sort by total salary descending
```

```python
emp = employees[['dept', 'salary', 'first_name']]
emp = emp[(emp['salary'].notna()) & (emp['dept'].notna())]
empie = emp.groupby('dept').agg(
    count = ('first_name' , 'count'),
    avg = ('salary', 'mean'),
    sumi = ('salary','sum'),
    maxi = ('salary','max'),
    mini = ('salary', 'min')
    )
empie = empie.reset_index()
empie = empie[(empie['avg'] > 85000) & (empie['sumi'] > 250000)]
empie['range'] = empie['maxi'] - empie['mini']
empie.sort_values('sumi')
empie
```

---

## Exercise 32: Complex Conditional Column Creation
```sql
-- Create a 'performance_tier' column based on:
-- Tier A: Salary > dept average AND hired before 2020
-- Tier B: Salary > dept average OR hired before 2020 (but not both)
-- Tier C: Everyone else
-- Then count employees in each tier by department
```

```python
# group by dept 
emp = employees
boob = emp.groupby('dept').agg(
    average = ('salary' , 'mean')
    )
emp = emp.merge(boob, on='dept', how='inner')
emp['performance_tier'] = np.where((emp['salary'] > emp['average']) & (pd.to_datetime(emp['hire_date']).dt.year < 2020), 'Tier A', 
                          np.where(((emp['salary'] > emp['average']) & (pd.to_datetime(emp['hire_date']).dt.year >= 2020)) | 
                                   ((emp['salary'] < emp['average']) & (pd.to_datetime(emp['hire_date']).dt.year < 2020)), 
                                    'Tier B', 'Tier C'))
emp
```

---

## Exercise 33: Multi-Step Transformation with Ranking
```sql
-- For each department:
-- 1. Rank employees by salary (1 = highest)
-- 2. Calculate the salary difference between each employee and the next lower rank
-- 3. Show only employees ranked 1-3 with their salary gaps
```

```python
emp = employees.copy()
emp= emp[emp['salary'].notna()]
emp['ranking']= emp.groupby('dept')['salary'].rank(ascending=False)
emp = emp.sort_values(['dept', 'ranking'])
emp['salary_shifted'] = emp['salary'].shift(-1)
emp['diff'] = emp['salary'] - emp['salary_shifted']
emp
```

---

## Exercise 34: Time-Based Analysis with Grouping
```sql
-- Calculate for each department:
-- 1. Average tenure (years employed) as of 2025-07-18
-- 2. Turnover rate (% of employees hired after 2020)
-- 3. Average salary by hiring year
-- Present as a multi-column summary
```

```python
# Your solution here
```

---

## Exercise 35: Complex Merge with Calculations
```sql
-- Merge employees with departments, then:
-- 1. Calculate each employee's salary as % of department budget
-- 2. Flag employees whose salary is > 20% of dept budget
-- 3. Show department utilization (total salaries / budget)
```

```python
# Your solution here
```

---

## Exercise 36: Hierarchical Analysis (Manager Relationships)
```sql
-- Find all manager-employee pairs and calculate:
-- 1. Salary ratio (employee salary / manager salary)
-- 2. Flag if employee makes more than manager
-- 3. Count how many direct reports each manager has
-- Include manager names and employee names
```

```python
# Your solution here
```

---

## Exercise 37: Advanced Filtering with Multiple Conditions
```sql
-- Create a report showing:
-- 1. Employees who are "outliers" (salary > 1.5x dept median OR < 0.5x dept median)
-- 2. Add columns showing: dept median, how far above/below median (as %)
-- 3. Only include departments with 3+ employees
```

```python
# Your solution here
```




---

## Exercise 38: Cumulative Calculations within Groups
```sql
-- For each department (ordered by hire date):
-- 1. Show running total of salaries
-- 2. Show running average salary
-- 3. Mark when dept first exceeded 200k in total salaries
-- 4. Include hire_date, first_name, salary in output
```

```python
# Your solution here
```

---

## Exercise 39: Cross-Department Analysis
```sql
-- Compare all pairs of departments and show:
-- 1. Average salary difference
-- 2. Which dept pays more
-- 3. Ratio of average salaries
-- 4. Exclude self-comparisons and show each pair only once
```

```python
# Your solution here
```

---

## Exercise 40: Comprehensive Summary Report
```sql
-- Create a final report that combines everything:
-- For each department show:
-- 1. Basic stats (count, avg/median/std salary)
-- 2. Hiring trends (employees hired per year)
-- 3. Budget efficiency (total salaries / budget)
-- 4. Top 2 earners' names and salaries
-- Present as a single merged DataFrame
```

```python
# Your solution here
```

---

## Solution Guidelines

### For Exercise 31 (Multiple Aggregations):
- Use `.agg()` with multiple functions
- Boolean filtering on aggregated results
- Remember to handle NaN values

### For Exercise 32 (Performance Tiers):
- Convert hire_date to datetime first
- Calculate dept averages, then merge back
- Use `np.select()` for multiple conditions

### For Exercise 33 (Ranking):
- Use `.rank(method='dense', ascending=False)`
- `.shift()` within groups for gap calculation
- Filter with boolean indexing

### For Exercise 34 (Time-Based):
- Calculate tenure with datetime operations
- Use `.value_counts(normalize=True)` for percentages
- Pivot or groupby with multiple keys

### For Exercise 35 (Budget Analysis):
- Merge on dept/dname
- Calculate percentages with vectorized operations
- Use `.assign()` for clean column creation

### For Exercise 36 (Hierarchical):
- Self-merge on manager_id = id
- Handle NaN managers appropriately
- Count with `.value_counts()` or `.groupby().size()`

### For Exercise 37 (Outliers):
- Calculate median per dept with `.transform()`
- Filter groups with `.filter(lambda x: len(x) >= 3)`
- Calculate percentage differences

### For Exercise 38 (Cumulative):
- Sort by dept and hire_date first
- Use `.cumsum()` and `.expanding().mean()`
- Boolean column for threshold crossing

### For Exercise 39 (Cross-Department):
- Create cartesian product with merge
- Filter to avoid duplicates (dept1 < dept2)
- Calculate ratios with safe division

### For Exercise 40 (Comprehensive):
- Multiple groupby operations
- Combine results with merge/join
- Use `.nlargest(2)` for top earners
- Present cleanly with proper column names
