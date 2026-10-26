-- ============================================================================
-- SESSION 16: SQL Project – Sales Analysis
-- Preferred Technology: SQL (MySQL Community Server 8.0 / MySQL Workbench)
-- Database Engine: MySQL 8.0 / 8.4 & SQLite3
-- Target Database: session16_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session16_db;
USE session16_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Import CSV of Food Delivery Orders into 'FoodOrders' Table
-- Table Schema: order_id, restaurant_name, customer_name, order_amount, order_date
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS FoodOrders;

CREATE TABLE FoodOrders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    order_amount DECIMAL(10, 2) NOT NULL,
    order_date DATE NOT NULL
);

-- Method A: LOAD DATA INFILE (Direct CSV ingestion from food_orders_data.csv)
-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/food_orders_data.csv'
-- INTO TABLE FoodOrders
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 ROWS;

-- Method B: Direct Multi-Row Insert (matches CSV contents for portable execution)
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

-- Verification Query:
SELECT * FROM FoodOrders ORDER BY order_id;


-- ----------------------------------------------------------------------------
-- TASK 2: Create Table 'TopSongs' and Insert 5 Popular Spotify Tracks
-- Columns: song_id, song_title, artist, streams, release_date
-- ----------------------------------------------------------------------------
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

-- Verification Query:
SELECT * FROM TopSongs ORDER BY streams DESC;


-- ----------------------------------------------------------------------------
-- TASK 3: Top 3 Customers by Total Order Amount
-- Aggregates customer spending and returns highest-value patrons
-- ----------------------------------------------------------------------------
SELECT 
    customer_name, 
    SUM(order_amount) AS total_spent
FROM FoodOrders
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 3;


-- ----------------------------------------------------------------------------
-- TASK 4: Product / Restaurant Performance Report
-- Lists restaurant name, order count, and total gross revenue ordered descending
-- ----------------------------------------------------------------------------
SELECT 
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_order_amount
FROM FoodOrders
GROUP BY restaurant_name
ORDER BY total_order_amount DESC;


-- ----------------------------------------------------------------------------
-- TASK 5: Dashboard Key Performance Indicators (KPIs)
-- Formatted as a 2-column key-value dashboard summary (kpi_name, kpi_value)
-- ----------------------------------------------------------------------------
SELECT 
    'Average Order Amount (INR)' AS kpi_name,
    ROUND(AVG(order_amount), 2) AS kpi_value
FROM FoodOrders

UNION ALL

SELECT 
    'Total Unique Customers' AS kpi_name,
    COUNT(DISTINCT customer_name) AS kpi_value
FROM FoodOrders;
