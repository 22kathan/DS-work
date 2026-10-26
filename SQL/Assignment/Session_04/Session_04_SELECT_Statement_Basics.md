# Session 4: SELECT Statement Basics

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Tables**: `MusicPlaylist`, `FoodOrders`  
**SQL Script File**: [`session_04_select_basics.sql`](session_04_select_basics.sql)

---

## 📌 Overview

This session covers fundamental Data Query Language (DQL) concepts in SQL:
1. **Full Table Projections**: Using `SELECT *` to inspect complete table records.
2. **Column Projection & Result Limiting**: Selecting specific columns and restricting returned rows using `LIMIT`.
3. **De-duplication**: Using the `DISTINCT` keyword to extract unique entities.
4. **Column Aliasing**: Renaming output columns using `AS` for human-friendly presentation.
5. **Syntax & Logic Troubleshooting**: Diagnosing common errors with `LIMIT` placement, determinism (`ORDER BY`), and multi-column `DISTINCT` behavior.

---

## Task 1: Create Table `MusicPlaylist` & Retrieve All Records

### Objective
Create a table named `MusicPlaylist` with columns: `id`, `song_name`, `artist`, `genre`, and `duration`. Insert at least 5 records representing favorite Spotify tracks, then retrieve all columns for all songs using `SELECT *`.

### Table Schema & DDL
* `id`: `INT PRIMARY KEY`
* `song_name`: `VARCHAR(255) NOT NULL`
* `artist`: `VARCHAR(255) NOT NULL`
* `genre`: `VARCHAR(100) NOT NULL`
* `duration`: `INT NOT NULL` (duration in seconds)

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session04_db;
USE session04_db;

DROP TABLE IF EXISTS MusicPlaylist;

CREATE TABLE MusicPlaylist (
    id INT PRIMARY KEY,
    song_name VARCHAR(255) NOT NULL,
    artist VARCHAR(255) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    duration INT NOT NULL
);

-- Insert 6 representative tracks from Spotify
INSERT INTO MusicPlaylist (id, song_name, artist, genre, duration) VALUES
(1, 'Kesariya', 'Arijit Singh', 'Bollywood Romantic', 268),
(2, 'Brown Munde', 'AP Dhillon', 'Punjabi Pop', 262),
(3, 'Blinding Lights', 'The Weeknd', 'Synthwave / Pop', 200),
(4, 'Starboy', 'The Weeknd', 'R&B / Pop', 230),
(5, 'Apna Bana Le', 'Arijit Singh', 'Bollywood Soul', 261),
(6, 'Excuses', 'AP Dhillon', 'Punjabi Pop', 236);

-- Retrieve all columns for all songs
SELECT * 
FROM MusicPlaylist;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM MusicPlaylist;
+----+-----------------+--------------+--------------------+----------+
| id | song_name       | artist       | genre              | duration |
+----+-----------------+--------------+--------------------+----------+
|  1 | Kesariya        | Arijit Singh | Bollywood Romantic |      268 |
|  2 | Brown Munde     | AP Dhillon   | Punjabi Pop        |      262 |
|  3 | Blinding Lights | The Weeknd   | Synthwave / Pop    |      200 |
|  4 | Starboy         | The Weeknd   | R&B / Pop          |      230 |
|  5 | Apna Bana Le    | Arijit Singh | Bollywood Soul     |      261 |
|  6 | Excuses         | AP Dhillon   | Punjabi Pop        |      236 |
+----+-----------------+--------------+--------------------+----------+
6 rows in set (0.00 sec)
```

---

## Task 2: Specific Column Projection with `LIMIT`

### Objective
Write an SQL query to display only the `song_name` and `artist` columns from the `MusicPlaylist` table, showing just the first 3 records using the `LIMIT` keyword.

### Query Design
* **Projection**: `SELECT song_name, artist` (projects only the 2 required columns, avoiding the network and memory overhead of `SELECT *`).
* **Pagination / Row Cap**: `LIMIT 3` instructs the database storage engine to halt scanning and return once 3 matching rows are collected.

### SQL Implementation
```sql
SELECT song_name, artist
FROM MusicPlaylist
LIMIT 3;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT song_name, artist FROM MusicPlaylist LIMIT 3;
+-----------------+--------------+
| song_name       | artist       |
+-----------------+--------------+
| Kesariya        | Arijit Singh |
| Brown Munde     | AP Dhillon   |
| Blinding Lights | The Weeknd   |
+-----------------+--------------+
3 rows in set (0.00 sec)
```

---

## Task 3: Unique Restaurant Names Using `DISTINCT`

### Objective
Suppose you have a table named `FoodOrders` with columns: `id`, `restaurant`, `food_item`, and `order_date`. Write an SQL query to list all unique restaurant names where you have placed orders, using the `DISTINCT` keyword.

### Table Schema & Sample Data Setup
To realistically demonstrate de-duplication, the sample dataset contains multiple repeat orders from the same restaurants (e.g., Domino's Pizza, Burger King):

```sql
DROP TABLE IF EXISTS FoodOrders;

CREATE TABLE FoodOrders (
    id INT PRIMARY KEY,
    restaurant VARCHAR(255) NOT NULL,
    food_item VARCHAR(255) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO FoodOrders (id, restaurant, food_item, order_date) VALUES
(101, 'Domino\'s Pizza', 'Farmhouse Pizza', '2026-10-15'),
(102, 'Burger King', 'Whopper Meal', '2026-10-18'),
(103, 'Domino\'s Pizza', 'Garlic Breadsticks', '2026-10-20'),
(104, 'Subway', 'Paneer Tikka Sub', '2026-10-21'),
(105, 'Burger King', 'Veg Crispy Burger', '2026-10-22'),
(106, 'Haldiram\'s', 'Chole Bhature', '2026-10-24'),
(107, 'Domino\'s Pizza', 'Farmhouse Pizza', '2026-10-25');
```

### SQL Implementation
```sql
SELECT DISTINCT restaurant
FROM FoodOrders;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT DISTINCT restaurant FROM FoodOrders;
+----------------+
| restaurant     |
+----------------+
| Domino's Pizza |
| Burger King    |
| Subway         |
| Haldiram's     |
+----------------+
4 rows in set (0.00 sec)
```
*(Notice: Out of 7 total order records, duplicate restaurant entries were collapsed into the 4 distinct restaurant brands).*

---

## Task 4: Column Aliases with `AS`

### Objective
Write an SQL query on the `FoodOrders` table to select `food_item` as `'Dish'` and `order_date` as `'Date Ordered'`, displaying only these two columns with the column aliases in the output.

### Query Design
* `food_item AS Dish`: Simple single-word identifier alias.
* `order_date AS `Date Ordered``: Multi-word alias containing whitespace, enclosed in backticks (MySQL standard) or double quotes (ANSI SQL standard).

### SQL Implementation
```sql
SELECT 
    food_item AS Dish,
    order_date AS `Date Ordered`
FROM FoodOrders;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT food_item AS Dish, order_date AS `Date Ordered` FROM FoodOrders;
+--------------------+--------------+
| Dish               | Date Ordered |
+--------------------+--------------+
| Farmhouse Pizza    | 2026-10-15   |
| Whopper Meal       | 2026-10-18   |
| Garlic Breadsticks | 2026-10-20   |
| Paneer Tikka Sub   | 2026-10-21   |
| Veg Crispy Burger  | 2026-10-22   |
| Chole Bhature      | 2026-10-24   |
| Farmhouse Pizza    | 2026-10-25   |
+--------------------+--------------+
7 rows in set (0.00 sec)
```

---

## Task 5: Query Diagnosis & Mistake Resolution (`DISTINCT` + `LIMIT`)

### Problem Statement
> *You tried running this query:*  
> `SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2`  
> *but it returns an error or doesn't work as expected. Identify and fix the mistake in the query.*  
> *Hint: Check the correct placement and usage of the LIMIT keyword in SQL syntax.*

---

### In-Depth Diagnostic Analysis

The query `SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2` has multiple common pitfalls depending on how it was entered and what business outcome was expected:

#### 1. Common Syntax Error: Misplaced `LIMIT` Keyword
Beginners learning SQL frequently confuse `LIMIT` with SQL Server's `TOP` keyword and place `LIMIT` immediately after `SELECT` or before `FROM`:
```sql
-- INCORRECT: Placing LIMIT before FROM
SELECT DISTINCT food_item, restaurant LIMIT 2 FROM FoodOrders;

-- INCORRECT: Placing LIMIT right after SELECT
SELECT LIMIT 2 DISTINCT food_item, restaurant FROM FoodOrders;
```
* **Engine Response**: MySQL throws `ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'LIMIT 2 FROM FoodOrders'`.
* **SQL Clause Order Rule**: In SQL grammar, clauses must follow a strict execution pipeline order:
  $$\text{SELECT} \longrightarrow \text{FROM} \longrightarrow \text{WHERE} \longrightarrow \text{GROUP BY} \longrightarrow \text{HAVING} \longrightarrow \text{ORDER BY} \longrightarrow \text{LIMIT}$$
  `LIMIT` must **always be placed at the very end** of the query.

#### 2. Logical Defect: Non-Deterministic Results (Missing `ORDER BY`)
In relational databases, rows have **no inherent order**. When executing `LIMIT 2` without an `ORDER BY` clause:
* The database engine stops after finding any arbitrary 2 rows according to physical disk storage or index caching.
* The query is **non-deterministic**: running it today might return different items than tomorrow.
* **Fix**: Always specify an explicit `ORDER BY` clause whenever using `LIMIT`.

#### 3. Semantic Misunderstanding: Scope of `DISTINCT` on Multiple Columns
* Many learners mistakenly assume that `SELECT DISTINCT food_item, restaurant` makes only `food_item` distinct.
* In reality, `DISTINCT` applies to the **combination (tuple) of all listed columns** `(food_item, restaurant)`. If "Farmhouse Pizza" is sold by two different restaurants, both rows appear because the tuple is distinct. If the intention was distinct dishes regardless of restaurant, only `food_item` should be selected.

#### 4. Database Engine Incompatibility (Dialect Differences)
* If executing in **Microsoft SQL Server (T-SQL)**, `LIMIT` is an invalid keyword and throws a syntax error.
* SQL Server uses `SELECT DISTINCT TOP 2 food_item, restaurant FROM FoodOrders;`.
* Oracle (pre-12c) uses `ROWNUM <= 2`, or Oracle 12c+ uses `FETCH FIRST 2 ROWS ONLY`.

---

### Corrected SQL Queries

Depending on the intended business objective, here are the corrected, production-ready solutions:

#### Solution A: Predictable Top 2 Unique Dishes Alphabetically (Recommended)
```sql
SELECT DISTINCT food_item, restaurant
FROM FoodOrders
ORDER BY food_item ASC
LIMIT 2;
```
* **Execution Output**:
```text
+-----------------+----------------+
| food_item       | restaurant     |
+-----------------+----------------+
| Chole Bhature   | Haldiram's     |
| Farmhouse Pizza | Domino's Pizza |
+-----------------+----------------+
2 rows in set (0.00 sec)
```

#### Solution B: Most Recent 2 Unique Orders (By Date)
```sql
SELECT DISTINCT food_item, restaurant, order_date
FROM FoodOrders
ORDER BY order_date DESC
LIMIT 2;
```
* **Execution Output**:
```text
+-----------------+----------------+------------+
| food_item       | restaurant     | order_date |
+-----------------+----------------+------------+
| Farmhouse Pizza | Domino's Pizza | 2026-10-25 |
| Chole Bhature   | Haldiram's     | 2026-10-24 |
+-----------------+----------------+------------+
2 rows in set (0.00 sec)
```

#### Solution C: If User Intended Distinct Food Items Only
```sql
SELECT DISTINCT food_item
FROM FoodOrders
ORDER BY food_item ASC
LIMIT 2;
```
* **Execution Output**:
```text
+-----------------+
| food_item       |
+-----------------+
| Chole Bhature   |
| Farmhouse Pizza |
+-----------------+
2 rows in set (0.00 sec)
```

---

## 💡 Summary of Key Takeaways

1. **`SELECT *` vs Explicit Columns**: While `SELECT *` is helpful for ad-hoc inspection, production queries should specify explicit column names to minimize bandwidth and memory consumption.
2. **`LIMIT` Placement**: `LIMIT` always sits at the very end of the SQL statement.
3. **`LIMIT` + `ORDER BY` Pair**: Never use `LIMIT` without an `ORDER BY` unless random sampling is explicitly desired.
4. **`DISTINCT` Multi-Column Evaluation**: `DISTINCT` evaluates the entire row projection, not just the first column following the keyword.
5. **Column Aliases (`AS`)**: Make output intuitive for reporting and dashboards. Use backticks (`` `alias` ``) or quotes when spaces are present.
