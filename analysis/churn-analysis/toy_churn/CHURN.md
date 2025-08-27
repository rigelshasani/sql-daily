Concept Introduction: Customer Churn Analysis

What is churn? When customers stop using a service (cancel subscription, stop buying, etc.)
What is churn analysis? Using data to predict which customers are likely to leave so we can try to keep them.
Basic business logic:

Customers who use the service longer (tenure) = less likely to churn
Customers paying more = might be more/less likely to churn (depends)
Recent behavior matters more than old behavior

Concept Introduction: Column Categorization for Business Problems
When I have a business problem, I group columns by importance:

```python
# Basic pattern for categorizing columns
critical_cols = ['target_variable']  # What I'm trying to predict
important_cols = ['strong_predictors']  # Columns that likely predict the target well
optional_cols = ['nice_to_have']  # Helpful but not essential
```

In my churn dataset, which column tells me if a customer actually churned? (Hint: look at the column names)
Once I identify that, then we can think about which other columns would help predict it.
Before getting there I have to analyze whether or not the data is reliable. 

When i call `df_raw[df_raw['age'] < 0]`, i get 61 rows back, but age shouldnt be negative.
This is an indicator that the data is unreliable.

```python
df_raw['age'].min()
```
```bash
np.float64(-18.836003774275135)
```
Okay so in professional situations this type of data wouldn't be accepted since it's an indicator that the whole dataset could be unreliable, but considering this is a training setup, we will clean the data by removing these outliers. 

In our dataset, what percentage of the age values are clearly wrong (negative or >120)?

```python
below0 = df_raw[df_raw['age'] <= 0].count()
below0 = below0['age']
below0
above120 = df_raw[df_raw['age'] > 120]['age'].count()
above120
beyondBounds = below0 + above120
beyondBounds
withinBounds = df_raw[(df_raw['age'] <= 120) & (df_raw['age'] > 0)]['age'].count()
withinBounds
percentage = (beyondBounds / (beyondBounds + withinBounds)) * 100
percentage
```
Here we see the percentage is 2.44%, or 120 values are beyond possible bounds(Assuming max age is 120 and minimum age is 0.

120 INVALID VALUES 
4788 VALID VALUES

--
Total: 4908 VALUES
But something doesn't look quite right. Let's count all column rows and see what's going on
```python
df_raw.count()
```

```
customer_id         5045
first_name          5150
last_name           5150
age                 4908
tenure_months       4994
monthly_charges     5150
total_charges       5098
contract            5150
phone_service       5150
internet_service    5150
churn               5055
dtype: int64
```
Okay it looks here like many of these columns have problematic counts, with many of the values missing, which we will have to fill out. 
The Age column is missing 5150 - 4908 = **242 values**. And even the other columns are missing other values. It looks like 5150 is the actual number of customers, considering it gets repeated in contract, phone service and monthly_charges. 

Let's check on another column to make sure. How about tenure_months?

```python
df_raw['tenure_months'].min()
```
This gives me 1.0, which is good, means it's valid. 

```python
df_raw['tenure_months'].max()
```
This gives me 72 months max, also valid.

Now let's see the distribution:
```python
df_raw.groupby('tenure_months').size()
```

```
tenure_months
1.0     67
2.0     65
3.0     76
4.0     86
5.0     61
        ..
68.0    66
69.0    79
70.0    70
71.0    66
72.0    63
Length: 72, dtype: int64
```
This distribution is pretty odd, as usually contracts are either 1/2/3/4 year, not so equally distributed each month. This is of course because the data is programmatically generated.

Let's check for missingness.

```python
df_raw['tenure_months'].count()
```
Looks like its missing 161 values. 
```
np.int64(4994)
``` 

What I ran earlier was apparently called a Column Profiling. It's made up of a range + missingness check + distribution shape.

Column Profiling: Numeric Range + Missingness + Distribution Shape.