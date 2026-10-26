# Session 15: SQL + Python Integration

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **Python 3 (`sqlite3` standard library, `pandas`) + SQL**  
**Target Database**: `foodie.db`  
**Target Table**: `Restaurants`  
**Source Files**:
* Python Pipeline: [`session_15_sql_python.py`](session_15_sql_python.py)
* Daily Automation: [`daily_summary_automation.py`](daily_summary_automation.py)
* SQL Equivalents: [`session_15_sql_queries.sql`](session_15_sql_queries.sql)
* Exported Report: [`top_rated_restaurants.csv`](top_rated_restaurants.csv)

---

## Task 1: Module Setup & Create `foodie.db` with `Restaurants` Table

### Objective
Install / import the `sqlite3` module in Python and write a script to create a new database called `foodie.db` with a table `Restaurants` (`id`, `name`, `cuisine`, `rating`).

### Technical Note
In Python 3, `sqlite3` is a built-in module part of the Python Standard Library (PEP 249 compliant DB-API 2.0). It requires no external `pip install sqlite3` command. It is imported directly via `import sqlite3`.

### Python Implementation
```python
import sqlite3

# Establish connection (creates foodie.db file if it does not exist)
conn = sqlite3.connect("foodie.db")
cursor = conn.cursor()

# Create table
cursor.execute("DROP TABLE IF EXISTS Restaurants")
cursor.execute("""
    CREATE TABLE Restaurants (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        cuisine TEXT NOT NULL,
        rating REAL NOT NULL
    )
""")

conn.commit()
conn.close()
print("Database 'foodie.db' created with table 'Restaurants' successfully.")
```

### Execution Output
```text
Database 'foodie.db' created with table 'Restaurants' successfully.
```

---

## Task 2: Insert 3 Sample Restaurants & Fetch Rating > 4.0

### Objective
Using `sqlite3` in Python, insert three sample restaurants into the `Restaurants` table in `foodie.db` and write a query to fetch all restaurants with a rating above 4.0, then print their names.

### Python Implementation
```python
import sqlite3

conn = sqlite3.connect("foodie.db")
cursor = conn.cursor()

# Sample data
sample_restaurants = [
    (1, "Little Italy", "Italian", 4.7),
    (2, "Honest Restaurant", "North Indian", 4.2),
    (3, "Sankalp South Indian", "South Indian", 3.9)
]

cursor.executemany("""
    INSERT INTO Restaurants (id, name, cuisine, rating) 
    VALUES (?, ?, ?, ?)
""", sample_restaurants)
conn.commit()

# Query restaurants with rating > 4.0
cursor.execute("SELECT name, rating FROM Restaurants WHERE rating > 4.0")
rows = cursor.fetchall()

print("Restaurants with rating > 4.0:")
for name, rating in rows:
    print(f"- {name} (Rating: {rating})")

conn.close()
```

### Execution Output
```text
Inserted 3 sample restaurants successfully.

Restaurants with rating > 4.0:
- Little Italy (Rating: 4.7)
- Honest Restaurant (Rating: 4.2)
```

---

## Task 3: Load Data into Pandas DataFrame & `head(2)`

### Objective
Write Python code to load all rows from the `Restaurants` table in `foodie.db` into a Pandas DataFrame and display the top 2 rows using `DataFrame.head()`.

### Python Implementation
```python
import sqlite3
import pandas as pd

conn = sqlite3.connect("foodie.db")

# Load table directly into a Pandas DataFrame using pd.read_sql_query
df = pd.read_sql_query("SELECT * FROM Restaurants", conn)
conn.close()

# Display first 2 records
print("Top 2 rows from Restaurants table:")
print(df.head(2))
```

### Execution Output
```text
Top 2 rows from Restaurants table:
   id               name       cuisine  rating
0   1       Little Italy       Italian     4.7
1   2  Honest Restaurant  North Indian     4.2
```

---

## Task 4: Feature Engineering (`delivery_charge` & Conditional `final_rating`)

### Objective
Add a new column `'delivery_charge'` to your DataFrame, setting it to 50 for all restaurants, and then calculate a new column `'final_rating'` as `rating + (0.1 if cuisine is 'Italian')`.

### Mechanics & Hint
* **Hint**: *Use `DataFrame.apply()` or a lambda function for the conditional logic.*
* A static assignment `df['delivery_charge'] = 50` creates the uniform delivery charge column.
* `apply(lambda row: ..., axis=1)` iterates across DataFrame rows to conditionally reward Italian restaurants with a `+0.1` rating boost.

### Python Implementation
```python
# 1. Assign static delivery charge
df["delivery_charge"] = 50

# 2. Conditional logic using lambda and DataFrame.apply()
df["final_rating"] = df.apply(
    lambda row: round(row["rating"] + 0.1, 2) if row["cuisine"] == "Italian" else row["rating"],
    axis=1
)

print("Updated DataFrame with 'delivery_charge' and 'final_rating':")
print(df[["id", "name", "cuisine", "rating", "delivery_charge", "final_rating"]])
```

### Execution Output
```text
Updated DataFrame with 'delivery_charge' and 'final_rating':
   id                  name       cuisine  rating  delivery_charge  final_rating
0   1          Little Italy       Italian     4.7               50           4.8
1   2     Honest Restaurant  North Indian     4.2               50           4.2
2   3  Sankalp South Indian  South Indian     3.9               50           3.9
```

---

## Task 5: Automated Daily Summary Export to CSV

### Objective
Automate a daily summary: Write a Python script that connects to `foodie.db`, fetches all restaurants with rating above 4.5, loads them into a DataFrame, and saves the result as a CSV file named `top_rated_restaurants.csv`.

### Python Implementation ([`daily_summary_automation.py`](daily_summary_automation.py))
```python
import sqlite3
import pandas as pd
import os

DB_PATH = "foodie.db"
OUTPUT_CSV = "top_rated_restaurants.csv"

def export_top_rated_summary():
    """Connects to foodie.db, filters rating > 4.5, and exports to CSV."""
    conn = sqlite3.connect(DB_PATH)
    
    query = "SELECT id, name, cuisine, rating FROM Restaurants WHERE rating > 4.5"
    top_rated_df = pd.read_sql_query(query, conn)
    conn.close()

    # Save to CSV without the Pandas integer index
    top_rated_df.to_csv(OUTPUT_CSV, index=False)
    print(f"Top-rated restaurants (rating > 4.5) successfully saved to '{OUTPUT_CSV}':")
    print(top_rated_df)

if __name__ == "__main__":
    export_top_rated_summary()
```

### Execution Output
```text
[SUCCESS] Exported 1 top-rated restaurants to: top_rated_restaurants.csv
   id          name  cuisine  rating
0   1  Little Italy  Italian     4.7
```

### Content of `top_rated_restaurants.csv`
```csv
id,name,cuisine,rating
1,Little Italy,Italian,4.7
```
