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
# Copy original & Get hire year & Get today's date -> Calculate tenure years
emp = employees[employees['dept'].notna()].copy()
emp['hire_year'] = pd.to_datetime(emp['hire_date']).dt.year
today = pd.to_datetime('2025-07-18')
emp['tenure_years'] = (today - pd.to_datetime(emp['hire_date'])).dt.days / 365.25
grouped_tenure = emp.groupby('dept').agg({'tenure_years' : 'mean'})
# Get employees after 2020, count groups by dept & count all emps grouped by dept
recent_hires = emp[emp['hire_year'] > 2020]
filterfirst = recent_hires.groupby('dept').size()
total_per_dept = emp.groupby('dept').size()
# Get percentage by comparing small groups to big groups
turnover_pct = (filterfirst / total_per_dept * 100).fillna(0)
# Create copy
merged = grouped_tenure.copy()
# Assign series to column
merged['Turnover%'] = turnover_pct
# Since dept is the index and not a column, we assign the "index" instead of the values to all_depts
all_depts = merged.index
# Group by dept, get salary averages, reindex by the dept names we got earlier and fill NA values with 0
recent_salaries = recent_hires.groupby('dept')['salary'].mean().reindex(all_depts, fill_value=0)
merged['Avg Salary (Recent)'] = recent_salaries
# Same approach but for old salaries
old_salaries = (emp[emp['hire_year'] <= 2020]).groupby('dept')['salary'].mean().reindex(all_depts, fill_value=0)
merged['Avg Salary (Veteran)'] = old_salaries
merged
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
merged = employees.merge(departments, left_on=('dept'), right_on=('dname'))
merged['Salary%ofBudget'] = (merged['salary'] / merged['budget']) * 100
merged['FlagMoreThan20%'] = np.where(merged['Salary%ofBudget'] > 20, 'Yes', 'No')
deptUtil = (merged.groupby('dept')['salary'].sum() / merged.groupby('dept')['budget'].mean()) * 100
# 2 SOLUTIONS BELOW!
#EITHER this
merged['Department Utilization'] = merged['dept'].map(deptUtil)
#OR this with merge
deptUtil_df = deptUtil.to_frame('Department Utilization')
merged = merged.merge(deptUtil_df, on='dept')

# PICK ONE OR IT WONT WORK WITH BOTH LOL

# Round for readability
merged['Salary%ofBudget'] = merged['Salary%ofBudget'].round(1)
merged['Department Utilization'] = merged['Department Utilization'].round(1)

merged
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
emp = employees.copy()
mgr = employees.copy()
emp = emp.merge(mgr, left_on='manager_id', right_on='id', how='inner',  suffixes=('_emp', '_mgr'))
ratio = emp[['first_name_emp','last_name_emp', 'first_name_mgr','last_name_mgr', 'salary_emp', 'salary_mgr', 'id_emp', 'manager_id_emp']]
summary = ratio.copy()
summary['ratio'] = summary['salary_emp'] / summary['salary_mgr']
gommi = summary.groupby('manager_id_emp')['first_name_emp'].count().reset_index(name='direct_reports_count')
summary = summary.merge(gommi, on='manager_id_emp')
summary['flag'] = np.where(summary['salary_emp'] > summary['salary_mgr'], 'Yes', 'No')
summary
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
medianbydept = employees.groupby('dept')['salary'].median()
medianbydept
emp = employees.copy()
emp = emp.merge(medianbydept, on='dept', suffixes=('','_median'))
yup = emp[(emp['salary'] > 1.5 * emp['salary_median']) | (emp['salary'] < 0.5 * emp['salary_median'])]
yup['relation_to_median'] = (yup['salary'] - yup['salary_median']) / yup['salary_median'] * 100
counts = yup.merge(emp.groupby('dept')['first_name'].count(), on='dept')
counts = counts[counts['first_name_y'] > 2]
counts
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
depts = employees[['first_name', 'salary', 'dept', 'hire_date']]
depts = depts[depts['salary'].notna()]
depts = depts.sort_values('hire_date')
depts['running_salary'] = depts.groupby('dept')['salary'].cumsum()
depts['running_200k'] = np.where(depts['running_salary'] > 200000, 'Passed', 'Not-Passed')
depts['running_count'] = depts.groupby('dept').cumcount() + 1
depts['running_avg'] = depts['running_salary'] / depts['running_count']
depts
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
de = employees[['dept', 'salary']]
de = de[de['salary'].notna()]
de = de.groupby('dept').agg({'salary':'mean'})
de = de.reset_index()
de2 = de.copy()
de2 = de.merge(de2,  how='cross')
de2 = de2[(de2['salary_x'] != de2['salary_y']) & (de2['dept_x'] < de2['dept_y'])]
de2['difference'] = abs(de2['salary_y'] - de2['salary_x'])
de2['which_pays_more'] = np.where(de2['salary_y'] - de2['salary_x'] > 0, de2['dept_y'], de2['dept_x'])
de2['ratio'] = de2['salary_x'] / de2['salary_y']
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
emp_report = employees[['first_name', 'last_name', 'dept', 'salary', 'hire_date']]
emp_report = emp_report.merge(departments, left_on='dept', right_on='dname')
emp_report = emp_report.drop('dname', axis=1)
emp_report.columns = ['first_name', 'last_name', 'dept', 'salary', 'hire_date', 'dept_budget']
emp_report_grouped = emp_report.groupby('dept').agg(
    avg_salary = ('salary','mean'), 
    median_salary = ('salary','median'), 
    std_salary = ('salary','std'))
emp_report['hire_year'] = pd.to_datetime(emp_report['hire_date']).dt.year
counter = emp_report.groupby(['dept','hire_year']).agg(emp_hired_that_year = ('salary','count'))
counter = counter.unstack(level='hire_year')
counter.columns
counter.columns = ['hired_' + str(col[1]) for col in counter.columns]
counter = counter.fillna(0)
emp_report_grouped = emp_report_grouped.join(counter)
utilized = emp_report.groupby('dept').agg({'salary':'sum', 'dept_budget':'sum'})
counter = counter.join(utilized, on='dept')
counter
counter['utilized_percentage'] = (
    (counter['salary'] / counter['dept_budget'] * 100)
    .round(2).astype(str) + '%'
)
counter

extra = counter[['salary', 'dept_budget', 'utilized_percentage']].rename(columns={'salary': 'total_salary'})
emp_report_grouped = emp_report_grouped.join(extra)
emp_report_grouped

```

---

