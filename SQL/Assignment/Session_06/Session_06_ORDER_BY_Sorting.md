# Session 6: ORDER BY + Sorting

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Tables**: `products`, `movies`, `restaurants`, `songs`  
**SQL Script File**: [`session_06_order_by_sorting.sql`](session_06_order_by_sorting.sql)

---

## Task 1: Flipkart Price Sorting (Ascending: Lowest to Highest)

### Objective
Write an SQL query to display all products from a `products` table and sort them by price in ascending order, similar to how Flipkart lists items from lowest to highest price.

### Table Schema & DDL
* `product_id`: `INT PRIMARY KEY`
* `product_name`: `VARCHAR(255) NOT NULL`
* `category`: `VARCHAR(100) NOT NULL`
* `price`: `DECIMAL(10, 2) NOT NULL`

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session06_db;
USE session06_db;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'boAt Bassheads 100 Wired Earphones', 'Audio', 399.00),
(2, 'SanDisk 64GB Pen Drive', 'Accessories', 489.00),
(3, 'Noise ColorFit Pulse Smartwatch', 'Wearables', 1499.00),
(4, 'Puma Men Running Shoes', 'Footwear', 2199.00),
(5, 'Sony WH-1000XM5 Headphones', 'Audio', 26990.00),
(6, 'Samsung Galaxy S24 Ultra', 'Smartphones', 129999.00),
(7, 'Apple iPhone 16 Pro', 'Smartphones', 119900.00),
(8, 'Dell XPS 15 Laptop', 'Computers', 174990.00);

-- Query: Sort items from lowest to highest price (ASC)
SELECT * 
FROM products 
ORDER BY price ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM products ORDER BY price ASC;
+------------+------------------------------------+-------------+-----------+
| product_id | product_name                       | category    | price     |
+------------+------------------------------------+-------------+-----------+
|          1 | boAt Bassheads 100 Wired Earphones | Audio       |    399.00 |
|          2 | SanDisk 64GB Pen Drive             | Accessories |    489.00 |
|          3 | Noise ColorFit Pulse Smartwatch    | Wearables   |   1499.00 |
|          4 | Puma Men Running Shoes             | Footwear    |   2199.00 |
|          5 | Sony WH-1000XM5 Headphones         | Audio       |  26990.00 |
|          7 | Apple iPhone 16 Pro                | Smartphones | 119900.00 |
|          6 | Samsung Galaxy S24 Ultra           | Smartphones | 129999.00 |
|          8 | Dell XPS 15 Laptop                 | Computers   | 174990.00 |
+------------+------------------------------------+-------------+-----------+
8 rows in set (0.00 sec)
```

---

## Task 2: Top 5 Most Expensive Products (`ORDER BY DESC` + `LIMIT`)

### Objective
Modify your previous query to show the top 5 most expensive products using `ORDER BY` with `DESC` and `LIMIT`.

### Query Design
* `ORDER BY price DESC`: Orders records starting from the highest numeric price down to the lowest.
* `LIMIT 5`: Stops scanning and caps the output at precisely the 5 most expensive catalog items.

### SQL Implementation
```sql
SELECT * 
FROM products 
ORDER BY price DESC 
LIMIT 5;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM products ORDER BY price DESC LIMIT 5;
+------------+----------------------------+-------------+-----------+
| product_id | product_name               | category    | price     |
+------------+----------------------------+-------------+-----------+
|          8 | Dell XPS 15 Laptop         | Computers   | 174990.00 |
|          6 | Samsung Galaxy S24 Ultra   | Smartphones | 129999.00 |
|          7 | Apple iPhone 16 Pro        | Smartphones | 119900.00 |
|          5 | Sony WH-1000XM5 Headphones | Audio       |  26990.00 |
|          4 | Puma Men Running Shoes     | Footwear    |   2199.00 |
+------------+----------------------------+-------------+-----------+
5 rows in set (0.00 sec)
```

---

## Task 3: Multi-Level Sorting on Movies (`release_year DESC`, `rating DESC`)

### Objective
Given a `movies` table with columns `title`, `release_year`, and `rating`, write an SQL query to list all movies sorted first by `release_year` in descending order (latest first), then by `rating` in descending order (highest rated first).

### Table Schema & DDL
* `movie_id`: `INT PRIMARY KEY`
* `title`: `VARCHAR(255) NOT NULL`
* `release_year`: `INT NOT NULL`
* `rating`: `DECIMAL(3, 1) NOT NULL`

### SQL Implementation
```sql
DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT NOT NULL,
    rating DECIMAL(3, 1) NOT NULL
);

INSERT INTO movies (movie_id, title, release_year, rating) VALUES
(1, 'Dune: Part Two', 2024, 8.6),
(2, 'Stree 2', 2024, 7.7),
(3, 'Deadpool & Wolverine', 2024, 7.9),
(4, 'Oppenheimer', 2023, 8.9),
(5, 'Jawan', 2023, 7.1),
(6, 'Spider-Man: Across the Spider-Verse', 2023, 8.7),
(7, 'RRR', 2022, 7.8),
(8, 'Top Gun: Maverick', 2022, 8.3);

-- Query: Multi-column sorting (Year latest first -> Rating highest first)
SELECT title, release_year, rating 
FROM movies 
ORDER BY release_year DESC, rating DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT title, release_year, rating FROM movies ORDER BY release_year DESC, rating DESC;
+-------------------------------------+--------------+--------+
| title                               | release_year | rating |
+-------------------------------------+--------------+--------+
| Dune: Part Two                      |         2024 |    8.6 |
| Deadpool & Wolverine                |         2024 |    7.9 |
| Stree 2                             |         2024 |    7.7 |
| Oppenheimer                         |         2023 |    8.9 |
| Spider-Man: Across the Spider-Verse |         2023 |    8.7 |
| Jawan                               |         2023 |    7.1 |
| Top Gun: Maverick                   |         2022 |    8.3 |
| RRR                                 |         2022 |    7.8 |
+-------------------------------------+--------------+--------+
8 rows in set (0.00 sec)
```
*(Notice: Within the 2024 cohort, Dune (8.6) appears before Deadpool & Wolverine (7.9) and Stree 2 (7.7). Within 2023, Oppenheimer (8.9) leads Spider-Man (8.7) and Jawan (7.1)).*

---

## Task 4: Zomato A-Z Alphabetical Listing (`LIMIT 10`)

### Objective
Write an SQL query to display the first 10 restaurants from a `restaurants` table, sorted alphabetically by name, just like Zomato's A-Z listing.

### Table Schema & DDL
* `restaurant_id`: `INT PRIMARY KEY`
* `name`: `VARCHAR(255) NOT NULL`
* `cuisine`: `VARCHAR(100) NOT NULL`
* `city`: `VARCHAR(100) NOT NULL`

### SQL Implementation
```sql
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    cuisine VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

INSERT INTO restaurants (restaurant_id, name, cuisine, city) VALUES
(1, 'Subway', 'Sandwiches', 'Ahmedabad'),
(2, 'Burger King', 'Fast Food', 'Ahmedabad'),
(3, 'Domino\'s Pizza', 'Pizza', 'Surat'),
(4, 'Haldiram\'s', 'Mithai / Fast Food', 'Ahmedabad'),
(5, 'Swagat Restaurant', 'North Indian', 'Ahmedabad'),
(6, 'KFC', 'Fast Food', 'Vadodara'),
(7, 'Barbeque Nation', 'Buffet', 'Surat'),
(8, 'The Belgian Waffle Co.', 'Desserts', 'Rajkot'),
(9, 'Mainland China', 'Chinese', 'Vadodara'),
(10, 'McDonald\'s', 'Fast Food', 'Ahmedabad'),
(11, 'Pizza Hut', 'Pizza', 'Surat'),
(12, 'Chai Point', 'Beverages', 'Ahmedabad');

-- Query: First 10 restaurants sorted alphabetically (A to Z)
SELECT * 
FROM restaurants 
ORDER BY name ASC 
LIMIT 10;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM restaurants ORDER BY name ASC LIMIT 10;
+---------------+------------------------+--------------------+-----------+
| restaurant_id | name                   | cuisine            | city      |
+---------------+------------------------+--------------------+-----------+
|             7 | Barbeque Nation        | Buffet             | Surat     |
|             2 | Burger King            | Fast Food          | Ahmedabad |
|            12 | Chai Point             | Beverages          | Ahmedabad |
|             3 | Domino's Pizza         | Pizza              | Surat     |
|             4 | Haldiram's             | Mithai / Fast Food | Ahmedabad |
|             6 | KFC                    | Fast Food          | Vadodara  |
|             9 | Mainland China         | Chinese            | Vadodara  |
|            10 | McDonald's             | Fast Food          | Ahmedabad |
|            11 | Pizza Hut              | Pizza              | Surat     |
|             1 | Subway                 | Sandwiches         | Ahmedabad |
+---------------+------------------------+--------------------+-----------+
10 rows in set (0.00 sec)
```

---

## Task 5: Top 3 Trending Songs with Tie-Breaker (`play_count DESC`, `added_date DESC`)

### Objective
Suppose you want to display the top 3 trending songs from a `songs` table based on `play_count`, but if two songs have the same `play_count`, the more recently added song should come first. Write the SQL query to achieve this.

### Table Schema & DDL
* `song_id`: `INT PRIMARY KEY`
* `title`: `VARCHAR(255) NOT NULL`
* `artist`: `VARCHAR(255) NOT NULL`
* `play_count`: `INT NOT NULL` (Total stream count)
* `added_date`: `DATE NOT NULL` (Date added to streaming platform)

### Tie-Breaker Logic
* **Primary Criterion**: `play_count DESC` (highest streams to lowest).
* **Secondary Criterion (Tie-Breaker)**: `added_date DESC` (latest calendar date wins over older tracks with equal stream numbers).

### SQL Implementation
```sql
DROP TABLE IF EXISTS songs;

CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    artist VARCHAR(255) NOT NULL,
    play_count INT NOT NULL,
    added_date DATE NOT NULL
);

INSERT INTO songs (song_id, title, artist, play_count, added_date) VALUES
(1, 'Tauba Tauba', 'Karan Aujla', 15000000, '2026-07-10'),
(2, 'Millionaire', 'Yo Yo Honey Singh', 18500000, '2026-08-15'),
(3, 'Big Dawgs', 'Hanumankind', 18500000, '2026-08-28'), -- Same plays as Millionaire, but added later
(4, 'Winning Speech', 'Karan Aujla', 12000000, '2026-06-20'),
(5, 'Illuminati', 'Sushin Shyam', 14200000, '2026-05-12');

-- Query: Top 3 songs sorted by play_count DESC with added_date DESC tie-breaker
SELECT song_id, title, artist, play_count, added_date 
FROM songs 
ORDER BY play_count DESC, added_date DESC 
LIMIT 3;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT song_id, title, artist, play_count, added_date FROM songs ORDER BY play_count DESC, added_date DESC LIMIT 3;
+---------+-------------+-------------------+------------+------------+
| song_id | title       | artist            | play_count | added_date |
+---------+-------------+-------------------+------------+------------+
|       3 | Big Dawgs   | Hanumankind       |   18500000 | 2026-08-28 |
|       2 | Millionaire | Yo Yo Honey Singh |   18500000 | 2026-08-15 |
|       1 | Tauba Tauba | Karan Aujla       |   15000000 | 2026-07-10 |
+---------+-------------+-------------------+------------+------------+
3 rows in set (0.00 sec)
```
*(Notice: Both 'Big Dawgs' and 'Millionaire' have 18,500,000 streams. Because 'Big Dawgs' was added on 2026-08-28, it ranks higher than 'Millionaire' added on 2026-08-15).*
