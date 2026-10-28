# Session 06: Data Cleaning (Part 1: Missing Values)

**Module:** Data Collection, Cleaning, Visualization and Analysis  
**Session:** 06  
**Status:** ✅ Completed

---

## 📋 Topics Covered
- **Identifying missing data**:
  - Detection using `.isnull()`, `.isna()`, and `.notnull()`
  - Summarizing missing counts and percentages per column
- **Strategies to handle missing data**:
  - Dropping missing values with `dropna()` parameters (`axis=0/1`, `how='any'/'all'`, `thresh`)
  - Measuring data loss and shape changes before and after dropping
- **Imputation techniques**:
  - Imputing with summary statistics (`mean`, `median`, `mode`) using `fillna()`
  - Sequential imputation: Forward fill (`ffill`) and Backward fill (`bfill`)
- **Missingness mechanisms (Conceptual)**:
  - **MCAR** (Missing Completely at Random)
  - **MAR** (Missing at Random)
  - **MNAR** (Missing Not at Random)
- **Practical examples**:
  - Handling missing data in IPL player statistics
  - Cleaning incomplete restaurant ratings (Zomato simulation)

---

## 🛠️ Task Walkthrough & Implementation

### Task 1: Ingest IPL Player Stats & Detect Missing Values
**Problem Statement:**  
*Download a sample CSV file of IPL player stats (include columns like player name, runs, matches, and some missing values). Load it into a pandas DataFrame and use `isnull()` and `notnull()` to print how many missing values are present in each column.*

```python
import pandas as pd
import numpy as np

# Load IPL player stats dataset
df_ipl = pd.read_csv("ipl_player_stats.csv")

# Method 1: Count missing values using isnull()
missing_isnull = df_ipl.isnull().sum()

# Method 2: Count missing values using notnull()
missing_notnull = len(df_ipl) - df_ipl.notnull().sum()

print("Missing values count per column (using isnull):")
print(missing_isnull)

print("\nMissing values count per column (verified using notnull):")
print(missing_notnull)
```

**Output:**
```text
Missing values count per column (using isnull):
player_id       0
player_name     0
team            0
matches         0
runs            3
wickets         2
batting_avg     2
strike_rate     2
dtype: int64

Missing values count per column (verified using notnull):
player_id       0
player_name     0
team            0
matches         0
runs            3
wickets         2
batting_avg     2
strike_rate     2
dtype: int64
```

---

### Task 2: Remove Missing Rows with `dropna(axis=0, how='any')`
**Problem Statement:**  
*Using the loaded IPL player stats DataFrame, apply `dropna(axis=0, how='any')` to remove all rows with any missing data and display the shape of the DataFrame before and after dropping.*

```python
# Inspect shape before dropping
shape_before = df_ipl.shape

# Drop rows containing any missing value
df_dropped = df_ipl.dropna(axis=0, how='any')
shape_after = df_dropped.shape

print(f"DataFrame Shape Before dropna: {shape_before}")
print(f"DataFrame Shape After dropna:  {shape_after}")
print(f"Rows removed: {shape_before[0] - shape_after[0]}")
```

**Output:**
```text
DataFrame Shape Before dropna: (10, 8)
DataFrame Shape After dropna:  (5, 8)
Rows removed: 5
```

---

### Task 3: Mean Imputation on 'runs' Column with `fillna()`
**Problem Statement:**  
*For the 'runs' column in your IPL player stats DataFrame, use `fillna()` to replace missing values with the mean of the column. Print the updated column to verify the changes.*

```python
# Calculate mean of available runs
runs_mean = df_ipl['runs'].mean()
print(f"Calculated Mean Runs: {runs_mean:.2f}")

# Impute missing values with column mean
df_ipl_imputed = df_ipl.copy()
df_ipl_imputed['runs'] = df_ipl_imputed['runs'].fillna(runs_mean)

# Verify updated column
verification = pd.DataFrame({
    'player_name': df_ipl['player_name'],
    'runs_original': df_ipl['runs'],
    'runs_imputed': df_ipl_imputed['runs'].round(2)
})
print(verification)
print(f"\nMissing values in runs after imputation: {df_ipl_imputed['runs'].isnull().sum()}")
```

**Output:**
```text
Calculated Mean Runs: 441.57

       player_name  runs_original  runs_imputed
0      Virat Kohli          741.0        741.00
1     Rohit Sharma          417.0        417.00
2   Jasprit Bumrah            NaN        441.57
3     Sunil Narine          488.0        488.00
4         MS Dhoni          161.0        161.00
5  Heinrich Klaasen         479.0        479.00
6      Pat Cummins            NaN        441.57
7  Ruturaj Gaikwad          583.0        583.00
8    Andre Russell          222.0        222.00
9    Kuldeep Yadav            NaN        441.57

Missing values in runs after imputation: 0
```

---

### Task 4: Sequential Fill (Forward Fill + Backward Fill)
**Problem Statement:**  
*Simulate a Zomato-style restaurant ratings dataset with some missing ratings. Use forward fill (`method='ffill'` or `.ffill()`) to fill missing values in the ratings column, then use backward fill (`method='bfill'` or `.bfill()`) for any remaining missing values. Show the before and after results.*

```python
# Load simulated Zomato ratings
df_zomato = pd.read_csv("zomato_ratings.csv")

# Apply forward fill then backward fill
df_ratings = df_zomato.copy()
df_ratings['rating_ffill'] = df_ratings['rating'].ffill()
df_ratings['rating_final'] = df_ratings['rating_ffill'].bfill()

print(df_ratings[['restaurant_name', 'rating', 'rating_ffill', 'rating_final']])
```

**Output:**
```text
     restaurant_name  rating  rating_ffill  rating_final
0      The Fatty Bao     NaN           NaN           4.5
1           Truffles     4.5           4.5           4.5
2       Corner House     NaN           4.5           4.5
3      Meghana Foods     NaN           4.5           4.5
4               Toit     4.7           4.7           4.7
5   Vidyarthi Bhavan     4.4           4.4           4.4
6   Glen's Bakehouse     NaN           4.4           4.4
7  Empire Restaurant     3.9           3.9           3.9
```

---

### Task 5: Missingness Mechanism Analysis (MCAR, MAR, MNAR)
**Problem Statement:**  
*Pick any one column with missing values from your dataset and explain which missingness mechanism (MCAR, MAR, or MNAR) is most likely and why, using 2-3 sentences.*  
*Hint: Think about whether the missing data is random or related to other factors in the dataset.*

#### **Selected Column:** `wickets` (from `ipl_player_stats.csv`)
> **Most Likely Mechanism:** **MAR (Missing at Random)**
>
> **Explanation:**  
> In the IPL dataset, missing values in the `wickets` column do not happen completely at random; rather, they are systematically related to the player's primary role in the team. Specialist batsmen and wicketkeepers (like Virat Kohli or MS Dhoni) rarely or never bowl in an IPL match, so bowling stats are left unrecorded conditioned directly on their observed batting specialization. Because this missingness is explainable by another observed variable (player role / batting runs), it represents **Missing at Random (MAR)**.

---

## 📁 Files in this Directory

```text
Session-06/
├── README.md                                       # Session documentation & explanations
├── session_6_data_cleaning_missing_values.ipynb    # Interactive Jupyter Notebook (.ipynb)
├── ipl_player_stats.csv                            # IPL player stats dataset with nulls (CSV)
└── zomato_ratings.csv                              # Simulated Zomato ratings with nulls (CSV)
```

---

## 🚀 How to Run

```bash
# Launch Jupyter Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-06/session_6_data_cleaning_missing_values.ipynb"
```
