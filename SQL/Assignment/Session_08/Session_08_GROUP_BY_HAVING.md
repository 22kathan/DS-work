# Session 8: GROUP BY + HAVING

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Table**: `Orders`  
**SQL Script File**: [`session_08_group_by_having.sql`](session_08_group_by_having.sql)

---

## Task 1: Create Table `Orders` with Payment Methods & Sample Records

### Objective
Create a table called `Orders` with columns: `order_id`, `user_id`, `payment_method`, and `amount`. Insert at least 8 sample records representing different users and payment methods (like UPI, Card, Wallet, COD).

### Table Schema & DDL
* `order_id`: `INT PRIMARY KEY`
* `user_id`: `INT NOT NULL`
* `payment_method`: `VARCHAR(50) NOT NULL` (e.g., 'UPI', 'Card', 'Wallet', 'COD')
* `amount`: `DECIMAL(10, 2) NOT NULL`

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session08_db;
USE session08_db;

DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO Orders (order_id, user_id, payment_method, amount) VALUES
(1, 101, 'UPI', 450.00),
(2, 102, 'Card', 850.00),
(3, 101, 'Wallet', 180.00),
(4, 103, 'UPI', 520.00),
(5, 102, 'COD', 250.00),
(6, 104, 'Card', 920.00),
(7, 101, 'UPI', 310.00),
(8, 103, 'Wallet', 150.00),
(9, 104, 'COD', 220.00),
(10, 102, 'Card', 600.00);

SELECT * FROM Orders;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Orders;
+----------+---------+----------------+--------+
| order_id | user_id | payment_method | amount |
+----------+---------+----------------+--------+
|        1 |     101 | UPI            | 450.00 |
|        2 |     102 | Card           | 850.00 |
|        3 |     101 | Wallet         | 180.00 |
|        4 |     103 | UPI            | 520.00 |
|        5 |     102 | COD            | 250.00 |
|        6 |     104 | Card           | 920.00 |
|        7 |     101 | UPI            | 310.00 |
|        8 |     103 | Wallet         | 150.00 |
|        9 |     104 | COD            | 220.00 |
|       10 |     102 | Card           | 600.00 |
+----------+---------+----------------+--------+
10 rows in set (0.00 sec)
```

---

## Task 2: Order Breakdown by Payment Method (Zomato Analytics Style)

### Objective
Write an SQL query to count how many orders were placed using each `payment_method` in the `Orders` table, similar to how Zomato shows payment breakdown in analytics.

### Query Design
* `GROUP BY payment_method`: Consolidates all individual transactions into distinct payment method buckets.
* `COUNT(*)`: Calculates the frequency of orders settled through each instrument.

### SQL Implementation
```sql
SELECT 
    payment_method,
    COUNT(*) AS order_count
FROM Orders
GROUP BY payment_method
ORDER BY order_count DESC, payment_method ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT payment_method, COUNT(*) AS order_count FROM Orders GROUP BY payment_method ORDER BY order_count DESC, payment_method ASC;
+----------------+-------------+
| payment_method | order_count |
+----------------+-------------+
| Card           |           3 |
| UPI            |           3 |
| COD            |           2 |
| Wallet         |           2 |
+----------------+-------------+
4 rows in set (0.00 sec)
```

---

## Task 3: Total Spend by Each User (`SUM(amount)` + `GROUP BY user_id`)

### Objective
Write an SQL query to find the total amount spent by each `user_id` in the `Orders` table. Display `user_id` and their total spend.

### Query Design
* `SUM(amount) AS total_spend`: Adds together all order values attributed to each customer ID.
* `ORDER BY total_spend DESC`: Ranks customers from highest total spending to lowest.

### SQL Implementation
```sql
SELECT 
    user_id,
    SUM(amount) AS total_spend
FROM Orders
GROUP BY user_id
ORDER BY total_spend DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT user_id, SUM(amount) AS total_spend FROM Orders GROUP BY user_id ORDER BY total_spend DESC;
+---------+-------------+
| user_id | total_spend |
+---------+-------------+
|     102 |     1700.00 |
|     104 |     1140.00 |
|     101 |      940.00 |
|     103 |      670.00 |
+---------+-------------+
4 rows in set (0.00 sec)
```

---

## Task 4: Filter Payment Methods with Average Order Amount > 300 (`HAVING`)

### Objective
Write an SQL query to show only those payment methods where the average order amount is greater than 300, using `GROUP BY` and `HAVING`.

### Query Design & Hint
* **Hint**: *Use `AVG(amount)` in your `HAVING` clause.*
* Aggregate metric:
  - Card: $(850 + 920 + 600) / 3 = 790.00$ (> 300 $\rightarrow$ **Retained**)
  - UPI: $(450 + 520 + 310) / 3 = 426.67$ (> 300 $\rightarrow$ **Retained**)
  - COD: $(250 + 220) / 2 = 235.00$ ($\le 300 \rightarrow$ **Filtered out**)
  - Wallet: $(180 + 150) / 2 = 165.00$ ($\le 300 \rightarrow$ **Filtered out**)

### SQL Implementation
```sql
SELECT 
    payment_method,
    ROUND(AVG(amount), 2) AS avg_order_amount
FROM Orders
GROUP BY payment_method
HAVING AVG(amount) > 300
ORDER BY avg_order_amount DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT payment_method, ROUND(AVG(amount), 2) AS avg_order_amount FROM Orders GROUP BY payment_method HAVING AVG(amount) > 300 ORDER BY avg_order_amount DESC;
+----------------+------------------+
| payment_method | avg_order_amount |
+----------------+------------------+
| Card           |           790.00 |
| UPI            |           426.67 |
+----------------+------------------+
2 rows in set (0.00 sec)
```

---

## Task 5: Difference Between WHERE and HAVING with Example Queries

### Conceptual Differences

| Comparison Aspect | `WHERE` Clause | `HAVING` Clause |
| :--- | :--- | :--- |
| **Pipeline Stage** | Filters individual **rows** **before** grouping and aggregation. | Filters aggregated **groups** **after** `GROUP BY` execution. |
| **Aggregate Functions** | **Cannot** use aggregate functions (e.g. `WHERE AVG(amount) > 300` causes syntax error `ERROR 1111: Invalid use of group function`). | **Can and often does** filter on aggregate functions (e.g. `HAVING SUM(amount) > 1000`). |
| **Target Scope** | Individual records from the source table. | Summary rows produced by `GROUP BY`. |

---

### Example 1: `WHERE` Clause (Filtering Individual Rows Before Aggregation)
* **Scenario**: Count orders per payment method, but **only consider transactions larger than ₹200**. Individual transactions below or equal to ₹200 (such as Wallet ₹180 and ₹150) are eliminated before counting.

```sql
SELECT 
    payment_method,
    COUNT(*) AS qualifying_orders
FROM Orders
WHERE amount > 200
GROUP BY payment_method
ORDER BY qualifying_orders DESC;
```

#### Output:
```text
+----------------+-------------------+
| payment_method | qualifying_orders |
+----------------+-------------------+
| Card           |                 3 |
| UPI            |                 3 |
| COD            |                 2 |
+----------------+-------------------+
```
*(Notice: Wallet had 2 orders, but both were $\le 200$, so Wallet was filtered out at the row level before grouping).*

---

### Example 2: `HAVING` Clause (Filtering Aggregated Summary Groups)
* **Scenario**: Group all orders by user and identify high-value VIP users **whose cumulative total spend exceeds ₹1,000**. The calculation evaluates the sum across all transactions for each user, then filters the groups.

```sql
SELECT 
    user_id,
    SUM(amount) AS total_spend
FROM Orders
GROUP BY user_id
HAVING SUM(amount) > 1000
ORDER BY total_spend DESC;
```

#### Output:
```text
+---------+-------------+
| user_id | total_spend |
+---------+-------------+
|     102 |     1700.00 |
|     104 |     1140.00 |
+---------+-------------+
```
*(Notice: User 101 (₹940) and User 103 (₹670) are filtered out because their group total spend did not reach ₹1,000).*

---

### Example 3: Combined Query Demonstrating the Complete Execution Pipeline
This query applies both clauses in a single statement to illustrate the end-to-end execution flow:
$$\text{WHERE (Filter Raw Rows)} \longrightarrow \text{GROUP BY (Bucket)} \longrightarrow \text{HAVING (Filter Buckets)}$$

```sql
SELECT 
    payment_method,
    COUNT(*) AS count_above_200,
    ROUND(AVG(amount), 2) AS avg_amount
FROM Orders
WHERE amount > 200                  -- Step 1: Discard raw transactions <= 200
GROUP BY payment_method             -- Step 2: Bucket remaining transactions
HAVING AVG(amount) > 500            -- Step 3: Keep only buckets with average > 500
ORDER BY avg_amount DESC;
```

#### Output:
```text
+----------------+------------------+------------+
| payment_method | count_above_200  | avg_amount |
+----------------+------------------+------------+
| Card           |                3 |     790.00 |
+----------------+------------------+------------+
1 row in set (0.00 sec)
```
*(Card is the only payment method satisfying both the individual row threshold and the group average threshold).*
