# Session 18: Interview Questions + Final Revision

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server 8.0 & MySQL Workbench)**  
**Target Tables**: `songs`, `users`, `orders`, `restaurants`, `transactions`, `products`  
**Target Database**: `session18_db`  
**SQL Script File**: [`session_18_interview_revision.sql`](session_18_interview_revision.sql)

---

## Task 1: Songs Upload Volume per Artist (Uploads > 3 Songs)

### Objective
Write an SQL query to display the total number of songs uploaded by each artist from a table `songs` (columns: `song_id`, `artist_name`, `title`) and show only those artists who have uploaded more than 3 songs.

### Table Schema & DDL
* `song_id`: `INT PRIMARY KEY` — Unique track identifier
* `artist_name`: `VARCHAR(100) NOT NULL` — Name of performing artist
* `title`: `VARCHAR(100) NOT NULL` — Track title

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session18_db;
USE session18_db;

DROP TABLE IF EXISTS songs;

CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL,
    title VARCHAR(100) NOT NULL
);

INSERT INTO songs (song_id, artist_name, title) VALUES
(1, 'Arijit Singh', 'Tum Hi Ho'),
(2, 'Arijit Singh', 'Kesariya'),
(3, 'Arijit Singh', 'Channa Mereya'),
(4, 'Arijit Singh', 'Apna Bana Le'),
(5, 'Diljit Dosanjh', 'Lover'),
(6, 'Diljit Dosanjh', 'Born to Shine'),
(7, 'Diljit Dosanjh', 'Proper Patola'),
(8, 'Diljit Dosanjh', 'GOAT'),
(9, 'AP Dhillon', 'Brown Munde'),
(10, 'AP Dhillon', 'Excuses'),
(11, 'AP Dhillon', 'Insane'),
(12, 'Shreya Ghoshal', 'Sunn Raha Hai'),
(13, 'Shreya Ghoshal', 'Deewani Mastani');

SELECT 
    artist_name, 
    COUNT(song_id) AS total_songs
FROM songs
GROUP BY artist_name
HAVING COUNT(song_id) > 3
ORDER BY total_songs DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT artist_name, COUNT(song_id) AS total_songs FROM songs GROUP BY artist_name HAVING COUNT(song_id) > 3 ORDER BY total_songs DESC;
+----------------+-------------+
| artist_name    | total_songs |
+----------------+-------------+
| Arijit Singh   |           4 |
| Diljit Dosanjh |           4 |
+----------------+-------------+
2 rows in set (0.00 sec)
```

---

## Task 2: Total Order Amount per User via SQL JOIN

### Objective
Given two tables, `orders` (`order_id`, `user_id`, `amount`) and `users` (`user_id`, `username`), write a SQL JOIN query to display each username along with their total order amount.

### Table Schemas & DDL
* `users`: `user_id INT PRIMARY KEY`, `username VARCHAR(100) NOT NULL`
* `orders`: `order_id INT PRIMARY KEY`, `user_id INT NOT NULL`, `amount DECIMAL(10, 2) NOT NULL`

### SQL Implementation
```sql
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

INSERT INTO users (user_id, username) VALUES
(1, 'kathan_gadhiya'),
(2, 'aarav_patel'),
(3, 'priya_sharma'),
(4, 'rohan_mehta');

INSERT INTO orders (order_id, user_id, amount) VALUES
(101, 1, 650.00),
(102, 1, 820.00),
(103, 2, 350.00),
(104, 2, 1100.00),
(105, 3, 1200.00);

SELECT 
    u.user_id,
    u.username,
    COALESCE(SUM(o.amount), 0.00) AS total_order_amount
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY total_order_amount DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT u.user_id, u.username, COALESCE(SUM(o.amount), 0.00) AS total_order_amount FROM users u LEFT JOIN orders o ON u.user_id = o.user_id GROUP BY u.user_id, u.username ORDER BY total_order_amount DESC;
+---------+----------------+--------------------+
| user_id | username       | total_order_amount |
+---------+----------------+--------------------+
|       1 | kathan_gadhiya |            1470.00 |
|       2 | aarav_patel    |            1450.00 |
|       3 | priya_sharma   |            1200.00 |
|       4 | rohan_mehta    |               0.00 |
+---------+----------------+--------------------+
4 rows in set (0.00 sec)
```

---

## Task 3: Restaurants with Rating Above Fleet Average (Subquery)

### Objective
Write a SQL subquery to find the names of all restaurants from a `restaurants` table (`id`, `name`, `rating`) whose rating is higher than the average rating of all restaurants.

### Table Schema & DDL
* `id`: `INT PRIMARY KEY` — Unique restaurant identifier
* `name`: `VARCHAR(100) NOT NULL` — Restaurant name
* `rating`: `DECIMAL(2, 1) NOT NULL` — Platform rating (out of 5.0)

### SQL Implementation
```sql
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL
);

INSERT INTO restaurants (id, name, rating) VALUES
(1, 'Swagat Restaurant', 4.5),
(2, 'Honest Restaurant', 4.1),
(3, 'Little Italy', 4.8),
(4, 'Burger Farm', 3.9),
(5, 'Agashiye', 4.6),
(6, 'Snack Corner', 3.7);

SELECT 
    id,
    name, 
    rating
FROM restaurants
WHERE rating > (
    SELECT AVG(rating) 
    FROM restaurants
)
ORDER BY rating DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT id, name, rating FROM restaurants WHERE rating > (SELECT AVG(rating) FROM restaurants) ORDER BY rating DESC;
+----+-------------------+--------+
| id | name              | rating |
+----+-------------------+--------+
|  3 | Little Italy      |    4.8 |
|  5 | Agashiye          |    4.6 |
|  1 | Swagat Restaurant |    4.5 |
+----+-------------------+--------+
3 rows in set (0.00 sec)
```
*(Fleet average rating across all 6 restaurants is 4.27; the 3 restaurants above exceed this baseline).*

---

## Task 4: User Running Total via Window Function

### Objective
Using a `transactions` table (`id`, `user_id`, `amount`, `transaction_date`), write a SQL query with a window function to display each user's transaction amount and their running total (cumulative sum) ordered by `transaction_date`.

### Table Schema & DDL
* `id`: `INT PRIMARY KEY` — Unique transaction identifier
* `user_id`: `INT NOT NULL` — Account holder ID
* `amount`: `DECIMAL(10, 2) NOT NULL` — Transaction value in INR
* `transaction_date`: `DATE NOT NULL` — Timestamp date

### SQL Implementation
```sql
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_date DATE NOT NULL
);

INSERT INTO transactions (id, user_id, amount, transaction_date) VALUES
(1, 101, 500.00, '2026-10-01'),
(2, 101, 750.00, '2026-10-05'),
(3, 101, 1200.00, '2026-10-10'),
(4, 102, 300.00, '2026-10-02'),
(5, 102, 450.00, '2026-10-08'),
(6, 102, 900.00, '2026-10-14');

SELECT 
    user_id,
    id AS transaction_id,
    transaction_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY user_id 
        ORDER BY transaction_date ASC, id ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM transactions
ORDER BY user_id ASC, transaction_date ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT user_id, id AS transaction_id, transaction_date, amount, SUM(amount) OVER (PARTITION BY user_id ORDER BY transaction_date ASC, id ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total FROM transactions ORDER BY user_id ASC, transaction_date ASC;
+---------+----------------+------------------+---------+---------------+
| user_id | transaction_id | transaction_date | amount  | running_total |
+---------+----------------+------------------+---------+---------------+
|     101 |              1 | 2026-10-01       |  500.00 |        500.00 |
|     101 |              2 | 2026-10-05       |  750.00 |       1250.00 |
|     101 |              3 | 2026-10-10       | 1200.00 |       2450.00 |
|     102 |              4 | 2026-10-02       |  300.00 |        300.00 |
|     102 |              5 | 2026-10-08       |  450.00 |        750.00 |
|     102 |              6 | 2026-10-14       |  900.00 |       1650.00 |
+---------+----------------+------------------+---------+---------------+
6 rows in set (0.00 sec)
```

---

## Task 5: Query Performance Optimization on Flipkart Product Filtering

### Objective
List two optimizations you would apply to speed up a query that filters Flipkart products by category and price, and briefly explain how each helps.

### Target Scenario
```sql
SELECT product_id, product_name, price 
FROM products 
WHERE category = 'Mobiles' 
  AND price BETWEEN 10000.00 AND 30000.00;
```

---

### Optimization 1: Create a Composite B-Tree Index on `(category, price)`

* **DDL Definition**:
  ```sql
  CREATE INDEX idx_products_category_price ON products (category, price);
  ```
* **How It Helps**:
  1. **Index Column Ordering Rule (Equality First, Range Second)**: Placing the equality column (`category = 'Mobiles'`) first and the range column (`price BETWEEN ...`) second enables MySQL's query optimizer to perform a single index seek to the specific category leaf page and then traverse a continuous range of price values within that subtree.
  2. **Eliminates Full Table Scans**: Transforms query complexity from $O(N)$ (scanning all millions of catalog rows) down to $O(\log N + K)$ (traversing the B-Tree height and scanning only the matching $K$ products).
  3. **Covering Index Extension**: By appending projected columns (`category, price, product_id, product_name`), the database performs an **Index-Only Scan** (`Using index`), satisfying the entire query directly from RAM without dereferencing data pages on physical disk.

---

### Optimization 2: Query Structure Refactoring & Ensuring SARGability

* **Optimized Query**:
  ```sql
  SELECT 
      product_id, 
      product_name, 
      price 
  FROM products 
  WHERE category = 'Mobiles' 
    AND price >= 10000.00 
    AND price <= 30000.00
  ORDER BY price ASC
  LIMIT 20 OFFSET 0;
  ```
* **How It Helps**:
  1. **Strict Column Projection**: Eliminates `SELECT *`. Avoids reading unneeded heavy text or image blob columns into the MySQL InnoDB Buffer Pool, saving memory bandwidth and reducing network transfer latencies to the frontend client.
  2. **Search Argument Able (SARGable) Predicates**: Avoids wrapping indexed columns in functions (such as `WHERE LOWER(category) = 'mobiles'` or `WHERE ROUND(price) > 10000`). Applying scalar functions on indexed columns blinds the query planner and forces a full table scan. Keeping predicates clean preserves B-Tree index utilization.
  3. **Paginated Execution with `LIMIT`**: Combined with the composite index, an ordered `LIMIT` query terminates execution immediately once the top 20 items are found (early pipeline exit), rather than materializing the full catalog result set.
