# Session 1: Database Introduction & SQL Basics

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL / MySQL Workbench)**  
**SQL Source File**: [`music_streaming_app.sql`](music_streaming_app.sql)

---

## Task 1: Install MySQL and Create Database `music_streaming_app`

### System Environment
* **RDBMS Engine**: MySQL Server 8.0 (Community Server)
* **GUI Management Tool**: MySQL Workbench 8.0
* **CLI Client**: `mysql` command-line utility

### SQL Command
```sql
-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS music_streaming_app;

-- Step 2: Switch context to music_streaming_app
USE music_streaming_app;
```

### Execution Output (MySQL CLI)
```sql
mysql> CREATE DATABASE IF NOT EXISTS music_streaming_app;
Query OK, 1 row affected (0.01 sec)

mysql> USE music_streaming_app;
Database changed
```

---

## Task 2: Create Table `playlists`

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

### Column Architecture
| Column | MySQL Data Type | Key / Constraint | Purpose |
| :--- | :--- | :--- | :--- |
| `playlist_id` | `INT` | `PRIMARY KEY` | Unique identifier for each playlist record. Enforces non-null and unique values. |
| `name` | `VARCHAR(255)` | `NOT NULL` | The title/name of the playlist (up to 255 characters). |
| `created_by` | `VARCHAR(100)` | `NOT NULL` | The name or username of the user who authored the playlist. |

### Execution Output (MySQL CLI)
```sql
mysql> CREATE TABLE IF NOT EXISTS playlists (
    ->     playlist_id INT PRIMARY KEY,
    ->     name VARCHAR(255) NOT NULL,
    ->     created_by VARCHAR(100) NOT NULL
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> DESCRIBE playlists;
+-------------+--------------+------+-----+---------+-------+
| Field       | Type         | Null | Key | Default | Extra |
+-------------+--------------+------+-----+---------+-------+
| playlist_id | int          | NO   | PRI | NULL    |       |
| name        | varchar(255) | NO   |     | NULL    |       |
| created_by  | varchar(100) | NO   |     | NULL    |       |
+-------------+--------------+------+-----+---------+-------+
3 rows in set (0.00 sec)
```

---

## Task 3: Insert Three Sample Playlists

### Objective
Insert three sample rows into the `playlists` table representing playlists:
* `'Bollywood Hits'`
* `'Chill Vibes'`
* `'Workout Mix'`
Each created by a different user.

### SQL DML Statement
```sql
INSERT INTO playlists (playlist_id, name, created_by) VALUES
(1, 'Bollywood Hits', 'Amit'),
(2, 'Chill Vibes', 'Neha'),
(3, 'Workout Mix', 'Rohan');
```

### Execution Output (MySQL CLI)
```sql
mysql> INSERT INTO playlists (playlist_id, name, created_by) VALUES
    -> (1, 'Bollywood Hits', 'Amit'),
    -> (2, 'Chill Vibes', 'Neha'),
    -> (3, 'Workout Mix', 'Rohan');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM playlists;
+-------------+----------------+------------+
| playlist_id | name           | created_by |
+-------------+----------------+------------+
|           1 | Bollywood Hits | Amit       |
|           2 | Chill Vibes    | Neha       |
|           3 | Workout Mix    | Rohan      |
+-------------+----------------+------------+
3 rows in set (0.00 sec)
```

---

## Task 4: Filter Query for User 'Amit'

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

### Execution Output (MySQL CLI / Workbench)
```sql
mysql> SELECT playlist_id, name, created_by 
    -> FROM playlists 
    -> WHERE created_by = 'Amit';
+-------------+----------------+------------+
| playlist_id | name           | created_by |
+-------------+----------------+------------+
|           1 | Bollywood Hits | Amit       |
+-------------+----------------+------------+
1 row in set (0.00 sec)
```

---

## Task 5: AI Explanation — Difference Between Table, Row, and Column (Zomato Example)

### Prompt Given to AI (ChatGPT / Copilot)
> *"Explain the difference between a table, a row, and a column in SQL using an example from a food delivery app like Zomato."*

### Received Explanation:

In relational databases (RDBMS) like MySQL, data is structured logically as a two-dimensional grid consisting of **Tables**, **Columns**, and **Rows**:

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
* **Definition**: A **Table** is a structured collection of related data organized in rows and columns, representing an entire entity or business category.
* **Zomato Example**: The table is titled **`zomato_orders`**. It stores the complete ledger of all food orders placed across the application. Other tables in Zomato include `restaurants`, `users`, and `delivery_riders`.

#### 2. What is a Column (Attribute / Field)?
* **Definition**: A **Column** is a vertical dimension that defines a specific characteristic or property stored for every record, governed by a defined data type.
* **Zomato Example**:
  - `restaurant_name` (VARCHAR): Stores text names of restaurants.
  - `total_amount` (DECIMAL / INT): Stores the monetary order value.
  - `order_status` (VARCHAR): Stores current order status ('Delivered', 'On the way', 'Preparing').

#### 3. What is a Row (Record / Tuple)?
* **Definition**: A **Row** is a single horizontal entry in the table containing all attributes for one individual entity or transaction.
* **Zomato Example**: Row 1 (`501`, `'Haldiram\'s'`, `'Chole Bhature'`, `280`, `'Delivered'`) represents **one specific order receipt** placed by a customer. It connects the order ID, restaurant, food item, bill amount, and delivery status into a coherent record.

### Summary Comparison Table
| SQL Concept | Zomato Example | Dimension | Description |
| :--- | :--- | :--- | :--- |
| **Table** | `zomato_orders` | 2D Matrix (Grid) | Entire data entity storing all past and present orders. |
| **Column** | `total_amount` | Vertical ($\downarrow$) | Specific attribute and data type shared by all records. |
| **Row** | Order #501 Receipt | Horizontal ($\rightarrow$) | A single, complete transaction record. |
