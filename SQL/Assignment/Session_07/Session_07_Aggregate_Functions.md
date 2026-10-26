# Session 7: Aggregate Functions

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Table**: `Orders`  
**SQL Script File**: [`session_07_aggregate_functions.sql`](session_07_aggregate_functions.sql)

---

## Task 1: Create Table `Orders` with Sample Data (Including NULL Amount)

### Objective
Create a table called `Orders` with columns: `order_id`, `user_name`, `total_amount`, and `order_date`. Insert 5 sample rows with different users and order amounts, including at least one `NULL` value for `total_amount`.

### Table Schema & DDL
* `order_id`: `INT PRIMARY KEY`
* `user_name`: `VARCHAR(100) NOT NULL`
* `total_amount`: `DECIMAL(10, 2)` (Nullable to handle unbilled/cancelled orders)
* `order_date`: `DATE NOT NULL`

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session07_db;
USE session07_db;

DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    total_amount DECIMAL(10, 2),
    order_date DATE NOT NULL
);

INSERT INTO Orders (order_id, user_name, total_amount, order_date) VALUES
(101, 'kathan_g', 2499.00, '2026-10-15'),
(102, 'priya_s', 1250.50, '2026-10-16'),
(103, 'kathan_g', 4899.00, '2026-10-18'),
(104, 'rahul_v', NULL, '2026-10-20'),     -- NULL total_amount
(105, 'priya_s', 899.00, '2026-10-22'),
(106, 'amit_p', 3200.00, '2026-10-23');

SELECT * FROM Orders;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Orders;
+----------+-----------+--------------+------------+
| order_id | user_name | total_amount | order_date |
+----------+-----------+--------------+------------+
|      101 | kathan_g  |      2499.00 | 2026-10-15 |
|      102 | priya_s   |      1250.50 | 2026-10-16 |
|      103 | kathan_g  |      4899.00 | 2026-10-18 |
|      104 | rahul_v   |         NULL | 2026-10-20 |
|      105 | priya_s   |       899.00 | 2026-10-22 |
|      106 | amit_p    |      3200.00 | 2026-10-23 |
+----------+-----------+--------------+------------+
6 rows in set (0.00 sec)
```

---

## Task 2: Count Orders Placed by Each User (`COUNT` + `GROUP BY`)

### Objective
Write an SQL query to count how many orders were placed by each user in the `Orders` table, displaying `user_name` and the number of orders as `order_count`.

### Query Design
* `COUNT(*)` counts total rows per group, capturing all transaction attempts (including order #104 placed by `rahul_v`).
* `GROUP BY user_name` aggregates records by unique user handles.

### SQL Implementation
```sql
SELECT 
    user_name,
    COUNT(*) AS order_count
FROM Orders
GROUP BY user_name
ORDER BY order_count DESC, user_name ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT user_name, COUNT(*) AS order_count FROM Orders GROUP BY user_name ORDER BY order_count DESC, user_name ASC;
+-----------+-------------+
| user_name | order_count |
+-----------+-------------+
| kathan_g  |           2 |
| priya_s   |           2 |
| amit_p    |           1 |
| rahul_v   |           1 |
+-----------+-------------+
4 rows in set (0.00 sec)
```

---

## Task 3: Average Order Amount (`AVG`, Ignoring NULL Values)

### Objective
Write an SQL query to calculate the average `total_amount` of all orders in the `Orders` table, making sure to ignore any `NULL` values.

### Query Design & NULL Handling
* In ANSI SQL, standard aggregate functions (`AVG`, `SUM`, `MIN`, `MAX`) automatically ignore `NULL` entries and compute the mean across only non-null values ($12747.50 / 5 = 2549.50$).
* Adding `WHERE total_amount IS NOT NULL` explicitly clarifies query intent.

### SQL Implementation
```sql
SELECT 
    ROUND(AVG(total_amount), 2) AS average_order_amount
FROM Orders
WHERE total_amount IS NOT NULL;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT ROUND(AVG(total_amount), 2) AS average_order_amount FROM Orders WHERE total_amount IS NOT NULL;
+----------------------+
| average_order_amount |
+----------------------+
|              2549.50 |
+----------------------+
1 row in set (0.00 sec)
```

---

## Task 4: Flipkart Dashboard: Highest & Lowest Order Amount (`MAX` & `MIN`)

### Objective
Suppose you are building a Flipkart-style dashboard: Write an SQL query to find the highest and lowest order amounts (`MAX` and `MIN`) from the `Orders` table, and display both values in a single result row.

### Query Design
* Both aggregate functions `MAX(total_amount)` and `MIN(total_amount)` are projected together within the same `SELECT` clause, resulting in a single summary row.

### SQL Implementation
```sql
SELECT 
    MAX(total_amount) AS highest_order_amount,
    MIN(total_amount) AS lowest_order_amount
FROM Orders;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT MAX(total_amount) AS highest_order_amount, MIN(total_amount) AS lowest_order_amount FROM Orders;
+----------------------+---------------------+
| highest_order_amount | lowest_order_amount |
+----------------------+---------------------+
|              4899.00 |              899.00 |
+----------------------+---------------------+
1 row in set (0.00 sec)
```

---

## Task 5: Total Sales (`SUM`) Filtering Out NULL Values

### Objective
Write an SQL query to calculate the total sales (`SUM` of `total_amount`) for all orders, but only include orders where `total_amount` is not NULL.

### Query Design & Hint
* **Hint**: *Use a WHERE clause to filter out NULL values before applying the SUM function.*
* Filter condition: `WHERE total_amount IS NOT NULL` ensures the query engine discards incomplete orders before computing the total sum.

### SQL Implementation
```sql
SELECT 
    SUM(total_amount) AS total_sales
FROM Orders
WHERE total_amount IS NOT NULL;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT SUM(total_amount) AS total_sales FROM Orders WHERE total_amount IS NOT NULL;
+-------------+
| total_sales |
+-------------+
|    12747.50 |
+-------------+
1 row in set (0.00 sec)
```
*(Calculation: $2499.00 + 1250.50 + 4899.00 + 899.00 + 3200.00 = 12747.50$).*
