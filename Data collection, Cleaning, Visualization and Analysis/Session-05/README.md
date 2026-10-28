# Session 05: Data Collection using Pandas (Part 2)

**Module:** Data Collection, Cleaning, Visualization and Analysis  
**Session:** 05  
**Status:** ✅ Completed

---

## 📋 Topics Covered
- **Reading data from Relational Databases**:
  - Connecting via SQLAlchemy (`create_engine`)
  - Full table ingestion with `pd.read_sql()`
  - Push-down filtered queries with `pd.read_sql_query()`
- **Web-based extraction (Intro only)**:
  - Consuming REST API endpoints directly
  - JSON to DataFrame conversion via `pd.read_json()`
- **File path handling with `pathlib`**:
  - `pathlib.Path` for cross-platform, robust file references
- **Merging datasets (`pd.merge`)**:
  - Key-based relational joins on shared columns (e.g. `user_id`)
- **Concatenating datasets (`pd.concat`)**:
  - Stacking DataFrames vertically across rows
  - Resetting indices with `ignore_index=True` and `.reset_index(drop=True)`

---

## 🛠️ Task Walkthrough & Implementation

### Task 1: Connect to Database & Load Table with `pd.read_sql()`
**Problem Statement:**  
*Connect to a MySQL or PostgreSQL database using SQLAlchemy and pandas, then use `pd.read_sql()` to load the entire `restaurants` table (imagine Zomato backend) into a DataFrame and display the first 5 rows.*

```python
import pandas as pd
from sqlalchemy import create_engine

# Database Connection (MySQL / PostgreSQL / SQLite)
# For PostgreSQL: "postgresql+psycopg2://user:password@host:port/dbname"
# For MySQL: "mysql+pymysql://user:password@host:port/dbname"
engine = create_engine("sqlite:///session5_local.db")

# Load entire 'restaurants' table into DataFrame
df_restaurants = pd.read_sql("restaurants", con=engine)

# Display first 5 rows
print("First 5 rows of Zomato restaurants:")
print(df_restaurants.head(5))
```

**Output:**
```text
First 5 rows of Zomato restaurants:
   restaurant_id            name       cuisine  rating       city  cost_for_two
0            101        Truffles      American     4.5  Bangalore           800
1            102        Bawarchi       Biryani     4.2  Hyderabad           600
2            103       Peter Cat   Continental     4.4    Kolkata          1200
3            104        Bademiya       Mughlai     4.1     Mumbai           700
4            105         Karim's  North Indian     4.3      Delhi           900
```

---

### Task 2: Filtered Data Retrieval with `pd.read_sql_query()`
**Problem Statement:**  
*Use `pd.read_sql_query()` to fetch only the `name` and `rating` columns from a `movies` table (think BookMyShow-like data) where rating is above 8, and print the resulting DataFrame.*  
*Hint: Write a custom SQL SELECT query as the first argument to `pd.read_sql_query()`.*

```python
# Custom SQL SELECT query
query = """
SELECT name, rating 
FROM movies 
WHERE rating > 8;
"""

# Query database directly into DataFrame
df_top_movies = pd.read_sql_query(query, con=engine)

print("Movies with rating > 8:")
print(df_top_movies)
```

**Output:**
```text
Movies with rating > 8:
                 name  rating
0           Inception     8.8
1        Interstellar     8.7
2     The Dark Knight     9.0
3         Oppenheimer     8.9
4   Avengers: Endgame     8.4
5          Fight Club     8.8
```

---

### Task 3: Ingest JSON Dataset Directly from REST API URL
**Problem Statement:**  
*Read a JSON dataset from the URL `https://jsonplaceholder.typicode.com/users` using pandas, convert it into a DataFrame, and print the usernames column.*  
*Hint: Use `pd.read_json()` directly with the URL.*

```python
# REST API endpoint
url = "https://jsonplaceholder.typicode.com/users"

# Ingest JSON directly from URL into DataFrame
df_users_api = pd.read_json(url)

# Display usernames column
print("Usernames extracted from API:")
print(df_users_api['username'])
```

**Output:**
```text
Usernames extracted from API:
0               Bret
1          Antonette
2           Samantha
3           Karianne
4             Kamren
5    Leopoldo_Corkery
6       Elwyn.Skiles
7      Maxime_Nienow
8           Delphine
9     Moriah.Stanton
Name: username, dtype: object
```

---

### Task 4: File Path Handling with `pathlib` & Merging Datasets
**Problem Statement:**  
*You have two CSV files: `orders.csv` (`order_id`, `user_id`, `amount`) and `users.csv` (`user_id`, `username`). Load both into DataFrames using `pathlib` for file paths, then merge them on `user_id` to show a combined table with `username` and `amount`.*

```python
from pathlib import Path
import pandas as pd

# Define paths using pathlib for cross-platform safety
base_path = Path.cwd()
orders_file = base_path / "orders.csv"
users_file = base_path / "users.csv"

# Load CSV files into DataFrames
df_orders = pd.read_csv(orders_file)
df_users = pd.read_csv(users_file)

# Merge datasets on shared key 'user_id'
df_merged = pd.merge(df_orders, df_users, on="user_id", how="inner")

# Display combined table showing username and amount
result_table = df_merged[["username", "amount"]]
print("Combined Table (Username & Order Amount):")
print(result_table)
```

**Output:**
```text
Combined Table (Username & Order Amount):
        username   amount
0       john_doe   250.50
1       john_doe   899.00
2        alice_w   149.00
3        alice_w   320.00
4      bob_smith   450.00
5   emma_watson  1200.75
6      charlie_b    99.00
7       kathan_g   750.25
```

---

### Task 5: Concatenating Datasets with `pd.concat()` & Index Reset
**Problem Statement:**  
*Concatenate two DataFrames representing `today_orders` and `yesterday_orders` (each with columns: `order_id`, `item`, `price`), and display the combined DataFrame.*  
*Constraint: Use `pd.concat()` and reset the index after concatenation.*

```python
# Sample orders DataFrames
today_orders = pd.DataFrame({
    'order_id': [101, 102],
    'item': ['Burger', 'Pizza'],
    'price': [150, 350]
})

yesterday_orders = pd.DataFrame({
    'order_id': [99, 100],
    'item': ['Pasta', 'Sandwich'],
    'price': [250, 120]
})

# Concatenate vertically and reset index
combined_orders = pd.concat([yesterday_orders, today_orders], ignore_index=True)

print("Combined Orders (Yesterday + Today with reset index):")
print(combined_orders)
```

**Output:**
```text
Combined Orders (Yesterday + Today with reset index):
   order_id      item  price
0        99     Pasta    250
1       100  Sandwich    120
2       101    Burger    150
3       102     Pizza    350
```

---

## 📁 Files in this Directory

```text
Session-05/
├── README.md                               # Session documentation & explanations
├── session_5_data_collection_pandas.ipynb  # Interactive Jupyter Notebook (.ipynb)
├── orders.csv                              # Order transactions dataset (CSV)
├── users.csv                               # User profiles dataset (CSV)
├── restaurants.csv                         # Zomato restaurants database seed (CSV)
└── movies.csv                              # BookMyShow movies database seed (CSV)
```

---

## 🚀 How to Run

```bash
# Launch Jupyter Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-05/session_5_data_collection_pandas.ipynb"
```
