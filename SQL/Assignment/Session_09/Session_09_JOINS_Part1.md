# Session 9: JOINS - Part 1

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Tables**: `restaurants`, `dishes`, `playlists`, `playlist_songs`  
**SQL Script File**: [`session_09_joins_part1.sql`](session_09_joins_part1.sql)

---

## Task 1: Create `restaurants` and `dishes` Tables & Insert Sample Records

### Objective
Create two tables in your database: `restaurants` (`id`, `name`, `city`) and `dishes` (`id`, `restaurant_id`, `dish_name`, `price`). Insert at least 3 restaurants and 2–3 dishes for each restaurant.

### Table Schema & DDL
* **`restaurants`**:
  - `id`: `INT PRIMARY KEY`
  - `name`: `VARCHAR(255) NOT NULL`
  - `city`: `VARCHAR(100) NOT NULL`
* **`dishes`**:
  - `id`: `INT PRIMARY KEY`
  - `restaurant_id`: `INT` (References `restaurants.id`)
  - `dish_name`: `VARCHAR(255) NOT NULL`
  - `price`: `DECIMAL(10, 2) NOT NULL`

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session09_db;
USE session09_db;

DROP TABLE IF EXISTS dishes;
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL
);

INSERT INTO restaurants (id, name, city) VALUES
(1, 'Domino\'s Pizza', 'Ahmedabad'),
(2, 'Burger King', 'Surat'),
(3, 'Haldiram\'s', 'Ahmedabad'),
(4, 'The Belgian Waffle Co.', 'Rajkot'); -- Restaurant without dishes (for Task 3 LEFT JOIN)

CREATE TABLE dishes (
    id INT PRIMARY KEY,
    restaurant_id INT,
    dish_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

INSERT INTO dishes (id, restaurant_id, dish_name, price) VALUES
(101, 1, 'Farmhouse Pizza', 450.00),
(102, 1, 'Garlic Breadsticks', 150.00),
(103, 2, 'Whopper Burger', 220.00),
(104, 2, 'Crispy Veg Burger', 120.00),
(105, 3, 'Chole Bhature', 180.00),
(106, 3, 'Raj Kachori', 140.00),
(107, 999, 'Special Mystery Dish', 299.00); -- Dish without matching restaurant (for Task 4 RIGHT JOIN)

SELECT * FROM restaurants;
SELECT * FROM dishes;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM restaurants;
+----+------------------------+-----------+
| id | name                   | city      |
+----+------------------------+-----------+
|  1 | Domino's Pizza         | Ahmedabad |
|  2 | Burger King            | Surat     |
|  3 | Haldiram's             | Ahmedabad |
|  4 | The Belgian Waffle Co. | Rajkot    |
+----+------------------------+-----------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM dishes;
+-----+---------------+----------------------+--------+
| id  | restaurant_id | dish_name            | price  |
+-----+---------------+----------------------+--------+
| 101 |             1 | Farmhouse Pizza      | 450.00 |
| 102 |             1 | Garlic Breadsticks   | 150.00 |
| 103 |             2 | Whopper Burger       | 220.00 |
| 104 |             2 | Crispy Veg Burger    | 120.00 |
| 105 |             3 | Chole Bhature        | 180.00 |
| 106 |             3 | Raj Kachori          | 140.00 |
| 107 |           999 | Special Mystery Dish | 299.00 |
+-----+---------------+----------------------+--------+
7 rows in set (0.00 sec)
```

---

## Task 2: INNER JOIN Query (Zomato-Style Dish & Restaurant Info)

### Objective
Write an SQL `INNER JOIN` query to display each dish along with its restaurant name and city, similar to how Zomato shows dish details with the restaurant info.

### Query Design
* `INNER JOIN` returns only records that have a valid match in **both** tables (`d.restaurant_id = r.id`).
* Restaurants without dishes (Restaurant #4) and dishes without valid restaurants (Dish #107) are excluded.

### SQL Implementation
```sql
SELECT 
    d.id AS dish_id,
    d.dish_name,
    d.price,
    r.name AS restaurant_name,
    r.city
FROM dishes d
INNER JOIN restaurants r ON d.restaurant_id = r.id
ORDER BY d.id ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT d.id AS dish_id, d.dish_name, d.price, r.name AS restaurant_name, r.city FROM dishes d INNER JOIN restaurants r ON d.restaurant_id = r.id ORDER BY d.id ASC;
+---------+--------------------+--------+-----------------+-----------+
| dish_id | dish_name          | price  | restaurant_name | city      |
+---------+--------------------+--------+-----------------+-----------+
|     101 | Farmhouse Pizza    | 450.00 | Domino's Pizza  | Ahmedabad |
|     102 | Garlic Breadsticks | 150.00 | Domino's Pizza  | Ahmedabad |
|     103 | Whopper Burger     | 220.00 | Burger King     | Surat     |
|     104 | Crispy Veg Burger  | 120.00 | Burger King     | Surat     |
|     105 | Chole Bhature      | 180.00 | Haldiram's      | Ahmedabad |
|     106 | Raj Kachori        | 140.00 | Haldiram's      | Ahmedabad |
+---------+--------------------+--------+-----------------+-----------+
6 rows in set (0.00 sec)
```

---

## Task 3: LEFT JOIN Query (All Restaurants, Even Without Dishes)

### Objective
Write an SQL `LEFT JOIN` query to list all restaurants and their dishes, showing restaurants even if they currently have no dishes on the menu.

### Query Design & Hint
* **Hint**: *Use `LEFT JOIN` so restaurants without dishes still appear in the results with `NULL` for dish columns.*
* The left table (`restaurants`) is fully preserved. When a restaurant has no associated rows in `dishes`, the engine populates `dish_name` and `price` with `NULL`.

### SQL Implementation
```sql
SELECT 
    r.id AS restaurant_id,
    r.name AS restaurant_name,
    r.city,
    d.dish_name,
    d.price
FROM restaurants r
LEFT JOIN dishes d ON r.id = d.restaurant_id
ORDER BY r.id ASC, d.id ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT r.id AS restaurant_id, r.name AS restaurant_name, r.city, d.dish_name, d.price FROM restaurants r LEFT JOIN dishes d ON r.id = d.restaurant_id ORDER BY r.id ASC, d.id ASC;
+---------------+------------------------+-----------+--------------------+--------+
| restaurant_id | restaurant_name        | city      | dish_name          | price  |
+---------------+------------------------+-----------+--------------------+--------+
|             1 | Domino's Pizza         | Ahmedabad | Farmhouse Pizza    | 450.00 |
|             1 | Domino's Pizza         | Ahmedabad | Garlic Breadsticks | 150.00 |
|             2 | Burger King            | Surat     | Whopper Burger     | 220.00 |
|             2 | Burger King            | Surat     | Crispy Veg Burger  | 120.00 |
|             3 | Haldiram's             | Ahmedabad | Chole Bhature      | 180.00 |
|             3 | Haldiram's             | Ahmedabad | Raj Kachori        | 140.00 |
|             4 | The Belgian Waffle Co. | Rajkot    | NULL               |   NULL |
+---------------+------------------------+-----------+--------------------+--------+
7 rows in set (0.00 sec)
```
*(Notice: Restaurant #4 'The Belgian Waffle Co.' appears in the result with `NULL` for dish columns).*

---

## Task 4: RIGHT JOIN Query (All Dishes, Including Unlinked Orphan Dishes)

### Objective
Write an SQL `RIGHT JOIN` query to display all dishes and their restaurant names, including any dishes that might not be linked to a restaurant (simulate a data error where a dish has a `restaurant_id` that doesn't match any restaurant).

### Query Design
* The right table (`dishes`) is fully preserved.
* Dish #107 (`Special Mystery Dish`) has `restaurant_id = 999`, which does not exist in `restaurants`. The `RIGHT JOIN` retains this dish and outputs `NULL` for `restaurant_name` and `city`.

### SQL Implementation
```sql
SELECT 
    r.name AS restaurant_name,
    r.city,
    d.id AS dish_id,
    d.dish_name,
    d.price
FROM restaurants r
RIGHT JOIN dishes d ON r.id = d.restaurant_id
ORDER BY d.id ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT r.name AS restaurant_name, r.city, d.id AS dish_id, d.dish_name, d.price FROM restaurants r RIGHT JOIN dishes d ON r.id = d.restaurant_id ORDER BY d.id ASC;
+-----------------+-----------+---------+----------------------+--------+
| restaurant_name | city      | dish_id | dish_name            | price  |
+-----------------+-----------+---------+----------------------+--------+
| Domino's Pizza  | Ahmedabad |     101 | Farmhouse Pizza      | 450.00 |
| Domino's Pizza  | Ahmedabad |     102 | Garlic Breadsticks   | 150.00 |
| Burger King     | Surat     |     103 | Whopper Burger       | 220.00 |
| Burger King     | Surat     |     104 | Crispy Veg Burger    | 120.00 |
| Haldiram's      | Ahmedabad |     105 | Chole Bhature        | 180.00 |
| Haldiram's      | Ahmedabad |     106 | Raj Kachori          | 140.00 |
| NULL            | NULL      |     107 | Special Mystery Dish | 299.00 |
+-----------------+-----------+---------+----------------------+--------+
7 rows in set (0.00 sec)
```
*(Notice: The orphan dish #107 is preserved with `NULL` for restaurant metadata).*

---

## Task 5: Spotify Playlists Scenario (All Playlists Including Empty Ones)

### Scenario Analysis & Join Selection
* **Problem**: We need to display all playlists and the songs inside them, like Spotify. Even if a playlist currently has zero songs, it must still appear on the dashboard.
* **Join Choice**: **`LEFT JOIN`**
* **Rationale**:
  - An **`INNER JOIN`** would drop empty playlists completely, because an empty playlist has no matching rows in the `playlist_songs` table.
  - A **`LEFT JOIN`** ensures that every single playlist from the left table (`playlists`) is returned. For playlists with tracks, song details are displayed; for empty playlists, the song columns are populated with `NULL`.

### Table Setup & SQL Implementation
```sql
DROP TABLE IF EXISTS playlist_songs;
DROP TABLE IF EXISTS playlists;

CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY,
    playlist_name VARCHAR(100) NOT NULL
);

INSERT INTO playlists (playlist_id, playlist_name) VALUES
(1, 'Gym Workout'),
(2, 'Chill Acoustic'),
(3, 'Roadtrip 2026'); -- Empty playlist (no songs added yet)

CREATE TABLE playlist_songs (
    song_id INT PRIMARY KEY,
    playlist_id INT,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL
);

INSERT INTO playlist_songs (song_id, playlist_id, song_name, artist) VALUES
(1, 1, 'Tauba Tauba', 'Karan Aujla'),
(2, 1, 'Winning Speech', 'Karan Aujla'),
(3, 2, 'Kesariya', 'Arijit Singh');

-- SQL Query using LEFT JOIN:
SELECT 
    p.playlist_id,
    p.playlist_name,
    s.song_id,
    s.song_name,
    s.artist
FROM playlists p
LEFT JOIN playlist_songs s ON p.playlist_id = s.playlist_id
ORDER BY p.playlist_id ASC, s.song_id ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT p.playlist_id, p.playlist_name, s.song_id, s.song_name, s.artist FROM playlists p LEFT JOIN playlist_songs s ON p.playlist_id = s.playlist_id ORDER BY p.playlist_id ASC, s.song_id ASC;
+-------------+----------------+---------+----------------+--------------+
| playlist_id | playlist_name  | song_id | song_name      | artist       |
+-------------+----------------+---------+----------------+--------------+
|           1 | Gym Workout    |       1 | Tauba Tauba    | Karan Aujla  |
|           1 | Gym Workout    |       2 | Winning Speech | Karan Aujla  |
|           2 | Chill Acoustic |       3 | Kesariya       | Arijit Singh |
|           3 | Roadtrip 2026  |    NULL | NULL           | NULL         |
+-------------+----------------+---------+----------------+--------------+
4 rows in set (0.00 sec)
```
*(Playlist #3 'Roadtrip 2026' is successfully retained on the dashboard despite having zero tracks).*
