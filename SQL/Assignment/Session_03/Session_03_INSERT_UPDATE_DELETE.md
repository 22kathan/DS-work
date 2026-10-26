# Session 3: INSERT, UPDATE & DELETE (DML Operations)

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server & MySQL Workbench)**  
**Target Table**: `Playlist`  
**SQL Script File**: [`session_03_dml_operations.sql`](session_03_dml_operations.sql)

---

## Task 1: Create Table `Playlist` & Insert Favorite Song

### Objective
Create a table called `Playlist` with columns:
* `id` (`INT`, primary key)
* `song_name` (`VARCHAR`)
* `artist` (`VARCHAR`)
* `duration` (`INT`, seconds)

Insert a single row representing your current favorite song.

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS spotify_db;
USE spotify_db;

CREATE TABLE IF NOT EXISTS Playlist (
    id INT PRIMARY KEY,
    song_name VARCHAR(255) NOT NULL,
    artist VARCHAR(255) NOT NULL,
    duration INT NOT NULL
);

-- Insert favorite song (introducing an intentional typo 'Arjit Singh' for Task 3)
INSERT INTO Playlist (id, song_name, artist, duration) VALUES
(1, 'Kesariya', 'Arjit Singh', 268);
```

### Table View After Task 1
```text
+----+-----------+-------------+----------+
| id | song_name | artist      | duration |
+----+-----------+-------------+----------+
|  1 | Kesariya  | Arjit Singh |      268 |
+----+-----------+-------------+----------+
1 row in set (0.00 sec)
```

---

## Task 2: Insert 3 New Spotify Tracks

### Objective
Insert 3 new rows into the `Playlist` table for songs recently listened to on Spotify, including their `song_name`, `artist`, and `duration`.

### SQL Implementation
```sql
INSERT INTO Playlist (id, song_name, artist, duration) VALUES
(2, 'Brown Munde', 'AP Dhillon', 262),       -- Duration: 4m 22s (> 180s)
(3, 'Excuses', 'AP Dhillon', 236),           -- Duration: 3m 56s (> 180s)
(4, 'Morning Acoustic Intro', 'Spotify', 95),-- Duration: 1m 35s (< 120s, targets Task 4)
(5, 'Insane', 'AP Dhillon', 175);            -- Duration: 2m 55s (< 180s, tests Task 5 condition)
```

### Table View After Task 2
```text
+----+------------------------+-------------+----------+
| id | song_name              | artist      | duration |
+----+------------------------+-------------+----------+
|  1 | Kesariya               | Arjit Singh |      268 |
|  2 | Brown Munde            | AP Dhillon  |      262 |
|  3 | Excuses                | AP Dhillon  |      236 |
|  4 | Morning Acoustic Intro | Spotify     |       95 |
|  5 | Insane                 | AP Dhillon  |      175 |
+----+------------------------+-------------+----------+
5 rows in set (0.00 sec)
```

---

## Task 3: Fix Artist Typo Using UPDATE with WHERE Clause

### Objective
Update the artist name for one of your `Playlist` entries to fix a typo (change `'Arjit Singh'` to `'Arijit Singh'`) using the `UPDATE` statement with a `WHERE` clause.

### SQL Implementation
```sql
-- Disable safe updates in MySQL Workbench for non-key updates:
SET SQL_SAFE_UPDATES = 0;

UPDATE Playlist
SET artist = 'Arijit Singh'
WHERE artist = 'Arjit Singh';

-- Verify update on row 1
SELECT * FROM Playlist WHERE id = 1;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> UPDATE Playlist
    -> SET artist = 'Arijit Singh'
    -> WHERE artist = 'Arjit Singh';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM Playlist WHERE id = 1;
+----+-----------+--------------+----------+
| id | song_name | artist       | duration |
+----+-----------+--------------+----------+
|  1 | Kesariya  | Arijit Singh |      268 |
+----+-----------+--------------+----------+
1 row in set (0.00 sec)
```

---

## Task 4: Delete Short Song (< 120 Seconds) with Specific WHERE Clause

### Objective
Delete a song from the `Playlist` table where the `duration` is less than 120 seconds using the `DELETE` statement with a specific `WHERE` clause.

> [!WARNING]
> **Safety Best Practice**: Always specify an exact `WHERE` condition when using `DELETE`. Omitting the `WHERE` clause (`DELETE FROM Playlist;`) permanently wipes all rows from the table!

### SQL Implementation
```sql
DELETE FROM Playlist
WHERE duration < 120;

-- Verify deletion
SELECT * FROM Playlist;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> DELETE FROM Playlist
    -> WHERE duration < 120;
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM Playlist;
+----+-------------+--------------+----------+
| id | song_name   | artist       | duration |
+----+-------------+--------------+----------+
|  1 | Kesariya    | Arijit Singh |      268 |
|  2 | Brown Munde | AP Dhillon   |      262 |
|  3 | Excuses     | AP Dhillon   |      236 |
|  5 | Insane      | AP Dhillon   |      175 |
+----+-------------+--------------+----------+
4 rows in set (0.00 sec)
```
*(Notice: Track #4 with duration 95 seconds was cleanly deleted, while all other songs were preserved).*

---

## Task 5: Compound Conditional UPDATE (AP Dhillon Remixes)

### Objective
Write an SQL statement that updates the `song_name` for all songs by `'AP Dhillon'` in your `Playlist` to append `'(Remix)'` at the end of the name, but **only if the duration is more than 180 seconds**.

### Query Design & Constraints
* Target Artist: `artist = 'AP Dhillon'`
* Duration Filter: `duration > 180`
* Function: MySQL's `CONCAT(song_name, ' (Remix)')` to append the suffix string.
* Compound Operator: Logical `AND` combining both filters.

### SQL Implementation
```sql
UPDATE Playlist
SET song_name = CONCAT(song_name, ' (Remix)')
WHERE artist = 'AP Dhillon' AND duration > 180;

-- Re-enable safe updates
SET SQL_SAFE_UPDATES = 1;

-- Final Verification Query
SELECT 
    id,
    song_name,
    artist,
    duration,
    CONCAT(FLOOR(duration / 60), 'm ', (duration % 60), 's') AS formatted_duration
FROM Playlist
ORDER BY id ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> UPDATE Playlist
    -> SET song_name = CONCAT(song_name, ' (Remix)')
    -> WHERE artist = 'AP Dhillon' AND duration > 180;
Query OK, 2 rows affected (0.01 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> SELECT id, song_name, artist, duration, CONCAT(FLOOR(duration / 60), 'm ', (duration % 60), 's') AS formatted_duration FROM Playlist ORDER BY id ASC;
+----+----------------------+--------------+----------+--------------------+
| id | song_name            | artist       | duration | formatted_duration |
+----+----------------------+--------------+----------+--------------------+
|  1 | Kesariya             | Arijit Singh |      268 | 4m 28s             |
|  2 | Brown Munde (Remix)  | AP Dhillon   |      262 | 4m 22s             |
|  3 | Excuses (Remix)      | AP Dhillon   |      236 | 3m 56s             |
|  5 | Insane               | AP Dhillon   |      175 | 2m 55s             |
+----+----------------------+--------------+----------+--------------------+
4 rows in set (0.00 sec)
```

### Result Analysis
* **Track #2 ('Brown Munde', 262s)**: Satisfied `artist = 'AP Dhillon'` AND `duration > 180` $\rightarrow$ Updated to `'Brown Munde (Remix)'`.
* **Track #3 ('Excuses', 236s)**: Satisfied `artist = 'AP Dhillon'` AND `duration > 180` $\rightarrow$ Updated to `'Excuses (Remix)'`.
* **Track #5 ('Insane', 175s)**: Failed `duration > 180` constraint $\rightarrow$ **Unchanged** as `'Insane'`.
* **Track #1 ('Kesariya')**: Different artist $\rightarrow$ **Unchanged**.
