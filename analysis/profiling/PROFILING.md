# Memory Analysis & Profiling

Goal: decrease memory usage as much as possible in efficient placements.
```
np.int64(11173) < Starting
np.int64(6382)  < After Optimizations
```
Total savings in percentage: **43%**
### Measuring memory usage

```python
df.info(memory_usage='deep')
df.memory_usage(deep=True) (per-column breakdown)
```

#### Optimizing column types

- Converting object → category for repeated strings
- Downcasting int64 → int32 or float64 → float32
- Use pd.to_numeric(..., downcast='integer')
#### Profiling methods

- df.describe(include='all') for stats + categorical summary
- df.nunique() vs df.value_counts() for uniqueness
- Distribution checks: .hist(), .plot(kind='box')
#### Case study (employees.csv)

- Load, check memory footprint
- Optimize columns (dept, salary, hire_date)
- Show before/after memory usage
- Note which optimizations saved the most
#### Checklist

- Always check .info() on load
- Always test .nunique() on object columns → candidate for category
- Always test .isna().sum() for missing value strategy

---

```python
employees.info(memory_usage="deep")
```

This command shows memory usage as a total footprint.

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 40 entries, 0 to 39
Data columns (total 7 columns):
 #   Column      Non-Null Count  Dtype  
---  ------      --------------  -----  
 0   id          40 non-null     int64  
 1   first_name  40 non-null     object 
 2   last_name   40 non-null     object 
 3   dept        39 non-null     object 
 4   salary      39 non-null     float64
 5   manager_id  38 non-null     float64
 6   hire_date   40 non-null     object 
dtypes: float64(2), int64(1), object(4)
memory usage: 10.9 KB
```

To see which columns are hogging memory:

```python
employees.memory_usage(deep=True)
```

```
Index          132
id             320
first_name    2441
last_name     2509
dept          2451
salary         320
manager_id     320
hire_date     2680
dtype: int64
```

###### **NOTICE**: highest memory usage is on **first/last name, dept and hire_date.**

Let’s make a smart plan (tiny steps):
1. Only convert to `category` when the column has **low cardinality** (many repeats). Good candidates are usually `dept` (few values). Names are often high‑cardinality (mostly unique), so `category` might not help there.
2. Parse dates to `datetime64[ns]` (8 bytes/row, fast ops)    
3. Downcast numerics:
    - `id`: `int64 → int32` (if range allows)
    - `salary`: maybe `float64 → float32`
    - `manager_id`: use pandas’ nullable integer `Int32/Int64` if you want integers with NaN; otherwise keep float.

Let's see these values' cardinality.
```python
employees[['first_name','last_name','dept']].nunique()
```
What we notice is that dept is a good candidate for categorization. 
Also: (`hire_date` using ~2.6 KB) comes from storing dates as Python strings (`object`). If we convert that to `datetime64[ns]`, pandas packs it into a fixed 8 bytes per row → huge savings.
```
first_name    40
last_name     40
dept           4
dtype: int64
```
Convert `dept` → `category` and `hire_date` → `datetime64[ns]`
```python
employees['dept'] = employees['dept'].astype('category')
employees['hire_date'] = pd.to_datetime(employees['hire_date'])

employees.memory_usage(deep=True) # now let's see the savings in memory
```
Now let's see the savings in memory. 
```
Index          132
id             320
first_name    2441
last_name     2509
dept           460           <----- MASSIVE SAVINGS
salary         320
manager_id     320
hire_date      320           <----- MASSIVE SAVINGS
dtype: int64
```

Now let's continue with first/last name profiling.
```python
employees[['first_name', 'last_name']].applymap(len).describe()
```

```
|     |first_name|last_name|
      |----------|---------|
|count|40.00000  |40.000000|
|mean |4.025000  |5.7250000|
|std. |0.831665  |1.2807750|
|min. |3.000000  |3.0000000|
|25%  |3.000000  |5.0000000|
|50%  |4.000000  |5.5000000|
|75%  |4.250000  |6.0000000|
|max  |6.000000  |9.0000000|
```

- **First names**: mean length ≈ 4, max 6.
- **Last names**: mean length ≈ 5.7, max 9.
- Variability is tiny (std < 1.3).

So the strings themselves are _short and consistent_. 
Length is **not** the reason for the heavy memory use.

The real culprit = **high cardinality** (40 unique values across 40 rows). Categories work best when values repeat a lot — e.g., `dept` (4 uniques). With names, uniqueness means the category index would be almost as large as storing them directly, so we don’t gain much.

### Downcasting Numerics

- If `id` fits in 32‑bit and has no NA → `employees['id'] = employees['id'].astype('int32')`.
- If `salary` range tolerates less precision → `astype('float32')`.
- If `manager_id` is really integer-ish with NAs → `astype('Int32')` (nullable int).

```python
# 1) Ranges
employees[['id','salary','manager_id']].agg(['min','max'])

# 2) Missingness
employees[['id','salary','manager_id']].isna().sum()
```

```
| id  | salary | manager_id |
| --- | ------ | ---------- |
| min | 1      | 65000.0    |
| max | 40     | 107000.0   |
```

```
id            0
salary        1
manager_id    2
dtype: int64
```

Results:
- **`id`:** Range 1–40, no NAs → safe to downcast from `int64` → `int32`.
- **`salary`:** Range 65k–107k, **1 NA** → can downcast from `float64` → `float32`.
- **`manager_id`:** Range 1–15, **2 NAs** → since it’s really integers but with nulls, best fit is **nullable Int32** (capital “I”).

Before:
```
Index          132
id             320            <
first_name    2441
last_name     2509
dept           460
salary         320            <
manager_id     320            <
hire_date      320
dtype: int64
```
After:
```
Index          132
id             160             <------HALF the memory
first_name    2441
last_name     2509
dept           460
salary         160             <------HALF the memory
manager_id     200             <------SUBSTANTIAL IMPROVEMENT
hire_date      320
dtype: int64
```