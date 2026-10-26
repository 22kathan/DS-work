-- ============================================================================
-- CASE-STUDY DATASET: Zomato Bangalore Restaurants
-- Preferred Technology: SQL (MySQL Community Server 8.0 / MySQL Workbench)
-- Database Engine: MySQL 8.0 / 8.4 & SQLite3
-- Target Database: zomato_case_study_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS zomato_case_study_db;
USE zomato_case_study_db;


-- ----------------------------------------------------------------------------
-- TABLE DDL & SAMPLE DATASET INGESTION
-- Schema matches Kaggle's Zomato Bangalore Restaurants dataset
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS zomato_bangalore_restaurants;

CREATE TABLE zomato_bangalore_restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    online_order VARCHAR(10) NOT NULL,
    book_table VARCHAR(10) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    votes INT NOT NULL,
    location VARCHAR(100) NOT NULL,
    cuisine VARCHAR(100) NOT NULL,
    approx_cost_for_two INT NOT NULL
);

-- Batch Insertion representing the Kaggle Zomato Bangalore dataset:
INSERT INTO zomato_bangalore_restaurants VALUES
(1, 'Punjab Grill', 'Yes', 'Yes', 4.8, 2450, 'Koramangala 5th Block', 'North Indian', 1600),
(2, 'Oye Amritsar', 'Yes', 'No', 4.5, 1890, 'Koramangala 7th Block', 'North Indian', 900),
(3, 'Tandoori Taal', 'Yes', 'No', 4.4, 1250, 'Koramangala 4th Block', 'North Indian', 800),
(4, 'Sultans of Spice', 'Yes', 'Yes', 4.3, 1420, 'Koramangala 5th Block', 'North Indian', 1300),
(5, 'Kapoor\'s Cafe', 'Yes', 'No', 4.2, 980, 'Koramangala 6th Block', 'North Indian', 500),
(6, 'Dhaba By Claridges', 'No', 'Yes', 4.1, 760, 'Koramangala 5th Block', 'North Indian', 1400),
(7, 'Shiro', 'No', 'Yes', 4.6, 2100, 'UB City Lavelle Road', 'Japanese', 2500),
(8, 'Rim Naam - The Oberoi', 'No', 'Yes', 4.7, 1800, 'MG Road', 'Japanese', 2800),
(9, 'Toscano', 'Yes', 'Yes', 4.5, 3200, 'Whitefield', 'Mediterranean', 1900),
(10, 'Olive Beach', 'No', 'Yes', 4.6, 2800, 'Richmond Road', 'Mediterranean', 2200),
(11, 'Windmills Craftworks', 'No', 'Yes', 4.7, 4500, 'Whitefield', 'European', 2600),
(12, 'Sunny\'s', 'Yes', 'Yes', 4.4, 1950, 'Lavelle Road', 'European', 2100),
(13, 'Midnight Munchies', 'Yes', 'No', 2.6, 120, 'BTM 2nd Stage', 'Fast Food', 300),
(14, 'Daily Bowl Express', 'Yes', 'No', 2.8, 85, 'Electronic City', 'North Indian', 350),
(15, 'Quick Bite Corner', 'Yes', 'No', 2.5, 95, 'Marathahalli', 'Chinese', 250),
(16, 'Rolls & Bowls', 'Yes', 'No', 2.9, 140, 'HSR Layout', 'Fast Food', 300),
(17, 'Cafe Coffee Day', 'Yes', 'No', 3.6, 450, 'Koramangala 5th Block', 'Cafe', 450),
(18, 'Cafe Coffee Day', 'Yes', 'No', 3.7, 320, 'Indiranagar', 'Cafe', 450),
(19, 'Cafe Coffee Day', 'Yes', 'No', 3.5, 290, 'MG Road', 'Cafe', 450),
(20, 'Cafe Coffee Day', 'Yes', 'No', 3.8, 510, 'Whitefield', 'Cafe', 450),
(21, 'Onesta', 'Yes', 'Yes', 4.4, 3800, 'Koramangala 4th Block', 'Italian', 600),
(22, 'Onesta', 'Yes', 'Yes', 4.3, 2900, 'Indiranagar', 'Italian', 600),
(23, 'Onesta', 'Yes', 'Yes', 4.5, 3100, 'JP Nagar', 'Italian', 600),
(24, 'Empire Restaurant', 'Yes', 'No', 4.2, 4200, 'Church Street', 'North Indian', 700),
(25, 'Empire Restaurant', 'Yes', 'No', 4.1, 3900, 'Koramangala 5th Block', 'North Indian', 700),
(26, 'Empire Restaurant', 'Yes', 'No', 4.3, 4100, 'Indiranagar', 'North Indian', 700),
(27, 'Five Star Chicken', 'Yes', 'No', 3.6, 180, 'BTM', 'Fast Food', 250),
(28, 'Five Star Chicken', 'Yes', 'No', 3.5, 140, 'HSR Layout', 'Fast Food', 250),
(29, 'Five Star Chicken', 'Yes', 'No', 3.7, 210, 'Electronic City', 'Fast Food', 250),
(30, 'Domino\'s Pizza', 'Yes', 'No', 4.1, 2600, 'Koramangala', 'Fast Food', 500),
(31, 'Domino\'s Pizza', 'Yes', 'No', 4.0, 2400, 'Whitefield', 'Fast Food', 500),
(32, 'Domino\'s Pizza', 'Yes', 'No', 4.2, 2800, 'Indiranagar', 'Fast Food', 500),
(33, 'Just Bake', 'Yes', 'No', 3.8, 310, 'BTM', 'Bakery', 350),
(34, 'Just Bake', 'Yes', 'No', 3.7, 280, 'Koramangala', 'Bakery', 350),
(35, 'McDonald\'s', 'Yes', 'No', 4.2, 3400, 'Forum Mall Koramangala', 'Fast Food', 500),
(36, 'McDonald\'s', 'Yes', 'No', 4.1, 3100, 'Indiranagar', 'Fast Food', 500),
(37, 'KFC', 'Yes', 'No', 4.0, 2900, 'MG Road', 'Fast Food', 550),
(38, 'KFC', 'Yes', 'No', 4.1, 3300, 'Koramangala', 'Fast Food', 550),
(39, 'Subway', 'Yes', 'No', 3.9, 1200, 'Indiranagar', 'Fast Food', 400),
(40, 'Subway', 'Yes', 'No', 4.0, 1500, 'Koramangala', 'Fast Food', 400),
(41, 'Pizza Hut', 'Yes', 'No', 3.9, 1800, 'Brigade Road', 'Fast Food', 600),
(42, 'Pizza Hut', 'Yes', 'No', 4.0, 2100, 'Whitefield', 'Fast Food', 600);


-- ----------------------------------------------------------------------------
-- TASK 1: Top 5 Highest-Rated North Indian Restaurants in Koramangala
-- Filters by location and cuisine, ordering by rating and votes
-- ----------------------------------------------------------------------------
SELECT 
    name, 
    location, 
    cuisine, 
    rating, 
    votes, 
    approx_cost_for_two
FROM zomato_bangalore_restaurants
WHERE location LIKE '%Koramangala%'
  AND cuisine LIKE '%North Indian%'
ORDER BY rating DESC, votes DESC
LIMIT 5;


-- ----------------------------------------------------------------------------
-- TASK 2: 3 Most Expensive Cuisines to Eat in Bangalore
-- Calculates average cost for two people per cuisine and returns top 3
-- ----------------------------------------------------------------------------
SELECT 
    cuisine,
    ROUND(AVG(approx_cost_for_two), 2) AS avg_cost_for_two,
    COUNT(restaurant_id) AS restaurant_count
FROM zomato_bangalore_restaurants
GROUP BY cuisine
ORDER BY avg_cost_for_two DESC
LIMIT 3;


-- ----------------------------------------------------------------------------
-- TASK 3: Online Delivery Restaurants with Rating Below 3.0
-- Analysis of underperforming delivery outlets to formulate marketing strategy
-- ----------------------------------------------------------------------------
SELECT 
    restaurant_id,
    name,
    location,
    cuisine,
    approx_cost_for_two,
    rating,
    votes
FROM zomato_bangalore_restaurants
WHERE online_order = 'Yes'
  AND rating < 3.0
ORDER BY rating ASC;


-- ----------------------------------------------------------------------------
-- TASK 4: Market Segmentation by Average Cost for Two
-- Categories: Budget (< 400), Mid-Range (400 - 800), Premium (> 800)
-- ----------------------------------------------------------------------------
SELECT 
    CASE 
        WHEN approx_cost_for_two < 400 THEN 'Budget (< 400)'
        WHEN approx_cost_for_two BETWEEN 400 AND 800 THEN 'Mid-Range (400 - 800)'
        ELSE 'Premium (> 800)'
    END AS market_segment,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating), 2) AS avg_segment_rating,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM zomato_bangalore_restaurants), 2) AS percentage_share
FROM zomato_bangalore_restaurants
GROUP BY 
    CASE 
        WHEN approx_cost_for_two < 400 THEN 'Budget (< 400)'
        WHEN approx_cost_for_two BETWEEN 400 AND 800 THEN 'Mid-Range (400 - 800)'
        ELSE 'Premium (> 800)'
    END
ORDER BY MIN(approx_cost_for_two) ASC;


-- ----------------------------------------------------------------------------
-- TASK 5: Top 10 Popular Restaurant Chains by Number of Outlets
-- AI-Augmented query validated and run against the dataset
-- ----------------------------------------------------------------------------
SELECT 
    name AS restaurant_chain,
    COUNT(*) AS total_outlets,
    ROUND(AVG(rating), 2) AS avg_chain_rating,
    ROUND(AVG(approx_cost_for_two), 2) AS avg_cost_for_two
FROM zomato_bangalore_restaurants
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY total_outlets DESC, avg_chain_rating DESC
LIMIT 10;
