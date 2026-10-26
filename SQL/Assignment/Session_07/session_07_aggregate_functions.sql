-- ============================================================================
-- SESSION 7: Aggregate Functions
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: session07_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session07_db;
USE session07_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'Orders' Table & Insert 5+ Sample Rows (with NULL total_amount)
-- Columns:
--   - order_id     : INT PRIMARY KEY
--   - user_name    : VARCHAR(100) NOT NULL
--   - total_amount : DECIMAL(10, 2) (Nullable for cancelled / unbilled orders)
--   - order_date   : DATE NOT NULL
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    total_amount DECIMAL(10, 2),
    order_date DATE NOT NULL
);

INSERT INTO Orders (order_id, user_name, total_amount, order_date) VALUES
(101, 'kathan_g', 2499.00, '2026-10-15'),
(102, 'priya_s', 1250.50, '2026-10-16'),
(103, 'kathan_g', 4899.00, '2026-10-18'),
(104, 'rahul_v', NULL, '2026-10-20'),     -- NULL value representing pending/cancelled invoice
(105, 'priya_s', 899.00, '2026-10-22'),
(106, 'amit_p', 3200.00, '2026-10-23');

-- View all inserted rows
SELECT * FROM Orders;


-- ----------------------------------------------------------------------------
-- TASK 2: Count Orders Placed by Each User (GROUP BY user_name)
-- Displays user_name and order_count
-- ----------------------------------------------------------------------------
SELECT 
    user_name,
    COUNT(*) AS order_count
FROM Orders
GROUP BY user_name
ORDER BY order_count DESC, user_name ASC;


-- ----------------------------------------------------------------------------
-- TASK 3: Calculate Average total_amount (Ignoring NULL Values)
-- In SQL, AVG() ignores NULLs by definition; WHERE clause explicitly documents it
-- ----------------------------------------------------------------------------
SELECT 
    ROUND(AVG(total_amount), 2) AS average_order_amount
FROM Orders
WHERE total_amount IS NOT NULL;


-- ----------------------------------------------------------------------------
-- TASK 4: Flipkart-Style Dashboard Metrics (MAX and MIN in a Single Row)
-- Displays highest and lowest order values simultaneously
-- ----------------------------------------------------------------------------
SELECT 
    MAX(total_amount) AS highest_order_amount,
    MIN(total_amount) AS lowest_order_amount
FROM Orders;


-- ----------------------------------------------------------------------------
-- TASK 5: Total Sales (SUM of total_amount Filtering Out NULL Values)
-- Uses WHERE total_amount IS NOT NULL to explicitly exclude NULL records
-- ----------------------------------------------------------------------------
SELECT 
    SUM(total_amount) AS total_sales
FROM Orders
WHERE total_amount IS NOT NULL;
