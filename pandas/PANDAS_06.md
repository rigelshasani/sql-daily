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
# Create copies
temp = employees.copy()
dep = departments.copy()
emp_avg = temp['salary'].mean()
# Create 
summary_table = temp.groupby('dept').agg(salary_total = ('salary','sum') , salary_avg=('salary','mean'))
dep = dep.merge(summary_table, left_on='dname', right_on='dept', how='left')
summary_table = dep
temp['salary'] = temp['salary'] * 1.1
temp = temp.groupby('dept').agg(
    salarytotal_plus10percent=('salary','sum'), 
)
summary_table = summary_table.merge(temp, left_on='dname', right_on='dept', how='left')

summary_table['salary_total'] = summary_table['salary_total'].fillna(0)
summary_table['salary_avg'] = summary_table['salary_avg'].fillna(emp_avg)
summary_table['salarytotal_plus10percent'] = summary_table['salarytotal_plus10percent'].fillna(0)

summary_table['utilization_%'] = (summary_table['salary_total'] / summary_table['budget']) * 100
summary_table['projected_util_%'] = (summary_table['salarytotal_plus10percent'] / summary_table['budget']) * 100
summary_table['numberOfEmployeesAvailableToAdd'] = np.where(((summary_table['budget'] - summary_table['salary_total']) / summary_table['salary_avg']) < 1, 0, np.floor(((summary_table['budget'] - summary_table['salary_total']) / summary_table['salary_avg'])))
summary_table
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
df = employees.dropna(subset=['salary']).copy()

#Employee-level enrichments first
df['hire_year'] = pd.to_datetime(df['hire_date']).dt.year
df['years_employed'] = 2025 - df['hire_year']
df['starting_salary'] = df['salary'] / 1.03 ** df['years_employed']

#Cohort-level aggregation
cohort_agg = df.groupby('hire_year').agg(
    cohort_size = ('first_name', 'count'),
    current_avg = ('salary', 'mean'),
    starting_avg = ('starting_salary', 'mean')
)

#Compute growth rate at the cohort level
cohort_agg['salary_growth_rate'] = (cohort_agg['current_avg'] / cohort_agg['starting_avg']).round(2)
cohort_agg
```

***Exercise 57***
```sql
-- Build complete org hierarchy showing:
-- employee -> direct_manager -> skip_manager -> dept_head
-- Include level in hierarchy (1=dept_head, 2=direct report to head, etc)   
```

```python
skip = employees.copy()
skip['full_name'] = skip['first_name'] + ' ' + skip['last_name']
skip = skip[['id', 'full_name', 'manager_id']]
emptree = skip.copy().fillna(0)

emptree['divider0'] = '|'
# manager merge and rename

emptree = emptree.merge(skip, left_on='manager_id', right_on='id', suffixes=('_emp', '_mgr'), how='left')

emptree.rename(columns={
    'id_mgr':'direct_manager_id',
    'full_name_mgr': 'direct_manager_name',
    'manager_id_mgr': 'direct_manager_manager_id'
}, inplace=True)

# Divide
emptree['divider1'] = '|'
#skip manager merge and rename

emptree = emptree.merge(skip, left_on='direct_manager_manager_id', right_on='id' ,how='left')

emptree.rename(columns={
    'id': 'skip_manager_id',
    'full_name': 'skip_manager_name',
    'manager_id': 'skip_manager_manager_id'
}, inplace=True)


# Divide
emptree['divider2'] = '|'

# #dept heads
emptree  = emptree.merge(skip, left_on='skip_manager_manager_id', right_on='id', how='left')

emptree.rename(columns={
    'id': 'dept_head_id',
    'full_name': 'dept_head_name',
    'manager_id': 'dept_head_manager_id'
}, inplace=True)

emptree = emptree.merge(skip, left_on='dept_head_manager_id', right_on='id', how='left')
emptree.rename(columns={
    'id':'org_head_id',
    'full_name': 'org_head_name',
    'manager_id': 'org_head_manager_id'
}, inplace=True)

emptree['level_in_hierarchy'] = emptree[['direct_manager_id','skip_manager_id','dept_head_id','org_head_id']].notna().sum(axis=1) + 1

emptree
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