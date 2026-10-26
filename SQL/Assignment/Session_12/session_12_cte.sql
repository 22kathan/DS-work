-- ============================================================================
-- SESSION 12: CTE (WITH Clause)
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: session12_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session12_db;
USE session12_db;

-- ----------------------------------------------------------------------------
-- TASK 1: CTE to Select Top-Rated Products (Rating > 4.5)
-- Simulates Flipkart/Myntra's top-rated catalog highlight
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL
);

INSERT INTO Products (product_id, product_name, category, price, rating) VALUES
(1, 'Apple iPhone 16 Pro', 'Mobiles', 119900.00, 4.8),
(2, 'Sony WH-1000XM5', 'Audio', 26990.00, 4.7),
(3, 'Noise Pulse Smartwatch', 'Wearables', 1499.00, 4.2),
(4, 'Dell XPS 15', 'Laptops', 174990.00, 4.6),
(5, 'boAt Bassheads 100', 'Audio', 399.00, 4.1);

-- CTE Definition & Selection:
WITH TopRatedProducts AS (
    SELECT 
        product_id,
        product_name,
        category,
        price,
        rating
    FROM Products
    WHERE rating > 4.5
)
SELECT * 
FROM TopRatedProducts
ORDER BY rating DESC;


-- ----------------------------------------------------------------------------
-- TASK 2: Subquery vs. CTE Comparison for Ahmedabad Restaurants
-- Filters restaurants in 'Ahmedabad' with delivery charges under 50
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    delivery_charge DECIMAL(5, 2) NOT NULL
);

INSERT INTO Restaurants (restaurant_id, name, city, delivery_charge) VALUES
(1, 'Swagat Restaurant', 'Ahmedabad', 35.00),
(2, 'Agashiye', 'Ahmedabad', 65.00),
(3, 'Honest Pav Bhaji', 'Ahmedabad', 40.00),
(4, 'Burger King', 'Surat', 30.00);

-- Query 2A: Using Subquery (Nested Inside-Out)
SELECT 
    restaurant_id, 
    name, 
    city, 
    delivery_charge
FROM (
    SELECT restaurant_id, name, city, delivery_charge
    FROM Restaurants
    WHERE city = 'Ahmedabad'
) AS ahmedabad_restaurants
WHERE delivery_charge < 50
ORDER BY delivery_charge ASC;

-- Query 2B: Using CTE (Sequential Pipeline)
WITH AhmedabadRestaurants AS (
    SELECT 
        restaurant_id, 
        name, 
        city, 
        delivery_charge
    FROM Restaurants
    WHERE city = 'Ahmedabad'
)
SELECT 
    restaurant_id, 
    name, 
    city, 
    delivery_charge
FROM AhmedabadRestaurants
WHERE delivery_charge < 50
ORDER BY delivery_charge ASC;


-- ----------------------------------------------------------------------------
-- TASK 3: Two CTEs in a Single Query (Instagram Users & Posts)
-- Outputs top 3 most-followed users and top 3 most-liked posts in one result set
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    followers_count BIGINT NOT NULL
);

INSERT INTO Users (user_id, username, followers_count) VALUES
(1, 'virat.kohli', 270000000),
(2, 'shraddhakapoor', 92000000),
(3, 'aliaabhatt', 85000000),
(4, 'tech_reviewer', 50000);

CREATE TABLE Posts (
    post_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    post_caption VARCHAR(255) NOT NULL,
    likes_count BIGINT NOT NULL
);

INSERT INTO Posts (post_id, user_id, post_caption, likes_count) VALUES
(101, 1, 'Victory in Melbourne! T20 World Cup special', 4500000),
(102, 1, 'Match day prep with the team', 3200000),
(103, 2, 'Monsoon coffee vibes in Mumbai', 2800000),
(104, 3, 'National Award ceremony moments', 2900000),
(105, 4, 'Unboxing new gadget setup', 12000);

-- Two CTEs combined with UNION ALL:
WITH TopUsers AS (
    SELECT 
        'Top User' AS entity_type,
        user_id AS entity_id,
        username AS entity_name,
        followers_count AS metric_count
    FROM Users
    ORDER BY followers_count DESC
    LIMIT 3
),
TopPosts AS (
    SELECT 
        'Top Post' AS entity_type,
        post_id AS entity_id,
        post_caption AS entity_name,
        likes_count AS metric_count
    FROM Posts
    ORDER BY likes_count DESC
    LIMIT 3
)
SELECT * FROM TopUsers
UNION ALL
SELECT * FROM TopPosts;


-- ----------------------------------------------------------------------------
-- TASK 4: Recursive CTE for Next 7 Days (BookMyShow Movie Booking Dates)
-- Base case starts with CURDATE(), recursive member adds 1 day up to 7 days
-- ----------------------------------------------------------------------------
WITH RECURSIVE MovieBookingDates AS (
    -- Anchor member (Base Case: Day 1 - Today)
    SELECT 
        CURDATE() AS booking_date,
        DAYNAME(CURDATE()) AS day_of_week,
        1 AS day_number
    
    UNION ALL
    
    -- Recursive member: increment date by 1 day until day_number reaches 7
    SELECT 
        DATE_ADD(booking_date, INTERVAL 1 DAY),
        DAYNAME(DATE_ADD(booking_date, INTERVAL 1 DAY)),
        day_number + 1
    FROM MovieBookingDates
    WHERE day_number < 7
)
SELECT 
    booking_date,
    day_of_week,
    CONCAT('Day ', day_number) AS booking_slot
FROM MovieBookingDates;


-- ----------------------------------------------------------------------------
-- TASK 5: Refactoring Messy SQL Query to Clean CTE
-- Scenario: Finding all users with more than 1000 followers
-- ----------------------------------------------------------------------------

-- Messy Original Query (Redundant subquery and convoluted structure):
/*
SELECT u.user_id, u.username, u.followers_count
FROM (
    SELECT * 
    FROM Users 
    WHERE user_id IN (
        SELECT user_id 
        FROM Users 
        WHERE followers_count > 1000
    )
) u
WHERE u.followers_count > 1000
ORDER BY u.followers_count DESC;
*/

-- Refactored, Clean, and Maintainable Query Using CTE:
WITH PopularUsers AS (
    SELECT 
        user_id,
        username,
        followers_count
    FROM Users
    WHERE followers_count > 1000
)
SELECT 
    user_id,
    username,
    followers_count
FROM PopularUsers
ORDER BY followers_count DESC;
