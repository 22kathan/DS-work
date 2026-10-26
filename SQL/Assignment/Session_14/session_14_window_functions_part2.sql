-- ============================================================================
-- SESSION 14: Window Functions - Part 2
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: session14_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session14_db;
USE session14_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create Table 'Orders' and Insert Sample Food Delivery Data
-- Columns: order_id, user_id, order_date, total_amount
-- Sample data simulates Zomato / Swiggy customer ordering histories
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO Orders (order_id, user_id, order_date, total_amount) VALUES
(1, 101, '2026-10-01', 350.00),
(2, 101, '2026-10-05', 450.00),
(3, 101, '2026-10-10', 600.00),
(4, 101, '2026-10-15', 520.00),
(5, 102, '2026-10-02', 200.00),
(6, 102, '2026-10-08', 300.00),
(7, 102, '2026-10-14', 400.00),
(8, 103, '2026-10-04', 750.00),
(9, 103, '2026-10-12', 850.00);

-- Verify Initial Table Population:
SELECT * FROM Orders ORDER BY order_id;


-- ----------------------------------------------------------------------------
-- TASK 2: Previous Order Amount Using LAG()
-- Retrieves the prior order's total_amount per user ordered chronologically
-- ----------------------------------------------------------------------------
SELECT 
    user_id,
    order_id,
    order_date,
    total_amount,
    LAG(total_amount, 1) OVER (
        PARTITION BY user_id 
        ORDER BY order_date ASC
    ) AS previous_order_amount
FROM Orders
ORDER BY user_id ASC, order_date ASC;


-- ----------------------------------------------------------------------------
-- TASK 3: Next Order Amount Using LEAD()
-- Retrieves the subsequent order's total_amount per user
-- ----------------------------------------------------------------------------
SELECT 
    user_id,
    order_id,
    order_date,
    total_amount,
    LEAD(total_amount, 1) OVER (
        PARTITION BY user_id 
        ORDER BY order_date ASC
    ) AS next_order_amount
FROM Orders
ORDER BY user_id ASC, order_date ASC;


-- ----------------------------------------------------------------------------
-- TASK 4: Running Total of Total Amount per User
-- Window Specification: ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- ----------------------------------------------------------------------------
SELECT 
    user_id,
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY user_id 
        ORDER BY order_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM Orders
ORDER BY user_id ASC, order_date ASC;


-- ----------------------------------------------------------------------------
-- TASK 5: 3-Order Moving Average per User
-- Constraint: Use SUM() OVER() with ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
-- ----------------------------------------------------------------------------
SELECT 
    user_id,
    order_id,
    order_date,
    total_amount,
    ROUND(
        SUM(total_amount) OVER (
            PARTITION BY user_id 
            ORDER BY order_date ASC 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) / 
        COUNT(*) OVER (
            PARTITION BY user_id 
            ORDER BY order_date ASC 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg
FROM Orders
ORDER BY user_id ASC, order_date ASC;
