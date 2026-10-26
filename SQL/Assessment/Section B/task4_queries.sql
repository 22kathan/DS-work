-- Section B - Task 4: SQL Performance Queries
-- Database: food_delivery.db
-- Stack: SQLite / SQL

-- 1. Schema Definition: Restaurants Table
CREATE TABLE IF NOT EXISTS restaurants (
    restaurant_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    city TEXT NOT NULL
);

-- 2. Schema Definition: Orders Table
CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY,
    restaurant_id INTEGER,
    order_value REAL NOT NULL,
    delivery_time_mins REAL NOT NULL,
    rating REAL NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants (restaurant_id)
);

-- 3. Aggregation Query: Compute total_orders, total_revenue, avg_rating per restaurant
SELECT 
    r.restaurant_id,
    r.name AS restaurant_name,
    r.category,
    r.city,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.order_value), 2) AS total_revenue,
    ROUND(AVG(o.rating), 2) AS avg_rating,
    ROUND(AVG(o.delivery_time_mins), 2) AS avg_delivery_time
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name, r.category, r.city
ORDER BY total_revenue DESC;
