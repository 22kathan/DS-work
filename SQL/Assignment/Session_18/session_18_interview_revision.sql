-- ============================================================================
-- SESSION 18: Interview Questions + Final Revision
-- Preferred Technology: SQL (MySQL Community Server 8.0 / MySQL Workbench)
-- Database Engine: MySQL 8.0 / 8.4
-- Target Database: session18_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session18_db;
USE session18_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Songs Upload Volume per Artist (Uploads > 3 Songs)
-- Table: songs (song_id, artist_name, title)
-- Uses: GROUP BY artist_name HAVING COUNT(song_id) > 3
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS songs;

CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL,
    title VARCHAR(100) NOT NULL
);

INSERT INTO songs (song_id, artist_name, title) VALUES
(1, 'Arijit Singh', 'Tum Hi Ho'),
(2, 'Arijit Singh', 'Kesariya'),
(3, 'Arijit Singh', 'Channa Mereya'),
(4, 'Arijit Singh', 'Apna Bana Le'),
(5, 'Diljit Dosanjh', 'Lover'),
(6, 'Diljit Dosanjh', 'Born to Shine'),
(7, 'Diljit Dosanjh', 'Proper Patola'),
(8, 'Diljit Dosanjh', 'GOAT'),
(9, 'AP Dhillon', 'Brown Munde'),
(10, 'AP Dhillon', 'Excuses'),
(11, 'AP Dhillon', 'Insane'),
(12, 'Shreya Ghoshal', 'Sunn Raha Hai'),
(13, 'Shreya Ghoshal', 'Deewani Mastani');

-- Query: Show artists who uploaded strictly more than 3 songs
SELECT 
    artist_name, 
    COUNT(song_id) AS total_songs
FROM songs
GROUP BY artist_name
HAVING COUNT(song_id) > 3
ORDER BY total_songs DESC;


-- ----------------------------------------------------------------------------
-- TASK 2: Total Order Amount per User via SQL JOIN
-- Tables: orders (order_id, user_id, amount), users (user_id, username)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

INSERT INTO users (user_id, username) VALUES
(1, 'kathan_gadhiya'),
(2, 'aarav_patel'),
(3, 'priya_sharma'),
(4, 'rohan_mehta');

INSERT INTO orders (order_id, user_id, amount) VALUES
(101, 1, 650.00),
(102, 1, 820.00),
(103, 2, 350.00),
(104, 2, 1100.00),
(105, 3, 1200.00);

-- Query: Display each username with their total order amount (LEFT JOIN preserves users with 0 orders)
SELECT 
    u.user_id,
    u.username,
    COALESCE(SUM(o.amount), 0.00) AS total_order_amount
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY total_order_amount DESC;


-- ----------------------------------------------------------------------------
-- TASK 3: Subquery for Restaurants with Rating Above Fleet Average
-- Table: restaurants (id, name, rating)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL
);

INSERT INTO restaurants (id, name, rating) VALUES
(1, 'Swagat Restaurant', 4.5),
(2, 'Honest Restaurant', 4.1),
(3, 'Little Italy', 4.8),
(4, 'Burger Farm', 3.9),
(5, 'Agashiye', 4.6),
(6, 'Snack Corner', 3.7);

-- Query: Scalar subquery in WHERE clause
SELECT 
    id,
    name, 
    rating
FROM restaurants
WHERE rating > (
    SELECT AVG(rating) 
    FROM restaurants
)
ORDER BY rating DESC;


-- ----------------------------------------------------------------------------
-- TASK 4: Running Total (Cumulative Sum) per User
-- Table: transactions (id, user_id, amount, transaction_date)
-- Window Function: SUM() OVER (PARTITION BY user_id ORDER BY transaction_date)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_date DATE NOT NULL
);

INSERT INTO transactions (id, user_id, amount, transaction_date) VALUES
(1, 101, 500.00, '2026-10-01'),
(2, 101, 750.00, '2026-10-05'),
(3, 101, 1200.00, '2026-10-10'),
(4, 102, 300.00, '2026-10-02'),
(5, 102, 450.00, '2026-10-08'),
(6, 102, 900.00, '2026-10-14');

-- Query: Running total window calculation
SELECT 
    user_id,
    id AS transaction_id,
    transaction_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY user_id 
        ORDER BY transaction_date ASC, id ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM transactions
ORDER BY user_id ASC, transaction_date ASC;


-- ----------------------------------------------------------------------------
-- TASK 5: Performance Optimization Demo for Flipkart Product Catalog Filtering
-- Target Query:
-- SELECT product_id, product_name, price 
-- FROM products 
-- WHERE category = 'Mobiles' AND price BETWEEN 10000 AND 30000;
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    stock INT NOT NULL
);

-- Optimization 1: Create Composite B-Tree Index on (category, price)
CREATE INDEX idx_products_category_price ON products (category, price);

-- Optimization 2: Covering Index to allow Index-Only Scans
-- CREATE INDEX idx_products_covering ON products (category, price, product_id, product_name);

-- Optimized Query using SARGable condition and explicit column selection:
EXPLAIN SELECT 
    product_id, 
    product_name, 
    price 
FROM products 
WHERE category = 'Mobiles' 
  AND price BETWEEN 10000.00 AND 30000.00;
