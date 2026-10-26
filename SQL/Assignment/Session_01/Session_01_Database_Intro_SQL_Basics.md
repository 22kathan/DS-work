# Session 1: Database Introduction & SQL Basics

**Course**: Data Science  
**Module**: Working with Databases (SQL)  
**Status**: Completed  
**Artifacts**:
* 📄 SQL Script: [`session_01_tasks.sql`](session_01_tasks.sql)
* 🐍 Python Verification Script: [`verify_session_01.py`](verify_session_01.py)
* 🗄️ Database File: [`music_streaming_app.db`](music_streaming_app.db)

---

## Task 1: Database Creation (`music_streaming_app`)

### Objective
Install MySQL or PostgreSQL on your system and create a new database named `music_streaming_app` using the command line or a GUI tool (such as MySQL Workbench, pgAdmin, or DBeaver).

### SQL Implementation

#### Option A: MySQL Command Line / Workbench
```sql
-- Create database
CREATE DATABASE IF NOT EXISTS music_streaming_app;

-- Switch to active database context
USE music_streaming_app;
```

#### Option B: PostgreSQL (psql / pgAdmin)
```sql
-- Create database in PostgreSQL
CREATE DATABASE music_streaming_app;

-- Connect to the database
\c music_streaming_app;
```

---

## Task 2: Table Creation (`playlists`)

### Objective
Inside the `music_streaming_app` database, create a table called `playlists` with columns:
* `playlist_id` (integer, primary key)
* `name` (varchar)
* `created_by` (varchar)

### SQL DDL Statement
```sql
CREATE TABLE IF NOT EXISTS playlists (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_by VARCHAR(100) NOT NULL
);
```

### Column Specifications
| Column Name | Data Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `playlist_id` | `INT` / `INTEGER` | `PRIMARY KEY` | Unique identifier for each playlist; enforces uniqueness and cannot be `NULL`. |
| `name` | `VARCHAR(255)` | `NOT NULL` | Descriptive title of the playlist (e.g., 'Bollywood Hits'). |
| `created_by` | `VARCHAR(100)` | `NOT NULL` | Name of the user or curator who created the playlist. |

---

## Task 3: Inserting Sample Rows

### Objective
Insert three sample rows into the `playlists` table representing playlists like `'Bollywood Hits'`, `'Chill Vibes'`, and `'Workout Mix'`, each created by a different user.

### SQL DML Statement
```sql
INSERT INTO playlists (playlist_id, name, created_by) VALUES
(1, 'Bollywood Hits', 'Amit'),
(2, 'Chill Vibes', 'Neha'),
(3, 'Workout Mix', 'Rohan');
```

### Table View After Insertion
```text
+---------------+----------------+--------------+
|   playlist_id | name           | created_by   |
|---------------+----------------+--------------|
|             1 | Bollywood Hits | Amit         |
|             2 | Chill Vibes    | Neha         |
|             3 | Workout Mix    | Rohan        |
+---------------+----------------+--------------+
```

---

## Task 4: Filter Query with WHERE Clause

### Objective
Write an SQL `SELECT` query to display all playlists created by the user `'Amit'` from the `playlists` table using the `WHERE` clause.

### SQL Query
```sql
SELECT 
    playlist_id,
    name,
    created_by
FROM playlists
WHERE created_by = 'Amit';
```

### Query Execution Output
```text
+---------------+----------------+--------------+
|   playlist_id | name           | created_by   |
|---------------+----------------+--------------|
|             1 | Bollywood Hits | Amit         |
+---------------+----------------+--------------+
```

---

## Task 5: AI Explanation — Difference Between Table, Row, and Column (Zomato Example)

### Prompt Given to AI (ChatGPT / Copilot)
> *"Explain the difference between a table, a row, and a column in SQL using a clear real-world example from a food delivery app like Zomato."*

### Received Explanation:

Imagine you open the **Zomato** app and look at your past orders history. In SQL relational databases, data is organized in a tabular structure comprising **Tables**, **Rows**, and **Columns**:

```text
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                                 TABLE: `zomato_orders`                                 │
├─────────────┬─────────────────────┬──────────────────┬──────────────┬──────────────────┤
│  order_id   │   restaurant_name   │   food_item      │ total_amount │   order_status   │  ◄── COLUMNS
├─────────────┼─────────────────────┼──────────────────┼──────────────┼──────────────────┤
│    501      │  Haldiram's         │  Chole Bhature   │   ₹280       │   Delivered      │  ◄── ROW 1
│    502      │  Burger King        │  Whopper Meal    │   ₹399       │   On the way     │  ◄── ROW 2
│    503      │  Pizza Hut          │  Margherita      │   ₹549       │   Preparing      │  ◄── ROW 3
└─────────────┴─────────────────────┴──────────────────┴──────────────┴──────────────────┘
```

#### 1. What is a Table?
* **Definition**: A **Table** is the entire structured container (or collection) representing a single entity or business concept.
* **Zomato Analogy**: The table is like a complete spreadsheet titled **`zomato_orders`** that keeps track of every food delivery transaction placed on the platform. Other tables in Zomato might include `restaurants`, `delivery_partners`, and `customers`.

#### 2. What is a Column (Field / Attribute)?
* **Definition**: A **Column** is a vertical category that defines a specific property, attribute, or piece of information that each record can have, along with its data type.
* **Zomato Analogy**: 
  - `restaurant_name` is a column that holds text names of where food was ordered.
  - `total_amount` is a column that stores the numeric price of the bill.
  - `order_status` is a column holding the status ('Delivered', 'On the way', 'Preparing').

#### 3. What is a Row (Record / Tuple)?
* **Definition**: A **Row** is a single horizontal entry in the table representing one complete, individual instance of that entity.
* **Zomato Analogy**: A single row represents **one specific order placed by a customer**.
  - For example, Row 1 (`501`, `Haldiram's`, `Chole Bhature`, `₹280`, `Delivered`) is the complete snapshot of that particular lunch order. It ties all the different column attributes together for one distinct transaction.

### Summary Comparison Table
| SQL Concept | Real-World Zomato Equivalent | Orientation | What It Contains |
| :--- | :--- | :--- | :--- |
| **Table** | The complete Orders Register (`zomato_orders`) | 2D Grid (All Rows & Columns) | All past and present order history. |
| **Column** | An Order Feature (e.g., `total_amount`) | Vertical ($\downarrow$) | The same type of attribute across all orders. |
| **Row** | A Single Food Order Receipt (e.g., Order #501) | Horizontal ($\rightarrow$) | All details of one specific order transaction. |

---

## 6. Execution Verification Output

Running [`verify_session_01.py`](verify_session_01.py) in Python:

```text
======================================================================
SESSION 1: DATABASE INTRODUCTION & SQL BASICS VERIFICATION
======================================================================

--- Task 2: Creating 'playlists' Table ---
[SUCCESS] Table 'playlists' created successfully.

--- Task 3: Inserting Sample Rows ---
[SUCCESS] Inserted 3 playlists into 'playlists' table.

Current Table Contents:
+---------------+----------------+--------------+
|   playlist_id | name           | created_by   |
|---------------+----------------+--------------|
|             1 | Bollywood Hits | Amit         |
|             2 | Chill Vibes    | Neha         |
|             3 | Workout Mix    | Rohan        |
+---------------+----------------+--------------+

--- Task 4: SELECT Query with WHERE created_by = 'Amit' ---
+---------------+----------------+--------------+
|   playlist_id | name           | created_by   |
|---------------+----------------+--------------|
|             1 | Bollywood Hits | Amit         |
+---------------+----------------+--------------+

======================================================================
SESSION 1 VERIFICATION COMPLETED SUCCESSFULLY
======================================================================
```
