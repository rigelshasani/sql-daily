***Exercise 51***
```sql
-- Calculate percentile rank for salaries within each department
-- Percentile rank = (rank - 1) / (count - 1) * 100
-- Same salaries get same percentile
```

```python
emp = employees.copy()
emp = emp[emp['salary'].notna()]
emp['rankInDept'] = emp.groupby('dept')['salary'].rank()
# emp['deptCount'] = emp.groupby('dept')['salary'].transform('count')
# emp['percentile_%'] = round((emp['rankInDept'] - 1) / (emp['deptCount'] - 1) * 100)
# or 
emp2 = emp.groupby('dept')['salary'].agg('count')
emp['deptCount'] = emp['dept'].map(emp2)
emp['percentile_%'] = round((emp['rankInDept'] - 1) / (emp['deptCount'] - 1) * 100)

# or to handle single emp depts
#  emp['percentile_%'] = np.where(
#    emp['deptCount'] == 1, 
#    50.0,  # single employee = 50th percentile
#    round((emp['rankInDept'] - 1) / (emp['deptCount'] - 1) * 100)
#)
emp = emp.sort_values(['dept', 'salary'], ascending=[True, False])
emp[['id', 'first_name', 'dept', 'salary', 'percentile_%']]
```

***Exercise 52***
```sql
-- For each employee, calculate:
-- 1. Their salary rank within dept (dense_rank)
-- 2. Difference from dept leader (highest salary)
-- 3. Whether they're in top 50% of dept (Y/N flag)
```

```python
emp = employees.copy()
emp = emp[emp['salary'].notna()]
emp['deptrank'] = emp.groupby('dept')['salary'].rank(ascending=False, method='dense')
emp['biggestInDept'] = emp.groupby('dept')['salary'].transform('max')
emp['difference_compared_to_nr1'] = emp['biggestInDept'] - emp['salary']
emp['median'] = round(emp.groupby('dept')['salary'].transform('median'))
emp['flag'] = np.where(emp['salary'] > emp['median'], 'Y', 'N')
emp
```

***Exercise 53***
```sql
-- Compare hiring patterns year-over-year
-- Show: year, total_hired, change_from_prev_year, pct_change
```

```python
emp  = employees.copy()
emp['hire_year'] = pd.to_datetime(emp['hire_date']).dt.year
# Create a summary by year
summary_by_year = emp.groupby('hire_year').size().reset_index(name='total_hired')
summary_by_year['change_from_prev_year'] = summary_by_year['total_hired'] - summary_by_year['total_hired'].shift(1)
summary_by_year['pct_change'] =  (summary_by_year['change_from_prev_year'] /  summary_by_year['total_hired'].shift(1)) * 100
summary_by_year
```

***Exercise 54***
```sql
-- Find all manager-subordinate pairs where:
-- 1. Manager has 2+ direct reports
-- 2. Calculate avg salary of all reports for each manager
-- 3. Flag if any report earns within 10% of manager
```

```python
emp = employees.copy()
managers = employees.copy()

count = managers.groupby('manager_id').size().reset_index(name='count')
count = count.set_index('manager_id')['count']

managers['count'] = managers['id'].map(count)
managers = managers[managers['count'] >= 2]
managers = managers.merge(employees, left_on='id', right_on='manager_id')
meansalary = managers.groupby('id_x').agg({'salary_y':'mean'})
managers['mean_salary_of_reports'] = managers['id_x'].map(meansalary['salary_y'])
managers['is_high_earner'] = (managers['salary_y'] >= managers['salary_x'] * 0.9).astype(int)
stats = managers.groupby('id_x').agg({
    'salary_y':'mean',
    'is_high_earner':'max'
})
managers['mean_salary_of_reports'] = managers['id_x'].map(stats['salary_y'])
managers['has_high_earner'] = managers['id_x'].map(stats['is_high_earner'])
managers[['id_x', 'first_name_x', 'last_name_x', 'salary_x',
       'manager_id_x', 'id_y', 'first_name_y',
       'last_name_y', 'salary_y', 'manager_id_y',
       'mean_salary_of_reports', 'is_high_earner', 'has_high_earner']]
```

***Exercise 55***
```sql
-- For each department calculate:
-- 1. Current utilization (total_salaries / budget)
-- 2. Projected utilization if everyone gets 10% raise
-- 3. How many more people could be hired at avg dept salary
```

```python

```

***Exercise 56***
```sql
-- Group employees by hire year (cohort) and analyze:
-- 1. Cohort size
-- 2. Current avg salary by cohort
-- 3. Salary growth rate (current avg / starting avg)
-- Assume 3% annual raises for starting salary calculation
```

```python

```

***Exercise 57***
```sql
-- Build complete org hierarchy showing:
-- employee -> direct_manager -> skip_manager -> dept_head
-- Include level in hierarchy (1=dept_head, 2=direct report to head, etc)   
```

```python

```

***Exercise 58***
```sql
-- Create matrix showing salary comparisons between all dept pairs
-- For each pair show: avg_salary_ratio, median_salary_ratio
```

```python

```

***Exercise 59***
```sql
-- Create salary bands (0-70k, 70-85k, 85-100k, 100k+)
-- For each band show:
-- 1. Employee count and percentage of total
-- 2. Which departments are represented
-- 3. Avg years of experience (from hire_date)  
```

```python

```

***Exercise 60***
```sql
-- Simulate performance ratings based on:
-- 1. Salary relative to dept average (40% weight)
-- 2. Tenure/experience (30% weight)  
-- 3. Position in hierarchy (30% weight)
-- Create rating 1-5 and recommend salary adjustment %
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