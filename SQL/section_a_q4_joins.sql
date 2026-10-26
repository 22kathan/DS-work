-- ============================================================================
-- Section A - Question S4: SQL Joins for Comprehensive Reporting
-- Preferred Technology: SQL (SQLite)
-- Assessment: M4-A1 Data Science
-- ============================================================================
-- SCENARIO:
-- Three tables: orders, restaurants, customers.
-- Requirement: Report showing every restaurant's name and total revenue,
-- including restaurants that have not yet received any orders.
-- ============================================================================

-- 1. Table Definitions
CREATE TABLE IF NOT EXISTS restaurants (
    restaurant_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT NOT NULL,
    category TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    area TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    restaurant_id INTEGER,
    order_value REAL NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- 2. Populate Sample Data (including newly onboarded restaurants with 0 orders)
INSERT INTO restaurants (restaurant_id, name, city, category) VALUES
(1, 'Spice Symphony', 'Mumbai', 'Indian'),
(2, 'Burger Republic', 'Delhi', 'Fast Food'),
(3, 'Pizza Rustica', 'Bangalore', 'Italian'),
(4, 'Taco Fiesta (New - 0 Orders)', 'Delhi', 'Mexican'),
(5, 'The Golden Wok (Inactive - 0 Orders)', 'Mumbai', 'Chinese');

INSERT INTO customers (customer_id, name, area) VALUES
(101, 'Aarav Sharma', 'Bandra'),
(102, 'Diya Patel', 'Connaught Place'),
(103, 'Rohan Mehta', 'Indiranagar');

INSERT INTO orders (order_id, customer_id, restaurant_id, order_value) VALUES
(5001, 101, 1, 650.0),
(5002, 102, 1, 480.0),
(5003, 103, 2, 340.0),
(5004, 101, 3, 920.0),
(5005, 102, 3, 760.0);

-- ============================================================================
-- QUERY 1 (CORRECT): LEFT OUTER JOIN
-- Ensures unmatched restaurants with zero orders are PRESERVED in the report.
-- COALESCE converts NULL sums into 0.00.
-- ============================================================================
SELECT 
    r.restaurant_id,
    r.name AS restaurant_name,
    r.category,
    r.city,
    COUNT(o.order_id) AS total_orders,
    COALESCE(ROUND(SUM(o.order_value), 2), 0.0) AS total_revenue
FROM restaurants r
LEFT OUTER JOIN orders o 
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name, r.category, r.city
ORDER BY total_revenue DESC;

-- EXPECTED RESULT (5 rows returned):
-- +---------------+-------------------------------------+------------+-----------+--------------+---------------+
-- | restaurant_id | restaurant_name                     | category   | city      | total_orders | total_revenue |
-- +---------------+-------------------------------------+------------+-----------+--------------+---------------+
-- | 3             | Pizza Rustica                       | Italian    | Bangalore | 2            | 1680.0        |
-- | 1             | Spice Symphony                      | Indian     | Mumbai    | 2            | 1130.0        |
-- | 2             | Burger Republic                     | Fast Food  | Delhi     | 1            | 340.0         |
-- | 4             | Taco Fiesta (New - 0 Orders)        | Mexican    | Delhi     | 0            | 0.0           |
-- | 5             | The Golden Wok (Inactive - 0 Orders)| Chinese    | Mumbai    | 0            | 0.0           |
-- +---------------+-------------------------------------+------------+-----------+--------------+---------------+

-- ============================================================================
-- QUERY 2 (INCORRECT DEMO): INNER JOIN
-- Fails business requirement: silently DROPS restaurants with 0 orders!
-- ============================================================================
SELECT 
    r.restaurant_id,
    r.name AS restaurant_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.order_value), 2) AS total_revenue
FROM restaurants r
INNER JOIN orders o 
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name
ORDER BY total_revenue DESC;

-- FLAW RESULT (Only 3 rows returned; restaurants 4 and 5 are completely dropped!):
-- +---------------+-----------------+--------------+---------------+
-- | restaurant_id | restaurant_name | total_orders | total_revenue |
-- +---------------+-----------------+--------------+---------------+
-- | 3             | Pizza Rustica   | 2            | 1680.0        |
-- | 1             | Spice Symphony  | 2            | 1130.0        |
-- | 2             | Burger Republic | 1            | 340.0         |
-- +---------------+-----------------+--------------+---------------+
