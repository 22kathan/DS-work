# Session 11: Subqueries

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Tables**: `Restaurants`, `Users`, `Orders`, `Movies`, `Reviews`, `Sellers`, `Categories`, `Products`  
**SQL Script File**: [`session_11_subqueries.sql`](session_11_subqueries.sql)

---

## Task 1: Correlated Subquery in WHERE Clause (Restaurants Rating > City Average)

### Objective
Create a SQL query using a subquery in the `WHERE` clause to find all restaurants from a `Restaurants` table whose average rating is higher than the average rating of all restaurants in the city.

### Query Design & Mechanics
* A **Correlated Subquery** references the outer query row via `r2.city = r1.city`.
* For each individual restaurant evaluated in the outer loop, the inner subquery recalculates the average rating specific to that restaurant's city.
  - Ahmedabad Average: $(4.5 + 3.8 + 4.8) / 3 = 4.37 \longrightarrow$ Agashiye (4.8) and Swagat Restaurant (4.5) qualify.
  - Surat Average: $(4.1 + 4.6 + 3.7) / 3 = 4.13 \longrightarrow$ Kansar Gujarati Thali (4.6) qualifies.

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session11_db;
USE session11_db;

DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL
);

INSERT INTO Restaurants (id, name, city, rating) VALUES
(1, 'Swagat Restaurant', 'Ahmedabad', 4.5),
(2, 'Honest Restaurant', 'Ahmedabad', 3.8),
(3, 'Agashiye', 'Ahmedabad', 4.8),
(4, 'Burger King', 'Surat', 4.1),
(5, 'Kansar Gujarati Thali', 'Surat', 4.6),
(6, 'De Brand', 'Surat', 3.7);

-- Correlated Subquery in WHERE clause:
SELECT 
    r1.id, 
    r1.name, 
    r1.city, 
    r1.rating
FROM Restaurants r1
WHERE r1.rating > (
    SELECT AVG(r2.rating)
    FROM Restaurants r2
    WHERE r2.city = r1.city
)
ORDER BY r1.city ASC, r1.rating DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT r1.id, r1.name, r1.city, r1.rating FROM Restaurants r1 WHERE r1.rating > (SELECT AVG(r2.rating) FROM Restaurants r2 WHERE r2.city = r1.city) ORDER BY r1.city ASC, r1.rating DESC;
+----+-----------------------+-----------+--------+
| id | name                  | city      | rating |
+----+-----------------------+-----------+--------+
|  3 | Agashiye              | Ahmedabad |    4.8 |
|  1 | Swagat Restaurant     | Ahmedabad |    4.5 |
|  5 | Kansar Gujarati Thali | Surat     |    4.6 |
+----+-----------------------+-----------+--------+
3 rows in set (0.00 sec)
```

---

## Task 2: Subquery in SELECT Statement (Zomato User Profile Order Summary)

### Objective
Write a SQL query that uses a subquery in the `SELECT` statement to display each user's name from a `Users` table along with the total number of orders they have placed from an `Orders` table, like a summary you might see in a Zomato user profile.

### Query Design
* A **Scalar Subquery** placed directly inside the `SELECT` list produces a single numeric value for each row of the outer `Users` table.
* Correlates on `o.user_id = u.id`. Users with 0 orders cleanly return `0` without dropping the user from the list.

### SQL Implementation
```sql
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO Users (id, name) VALUES
(1, 'Kathan Gadhiya'),
(2, 'Priya Sharma'),
(3, 'Rahul Verma'); -- User with 0 orders

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO Orders (id, user_id, order_date) VALUES
(101, 1, '2026-10-15'),
(102, 1, '2026-10-18'),
(103, 1, '2026-10-22'),
(104, 2, '2026-10-20');

-- Query using a subquery in the SELECT clause:
SELECT 
    u.id AS user_id,
    u.name AS user_name,
    (
        SELECT COUNT(*) 
        FROM Orders o 
        WHERE o.user_id = u.id
    ) AS total_orders
FROM Users u
ORDER BY u.id ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT u.id AS user_id, u.name AS user_name, (SELECT COUNT(*) FROM Orders o WHERE o.user_id = u.id) AS total_orders FROM Users u ORDER BY u.id ASC;
+---------+----------------+--------------+
| user_id | user_name      | total_orders |
+---------+----------------+--------------+
|       1 | Kathan Gadhiya |            3 |
|       2 | Priya Sharma   |            1 |
|       3 | Rahul Verma    |            0 |
+---------+----------------+--------------+
3 rows in set (0.00 sec)
```

---

## Task 3: `IN` with a Subquery (BookMyShow Top-Rated 5-Star Movies)

### Objective
Given a `Movies` table and a `Reviews` table, write a SQL query using `IN` with a subquery to list all movies that have at least one review with a rating of 5 stars, as seen in BookMyShow's top-rated section.

### Query Design
* The subquery `(SELECT DISTINCT movie_id FROM Reviews WHERE rating = 5)` evaluates first, returning the set of movie IDs containing a 5-star rating.
* The outer query tests membership against this discrete set using the `IN` operator.

### SQL Implementation
```sql
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Movies;

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT NOT NULL
);

INSERT INTO Movies (movie_id, title, release_year) VALUES
(1, 'Dune: Part Two', 2024),
(2, 'Oppenheimer', 2023),
(3, 'Stree 2', 2024),
(4, 'Jawan', 2023);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    movie_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT
);

INSERT INTO Reviews (review_id, movie_id, rating, comment) VALUES
(101, 1, 5, 'Masterpiece visual spectacle!'),
(102, 2, 5, 'Incredible storytelling and sound'),
(103, 3, 4, 'Fun horror comedy'),
(104, 4, 3, 'Average action flick'),
(105, 1, 4, 'Great pacing');

-- Query using IN with subquery:
SELECT 
    movie_id, 
    title, 
    release_year
FROM Movies
WHERE movie_id IN (
    SELECT DISTINCT movie_id
    FROM Reviews
    WHERE rating = 5
)
ORDER BY movie_id ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT movie_id, title, release_year FROM Movies WHERE movie_id IN (SELECT DISTINCT movie_id FROM Reviews WHERE rating = 5) ORDER BY movie_id ASC;
+----------+----------------+--------------+
| movie_id | title          | release_year |
+----------+----------------+--------------+
|        1 | Dune: Part Two |         2024 |
|        2 | Oppenheimer    |         2023 |
+----------+----------------+--------------+
2 rows in set (0.00 sec)
```

---

## Task 4: Nested Subquery for Relational Division (Sellers in Every Category)

### Objective
Write a nested SQL query to find the names of all sellers from a `Sellers` table on a Flipkart-style platform who have sold products in every category listed in a `Categories` table.

### Problem Formulation
* Total catalog categories: 3 (`Electronics`, `Fashion`, `Home & Kitchen`).
* A qualifying seller must have sold at least one product in all 3 categories.
* **Hint**: *Use nested subqueries to compare seller's categories with the complete list of categories.*

### Table Schema & DDL
```sql
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Sellers;
DROP TABLE IF EXISTS Categories;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Fashion'),
(3, 'Home & Kitchen');

CREATE TABLE Sellers (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(100) NOT NULL
);

INSERT INTO Sellers (seller_id, seller_name) VALUES
(101, 'SuperCom Retail'), -- Sells in categories 1, 2, 3 (Qualifies)
(102, 'Apex Footwear'),   -- Sells only in category 2 (Fails)
(103, 'OmniStore India'); -- Sells in categories 1, 2, 3 (Qualifies)

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    seller_id INT NOT NULL,
    category_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL
);

INSERT INTO Products (product_id, seller_id, category_id, product_name) VALUES
(1, 101, 1, 'Noise Smartwatch'),
(2, 101, 2, 'Puma T-Shirt'),
(3, 101, 3, 'Prestige Cooker'),
(4, 102, 2, 'Running Shoes'),
(5, 103, 1, 'boAt Earphones'),
(6, 103, 2, 'Denim Jeans'),
(7, 103, 3, 'Non-stick Frying Pan');
```

### SQL Implementation

#### Method 1: Nested Category Count Comparison (Direct Implementation of Hint)
```sql
SELECT 
    s.seller_id, 
    s.seller_name
FROM Sellers s
WHERE (
    SELECT COUNT(DISTINCT p.category_id)
    FROM Products p
    WHERE p.seller_id = s.seller_id
) = (
    SELECT COUNT(*) 
    FROM Categories
)
ORDER BY s.seller_id ASC;
```

#### Method 2: Relational Division via Double `NOT EXISTS`
```sql
SELECT 
    s.seller_id, 
    s.seller_name
FROM Sellers s
WHERE NOT EXISTS (
    SELECT c.category_id
    FROM Categories c
    WHERE NOT EXISTS (
        SELECT p.product_id
        FROM Products p
        WHERE p.seller_id = s.seller_id 
          AND p.category_id = c.category_id
    )
)
ORDER BY s.seller_id ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT s.seller_id, s.seller_name FROM Sellers s WHERE (SELECT COUNT(DISTINCT p.category_id) FROM Products p WHERE p.seller_id = s.seller_id) = (SELECT COUNT(*) FROM Categories) ORDER BY s.seller_id ASC;
+-----------+-----------------+
| seller_id | seller_name     |
+-----------+-----------------+
|       101 | SuperCom Retail |
|       103 | OmniStore India |
+-----------+-----------------+
2 rows in set (0.00 sec)
```
*(Notice: Both SuperCom Retail and OmniStore India sold products across all 3 categories; Apex Footwear sold only in Fashion and was excluded).*
