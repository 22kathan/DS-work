# Session 5: WHERE Clause + LIKE Operator

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Table**: `Restaurants`  
**SQL Script File**: [`session_05_where_like.sql`](session_05_where_like.sql)

---

## Task 1: Create Table `Restaurants` & Insert Zomato Records

### Objective
Create a table called `Restaurants` with columns: `id`, `name`, `cuisine`, `rating`, and `city`. Insert at least 5 sample records representing real or fictional restaurants you might find on Zomato.

### Table Schema & DDL
* `id`: `INT PRIMARY KEY`
* `name`: `VARCHAR(255) NOT NULL` (Restaurant name)
* `cuisine`: `VARCHAR(100) NOT NULL` (Cuisine type)
* `rating`: `DECIMAL(2, 1) NOT NULL` (Rating from 1.0 to 5.0)
* `city`: `VARCHAR(100) NOT NULL` (Location city)

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session05_db;
USE session05_db;

DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    cuisine VARCHAR(100) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    city VARCHAR(100) NOT NULL
);

-- Insert 8 representative Zomato restaurants across Gujarat
INSERT INTO Restaurants (id, name, cuisine, rating, city) VALUES
(1, 'Swagat Restaurant', 'North Indian', 4.3, 'Ahmedabad'),
(2, 'Swadisht Dining Hall', 'Gujarati', 4.5, 'Surat'),
(3, 'Swati Snacks', 'South Indian', 4.6, 'Ahmedabad'),
(4, 'Mainland China', 'Chinese', 4.2, 'Vadodara'),
(5, 'Little Italy', 'Italian', 4.4, 'Ahmedabad'),
(6, 'Dakshin Express', 'South Indian', 3.8, 'Surat'),
(7, 'Wok Express', 'Chinese', 3.4, 'Ahmedabad'),
(8, 'The Belgian Waffle Co.', 'Desserts', 4.1, 'Rajkot');

-- Retrieve full table
SELECT * FROM Restaurants;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Restaurants;
+----+------------------------+--------------+--------+-----------+
| id | name                   | cuisine      | rating | city      |
+----+------------------------+--------------+--------+-----------+
|  1 | Swagat Restaurant      | North Indian |    4.3 | Ahmedabad |
|  2 | Swadisht Dining Hall   | Gujarati     |    4.5 | Surat     |
|  3 | Swati Snacks           | South Indian |    4.6 | Ahmedabad |
|  4 | Mainland China         | Chinese      |    4.2 | Vadodara  |
|  5 | Little Italy           | Italian      |    4.4 | Ahmedabad |
|  6 | Dakshin Express        | South Indian |    3.8 | Surat     |
|  7 | Wok Express            | Chinese      |    3.4 | Ahmedabad |
|  8 | The Belgian Waffle Co. | Desserts     |    4.1 | Rajkot    |
+----+------------------------+--------------+--------+-----------+
8 rows in set (0.00 sec)
```

---

## Task 2: Compound Filtering (Rating > 4.0 in Ahmedabad or Surat)

### Objective
Write an SQL query to find all restaurants in the `Restaurants` table that have a rating greater than `4.0` and are located in either `'Ahmedabad'` or `'Surat'`.

### Query Design & Logical Precedence
> [!IMPORTANT]
> **Operator Precedence**: In SQL, `AND` has higher precedence than `OR`. Writing:
> `WHERE rating > 4.0 AND city = 'Ahmedabad' OR city = 'Surat'`
> would be evaluated as:
> `(rating > 4.0 AND city = 'Ahmedabad') OR (city = 'Surat')`
> which would erroneously return **any** restaurant in Surat regardless of rating!  
> To guarantee correctness, parentheses or the `IN` operator must be used.

### SQL Implementation
```sql
-- Preferred Approach: Using IN operator
SELECT * 
FROM Restaurants
WHERE rating > 4.0 
  AND city IN ('Ahmedabad', 'Surat');

-- Alternative Approach: Using parenthesized OR
SELECT * 
FROM Restaurants
WHERE rating > 4.0 
  AND (city = 'Ahmedabad' OR city = 'Surat');
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Restaurants WHERE rating > 4.0 AND city IN ('Ahmedabad', 'Surat');
+----+----------------------+--------------+--------+-----------+
| id | name                 | cuisine      | rating | city      |
+----+----------------------+--------------+--------+-----------+
|  1 | Swagat Restaurant    | North Indian |    4.3 | Ahmedabad |
|  2 | Swadisht Dining Hall | Gujarati     |    4.5 | Surat     |
|  3 | Swati Snacks         | South Indian |    4.6 | Ahmedabad |
|  5 | Little Italy         | Italian      |    4.4 | Ahmedabad |
+----+----------------------+--------------+--------+-----------+
4 rows in set (0.00 sec)
```

---

## Task 3: Pattern Matching with `LIKE 'Swa%'`

### Objective
Using the `LIKE` operator, write a query to select all restaurants whose names start with `'Swa'` (for example, `'Swagat'`, `'Swadisht'`) from the `Restaurants` table.

### Query Design & Wildcard Mechanics
* **`%` Wildcard**: Matches 0, 1, or multiple arbitrary characters.
* **`'Swa%'` Pattern**: Enforces that the string starts with `Swa`, followed by any sequence of subsequent characters.
* **Case-Sensitivity**: In MySQL, standard string collations (`utf8mb4_0900_ai_ci`) are case-insensitive by default, matching both `'Swagat'` and `'swagat'`.

### SQL Implementation
```sql
SELECT * 
FROM Restaurants
WHERE name LIKE 'Swa%';
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Restaurants WHERE name LIKE 'Swa%';
+----+----------------------+--------------+--------+-----------+
| id | name                 | cuisine      | rating | city      |
+----+----------------------+--------------+--------+-----------+
|  1 | Swagat Restaurant    | North Indian |    4.3 | Ahmedabad |
|  2 | Swadisht Dining Hall | Gujarati     |    4.5 | Surat     |
|  3 | Swati Snacks         | South Indian |    4.6 | Ahmedabad |
+----+----------------------+--------------+--------+-----------+
3 rows in set (0.00 sec)
```

---

## Task 4: Range Filtering with `BETWEEN` (Rating 3.5 to 4.5)

### Objective
Write an SQL query using the `BETWEEN` keyword to find all restaurants in the `Restaurants` table with a rating between `3.5` and `4.5` (inclusive).

### Query Design
* The `BETWEEN val1 AND val2` operator is strictly **inclusive**:
  $$\text{rating} \ge 3.5 \quad \text{AND} \quad \text{rating} \le 4.5$$
* Boundary cases: Restaurants with rating `3.5` and `4.5` are included. Restaurants with rating `3.4` (Wok Express) or `4.6` (Swati Snacks) are excluded.

### SQL Implementation
```sql
SELECT * 
FROM Restaurants
WHERE rating BETWEEN 3.5 AND 4.5;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Restaurants WHERE rating BETWEEN 3.5 AND 4.5;
+----+------------------------+--------------+--------+-----------+
| id | name                   | cuisine      | rating | city      |
+----+------------------------+--------------+--------+-----------+
|  1 | Swagat Restaurant      | North Indian |    4.3 | Ahmedabad |
|  2 | Swadisht Dining Hall   | Gujarati     |    4.5 | Surat     |
|  4 | Mainland China         | Chinese      |    4.2 | Vadodara  |
|  5 | Little Italy           | Italian      |    4.4 | Ahmedabad |
|  6 | Dakshin Express        | South Indian |    3.8 | Surat     |
|  8 | The Belgian Waffle Co. | Desserts     |    4.1 | Rajkot    |
+----+------------------------+--------------+--------+-----------+
6 rows in set (0.00 sec)
```

---

## Task 5: Set Membership Filtering with `IN`

### Objective
Write a query to find all restaurants whose cuisine is either `'Chinese'`, `'Italian'`, or `'South Indian'` using the `IN` operator.

### Query Design
* The `IN` operator provides a clean, readable shorthand for multiple `OR` equality conditions:
  $$\text{cuisine} = \text{'Chinese'} \;\lor\; \text{cuisine} = \text{'Italian'} \;\lor\; \text{cuisine} = \text{'South Indian'}$$
* Highly optimized: Database query optimizers evaluate `IN` lists using hash lookups or index scans far more efficiently than long chains of `OR` expressions.

### SQL Implementation
```sql
SELECT * 
FROM Restaurants
WHERE cuisine IN ('Chinese', 'Italian', 'South Indian');
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Restaurants WHERE cuisine IN ('Chinese', 'Italian', 'South Indian');
+----+-----------------+--------------+--------+-----------+
| id | name            | cuisine      | rating | city      |
+----+-----------------+--------------+--------+-----------+
|  3 | Swati Snacks    | South Indian |    4.6 | Ahmedabad |
|  4 | Mainland China  | Chinese      |    4.2 | Vadodara  |
|  5 | Little Italy    | Italian      |    4.4 | Ahmedabad |
|  6 | Dakshin Express | South Indian |    3.8 | Surat     |
|  7 | Wok Express     | Chinese      |    3.4 | Ahmedabad |
+----+-----------------+--------------+--------+-----------+
5 rows in set (0.00 sec)
```


