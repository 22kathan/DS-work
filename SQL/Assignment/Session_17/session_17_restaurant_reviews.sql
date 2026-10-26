-- ============================================================================
-- SESSION 17: SQL Project – HR Analysis (Restaurant & Reviews Analytics)
-- Preferred Technology: SQL (MySQL Community Server 8.0 / MySQL Workbench)
-- Database Engine: MySQL 8.0 / 8.4
-- Target Database: session17_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session17_db;
USE session17_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create Table 'Restaurant' & Insert 5+ Popular Zomato Restaurants
-- Columns: id, name, cuisine, location, average_rating
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Restaurant;

CREATE TABLE Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL,
    average_rating DECIMAL(2, 1) NOT NULL
);

INSERT INTO Restaurant (id, name, cuisine, location, average_rating) VALUES
(1, 'Swagat Restaurant', 'North Indian', 'Vastrapur, Ahmedabad', 4.5),
(2, 'Honest Restaurant', 'North Indian', 'Navrangpura, Ahmedabad', 4.1),
(3, 'Little Italy', 'Italian', 'Bodakdev, Ahmedabad', 4.7),
(4, 'Pizza Twist', 'Italian', 'Satellite, Ahmedabad', 4.3),
(5, 'Sankalp Restaurant', 'South Indian', 'Drive In Road, Ahmedabad', 4.6),
(6, 'Dakshin Express', 'South Indian', 'Paldi, Ahmedabad', 4.2);

-- Verification:
SELECT * FROM Restaurant ORDER BY id;


-- ----------------------------------------------------------------------------
-- TASK 2: Count of Restaurants per Cuisine Type
-- Groups by cuisine and orders by restaurant count descending
-- ----------------------------------------------------------------------------
SELECT 
    cuisine, 
    COUNT(id) AS restaurant_count
FROM Restaurant
GROUP BY cuisine
ORDER BY restaurant_count DESC, cuisine ASC;


-- ----------------------------------------------------------------------------
-- TASK 3: Create Table 'Review' & Insert 10+ Sample Reviews
-- Columns: id, restaurant_id, user_name, rating, review_date
-- ----------------------------------------------------------------------------
CREATE TABLE Review (
    id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    review_date DATE NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(id) ON DELETE CASCADE
);

INSERT INTO Review (id, restaurant_id, user_name, rating, review_date) VALUES
(101, 1, 'Kathan Gadhiya', 5.0, '2026-10-01'),
(102, 1, 'Aarav Patel', 4.5, '2026-10-03'),
(103, 2, 'Priya Sharma', 4.0, '2026-10-04'),
(104, 2, 'Rohan Mehta', 4.2, '2026-10-06'),
(105, 3, 'Sneha Desai', 5.0, '2026-10-07'),
(106, 3, 'Kathan Gadhiya', 4.8, '2026-10-08'),
(107, 4, 'Ananya Roy', 4.0, '2026-10-09'),
(108, 4, 'Aarav Patel', 4.4, '2026-10-11'),
(109, 5, 'Priya Sharma', 4.7, '2026-10-12'),
(110, 5, 'Rohan Mehta', 4.5, '2026-10-14'),
(111, 6, 'Sneha Desai', 4.0, '2026-10-15'),
(112, 6, 'Kathan Gadhiya', 4.2, '2026-10-16');

-- Verification:
SELECT * FROM Review ORDER BY id;


-- ----------------------------------------------------------------------------
-- TASK 4: JOIN Restaurant & Review to Calculate Average Review Rating
-- Displays name, cuisine, and average rating ordered by highest average rating
-- ----------------------------------------------------------------------------
SELECT 
    r.id,
    r.name,
    r.cuisine,
    ROUND(AVG(rv.rating), 2) AS avg_review_rating,
    COUNT(rv.id) AS total_reviews
FROM Restaurant r
INNER JOIN Review rv ON r.id = rv.restaurant_id
GROUP BY r.id, r.name, r.cuisine
ORDER BY avg_review_rating DESC;


-- ----------------------------------------------------------------------------
-- TASK 5: Rank Restaurants by Average Review Rating within Each Cuisine
-- Uses CTE + DENSE_RANK() PARTITION BY cuisine ORDER BY avg_review_rating DESC
-- ----------------------------------------------------------------------------
WITH RestaurantAvgReviews AS (
    SELECT 
        r.id,
        r.name,
        r.cuisine,
        ROUND(AVG(rv.rating), 2) AS avg_review_rating
    FROM Restaurant r
    INNER JOIN Review rv ON r.id = rv.restaurant_id
    GROUP BY r.id, r.name, r.cuisine
)
SELECT 
    name,
    cuisine,
    avg_review_rating,
    DENSE_RANK() OVER (
        PARTITION BY cuisine 
        ORDER BY avg_review_rating DESC
    ) AS cuisine_rank
FROM RestaurantAvgReviews
ORDER BY cuisine ASC, cuisine_rank ASC;
