# Session 17: SQL Project – HR Analysis

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server 8.0 & MySQL Workbench)**  
**Target Tables**: `Restaurant`, `Review`  
**Target Database**: `session17_db`  
**SQL Script File**: [`session_17_restaurant_reviews.sql`](session_17_restaurant_reviews.sql)

---

## Task 1: Create Table `Restaurant` & Insert Popular Zomato Restaurants

### Objective
Create a SQL table called `Restaurant` with columns: `id`, `name`, `cuisine`, `location`, and `average_rating`. Insert at least 5 sample rows representing popular restaurants from Zomato.

### Table Schema & DDL
* `id`: `INT PRIMARY KEY` — Unique identifier for each restaurant
* `name`: `VARCHAR(100) NOT NULL` — Business trade name
* `cuisine`: `VARCHAR(50) NOT NULL` — Primary food style (North Indian, Italian, South Indian)
* `location`: `VARCHAR(100) NOT NULL` — City neighborhood
* `average_rating`: `DECIMAL(2, 1) NOT NULL` — Platform rating (out of 5.0)

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session17_db;
USE session17_db;

DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Restaurant;

CREATE TABLE Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL,
    average_rating DECIMAL(2, 1) NOT NULL
);

INSERT INTO Restaurant (id, name, cuisine, location, average_rating) VALUES
(1, 'Swagat Restaurant', 'North Indian', 'Vastrapur, Ahmedabad', 4.5),
(2, 'Honest Restaurant', 'North Indian', 'Navrangpura, Ahmedabad', 4.1),
(3, 'Little Italy', 'Italian', 'Bodakdev, Ahmedabad', 4.7),
(4, 'Pizza Twist', 'Italian', 'Satellite, Ahmedabad', 4.3),
(5, 'Sankalp Restaurant', 'South Indian', 'Drive In Road, Ahmedabad', 4.6),
(6, 'Dakshin Express', 'South Indian', 'Paldi, Ahmedabad', 4.2);

SELECT * FROM Restaurant ORDER BY id;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Restaurant ORDER BY id;
+----+--------------------+--------------+--------------------------+----------------+
| id | name               | cuisine      | location                 | average_rating |
+----+--------------------+--------------+--------------------------+----------------+
|  1 | Swagat Restaurant  | North Indian | Vastrapur, Ahmedabad     |            4.5 |
|  2 | Honest Restaurant  | North Indian | Navrangpura, Ahmedabad   |            4.1 |
|  3 | Little Italy       | Italian      | Bodakdev, Ahmedabad      |            4.7 |
|  4 | Pizza Twist        | Italian      | Satellite, Ahmedabad     |            4.3 |
|  5 | Sankalp Restaurant | South Indian | Drive In Road, Ahmedabad |            4.6 |
|  6 | Dakshin Express    | South Indian | Paldi, Ahmedabad         |            4.2 |
+----+--------------------+--------------+--------------------------+----------------+
6 rows in set (0.00 sec)
```

---

## Task 2: Restaurant Distribution by Cuisine Type

### Objective
Write a SQL query to generate a report showing the number of restaurants for each cuisine type from your `Restaurant` table, ordered by the count in descending order.

### Mechanics & Hint
* **Hint**: *Use `GROUP BY` and `ORDER BY`.*
* `COUNT(id)` groups and counts instances per `cuisine`.
* `ORDER BY restaurant_count DESC` sorts the most represented culinary categories to the top.

### SQL Implementation
```sql
SELECT 
    cuisine, 
    COUNT(id) AS restaurant_count
FROM Restaurant
GROUP BY cuisine
ORDER BY restaurant_count DESC, cuisine ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT cuisine, COUNT(id) AS restaurant_count FROM Restaurant GROUP BY cuisine ORDER BY restaurant_count DESC, cuisine ASC;
+--------------+------------------+
| cuisine      | restaurant_count |
+--------------+------------------+
| Italian      |                2 |
| North Indian |                2 |
| South Indian |                2 |
+--------------+------------------+
3 rows in set (0.00 sec)
```

---

## Task 3: Create Table `Review` & Insert 10+ Reviews

### Objective
Add a new table called `Review` with columns: `id`, `restaurant_id`, `user_name`, `rating`, and `review_date`. Insert at least 10 sample reviews, linking them to restaurants using `restaurant_id`.

### Table Schema & DDL
* `id`: `INT PRIMARY KEY` — Unique review identifier
* `restaurant_id`: `INT NOT NULL` — Foreign Key referencing `Restaurant(id)`
* `user_name`: `VARCHAR(100) NOT NULL` — Name of reviewer
* `rating`: `DECIMAL(2, 1) NOT NULL` — Rating score given
* `review_date`: `DATE NOT NULL` — Date review was posted

### SQL Implementation
```sql
CREATE TABLE Review (
    id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    review_date DATE NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(id) ON DELETE CASCADE
);

INSERT INTO Review (id, restaurant_id, user_name, rating, review_date) VALUES
(101, 1, 'Kathan Gadhiya', 5.0, '2026-10-01'),
(102, 1, 'Aarav Patel', 4.5, '2026-10-03'),
(103, 2, 'Priya Sharma', 4.0, '2026-10-04'),
(104, 2, 'Rohan Mehta', 4.2, '2026-10-06'),
(105, 3, 'Sneha Desai', 5.0, '2026-10-07'),
(106, 3, 'Kathan Gadhiya', 4.8, '2026-10-08'),
(107, 4, 'Ananya Roy', 4.0, '2026-10-09'),
(108, 4, 'Aarav Patel', 4.4, '2026-10-11'),
(109, 5, 'Priya Sharma', 4.7, '2026-10-12'),
(110, 5, 'Rohan Mehta', 4.5, '2026-10-14'),
(111, 6, 'Sneha Desai', 4.0, '2026-10-15'),
(112, 6, 'Kathan Gadhiya', 4.2, '2026-10-16');

SELECT * FROM Review ORDER BY id;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Review ORDER BY id;
+-----+---------------+----------------+--------+-------------+
| id  | restaurant_id | user_name      | rating | review_date |
+-----+---------------+----------------+--------+-------------+
| 101 |             1 | Kathan Gadhiya |    5.0 | 2026-10-01  |
| 102 |             1 | Aarav Patel    |    4.5 | 2026-10-03  |
| 103 |             2 | Priya Sharma   |    4.0 | 2026-10-04  |
| 104 |             2 | Rohan Mehta    |    4.2 | 2026-10-06  |
| 105 |             3 | Sneha Desai    |    5.0 | 2026-10-07  |
| 106 |             3 | Kathan Gadhiya |    4.8 | 2026-10-08  |
| 107 |             4 | Ananya Roy     |    4.0 | 2026-10-09  |
| 108 |             4 | Aarav Patel    |    4.4 | 2026-10-11  |
| 109 |             5 | Priya Sharma   |    4.7 | 2026-10-12  |
| 110 |             5 | Rohan Mehta    |    4.5 | 2026-10-14  |
| 111 |             6 | Sneha Desai    |    4.0 | 2026-10-15  |
| 112 |             6 | Kathan Gadhiya |    4.2 | 2026-10-16  |
+-----+---------------+----------------+--------+-------------+
12 rows in set (0.00 sec)
```

---

## Task 4: JOIN to Calculate Average Review Rating

### Objective
Write a SQL query using a `JOIN` to display each restaurant's name, cuisine, and its average review rating (from the `Review` table), ordered by highest average rating first.

### Mechanics & Hint
* **Hint**: *Use `JOIN` and `GROUP BY` with aggregate functions.*
* Relational join condition: `r.id = rv.restaurant_id`.
* Aggregation: `ROUND(AVG(rv.rating), 2)` computes actual dynamic customer review sentiment.

### SQL Implementation
```sql
SELECT 
    r.id,
    r.name,
    r.cuisine,
    ROUND(AVG(rv.rating), 2) AS avg_review_rating,
    COUNT(rv.id) AS total_reviews
FROM Restaurant r
INNER JOIN Review rv ON r.id = rv.restaurant_id
GROUP BY r.id, r.name, r.cuisine
ORDER BY avg_review_rating DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT r.id, r.name, r.cuisine, ROUND(AVG(rv.rating), 2) AS avg_review_rating, COUNT(rv.id) AS total_reviews FROM Restaurant r INNER JOIN Review rv ON r.id = rv.restaurant_id GROUP BY r.id, r.name, r.cuisine ORDER BY avg_review_rating DESC;
+----+--------------------+--------------+-------------------+---------------+
| id | name               | cuisine      | avg_review_rating | total_reviews |
+----+--------------------+--------------+-------------------+---------------+
|  3 | Little Italy       | Italian      |              4.90 |             2 |
|  1 | Swagat Restaurant  | North Indian |              4.75 |             2 |
|  5 | Sankalp Restaurant | South Indian |              4.60 |             2 |
|  4 | Pizza Twist        | Italian      |              4.20 |             2 |
|  2 | Honest Restaurant  | North Indian |              4.10 |             2 |
|  6 | Dakshin Express    | South Indian |              4.10 |             2 |
+----+--------------------+--------------+-------------------+---------------+
6 rows in set (0.00 sec)
```

---

## Task 5: Rank Restaurants by Average Review Rating within Cuisine

### Objective
Use a window function to rank restaurants by their average review rating within each cuisine type, showing the restaurant name, cuisine, average rating, and rank.

### Mechanics & Hint
* **Hint**: *Use the `RANK()` or `DENSE_RANK()` window function partitioned by cuisine.*
* `PARTITION BY cuisine`: Divides the dataset into separate ranking windows per cuisine.
* `ORDER BY avg_review_rating DESC`: Ranks the top-performing dining spot as #1 within each specific culinary category.

### SQL Implementation
```sql
WITH RestaurantAvgReviews AS (
    SELECT 
        r.id,
        r.name,
        r.cuisine,
        ROUND(AVG(rv.rating), 2) AS avg_review_rating
    FROM Restaurant r
    INNER JOIN Review rv ON r.id = rv.restaurant_id
    GROUP BY r.id, r.name, r.cuisine
)
SELECT 
    name,
    cuisine,
    avg_review_rating,
    DENSE_RANK() OVER (
        PARTITION BY cuisine 
        ORDER BY avg_review_rating DESC
    ) AS cuisine_rank
FROM RestaurantAvgReviews
ORDER BY cuisine ASC, cuisine_rank ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> WITH RestaurantAvgReviews AS (...) SELECT name, cuisine, avg_review_rating, DENSE_RANK() OVER (PARTITION BY cuisine ORDER BY avg_review_rating DESC) AS cuisine_rank FROM RestaurantAvgReviews ORDER BY cuisine ASC, cuisine_rank ASC;
+--------------------+--------------+-------------------+--------------+
| name               | cuisine      | avg_review_rating | cuisine_rank |
+--------------------+--------------+-------------------+--------------+
| Little Italy       | Italian      |              4.90 |            1 |
| Pizza Twist        | Italian      |              4.20 |            2 |
| Swagat Restaurant  | North Indian |              4.75 |            1 |
| Honest Restaurant  | North Indian |              4.10 |            2 |
| Sankalp Restaurant | South Indian |              4.60 |            1 |
| Dakshin Express    | South Indian |              4.10 |            2 |
+--------------------+--------------+-------------------+--------------+
6 rows in set (0.00 sec)
```
