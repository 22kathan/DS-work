# Session 16: SQL Project – Sales Analysis

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server 8.0 & MySQL Workbench) + Python Integration**  
**Target Tables**: `FoodOrders`, `TopSongs`  
**Target Database**: `session16_db` / `sales_analysis.db`  
**Source Files**:
* SQL Pipeline: [`session_16_sales_analysis.sql`](session_16_sales_analysis.sql)
* Dataset: [`food_orders_data.csv`](food_orders_data.csv)
* Python Import Script: [`import_csv_to_sql.py`](import_csv_to_sql.py)

---

## Task 1: Import CSV of Food Delivery Orders into `FoodOrders` Table

### Objective
Import a CSV file of food delivery orders (with columns: `order_id`, `restaurant_name`, `customer_name`, `order_amount`, `order_date`) into a new SQL table named `FoodOrders` using your database tool of choice.

### Table Schema & DDL
* `order_id`: `INT PRIMARY KEY` — Unique transaction identifier
* `restaurant_name`: `VARCHAR(100) NOT NULL` — Name of the restaurant
* `customer_name`: `VARCHAR(100) NOT NULL` — Customer placing the order
* `order_amount`: `DECIMAL(10, 2) NOT NULL` — Order value in INR
* `order_date`: `DATE NOT NULL` — Date of order placement

### CSV Dataset ([`food_orders_data.csv`](food_orders_data.csv))
```csv
order_id,restaurant_name,customer_name,order_amount,order_date
1,Swagat Restaurant,Kathan Gadhiya,650.00,2026-10-01
2,Honest Pav Bhaji,Aarav Patel,350.00,2026-10-02
3,Agashiye,Priya Sharma,1200.00,2026-10-03
4,Burger Farm,Rohan Mehta,450.00,2026-10-04
5,Swagat Restaurant,Kathan Gadhiya,820.00,2026-10-05
6,Honest Pav Bhaji,Sneha Desai,300.00,2026-10-06
7,Agashiye,Aarav Patel,1100.00,2026-10-07
8,La Pinoz Pizza,Priya Sharma,750.00,2026-10-08
9,Burger Farm,Kathan Gadhiya,520.00,2026-10-09
10,Swagat Restaurant,Sneha Desai,480.00,2026-10-10
```

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session16_db;
USE session16_db;

DROP TABLE IF EXISTS FoodOrders;

CREATE TABLE FoodOrders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    order_amount DECIMAL(10, 2) NOT NULL,
    order_date DATE NOT NULL
);

-- Option A: MySQL Workbench Table Data Import Wizard / LOAD DATA INFILE
-- LOAD DATA INFILE 'food_orders_data.csv'
-- INTO TABLE FoodOrders
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- Option B: Python Automated Ingestion (via import_csv_to_sql.py / Direct INSERT):
INSERT INTO FoodOrders (order_id, restaurant_name, customer_name, order_amount, order_date) VALUES
(1, 'Swagat Restaurant', 'Kathan Gadhiya', 650.00, '2026-10-01'),
(2, 'Honest Pav Bhaji', 'Aarav Patel', 350.00, '2026-10-02'),
(3, 'Agashiye', 'Priya Sharma', 1200.00, '2026-10-03'),
(4, 'Burger Farm', 'Rohan Mehta', 450.00, '2026-10-04'),
(5, 'Swagat Restaurant', 'Kathan Gadhiya', 820.00, '2026-10-05'),
(6, 'Honest Pav Bhaji', 'Sneha Desai', 300.00, '2026-10-06'),
(7, 'Agashiye', 'Aarav Patel', 1100.00, '2026-10-07'),
(8, 'La Pinoz Pizza', 'Priya Sharma', 750.00, '2026-10-08'),
(9, 'Burger Farm', 'Kathan Gadhiya', 520.00, '2026-10-09'),
(10, 'Swagat Restaurant', 'Sneha Desai', 480.00, '2026-10-10');

SELECT * FROM FoodOrders ORDER BY order_id;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM FoodOrders ORDER BY order_id;
+----------+-------------------+----------------+--------------+------------+
| order_id | restaurant_name   | customer_name  | order_amount | order_date |
+----------+-------------------+----------------+--------------+------------+
|        1 | Swagat Restaurant | Kathan Gadhiya |       650.00 | 2026-10-01 |
|        2 | Honest Pav Bhaji  | Aarav Patel    |       350.00 | 2026-10-02 |
|        3 | Agashiye          | Priya Sharma   |      1200.00 | 2026-10-03 |
|        4 | Burger Farm       | Rohan Mehta    |       450.00 | 2026-10-04 |
|        5 | Swagat Restaurant | Kathan Gadhiya |       820.00 | 2026-10-05 |
|        6 | Honest Pav Bhaji  | Sneha Desai    |       300.00 | 2026-10-06 |
|        7 | Agashiye          | Aarav Patel    |      1100.00 | 2026-10-07 |
|        8 | La Pinoz Pizza    | Priya Sharma   |       750.00 | 2026-10-08 |
|        9 | Burger Farm       | Kathan Gadhiya |       520.00 | 2026-10-09 |
|       10 | Swagat Restaurant | Sneha Desai    |       480.00 | 2026-10-10 |
+----------+-------------------+----------------+--------------+------------+
10 rows in set (0.00 sec)
```

---

## Task 2: Create Table `TopSongs` & Insert Popular Spotify Tracks

### Objective
Write SQL statements to create a table called `TopSongs` with columns: `song_id`, `song_title`, `artist`, `streams`, and `release_date`, then insert at least 5 records representing popular tracks from Spotify.

### Table Schema & DDL
* `song_id`: `INT PRIMARY KEY` — Unique track identifier
* `song_title`: `VARCHAR(100) NOT NULL` — Track title
* `artist`: `VARCHAR(100) NOT NULL` — Performing artist
* `streams`: `BIGINT NOT NULL` — Cumulative Spotify streams
* `release_date`: `DATE NOT NULL` — Global release date

### SQL Implementation
```sql
DROP TABLE IF EXISTS TopSongs;

CREATE TABLE TopSongs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    streams BIGINT NOT NULL,
    release_date DATE NOT NULL
);

INSERT INTO TopSongs (song_id, song_title, artist, streams, release_date) VALUES
(1, 'Blinding Lights', 'The Weeknd', 4200000000, '2019-11-29'),
(2, 'Shape of You', 'Ed Sheeran', 3800000000, '2017-01-06'),
(3, 'Starboy', 'The Weeknd', 3100000000, '2016-09-21'),
(4, 'As It Was', 'Harry Styles', 3000000000, '2022-04-01'),
(5, 'Stay', 'The Kid LAROI & Justin Bieber', 2900000000, '2021-07-09');

SELECT * FROM TopSongs ORDER BY streams DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT * FROM TopSongs ORDER BY streams DESC;
+---------+-----------------+-------------------------------+------------+--------------+
| song_id | song_title      | artist                        | streams    | release_date |
+---------+-----------------+-------------------------------+------------+--------------+
|       1 | Blinding Lights | The Weeknd                    | 4200000000 | 2019-11-29   |
|       2 | Shape of You    | Ed Sheeran                    | 3800000000 | 2017-01-06   |
|       3 | Starboy         | The Weeknd                    | 3100000000 | 2016-09-21   |
|       4 | As It Was       | Harry Styles                  | 3000000000 | 2022-04-01   |
|       5 | Stay            | The Kid LAROI & Justin Bieber | 2900000000 | 2021-07-09   |
+---------+-----------------+-------------------------------+------------+--------------+
5 rows in set (0.00 sec)
```

---

## Task 3: Top 3 Customers by Total Spend

### Objective
Write an SQL query to find the top 3 customers who ordered the most from the `FoodOrders` table based on total `order_amount`, and display their names and total spent.

### SQL Implementation
```sql
SELECT 
    customer_name, 
    SUM(order_amount) AS total_spent
FROM FoodOrders
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 3;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT customer_name, SUM(order_amount) AS total_spent FROM FoodOrders GROUP BY customer_name ORDER BY total_spent DESC LIMIT 3;
+----------------+-------------+
| customer_name  | total_spent |
+----------------+-------------+
| Kathan Gadhiya |     1990.00 |
| Priya Sharma   |     1950.00 |
| Aarav Patel    |     1450.00 |
+----------------+-------------+
3 rows in set (0.00 sec)
```

---

## Task 4: Product / Restaurant Performance Report

### Objective
Generate a product performance report by writing an SQL query that lists each `restaurant_name` from `FoodOrders`, the number of orders, and the total `order_amount`, ordered by total `order_amount` descending.

### Mechanics & Hint
* **Hint**: *Use `GROUP BY` and `ORDER BY` clauses.*
* `COUNT(order_id)` computes order frequency per vendor.
* `SUM(order_amount)` computes cumulative gross sales per vendor.
* `ORDER BY total_order_amount DESC` highlights top revenue drivers at the top of the report.

### SQL Implementation
```sql
SELECT 
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_order_amount
FROM FoodOrders
GROUP BY restaurant_name
ORDER BY total_order_amount DESC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT restaurant_name, COUNT(order_id) AS total_orders, SUM(order_amount) AS total_order_amount FROM FoodOrders GROUP BY restaurant_name ORDER BY total_order_amount DESC;
+-------------------+--------------+--------------------+
| restaurant_name   | total_orders | total_order_amount |
+-------------------+--------------+--------------------+
| Agashiye          |            2 |            2300.00 |
| Swagat Restaurant |            3 |            1950.00 |
| Burger Farm       |            2 |             970.00 |
| La Pinoz Pizza    |            1 |             750.00 |
| Honest Pav Bhaji  |            2 |             650.00 |
+-------------------+--------------+--------------------+
5 rows in set (0.00 sec)
```

---

## Task 5: Dashboard Key Performance Indicators (KPIs)

### Objective
Create an SQL query that calculates two KPIs for the `FoodOrders` table: (1) average `order_amount` and (2) total number of unique customers, and format the output for dashboard display (two columns: `kpi_name`, `kpi_value`).

### Architectural Solution
Using `UNION ALL`, two scalar aggregate calculations (`AVG(order_amount)` and `COUNT(DISTINCT customer_name)`) are unified into a normalized key-value schema (`kpi_name`, `kpi_value`), ideal for feeding business intelligence dashboard cards or frontend KPI tiles.

### SQL Implementation
```sql
SELECT 
    'Average Order Amount (INR)' AS kpi_name,
    ROUND(AVG(order_amount), 2) AS kpi_value
FROM FoodOrders

UNION ALL

SELECT 
    'Total Unique Customers' AS kpi_name,
    COUNT(DISTINCT customer_name) AS kpi_value
FROM FoodOrders;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT 'Average Order Amount (INR)' AS kpi_name, ROUND(AVG(order_amount), 2) AS kpi_value FROM FoodOrders UNION ALL SELECT 'Total Unique Customers' AS kpi_name, COUNT(DISTINCT customer_name) AS kpi_value FROM FoodOrders;
+----------------------------+-----------+
| kpi_name                   | kpi_value |
+----------------------------+-----------+
| Average Order Amount (INR) |    662.00 |
| Total Unique Customers     |         5 |
+----------------------------+-----------+
2 rows in set (0.00 sec)
```
