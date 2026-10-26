# Session 13: Window Functions - Part 1

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Table**: `Playlists`  
**SQL Script File**: [`session_13_window_functions_part1.sql`](session_13_window_functions_part1.sql)

---

## Task 1: Create Table `Playlists` & Insert Sample Rows

### Objective
Create a table named `Playlists` with columns: `id`, `user_id`, `playlist_name`, and `total_likes`. Insert at least 8 sample rows with different users and playlists, ensuring multiple playlists share the same `user_id`.

### Table Schema & DDL
* `id`: `INT PRIMARY KEY` — Unique playlist identifier
* `user_id`: `INT NOT NULL` — Foreign identifier representing the playlist owner
* `playlist_name`: `VARCHAR(100) NOT NULL` — Descriptive playlist title
* `total_likes`: `INT NOT NULL` — Total user likes accumulated

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session13_db;
USE session13_db;

DROP TABLE IF EXISTS Playlists;

CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    total_likes INT NOT NULL
);

INSERT INTO Playlists (id, user_id, playlist_name, total_likes) VALUES
(1, 101, 'Bollywood Hits', 4500),
(2, 101, 'Punjabi Party', 3200),
(3, 101, 'Lo-Fi Chill', 3200),
(4, 101, 'Workout Beats', 1800),
(5, 102, 'Acoustic Morning', 2500),
(6, 102, 'Indie Folk', 2500),
(7, 102, 'Late Night Drives', 1200),
(8, 103, 'Classic Rock Anthems', 5000),
(9, 103, 'Jazz Classics', 3200);

SELECT * FROM Playlists;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM Playlists;
+----+---------+----------------------+-------------+
| id | user_id | playlist_name        | total_likes |
+----+---------+----------------------+-------------+
|  1 |     101 | Bollywood Hits       |        4500 |
|  2 |     101 | Punjabi Party        |        3200 |
|  3 |     101 | Lo-Fi Chill          |        3200 |
|  4 |     101 | Workout Beats        |        1800 |
|  5 |     102 | Acoustic Morning     |        2500 |
|  6 |     102 | Indie Folk           |        2500 |
|  7 |     102 | Late Night Drives    |        1200 |
|  8 |     103 | Classic Rock Anthems |        5000 |
|  9 |     103 | Jazz Classics        |        3200 |
+----+---------+----------------------+-------------+
9 rows in set (0.00 sec)
```

---

## Task 2: Assign Unique Row Numbers with `ROW_NUMBER()` and `OVER()`

### Objective
Write a SQL query using `ROW_NUMBER()` and the `OVER()` clause to assign a unique row number to each playlist, ordered by `total_likes` in descending order.

### Mechanics
* `ROW_NUMBER()` is a non-deterministic window ranking function that assigns a strict, continuous sequence of integers starting from `1` to every row within the partition or full result set.
* Even if multiple playlists share the exact same `total_likes` (e.g. 3200 likes), each row receives a distinct row number. An optional secondary sort (`id ASC`) ensures deterministic reproducibility.

### SQL Implementation
```sql
SELECT 
    id,
    playlist_name,
    user_id,
    total_likes,
    ROW_NUMBER() OVER (
        ORDER BY total_likes DESC, id ASC
    ) AS row_num
FROM Playlists;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT id, playlist_name, user_id, total_likes, ROW_NUMBER() OVER (ORDER BY total_likes DESC, id ASC) AS row_num FROM Playlists;
+----+----------------------+---------+-------------+---------+
| id | playlist_name        | user_id | total_likes | row_num |
+----+----------------------+---------+-------------+---------+
|  8 | Classic Rock Anthems |     103 |        5000 |       1 |
|  1 | Bollywood Hits       |     101 |        4500 |       2 |
|  2 | Punjabi Party        |     101 |        3200 |       3 |
|  3 | Lo-Fi Chill          |     101 |        3200 |       4 |
|  9 | Jazz Classics        |     103 |        3200 |       5 |
|  5 | Acoustic Morning     |     102 |        2500 |       6 |
|  6 | Indie Folk           |     102 |        2500 |       7 |
|  4 | Workout Beats        |     101 |        1800 |       8 |
|  7 | Late Night Drives    |     102 |        1200 |       9 |
+----+----------------------+---------+-------------+---------+
9 rows in set (0.00 sec)
```

---

## Task 3: Global Ranking with `RANK()` and `OVER()`

### Objective
Use the `RANK()` function with the `OVER()` clause to rank all playlists by `total_likes`, and display the `playlist_name`, `user_id`, `total_likes`, and their rank.

### Mechanics
* `RANK()` computes the rank of each row within the ordered window.
* When rows share identical values for the ordering column (`total_likes`), they receive the same rank value.
* `RANK()` leaves gaps in the sequential ranking numbering equal to the number of tied rows (e.g., three rows tied at rank 3 skip ranks 4 and 5, advancing directly to rank 6).

### SQL Implementation
```sql
SELECT 
    playlist_name,
    user_id,
    total_likes,
    RANK() OVER (
        ORDER BY total_likes DESC
    ) AS playlist_rank
FROM Playlists;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT playlist_name, user_id, total_likes, RANK() OVER (ORDER BY total_likes DESC) AS playlist_rank FROM Playlists;
+----------------------+---------+-------------+---------------+
| playlist_name        | user_id | total_likes | playlist_rank |
+----------------------+---------+-------------+---------------+
| Classic Rock Anthems |     103 |        5000 |             1 |
| Bollywood Hits       |     101 |        4500 |             2 |
| Punjabi Party        |     101 |        3200 |             3 |
| Lo-Fi Chill          |     101 |        3200 |             3 |
| Jazz Classics        |     103 |        3200 |             3 |
| Acoustic Morning     |     102 |        2500 |             6 |
| Indie Folk           |     102 |        2500 |             6 |
| Workout Beats        |     101 |        1800 |             8 |
| Late Night Drives    |     102 |        1200 |             9 |
+----------------------+---------+-------------+---------------+
9 rows in set (0.00 sec)
```

---

## Task 4: User-Level Ranking with `DENSE_RANK()` and `PARTITION BY`

### Objective
Write a SQL query using `DENSE_RANK()` and `PARTITION BY user_id` to rank each user's playlists by `total_likes`, showing `playlist_name`, `user_id`, `total_likes`, and dense rank.

### Mechanics & Hint
* **Hint**: *This will show how popular each playlist is within each user's account, similar to how Spotify might rank your top playlists.*
* `PARTITION BY user_id` subdivides the dataset into independent evaluation windows per user. The ranking resets to 1 for each distinct user.
* `DENSE_RANK()` assigns identical ranks to tied rows but does **not** create numerical gaps for subsequent rows. For example, if User 101 has two playlists tied at rank 2, the next playlist receives rank 3 (unlike `RANK()` which would jump to 4).

### SQL Implementation
```sql
SELECT 
    playlist_name,
    user_id,
    total_likes,
    DENSE_RANK() OVER (
        PARTITION BY user_id 
        ORDER BY total_likes DESC
    ) AS user_dense_rank
FROM Playlists
ORDER BY user_id ASC, user_dense_rank ASC, playlist_name ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT playlist_name, user_id, total_likes, DENSE_RANK() OVER (PARTITION BY user_id ORDER BY total_likes DESC) AS user_dense_rank FROM Playlists ORDER BY user_id ASC, user_dense_rank ASC, playlist_name ASC;
+----------------------+---------+-------------+-----------------+
| playlist_name        | user_id | total_likes | user_dense_rank |
+----------------------+---------+-------------+-----------------+
| Bollywood Hits       |     101 |        4500 |               1 |
| Lo-Fi Chill          |     101 |        3200 |               2 |
| Punjabi Party        |     101 |        3200 |               2 |
| Workout Beats        |     101 |        1800 |               3 |
| Acoustic Morning     |     102 |        2500 |               1 |
| Indie Folk           |     102 |        2500 |               1 |
| Late Night Drives    |     102 |        1200 |               2 |
| Classic Rock Anthems |     103 |        5000 |               1 |
| Jazz Classics        |     103 |        3200 |               2 |
+----------------------+---------+-------------+-----------------+
9 rows in set (0.00 sec)
```

---

## Task 5: Top 2 Playlists Per User (Spotify 'Your Top Playlists' Feature)

### Objective
Imagine you want to show the top 2 playlists per user based on `total_likes`, like Spotify's 'Your Top Playlists' feature. Write a query using a window function to select only the top 2 playlists for each user.

### Architectural Solution
Window functions cannot be filtered directly in a `WHERE` clause of the same query block (e.g. `WHERE ROW_NUMBER() OVER (...) <= 2` is invalid in ANSI SQL because the `WHERE` clause executes before window function evaluation in the SQL processing order: `FROM` $\rightarrow$ `WHERE` $\rightarrow$ `GROUP BY` $\rightarrow$ `HAVING` $\rightarrow$ `WINDOW` $\rightarrow$ `SELECT`).

Therefore, we wrap the window calculation in a Common Table Expression (CTE) and filter `WHERE playlist_rank <= 2` in the outer query.

### SQL Implementation
```sql
WITH RankedUserPlaylists AS (
    SELECT 
        id,
        user_id,
        playlist_name,
        total_likes,
        ROW_NUMBER() OVER (
            PARTITION BY user_id 
            ORDER BY total_likes DESC, id ASC
        ) AS playlist_rank
    FROM Playlists
)
SELECT 
    user_id,
    playlist_name,
    total_likes,
    playlist_rank
FROM RankedUserPlaylists
WHERE playlist_rank <= 2
ORDER BY user_id ASC, playlist_rank ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> WITH RankedUserPlaylists AS (...) SELECT user_id, playlist_name, total_likes, playlist_rank FROM RankedUserPlaylists WHERE playlist_rank <= 2 ORDER BY user_id ASC, playlist_rank ASC;
+---------+----------------------+-------------+---------------+
| user_id | playlist_name        | total_likes | playlist_rank |
+---------+----------------------+-------------+---------------+
|     101 | Bollywood Hits       |        4500 |             1 |
|     101 | Punjabi Party        |        3200 |             2 |
|     102 | Acoustic Morning     |        2500 |             1 |
|     102 | Indie Folk           |        2500 |             2 |
|     103 | Classic Rock Anthems |        5000 |             1 |
|     103 | Jazz Classics        |        3200 |             2 |
+---------+----------------------+-------------+---------------+
6 rows in set (0.00 sec)
```
