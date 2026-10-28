# Session 09: Working with Date & Time Data

**Module:** Data Collection, Cleaning, Visualization and Analysis  
**Session:** 09  
**Status:** ✅ Completed

---

## 📋 Topics Covered
- **Converting Strings to Datetime**:
  - Ingesting date strings with `pd.to_datetime()`
  - Explicit datetime format specifiers (`format='%Y-%m-%d %H:%M:%S'`)
- **Extracting Temporal Components**:
  - Accessing date/time properties via `.dt` (`year`, `month`, `day`, `weekday`, `day_name()`, `quarter`)
- **Setting Datetime as Index & Time-Series Resampling**:
  - `df.set_index('order_date')`
  - Resampling frequencies (e.g. `'W'` for weekly aggregation, `'D'` for daily, `'M'` for monthly) via `.resample().size()`
- **Handling Timezone Conversions**:
  - Localizing naive timestamps to UTC (`.tz_localize('UTC')`)
  - Converting timezones to Indian Standard Time (`.tz_convert('Asia/Kolkata')`)
- **Temporal Feature Engineering**:
  - Creating custom boolean business logic features like `is_weekend` using `dt.dayofweek.isin([5, 6])`

---

## 🛠️ Task Walkthrough & Implementation

### Task 1: Convert String Delivery Timestamps to Datetime
**Problem Statement:**  
*Given a list of delivery timestamps as strings (e.g., `['2024-06-01 14:30', '2024-06-02 09:15', '2024-06-03 20:45']`), use pandas and `pd.to_datetime()` to convert them into datetime objects and print the result.*

```python
import pandas as pd

# List of timestamp strings
delivery_timestamps = ['2024-06-01 14:30', '2024-06-02 09:15', '2024-06-03 20:45']

# Convert to datetime objects
datetime_objects = pd.to_datetime(delivery_timestamps)

print("Converted Datetime Objects:")
print(datetime_objects)
print(f"\nDtype: {datetime_objects.dtype}")
```

**Output:**
```text
Converted Datetime Objects:
DatetimeIndex(['2024-06-01 14:30:00', '2024-06-02 09:15:00', '2024-06-03 20:45:00'], dtype='datetime64[ns]', freq=None)

Dtype: datetime64[ns]
```

---

### Task 2: Extract Year, Month, and Weekday from Order Dates
**Problem Statement:**  
*Load a CSV file containing order dates from a Flipkart-style order history (column: `'order_date'`, format: `'YYYY-MM-DD HH:MM:SS'`). Extract the year, month, and weekday for each order and add them as new columns in the DataFrame.*

```python
# Load Flipkart order history
df_flipkart = pd.read_csv("flipkart_orders.csv")

# Parse string order_date to datetime
df_flipkart['order_date'] = pd.to_datetime(df_flipkart['order_date'], format='%Y-%m-%d %H:%M:%S')

# Extract components using .dt accessor
df_flipkart['year'] = df_flipkart['order_date'].dt.year
df_flipkart['month'] = df_flipkart['order_date'].dt.month
df_flipkart['weekday'] = df_flipkart['order_date'].dt.day_name()

print(df_flipkart[['order_id', 'order_date', 'year', 'month', 'weekday']].head(5))
```

**Output:**
```text
  order_id          order_date  year  month   weekday
0   OD1001 2024-06-01 10:15:30  2024      6  Saturday
1   OD1002 2024-06-02 14:22:15  2024      6    Sunday
2   OD1003 2024-06-04 18:45:00  2024      6   Tuesday
3   OD1004 2024-06-07 09:30:45  2024      6    Friday
4   OD1005 2024-06-08 20:10:00  2024      6  Saturday
```

---

### Task 3: Datetime Indexing & Weekly Order Resampling
**Problem Statement:**  
*Set the `'order_date'` column as the index of your DataFrame and use resampling to calculate the total number of orders placed each week.*  
*Hint: Use `df.resample('W').size()` after setting the datetime index.*

```python
# Set datetime index
df_indexed = df_flipkart.set_index('order_date')

# Resample on weekly frequency ('W')
weekly_order_counts = df_indexed.resample('W').size()

print("Weekly Total Orders Placed:")
print(weekly_order_counts)
```

**Output:**
```text
Weekly Total Orders Placed:
order_date
2024-06-02    2
2024-06-09    4
2024-06-16    3
2024-06-23    4
2024-06-30    3
Freq: W-SUN, dtype: int64
```

---

### Task 4: Timezone Localization & Conversion (UTC to Asia/Kolkata)
**Problem Statement:**  
*Suppose you have a DataFrame of Instagram posts with a `'posted_at'` column in UTC. Convert these timestamps to `'Asia/Kolkata'` timezone and display the first 5 converted times.*

```python
# Load Instagram posts
df_insta = pd.read_csv("instagram_posts.csv")

# Localize UTC timestamps
df_insta['posted_at_utc'] = pd.to_datetime(df_insta['posted_at']).dt.tz_localize('UTC')

# Convert to Asia/Kolkata (IST = UTC + 5:30)
df_insta['posted_at_ist'] = df_insta['posted_at_utc'].dt.tz_convert('Asia/Kolkata')

print(df_insta[['post_id', 'username', 'posted_at_utc', 'posted_at_ist']].head(5))
```

**Output:**
```text
  post_id  username             posted_at_utc             posted_at_ist
0   IG801  kathan_g 2024-06-01 12:30:00+00:00 2024-06-01 18:00:00+05:30
1   IG802    arav_m 2024-06-02 03:15:00+00:00 2024-06-02 08:45:00+05:30
2   IG803   priya_s 2024-06-03 14:45:00+00:00 2024-06-03 20:15:00+05:30
3   IG804   rohit_k 2024-06-05 08:20:00+00:00 2024-06-05 13:50:00+05:30
4   IG805  ananya_d 2024-06-07 20:10:00+00:00 2024-06-08 01:40:00+05:30
```

---

### Task 5: Feature Engineering - `is_weekend` Flag
**Problem Statement:**  
*Create a new feature called `'is_weekend'` in your DataFrame that marks `True` if an order was placed on Saturday or Sunday, and `False` otherwise.*  
*Constraint: Do not use any external libraries except pandas and numpy.*

```python
# In pandas: Monday=0, Tuesday=1, ..., Saturday=5, Sunday=6
# Mark True if day of week is 5 or 6
df_flipkart['is_weekend'] = df_flipkart['order_date'].dt.dayofweek.isin([5, 6])

print(df_flipkart[['order_id', 'order_date', 'weekday', 'is_weekend']].head(8))
print("\nWeekend vs Weekday Breakdown:")
print(df_flipkart['is_weekend'].value_counts().rename({True: 'Weekend', False: 'Weekday'}))
```

**Output:**
```text
  order_id          order_date   weekday  is_weekend
0   OD1001 2024-06-01 10:15:30  Saturday        True
1   OD1002 2024-06-02 14:22:15    Sunday        True
2   OD1003 2024-06-04 18:45:00   Tuesday       False
3   OD1004 2024-06-07 09:30:45    Friday       False
4   OD1005 2024-06-08 20:10:00  Saturday        True
5   OD1006 2024-06-09 11:05:20    Sunday        True
6   OD1007 2024-06-12 16:40:10 Wednesday       False
7   OD1008 2024-06-15 13:15:00  Saturday        True

Weekend vs Weekday Breakdown:
is_weekend
Weekend    10
Weekday     6
Name: count, dtype: int64
```

---

## 📁 Files in this Directory

```text
Session-09/
├── README.md                           # Session documentation & explanations
├── session_9_date_time_data.ipynb      # Interactive Jupyter Notebook (.ipynb)
├── flipkart_orders.csv                 # Flipkart order history with timestamps (CSV)
└── instagram_posts.csv                 # Instagram posts with UTC timestamps (CSV)
```

---

## 🚀 How to Run

```bash
# Launch Jupyter Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-09/session_9_date_time_data.ipynb"
```
