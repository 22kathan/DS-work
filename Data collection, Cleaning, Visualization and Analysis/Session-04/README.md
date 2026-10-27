# Session 04: Data Collection using Pandas (Part 1)

**Module:** Data Collection, Cleaning, Visualization and Analysis  
**Session:** 04  
**Status:** ✅ Completed

---

## 📌 Topics Covered
- **What is pandas & why Data Science heavily depends on it**
- **Types of data files**: CSV, Excel, TSV, JSON
- **Importing datasets**:
  - `pd.read_csv()`
  - `pd.read_json()`
  - `pd.read_excel()`
- **Handling separators**:
  - Comma (`,`), Semicolon (`;`), Tab (`\t`)
- **Reading large files**:
  - Batch / chunk processing
  - Iterating through file chunks
- **Detecting data issues early**:
  - `df.info()`
  - `df.describe(include='all')`
  - Null value detection (`df.isnull().sum()`)

---

## 📋 Task Walkthrough & Implementation

### Task 1: Loading CSV Data (IPL Cricket Matches)
**Problem Statement:**  
*Download a sample CSV file of IPL cricket match scores from Kaggle or any public dataset, and use pd.read_csv() to load it into a DataFrame. Print the first 5 rows to verify the data.*

```python
import pandas as pd

# Load IPL match scores from CSV
df_ipl = pd.read_csv("ipl_matches.csv")

# Display first 5 rows
print("First 5 rows of IPL matches dataset:")
df_ipl.head(5)
```

**Output:**
```text
   match_id  season team1 team2 winner  win_by_runs  win_by_wickets      venue
0       101    2024   CSK   RCB    CSK           18               0    Chennai
1       102    2024   RCB    MI    RCB            0               7  Bengaluru
2       103    2024    MI   KKR    KKR           12               0     Mumbai
3       104    2024   KKR    DC    KKR           24               0    Kolkata
4       105    2024    DC    RR     DC            0               4      Delhi
```

---

### Task 2: Loading JSON Data & Schema Inspection (Spotify Trending)
**Problem Statement:**  
*Find a small JSON dataset of trending songs (for example, from Spotify's API samples or any open JSON file), and use pd.read_json() to import it into a DataFrame. Display the DataFrame's column names and data types using df.info().*

```python
# Load Spotify trending songs JSON dataset
df_spotify = pd.read_json("spotify_trending.json")

# Inspect schema, column names, non-null counts, and datatypes
print("Spotify Trending Songs Schema:")
df_spotify.info()
```

**Output:**
```text
<class 'pandas.DataFrame'>
RangeIndex: 5 entries, 0 to 4
Data columns (total 6 columns):
 #   Column        Non-Null Count  Dtype  
---  ------        --------------  -----  
 0   song_id       5 non-null      str    
 1   title         5 non-null      str    
 2   artist        5 non-null      str    
 3   streams       5 non-null      int64  
 4   danceability  5 non-null      float64
 5   release_year  5 non-null      int64  
dtypes: float64(1), int64(2), str(3)
memory usage: 372.0 bytes
```

---

### Task 3: Ingesting TSV Data & Full Summary Statistics (Zomato)
**Problem Statement:**  
*You have a TSV (tab-separated values) file containing Zomato restaurant data. Use pd.read_csv() with the correct separator to load the data, and then use df.describe(include='all') to generate summary statistics.*  
*Hint: The separator for TSV files is '\t'.*

```python
# Load TSV file using tab separator ('\t')
df_zomato = pd.read_csv("zomato_restaurants.tsv", sep='\t')

# Generate comprehensive summary statistics
print("Zomato Restaurants Summary Statistics:")
df_zomato.describe(include='all')
```

**Output:**
```text
        restaurant_id        name      cuisine    rating  cost_for_two       city
count        6.000000           6            6  6.000000      6.000000          6
unique            NaN           6            6       NaN           NaN          4
top               NaN  Haldiram's  North Indian       NaN           NaN  Hyderabad
freq              NaN           1            1       NaN           NaN          2
mean       503.500000         NaN          NaN  4.316667    675.000000        NaN
std          1.870829         NaN          NaN  0.248328    436.749356        NaN
min        501.000000         NaN          NaN  3.900000    250.000000        NaN
25%        502.250000         NaN          NaN  4.225000    437.500000        NaN
50%        503.500000         NaN          NaN  4.350000    600.000000        NaN
75%        504.750000         NaN          NaN  4.475000    687.500000        NaN
max        506.000000         NaN          NaN  4.600000   1500.000000        NaN
```

---

### Task 4: Reading Large Datasets in Chunks (Flipkart Products)
**Problem Statement:**  
*Download a large Excel file (at least 10,000 rows) of Flipkart product listings. Use pd.read_excel() with the chunksize parameter to read the file in chunks of 2000 rows, and print the number of rows in each chunk as you iterate.*

```python
# Iterating through 10,000 Flipkart product listings in batches of 2,000 rows
chunk_size = 2000
total_rows = 10000

for i in range(0, total_rows, chunk_size):
    skip = range(1, i + 1) if i > 0 else None
    chunk = pd.read_excel("flipkart_products.xlsx", skiprows=skip, nrows=chunk_size)
    print(f"Chunk {i // chunk_size + 1}: Loaded {len(chunk)} rows successfully")
```

**Output:**
```text
Chunk 1: Loaded 2000 rows successfully
Chunk 2: Loaded 2000 rows successfully
Chunk 3: Loaded 2000 rows successfully
Chunk 4: Loaded 2000 rows successfully
Chunk 5: Loaded 2000 rows successfully
```

---

### Task 5: Semicolon-Separated CSV & Null Detection (Paytm Transactions)
**Problem Statement:**  
*Use ChatGPT or Copilot to generate a Python code snippet that reads a semicolon-separated CSV of Paytm transactions, detects missing values, and prints out which columns have nulls. Test the code with a small sample file and fix any errors you encounter.*

```python
# Read semicolon-separated CSV
df_paytm = pd.read_csv("paytm_transactions.csv", sep=';')

# Detect missing (null) values per column
null_counts = df_paytm.isnull().sum()
columns_with_nulls = null_counts[null_counts > 0]

print("Paytm Transactions Preview:")
print(df_paytm.head(3))

print("\nColumns with missing (null) values:")
print(columns_with_nulls)
```

**Output:**
```text
Paytm Transactions Preview:
    txn_id user_id  amount   status payment_method         timestamp
0  TXN101     U01   250.0  SUCCESS            UPI  2026-10-01 10:15
1  TXN102     U02  1200.5  SUCCESS         Wallet  2026-10-01 11:30
2  TXN103     NaN    45.0  PENDING            UPI  2026-10-01 12:45

Columns with missing (null) values:
user_id           2
amount            2
status            1
payment_method    1
timestamp         1
dtype: int64
```

---

## 📁 Files in this Directory

```text
Session-04/
├── README.md                               # Session documentation & explanations
├── session_4_data_collection_pandas.ipynb  # Interactive Jupyter Notebook (.ipynb)
├── ipl_matches.csv                         # IPL match scores dataset (CSV)
├── spotify_trending.json                   # Spotify trending songs dataset (JSON)
├── zomato_restaurants.tsv                  # Zomato restaurant data (TSV)
├── flipkart_products.xlsx                  # 10,000-row product catalog (Excel)
└── paytm_transactions.csv                  # Semicolon-separated transactions with nulls
```

---

## 🚀 How to Run

```bash
# Launch Jupyter Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-04/session_4_data_collection_pandas.ipynb"
```
