# Pandas Exercises 71-80: Advanced Consolidation

## Exercise 71: Salary Compression Analysis
```sql
-- For each department, calculate the "salary compression ratio"
-- (difference between max and min salary) / average salary
-- Also show how many employees are within 10% of the dept average
-- Order by compression ratio (lowest = most compressed salaries)
```

```python
emp = employees.copy()
emp = emp[emp['salary'].notna()]

summary = emp.groupby('dept')['salary'].agg(max='max', min='min', avg='mean')
emp = emp.merge(summary, on='dept')

emp['within10'] = np.where((emp['salary']>=0.9*emp['avg']) & (emp['salary']<=1.1*emp['avg']), 1, 0)
summary['within10']= emp.groupby('dept')['within10'].agg('sum')
summary['compression_ratio'] = (summary['max'] - summary['min']) / summary['avg']
summary['compression_ratio'] = np.where(summary['avg']==0, np.nan, summary['compression_ratio'])
summary
```

---

## Exercise 72: Consecutive Hire Analysis  
```sql
-- Find all cases where a department hired 2+ people within 90 days
-- Show: dept, first_hire_date, second_hire_date, days_between
-- Include the names of both employees hired
```

```python
# copy, delete empty departments, sort by both dept and hire-date
emp = employees.copy()
emp = emp[emp['dept'].notna()]
emp['hire_date'] = pd.to_datetime(emp['hire_date']) 
emp = emp.sort_values(['dept', 'hire_date'])
# save hire date shifted and id of the shifted column to the current column for comparison
emp[['hire_date_shifted', 'id_shifted', 'first_name_shifted', 'last_name_shifted']] = (emp.groupby('dept')[['hire_date', 'id', 'first_name', 'last_name']].shift(1))

# calculate hiring date difference between current and earlier row(already sorted by hire_Date)
emp['hire_date_diff'] = (emp['hire_date'] - emp['hire_date_shifted']).dt.days

# filter for less than 90 days
emp = emp[emp['hire_date_diff'] <= 90]

emp = emp.rename(columns={'hire_date':'second_hire_date','hire_date_shifted':'first_hire_date','hire_date_diff':'days_between','first_name':'second_hire_first_name', 'last_name':'second_hire_last_name', 'first_name_shifted':'first_hire_first_name', 'last_name_shifted':'first_hire_last_name'})
emp['first_employee'] = emp['first_hire_first_name'] + ' ' + emp['first_hire_last_name']
emp['second_employee'] = emp['second_hire_first_name'] + ' ' + emp['second_hire_last_name']
emp = emp[['first_employee', 'dept','first_hire_date', 'second_hire_date', 'second_employee', 'days_between']]
emp = emp.sort_values(['dept', 'first_hire_date'])
emp
```

---

## Exercise 73: Manager Span & Depth
```sql
-- For each manager, calculate:
-- 1. Direct reports count
-- 2. Skip-level reports count (reports of their direct reports)
-- 3. Total reports (direct + skip-level only, max 2 levels)
-- 4. Total salary responsibility (sum of direct and skip-level reports' salaries)
-- Only show managers with at least 1 direct report
```

```python
# Your solution here
```

---

## Exercise 74: Budget Reallocation Simulation
```sql
-- If we moved the highest paid person from each "over-budget" dept
-- (where salaries > 60% of budget) to the dept with most budget room:
-- 1. Which employees would move?
-- 2. What would the new utilization % be for each dept?
```

```python
# Your solution here
```

---

## Exercise 75: Tenure-Based Salary Fairness
```sql
-- Group employees by tenure brackets (0-2, 2-4, 4-6, 6+ years)
-- For each bracket + dept combination:
-- Show avg salary and flag if it's lower than junior brackets
-- (indicating possible pay inversion)
```

```python
# Your solution here
```

---

## Exercise 76: Cross-Department Collaboration Potential
```sql
-- Find pairs of employees from different departments where:
-- 1. They have the same manager (indicating cross-dept management)
-- 2. Their salaries are within 15% of each other
-- Show the potential collaboration pairs with their depts and salaries
```

```python
# Your solution here
```

---

## Exercise 77: Promotion Readiness Score
```sql
-- Calculate a "promotion readiness score" for each employee:
-- - 40% weight: Years of experience (normalized 0-1 within dept)
-- - 30% weight: Salary below dept average (indicates room for growth)
-- - 30% weight: Not a manager yet (has no direct reports)
-- Show top 2 candidates per department
```

```python
# Your solution here
```

---

## Exercise 78: Department Health Metrics Dashboard
```sql
-- Create a comprehensive health check per department:
-- 1. Turnover risk: % of employees hired in last 2 years (0-100 scale)
-- 2. Salary spread: coefficient of variation (std/mean) (0-100 scale, lower is better)
-- 3. Manager ratio: managers / total employees (0-100 scale)
-- 4. Budget stress: (salary_total / budget) * 100
-- Health score = average of all 4 metrics (equal 25% weight each)
-- Show all metrics plus final health score
```

```python
# Your solution here
```

---

## Exercise 79: Department Distance Summary
```sql
-- Calculate average "organizational distance" between departments:
-- For each pair of employees, distance is:
-- - Same manager = distance 1
-- - Same department (different manager) = distance 2
-- - Different department = distance 3
-- Create a pivot table showing avg distance between each dept pair
-- (Should result in a 4x4 matrix for Tech, Sales, Marketing, HR)
```

```python
# Your solution here
```

---

## Exercise 80: Compensation Bands Auto-Generation
```sql
-- Automatically create salary bands for each department:
-- 1. Use quartiles (0-25th, 25-50th, 50-75th, 75-100th percentile)
-- 2. Label bands as: Entry, Mid, Senior, Principal
-- 3. For each band show: count, avg_salary, min_salary, max_salary
-- 4. Flag employees with 5+ years tenure still in Entry band as "review needed"
-- 5. Show these flagged employees with their name, tenure, salary, and dept
```

```python
# Your solution here
```

---

## Bonus Challenge: Combine Multiple Exercises
```sql
-- Using techniques from exercises 71-80, create a single executive summary:
-- 1. Which department has the healthiest compensation structure?
-- 2. Which employees are flight risks (underpaid for tenure)?
-- 3. Where are the biggest opportunities for reorg/optimization?
-- Present as a clean, business-ready summary table
```

```python
# Your solution here
```