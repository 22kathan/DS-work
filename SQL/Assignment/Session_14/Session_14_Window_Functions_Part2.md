# Session 14: Window Functions - Part 2

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Table**: `Orders`  
**SQL Script File**: [`session_14_window_functions_part2.sql`](session_14_window_functions_part2.sql)

---

## Task 1: Create Table `Orders` & Insert Sample Orders

### Objective
Create a table called `Orders` with columns: `order_id`, `user_id`, `order_date`, and `total_amount`. Insert at least 7 sample rows representing different users and dates, similar to how food orders appear in Zomato or Swiggy.

### Table Schema & DDL
* `order_id`: `INT PRIMARY KEY` — Unique identifier for each food order
* `user_id`: `INT NOT NULL` — Customer identifier
* `order_date`: `DATE NOT NULL` — Date when the order was placed
* `total_amount`: `DECIMAL(10, 2) NOT NULL` — Final billed amount in INR

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session14_db;
USE session14_db;

DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO Orders (order_id, user_id, order_date, total_amount) VALUES
(1, 101, '2026-10-01', 350.00),
(2, 101, '2026-10-05', 450.00),
(3, 101, '2026-10-10', 600.00),
(4, 101, '2026-10-15', 520.00),
(5, 102, '2026-10-02', 200.00),
(6, 102, '2026-10-08', 300.00),
(7, 102, '2026-10-14', 400.00),
(8, 103, '2026-10-04', 750.00),
(9, 103, '2026-10-12', 850.00);

SELECT * FROM Orders ORDER BY order_id;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Orders ORDER BY order_id;
+----------+---------+------------+--------------+
| order_id | user_id | order_date | total_amount |
+----------+---------+------------+--------------+
|        1 |     101 | 2026-10-01 |       350.00 |
|        2 |     101 | 2026-10-05 |       450.00 |
|        3 |     101 | 2026-10-10 |       600.00 |
|        4 |     101 | 2026-10-15 |       520.00 |
|        5 |     102 | 2026-10-02 |       200.00 |
|        6 |     102 | 2026-10-08 |       300.00 |
|        7 |     102 | 2026-10-14 |       400.00 |
|        8 |     103 | 2026-10-04 |       750.00 |
|        9 |     103 | 2026-10-12 |       850.00 |
+----------+---------+------------+--------------+
9 rows in set (0.00 sec)
```

---

## Task 2: Previous Order Amount Using `LAG()`

### Objective
Write a SQL query using the `LAG()` function to show each user's `order_id`, `order_date`, and the `total_amount` of their previous order (if any), ordered by user and date.

### Mechanics & Hint
* **Hint**: *Use `PARTITION BY user_id` and `ORDER BY order_date` in your window function.*
* `LAG(total_amount, 1)` accesses data from the previous row within the user's partition without requiring a self-join.
* For the first order placed by any user, `LAG()` naturally yields `NULL` because no preceding record exists within that user's partition.

### SQL Implementation
```sql
SELECT 
    user_id,
    order_id,
    order_date,
    total_amount,
    LAG(total_amount, 1) OVER (
        PARTITION BY user_id 
        ORDER BY order_date ASC
    ) AS previous_order_amount
FROM Orders
ORDER BY user_id ASC, order_date ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT user_id, order_id, order_date, total_amount, LAG(total_amount, 1) OVER (PARTITION BY user_id ORDER BY order_date ASC) AS previous_order_amount FROM Orders ORDER BY user_id ASC, order_date ASC;
+---------+----------+------------+--------------+-----------------------+
| user_id | order_id | order_date | total_amount | previous_order_amount |
+---------+----------+------------+--------------+-----------------------+
|     101 |        1 | 2026-10-01 |       350.00 |                  NULL |
|     101 |        2 | 2026-10-05 |       450.00 |                350.00 |
|     101 |        3 | 2026-10-10 |       600.00 |                450.00 |
|     101 |        4 | 2026-10-15 |       520.00 |                600.00 |
|     102 |        5 | 2026-10-02 |       200.00 |                  NULL |
|     102 |        6 | 2026-10-08 |       300.00 |                200.00 |
|     102 |        7 | 2026-10-14 |       400.00 |                300.00 |
|     103 |        8 | 2026-10-04 |       750.00 |                  NULL |
|     103 |        9 | 2026-10-12 |       850.00 |                750.00 |
+---------+----------+------------+--------------+-----------------------+
9 rows in set (0.00 sec)
```

---

## Task 3: Next Order Amount Using `LEAD()`

### Objective
Using the same `Orders` table, write a SQL query with the `LEAD()` function to display each `order_id`, `order_date`, and the next order's `total_amount` for the same user.

### Mechanics
* `LEAD(total_amount, 1)` looks ahead to the subsequent row within the partition.
* For the most recent (last) order placed by any user, `LEAD()` returns `NULL` since no subsequent order exists.
* Essential in food delivery apps for customer retention analytics, calculating inter-order churn risk, and measuring time elapsed between repeat purchases.

### SQL Implementation
```sql
SELECT 
    user_id,
    order_id,
    order_date,
    total_amount,
    LEAD(total_amount, 1) OVER (
        PARTITION BY user_id 
        ORDER BY order_date ASC
    ) AS next_order_amount
FROM Orders
ORDER BY user_id ASC, order_date ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT user_id, order_id, order_date, total_amount, LEAD(total_amount, 1) OVER (PARTITION BY user_id ORDER BY order_date ASC) AS next_order_amount FROM Orders ORDER BY user_id ASC, order_date ASC;
+---------+----------+------------+--------------+-------------------+
| user_id | order_id | order_date | total_amount | next_order_amount |
+---------+----------+------------+--------------+-------------------+
|     101 |        1 | 2026-10-01 |       350.00 |            450.00 |
|     101 |        2 | 2026-10-05 |       450.00 |            600.00 |
|     101 |        3 | 2026-10-10 |       600.00 |            520.00 |
|     101 |        4 | 2026-10-15 |       520.00 |              NULL |
|     102 |        5 | 2026-10-02 |       200.00 |            300.00 |
|     102 |        6 | 2026-10-08 |       300.00 |            400.00 |
|     102 |        7 | 2026-10-14 |       400.00 |              NULL |
|     103 |        8 | 2026-10-04 |       750.00 |            850.00 |
|     103 |        9 | 2026-10-12 |       850.00 |              NULL |
+---------+----------+------------+--------------+-------------------+
9 rows in set (0.00 sec)
```

---

## Task 4: Running Total of Order Amounts per User

### Objective
Write a SQL query to calculate the running total of `total_amount` for each user, showing `order_id`, `order_date`, `total_amount`, and a column `running_total` that accumulates the sum as you move through each user's orders.

### Mechanics & Hint
* **Hint**: *Use `SUM(total_amount) OVER (PARTITION BY user_id ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`.*
* The window frame specification `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` instructs the database engine to sum every record starting from the very first order of that user up to the current row being processed.

### SQL Implementation
```sql
SELECT 
    user_id,
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY user_id 
        ORDER BY order_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM Orders
ORDER BY user_id ASC, order_date ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT user_id, order_id, order_date, total_amount, SUM(total_amount) OVER (PARTITION BY user_id ORDER BY order_date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total FROM Orders ORDER BY user_id ASC, order_date ASC;
+---------+----------+------------+--------------+---------------+
| user_id | order_id | order_date | total_amount | running_total |
+---------+----------+------------+--------------+---------------+
|     101 |        1 | 2026-10-01 |       350.00 |        350.00 |
|     101 |        2 | 2026-10-05 |       450.00 |        800.00 |
|     101 |        3 | 2026-10-10 |       600.00 |       1400.00 |
|     101 |        4 | 2026-10-15 |       520.00 |       1920.00 |
|     102 |        5 | 2026-10-02 |       200.00 |        200.00 |
|     102 |        6 | 2026-10-08 |       300.00 |        500.00 |
|     102 |        7 | 2026-10-14 |       400.00 |        900.00 |
|     103 |        8 | 2026-10-04 |       750.00 |        750.00 |
|     103 |        9 | 2026-10-12 |       850.00 |       1600.00 |
+---------+----------+------------+--------------+---------------+
9 rows in set (0.00 sec)
```

---

## Task 5: 3-Order Moving Average per User

### Objective
Write a SQL query to calculate a 3-order moving average of `total_amount` for each user, showing `order_id`, `order_date`, `total_amount`, and `moving_avg` columns.

### Mechanics & Constraint
* **Constraint**: *Use `SUM() OVER()` with `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` to compute the moving average.*
* Mathematical formula:
  $$\text{Moving Average} = \frac{\sum_{i=0}^{2} \text{total\_amount}_{(\text{current}-i)}}{\text{count of valid rows in window}}$$
* On Order 1 of User 101, the window has 1 row: $350.00 / 1 = 350.00$.
* On Order 2, the window has 2 rows: $(350.00 + 450.00) / 2 = 400.00$.
* On Order 3, the window has 3 rows: $(350.00 + 450.00 + 600.00) / 3 = 466.67$.
* On Order 4, the oldest order drops out of the frame: $(450.00 + 600.00 + 520.00) / 3 = 523.33$.

### SQL Implementation
```sql
SELECT 
    user_id,
    order_id,
    order_date,
    total_amount,
    ROUND(
        SUM(total_amount) OVER (
            PARTITION BY user_id 
            ORDER BY order_date ASC 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) / 
        COUNT(*) OVER (
            PARTITION BY user_id 
            ORDER BY order_date ASC 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg
FROM Orders
ORDER BY user_id ASC, order_date ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT user_id, order_id, order_date, total_amount, ROUND(SUM(total_amount) OVER (PARTITION BY user_id ORDER BY order_date ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) / COUNT(*) OVER (PARTITION BY user_id ORDER BY order_date ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg FROM Orders ORDER BY user_id ASC, order_date ASC;
+---------+----------+------------+--------------+------------+
| user_id | order_id | order_date | total_amount | moving_avg |
+---------+----------+------------+--------------+------------+
|     101 |        1 | 2026-10-01 |       350.00 |     350.00 |
|     101 |        2 | 2026-10-05 |       450.00 |     400.00 |
|     101 |        3 | 2026-10-10 |       600.00 |     466.67 |
|     101 |        4 | 2026-10-15 |       520.00 |     523.33 |
|     102 |        5 | 2026-10-02 |       200.00 |     200.00 |
|     102 |        6 | 2026-10-08 |       300.00 |     250.00 |
|     102 |        7 | 2026-10-14 |       400.00 |     300.00 |
|     103 |        8 | 2026-10-04 |       750.00 |     750.00 |
|     103 |        9 | 2026-10-12 |       850.00 |     800.00 |
+---------+----------+------------+--------------+------------+
9 rows in set (0.00 sec)
```
