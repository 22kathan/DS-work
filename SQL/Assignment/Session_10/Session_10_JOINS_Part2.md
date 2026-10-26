# Session 10: JOINS - Part 2

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Tables**: `Influencers`, `Collaborations`, `Playlists`, `Users`, `Orders`, `Payments`, `Restaurants`, `Reviews`, `Products`, `Categories`  
**SQL Script File**: [`session_10_joins_part2.sql`](session_10_joins_part2.sql)

---

## Task 1: Influencers and Collaborations (FULL JOIN)

### Objective
Create two tables: `Influencers` (`id`, `name`) and `Collaborations` (`id`, `influencer1_id`, `influencer2_id`, `collab_date`). Write a SQL `FULL JOIN` query to list all influencers and show their collaboration partner names if any, including influencers with no collaborations.

### Table Schema & DDL
* `Influencers`: `id` (`INT PRIMARY KEY`), `name` (`VARCHAR(100) NOT NULL`)
* `Collaborations`: `id` (`INT PRIMARY KEY`), `influencer1_id` (`INT`), `influencer2_id` (`INT`), `collab_date` (`DATE`)

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session10_db;
USE session10_db;

DROP TABLE IF EXISTS Collaborations;
DROP TABLE IF EXISTS Influencers;

CREATE TABLE Influencers (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO Influencers (id, name) VALUES
(1, 'CarryMinati'),
(2, 'Bhuvan Bam'),
(3, 'Ashish Chanchlani'),
(4, 'Prajakta Koli'),
(5, 'Ranveer Allahbadia'); -- Influencer without collaborations

CREATE TABLE Collaborations (
    id INT PRIMARY KEY,
    influencer1_id INT,
    influencer2_id INT,
    collab_date DATE NOT NULL
);

INSERT INTO Collaborations (id, influencer1_id, influencer2_id, collab_date) VALUES
(101, 1, 2, '2026-05-10'),
(102, 2, 3, '2026-06-15'),
(103, 1, 4, '2026-07-20');

-- Standard ANSI SQL FULL OUTER JOIN:
/*
SELECT 
    i1.name AS influencer,
    i2.name AS collaborator,
    c.collab_date
FROM Influencers i1
FULL JOIN Collaborations c ON i1.id = c.influencer1_id
FULL JOIN Influencers i2 ON c.influencer2_id = i2.id;
*/

-- MySQL Production Implementation (UNION of LEFT JOIN and RIGHT JOIN):
SELECT 
    i1.name AS influencer,
    i2.name AS collaborator,
    c.collab_date
FROM Influencers i1
LEFT JOIN Collaborations c ON i1.id = c.influencer1_id
LEFT JOIN Influencers i2 ON c.influencer2_id = i2.id
UNION
SELECT 
    i1.name AS influencer,
    i2.name AS collaborator,
    c.collab_date
FROM Influencers i1
RIGHT JOIN Collaborations c ON i1.id = c.influencer1_id
LEFT JOIN Influencers i2 ON c.influencer2_id = i2.id;
```

### Execution Output (MySQL Workbench / CLI)
```text
+--------------------+-------------------+-------------+
| influencer         | collaborator      | collab_date |
+--------------------+-------------------+-------------+
| CarryMinati        | Bhuvan Bam        | 2026-05-10  |
| CarryMinati        | Prajakta Koli     | 2026-07-20  |
| Bhuvan Bam         | Ashish Chanchlani | 2026-06-15  |
| Ashish Chanchlani  | NULL              | NULL        |
| Prajakta Koli      | NULL              | NULL        |
| Ranveer Allahbadia | NULL              | NULL        |
+--------------------+-------------------+-------------+
6 rows in set (0.01 sec)
```

---

## Task 2: Spotify Nested Playlists Using SELF JOIN

### Objective
Using a `SELF JOIN`, write a query on a table called `Playlists` (`id`, `user_id`, `playlist_name`, `parent_playlist_id`) to display each playlist alongside its parent playlist name, similar to how Spotify shows nested playlists.

### Query Design & Hint
* **Hint**: *Join `Playlists` with itself on `parent_playlist_id = id`.*
* Using a `LEFT JOIN` allows root playlists (whose `parent_playlist_id` is `NULL`) to still be displayed with a `NULL` parent name.

### SQL Implementation
```sql
DROP TABLE IF EXISTS Playlists;

CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    parent_playlist_id INT NULL
);

INSERT INTO Playlists (id, user_id, playlist_name, parent_playlist_id) VALUES
(1, 101, 'Bollywood', NULL),
(2, 101, 'Arijit Singh Soul', 1),
(3, 101, '90s Romantic Hits', 1),
(4, 101, 'Fitness & Workout', NULL),
(5, 101, 'High Tempo Cardio', 4);

-- SELF JOIN query:
SELECT 
    child.id AS playlist_id,
    child.playlist_name AS playlist,
    parent.playlist_name AS parent_playlist
FROM Playlists child
LEFT JOIN Playlists parent ON child.parent_playlist_id = parent.id
ORDER BY child.id ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT child.id AS playlist_id, child.playlist_name AS playlist, parent.playlist_name AS parent_playlist FROM Playlists child LEFT JOIN Playlists parent ON child.parent_playlist_id = parent.id ORDER BY child.id ASC;
+-------------+-------------------+-------------------+
| playlist_id | playlist          | parent_playlist   |
+-------------+-------------------+-------------------+
|           1 | Bollywood         | NULL              |
|           2 | Arijit Singh Soul | Bollywood         |
|           3 | 90s Romantic Hits | Bollywood         |
|           4 | Fitness & Workout | NULL              |
|           5 | High Tempo Cardio | Fitness & Workout |
+-------------+-------------------+-------------------+
5 rows in set (0.00 sec)
```

---

## Task 3: Multiple Table JOINs (Users, Orders, and Payments)

### Objective
Given three tables: `Users` (`id`, `username`), `Orders` (`id`, `user_id`, `order_date`), and `Payments` (`id`, `order_id`, `amount`), write an SQL query using multiple `JOIN`s to display each username, their order date, and payment amount, showing all users even if they have no orders or payments.

### Query Design
* A chain of consecutive `LEFT JOIN` operations ensures that all users remain in the result set, even if they have zero orders or unbilled transactions.

### SQL Implementation
```sql
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL
);

INSERT INTO Users (id, username) VALUES
(1, 'kathan_g'),
(2, 'priya_s'),
(3, 'rahul_v'); -- Registered user with 0 orders

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO Orders (id, user_id, order_date) VALUES
(101, 1, '2026-10-15'),
(102, 1, '2026-10-18'),
(103, 2, '2026-10-20');

CREATE TABLE Payments (
    id INT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO Payments (id, order_id, amount) VALUES
(501, 101, 1499.00),
(502, 103, 899.00); -- Order 102 has no payment recorded

-- Multi-table LEFT JOIN query:
SELECT 
    u.id AS user_id,
    u.username,
    o.order_date,
    p.amount AS payment_amount
FROM Users u
LEFT JOIN Orders o ON u.id = o.user_id
LEFT JOIN Payments p ON o.id = p.order_id
ORDER BY u.id ASC, o.order_date ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT u.id AS user_id, u.username, o.order_date, p.amount AS payment_amount FROM Users u LEFT JOIN Orders o ON u.id = o.user_id LEFT JOIN Payments p ON o.id = p.order_id ORDER BY u.id ASC, o.order_date ASC;
+---------+----------+------------+----------------+
| user_id | username | order_date | payment_amount |
+---------+----------+------------+----------------+
|       1 | kathan_g | 2026-10-15 |        1499.00 |
|       1 | kathan_g | 2026-10-18 |           NULL |
|       2 | priya_s  | 2026-10-20 |         899.00 |
|       3 | rahul_v  | NULL       |           NULL |
+---------+----------+------------+----------------+
4 rows in set (0.00 sec)
```

---

## Task 4: Duplicate Rows Diagnosis & Resolution in Zomato Reviews

### Objective & Diagnosis
* **Problem**: Joining Zomato's `Restaurants` and `Reviews` tables returns duplicate rows for some restaurants.
* **One-Line Explanation**:
  > **Duplicates occur because the relationship between Restaurants and Reviews is One-to-Many ($1:N$); joining a restaurant that has multiple customer reviews duplicates the restaurant row for every matching review.**

### Table Setup & Sample Data
```sql
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

INSERT INTO Restaurants (id, name, city) VALUES
(1, 'Swagat Restaurant', 'Ahmedabad'),
(2, 'Burger King', 'Surat');

CREATE TABLE Reviews (
    id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT
);

INSERT INTO Reviews (id, restaurant_id, rating, comment) VALUES
(1, 1, 5, 'Great food!'),
(2, 1, 4, 'Nice ambience'),
(3, 1, 5, 'Loved the thali'),
(4, 2, 4, 'Tasty burgers');
```

### Modified Queries to Eliminate Duplicates

#### Method A: Using `DISTINCT`
```sql
SELECT DISTINCT 
    r.id, 
    r.name, 
    r.city
FROM Restaurants r
JOIN Reviews rv ON r.id = rv.restaurant_id
ORDER BY r.id ASC;
```
* **Output**:
```text
+----+-------------------+-----------+
| id | name              | city      |
+----+-------------------+-----------+
|  1 | Swagat Restaurant | Ahmedabad |
|  2 | Burger King       | Surat     |
+----+-------------------+-----------+
2 rows in set (0.00 sec)
```

#### Method B: Using `GROUP BY` with Aggregate Metrics (Recommended for Analytics)
```sql
SELECT 
    r.id, 
    r.name, 
    r.city,
    COUNT(rv.id) AS total_reviews,
    ROUND(AVG(rv.rating), 1) AS avg_rating
FROM Restaurants r
JOIN Reviews rv ON r.id = rv.restaurant_id
GROUP BY r.id, r.name, r.city
ORDER BY r.id ASC;
```
* **Output**:
```text
+----+-------------------+-----------+---------------+------------+
| id | name              | city      | total_reviews | avg_rating |
+----+-------------------+-----------+---------------+------------+
|  1 | Swagat Restaurant | Ahmedabad |             3 |        4.7 |
|  2 | Burger King       | Surat     |             1 |        4.0 |
+----+-------------------+-----------+---------------+------------+
2 rows in set (0.00 sec)
```

---

## Task 5: Two Different JOIN Conditions on Products and Categories

### Objective
Write two different `JOIN` queries on a `Products` and `Categories` table (like Flipkart) to list all products with their category names, using different join conditions in each. Briefly explain which join condition is more efficient and why.

### Table Schema & DDL
```sql
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

INSERT INTO Categories (category_id, category_name) VALUES
(10, 'Electronics'),
(20, 'Footwear'),
(30, 'Apparel');

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    category_name VARCHAR(100) NOT NULL
);

INSERT INTO Products (product_id, product_name, category_id, category_name) VALUES
(1, 'Smartwatch', 10, 'Electronics'),
(2, 'Running Shoes', 20, 'Footwear'),
(3, 'T-Shirt', 30, 'Apparel');
```

### Join Query 1: Join on Primary Key / Foreign Key Integer ID
```sql
SELECT 
    p.product_id, 
    p.product_name, 
    c.category_name
FROM Products p
INNER JOIN Categories c ON p.category_id = c.category_id;
```
* **Output**:
```text
+------------+---------------+---------------+
| product_id | product_name  | category_name |
+------------+---------------+---------------+
|          1 | Smartwatch    | Electronics   |
|          2 | Running Shoes | Footwear      |
|          3 | T-Shirt       | Apparel       |
+------------+---------------+---------------+
3 rows in set (0.00 sec)
```

### Join Query 2: Join on Category Name (String Matching)
```sql
SELECT 
    p.product_id, 
    p.product_name, 
    c.category_name
FROM Products p
INNER JOIN Categories c ON p.category_name = c.category_name;
```
* **Output**:
```text
+------------+---------------+---------------+
| product_id | product_name  | category_name |
+------------+---------------+---------------+
|          1 | Smartwatch    | Electronics   |
|          2 | Running Shoes | Footwear      |
|          3 | T-Shirt       | Apparel       |
+------------+---------------+---------------+
3 rows in set (0.00 sec)
```

### Efficiency Explanation
> **Query 1 (`ON p.category_id = c.category_id`) is significantly more efficient than Query 2.**  
> *Reason*:
> 1. **Index Optimization**: `category_id` is the table's integer `PRIMARY KEY`, so the database query optimizer performs a direct, ultra-fast $O(\log N)$ B-Tree index lookup.
> 2. **CPU & Memory Overhead**: Comparing 4-byte integers requires a single machine CPU cycle per comparison. In contrast, comparing `VARCHAR` strings (`p.category_name = c.category_name`) requires character-by-character collation and byte-level scanning, which consumes substantially more CPU cycles and RAM.
