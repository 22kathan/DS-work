# Session 12: CTE (WITH Clause)

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Tables**: `Products`, `Restaurants`, `Users`, `Posts`  
**SQL Script File**: [`session_12_cte.sql`](session_12_cte.sql)

---

## Task 1: CTE for Top-Rated Products (Rating > 4.5)

### Objective
Create a CTE using the `WITH` clause to select all products with a rating above 4.5 from a `Products` table, similar to how Flipkart or Myntra might highlight top-rated items.

### Table Schema & DDL
* `product_id`: `INT PRIMARY KEY`
* `product_name`: `VARCHAR(100) NOT NULL`
* `category`: `VARCHAR(50) NOT NULL`
* `price`: `DECIMAL(10, 2) NOT NULL`
* `rating`: `DECIMAL(2, 1) NOT NULL`

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session12_db;
USE session12_db;

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL
);

INSERT INTO Products (product_id, product_name, category, price, rating) VALUES
(1, 'Apple iPhone 16 Pro', 'Mobiles', 119900.00, 4.8),
(2, 'Sony WH-1000XM5', 'Audio', 26990.00, 4.7),
(3, 'Noise Pulse Smartwatch', 'Wearables', 1499.00, 4.2),
(4, 'Dell XPS 15', 'Laptops', 174990.00, 4.6),
(5, 'boAt Bassheads 100', 'Audio', 399.00, 4.1);

-- CTE Implementation using WITH clause:
WITH TopRatedProducts AS (
    SELECT 
        product_id,
        product_name,
        category,
        price,
        rating
    FROM Products
    WHERE rating > 4.5
)
SELECT * 
FROM TopRatedProducts
ORDER BY rating DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> WITH TopRatedProducts AS (SELECT product_id, product_name, category, price, rating FROM Products WHERE rating > 4.5) SELECT * FROM TopRatedProducts ORDER BY rating DESC;
+------------+---------------------+----------+-----------+--------+
| product_id | product_name        | category | price     | rating |
+------------+---------------------+----------+-----------+--------+
|          1 | Apple iPhone 16 Pro | Mobiles  | 119900.00 |    4.8 |
|          2 | Sony WH-1000XM5     | Audio    |  26990.00 |    4.7 |
|          4 | Dell XPS 15         | Laptops  | 174990.00 |    4.6 |
+------------+---------------------+----------+-----------+--------+
3 rows in set (0.00 sec)
```

---

## Task 2: Subquery vs. CTE Comparison for Ahmedabad Restaurants

### Objective
Rewrite a query that finds all restaurants in `'Ahmedabad'` with delivery charges under 50 from a `Restaurants` table, first using a subquery and then using a CTE. Compare both queries for readability.

### Table Setup & Sample Data
```sql
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    delivery_charge DECIMAL(5, 2) NOT NULL
);

INSERT INTO Restaurants (restaurant_id, name, city, delivery_charge) VALUES
(1, 'Swagat Restaurant', 'Ahmedabad', 35.00),
(2, 'Agashiye', 'Ahmedabad', 65.00),
(3, 'Honest Pav Bhaji', 'Ahmedabad', 40.00),
(4, 'Burger King', 'Surat', 30.00);
```

### Version 1: Using a Subquery (Nested Inside-Out)
```sql
SELECT 
    restaurant_id, 
    name, 
    city, 
    delivery_charge
FROM (
    SELECT restaurant_id, name, city, delivery_charge
    FROM Restaurants
    WHERE city = 'Ahmedabad'
) AS ahmedabad_restaurants
WHERE delivery_charge < 50
ORDER BY delivery_charge ASC;
```

### Version 2: Using a CTE (Top-to-Bottom Pipeline)
```sql
WITH AhmedabadRestaurants AS (
    SELECT 
        restaurant_id, 
        name, 
        city, 
        delivery_charge
    FROM Restaurants
    WHERE city = 'Ahmedabad'
)
SELECT 
    restaurant_id, 
    name, 
    city, 
    delivery_charge
FROM AhmedabadRestaurants
WHERE delivery_charge < 50
ORDER BY delivery_charge ASC;
```

### Execution Output (Both Queries Return Identical Results)
```text
+---------------+-------------------+-----------+-----------------+
| restaurant_id | name              | city      | delivery_charge |
+---------------+-------------------+-----------+-----------------+
|             1 | Swagat Restaurant | Ahmedabad |           35.00 |
|             3 | Honest Pav Bhaji  | Ahmedabad |           40.00 |
+---------------+-------------------+-----------+-----------------+
2 rows in set (0.00 sec)
```

### Readability Comparison
1. **Linear Cognitive Flow**: The CTE defines the dataset at the top under a descriptive name (`AhmedabadRestaurants`), allowing anyone reviewing the query to read top-to-bottom like regular code. In contrast, subqueries require reading "inside-out" starting from the inner `FROM` block.
2. **Reusability & Maintenance**: A CTE can be referenced multiple times within the same statement (e.g. joined with itself or aggregated), whereas a subquery must be copied and pasted, leading to code duplication and maintenance friction.

---

## Task 3: Two CTEs in a Single Query (Top Users & Top Posts)

### Objective
Using two CTEs in a single query, find the top 3 most-followed users and the top 3 most-liked posts from a `Users` and `Posts` table (Instagram-style data). Output both lists in the same result set.

### Table Schema & DDL
```sql
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    followers_count BIGINT NOT NULL
);

INSERT INTO Users (user_id, username, followers_count) VALUES
(1, 'virat.kohli', 270000000),
(2, 'shraddhakapoor', 92000000),
(3, 'aliaabhatt', 85000000),
(4, 'tech_reviewer', 50000);

CREATE TABLE Posts (
    post_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    post_caption VARCHAR(255) NOT NULL,
    likes_count BIGINT NOT NULL
);

INSERT INTO Posts (post_id, user_id, post_caption, likes_count) VALUES
(101, 1, 'Victory in Melbourne! T20 World Cup special', 4500000),
(102, 1, 'Match day prep with the team', 3200000),
(103, 2, 'Monsoon coffee vibes in Mumbai', 2800000),
(104, 3, 'National Award ceremony moments', 2900000),
(105, 4, 'Unboxing new gadget setup', 12000);
```

### SQL Implementation (Multiple CTEs + UNION ALL)
```sql
WITH TopUsers AS (
    SELECT 
        'Top User' AS entity_type,
        user_id AS entity_id,
        username AS entity_name,
        followers_count AS metric_count
    FROM Users
    ORDER BY followers_count DESC
    LIMIT 3
),
TopPosts AS (
    SELECT 
        'Top Post' AS entity_type,
        post_id AS entity_id,
        post_caption AS entity_name,
        likes_count AS metric_count
    FROM Posts
    ORDER BY likes_count DESC
    LIMIT 3
)
SELECT * FROM TopUsers
UNION ALL
SELECT * FROM TopPosts;
```

### Execution Output (MySQL Workbench / CLI)
```text
+-------------+-----------+---------------------------------------------+--------------+
| entity_type | entity_id | entity_name                                 | metric_count |
+-------------+-----------+---------------------------------------------+--------------+
| Top User    |         1 | virat.kohli                                 |    270000000 |
| Top User    |         2 | shraddhakapoor                              |     92000000 |
| Top User    |         3 | aliaabhatt                                  |     85000000 |
| Top Post    |       101 | Victory in Melbourne! T20 World Cup special |      4500000 |
| Top Post    |       102 | Match day prep with the team                |      3200000 |
| Top Post    |       104 | National Award ceremony moments             |      2900000 |
+-------------+-----------+---------------------------------------------+--------------+
6 rows in set (0.00 sec)
```

---

## Task 4: Recursive CTE for Next 7 Days (BookMyShow Movie Booking Dates)

### Objective
Write a recursive CTE that generates a list of dates for the next 7 days starting from today, similar to how BookMyShow shows available dates for movie bookings.

### Mechanics & Hint
* **Hint**: *Use a base case for today and recursion to add one day at a time.*
* **Anchor Member**: Evaluates `CURDATE()` as Day 1.
* **Recursive Member**: Uses `DATE_ADD(booking_date, INTERVAL 1 DAY)` and increments `day_number + 1` until `day_number < 7`.

### SQL Implementation
```sql
WITH RECURSIVE MovieBookingDates AS (
    -- Anchor Member (Base Case: Day 1 - Today)
    SELECT 
        CURDATE() AS booking_date,
        DAYNAME(CURDATE()) AS day_of_week,
        1 AS day_number
    
    UNION ALL
    
    -- Recursive Member: Add 1 day on each cycle until day_number reaches 7
    SELECT 
        DATE_ADD(booking_date, INTERVAL 1 DAY),
        DAYNAME(DATE_ADD(booking_date, INTERVAL 1 DAY)),
        day_number + 1
    FROM MovieBookingDates
    WHERE day_number < 7
)
SELECT 
    booking_date,
    day_of_week,
    CONCAT('Day ', day_number) AS booking_slot
FROM MovieBookingDates;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> WITH RECURSIVE MovieBookingDates AS (...) SELECT * FROM MovieBookingDates;
+--------------+-------------+--------------+
| booking_date | day_of_week | booking_slot |
+--------------+-------------+--------------+
| 2026-10-26   | Monday      | Day 1        |
| 2026-10-27   | Tuesday     | Day 2        |
| 2026-10-28   | Wednesday   | Day 3        |
| 2026-10-29   | Thursday    | Day 4        |
| 2026-10-30   | Friday      | Day 5        |
| 2026-10-31   | Saturday    | Day 6        |
| 2026-11-01   | Sunday      | Day 7        |
+--------------+-------------+--------------+
7 rows in set (0.00 sec)
```

---

## Task 5: Refactoring Messy SQL Query to a CTE

### Objective
Given a messy SQL query that finds all users with more than 1000 followers from a `Users` table, refactor it to use a CTE for better clarity and maintainability.

### 1. Messy Original Query
```sql
-- Messy, nested, redundant query:
SELECT u.user_id, u.username, u.followers_count
FROM (
    SELECT * 
    FROM Users 
    WHERE user_id IN (
        SELECT user_id 
        FROM Users 
        WHERE followers_count > 1000
    )
) u
WHERE u.followers_count > 1000
ORDER BY u.followers_count DESC;
```
* **Problems**:
  - Unnecessary subquery nested inside another subquery.
  - Redundant check (`WHERE followers_count > 1000` repeated twice).
  - High cognitive load for code reviewers and database query optimizers.

---

### 2. Refactored Query Using CTE
```sql
WITH PopularUsers AS (
    SELECT 
        user_id,
        username,
        followers_count
    FROM Users
    WHERE followers_count > 1000
)
SELECT 
    user_id,
    username,
    followers_count
FROM PopularUsers
ORDER BY followers_count DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> WITH PopularUsers AS (SELECT user_id, username, followers_count FROM Users WHERE followers_count > 1000) SELECT * FROM PopularUsers ORDER BY followers_count DESC;
+---------+----------------+-----------------+
| user_id | username       | followers_count |
+---------+----------------+-----------------+
|       1 | virat.kohli    |       270000000 |
|       2 | shraddhakapoor |        92000000 |
|       3 | aliaabhatt     |        85000000 |
|       4 | tech_reviewer  |           50000 |
+---------+----------------+-----------------+
4 rows in set (0.00 sec)
```

### Why the Refactored CTE Version is Superior
1. **Self-Documenting Code**: The CTE name `PopularUsers` immediately informs any developer of the semantic meaning of the dataset before looking at the rest of the query.
2. **Single Pass Filtering**: Filters the condition `followers_count > 1000` once, eliminating unnecessary execution overhead.
3. **Modularity**: If additional criteria are required later (e.g. verified badge, active within 30 days), the change is made cleanly inside the CTE without altering outer reporting logic.
