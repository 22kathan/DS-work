-- ============================================================================
-- Section A - Question S6: CTE (WITH clause) vs. Nested Subqueries
-- Preferred Technology: SQL (SQLite)
-- Assessment: M4-A1 Data Science
-- ============================================================================
-- SCENARIO:
-- Optimising a SQL report for a food delivery operations team.
-- Step 1: Identify top 5 restaurant categories by total order count.
-- Step 2: Retrieve full order details only for restaurants in those categories.
-- Comparison: CTE (WITH clause) vs. Nested Subquery in WHERE clause.
-- ============================================================================

-- 1. Table Definitions & Mock Data
CREATE TABLE IF NOT EXISTS demo_restaurants (
    restaurant_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS demo_orders (
    order_id INTEGER PRIMARY KEY,
    restaurant_id INTEGER,
    order_value REAL NOT NULL,
    delivery_time_mins REAL NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES demo_restaurants(restaurant_id)
);

INSERT INTO demo_restaurants VALUES
(1, 'Spice Symphony', 'Indian'),
(2, 'Biryani Blues', 'Indian'),
(3, 'Burger Kingpin', 'Fast Food'),
(4, 'Pizza Rustica', 'Italian'),
(5, 'Dragon Express', 'Chinese'),
(6, 'Sushi Wave', 'Japanese'),
(7, 'Taco Town', 'Mexican'),
(8, 'Sweet Temptations', 'Dessert');

INSERT INTO demo_orders VALUES
(101, 1, 450.0, 30.0), (102, 1, 520.0, 32.0), (103, 2, 610.0, 35.0), -- Indian (3 orders)
(104, 3, 280.0, 20.0), (105, 3, 310.0, 22.0), (106, 3, 350.0, 25.0), -- Fast Food (3 orders)
(107, 4, 850.0, 40.0), (108, 4, 720.0, 38.0),                         -- Italian (2 orders)
(109, 5, 420.0, 28.0), (110, 5, 490.0, 31.0),                         -- Chinese (2 orders)
(111, 6, 1200.0, 45.0), (112, 6, 950.0, 42.0),                        -- Japanese (2 orders)
(113, 7, 320.0, 24.0),                                                 -- Mexican (1 order)
(114, 8, 210.0, 18.0);                                                 -- Dessert (1 order)

-- ============================================================================
-- APPROACH 1 (RECOMMENDED): CTE (WITH clause)
-- High readability, modular top-to-bottom flow, and intermediate reusability.
-- ============================================================================
WITH top_5_categories AS (
    SELECT 
        r.category, 
        COUNT(o.order_id) AS total_category_orders
    FROM demo_orders o
    JOIN demo_restaurants r ON o.restaurant_id = r.restaurant_id
    GROUP BY r.category
    ORDER BY total_category_orders DESC
    LIMIT 5
)
SELECT 
    o.order_id,
    r.name AS restaurant_name,
    r.category,
    o.order_value,
    o.delivery_time_mins
FROM demo_orders o
JOIN demo_restaurants r ON o.restaurant_id = r.restaurant_id
JOIN top_5_categories t ON r.category = t.category
ORDER BY r.category, o.order_id;

-- ============================================================================
-- APPROACH 2: Deeply Nested Subquery inside WHERE clause
-- Harder to read (inside-out logic), cannot be reused without code repetition,
-- difficult to debug intermediate results.
-- ============================================================================
SELECT 
    o.order_id,
    r.name AS restaurant_name,
    r.category,
    o.order_value,
    o.delivery_time_mins
FROM demo_orders o
JOIN demo_restaurants r ON o.restaurant_id = r.restaurant_id
WHERE r.category IN (
    SELECT category
    FROM (
        SELECT 
            r_sub.category, 
            COUNT(o_sub.order_id) AS sub_orders
        FROM demo_orders o_sub
        JOIN demo_restaurants r_sub ON o_sub.restaurant_id = r_sub.restaurant_id
        GROUP BY r_sub.category
        ORDER BY sub_orders DESC
        LIMIT 5
    )
)
ORDER BY r.category, o.order_id;
