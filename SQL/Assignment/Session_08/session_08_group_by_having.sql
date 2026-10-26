-- ============================================================================
-- SESSION 8: GROUP BY + HAVING
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: session08_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session08_db;
USE session08_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'Orders' Table & Insert 10 Sample Records
-- Columns:
--   - order_id        : INT PRIMARY KEY
--   - user_id         : INT NOT NULL
--   - payment_method  : VARCHAR(50) NOT NULL (UPI, Card, Wallet, COD)
--   - amount          : DECIMAL(10, 2) NOT NULL
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO Orders (order_id, user_id, payment_method, amount) VALUES
(1, 101, 'UPI', 450.00),
(2, 102, 'Card', 850.00),
(3, 101, 'Wallet', 180.00),
(4, 103, 'UPI', 520.00),
(5, 102, 'COD', 250.00),
(6, 104, 'Card', 920.00),
(7, 101, 'UPI', 310.00),
(8, 103, 'Wallet', 150.00),
(9, 104, 'COD', 220.00),
(10, 102, 'Card', 600.00);

-- View all records
SELECT * FROM Orders;


-- ----------------------------------------------------------------------------
-- TASK 2: Order Breakdown by Payment Method (Zomato Analytics Style)
-- Counts how many orders were placed using each payment method
-- ----------------------------------------------------------------------------
SELECT 
    payment_method,
    COUNT(*) AS order_count
FROM Orders
GROUP BY payment_method
ORDER BY order_count DESC, payment_method ASC;


-- ----------------------------------------------------------------------------
-- TASK 3: Total Spend by Each user_id
-- Calculates cumulative spend per customer
-- ----------------------------------------------------------------------------
SELECT 
    user_id,
    SUM(amount) AS total_spend
FROM Orders
GROUP BY user_id
ORDER BY total_spend DESC;


-- ----------------------------------------------------------------------------
-- TASK 4: Payment Methods with Average Order Amount > 300 (GROUP BY + HAVING)
-- HAVING filters aggregated groups after AVG(amount) is calculated
-- ----------------------------------------------------------------------------
SELECT 
    payment_method,
    ROUND(AVG(amount), 2) AS avg_order_amount
FROM Orders
GROUP BY payment_method
HAVING AVG(amount) > 300
ORDER BY avg_order_amount DESC;


-- ----------------------------------------------------------------------------
-- TASK 5: WHERE vs. HAVING Demonstration
-- Scenario:
--   - WHERE filters individual rows BEFORE grouping takes place
--   - HAVING filters aggregated group metrics AFTER grouping takes place
-- ----------------------------------------------------------------------------

-- Example A: WHERE Clause (Row-level filter: Only consider orders where amount > 200)
SELECT 
    payment_method,
    COUNT(*) AS qualifying_orders
FROM Orders
WHERE amount > 200
GROUP BY payment_method
ORDER BY qualifying_orders DESC;

-- Example B: HAVING Clause (Group-level filter: Keep only users whose total spend exceeds 1000)
SELECT 
    user_id,
    SUM(amount) AS total_spend
FROM Orders
GROUP BY user_id
HAVING SUM(amount) > 1000
ORDER BY total_spend DESC;

-- Example C: Combined Pipeline Query (WHERE + GROUP BY + HAVING together)
SELECT 
    payment_method,
    COUNT(*) AS count_above_200,
    ROUND(AVG(amount), 2) AS avg_amount
FROM Orders
WHERE amount > 200                  -- Step 1: Discard raw transactions <= 200
GROUP BY payment_method             -- Step 2: Form groups by payment method
HAVING AVG(amount) > 500            -- Step 3: Filter groups with avg amount > 500
ORDER BY avg_amount DESC;
