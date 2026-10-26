-- ============================================================================
-- SESSION 5: WHERE Clause + LIKE Operator
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: foodie_app / session05_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session05_db;
USE session05_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'Restaurants' Table & Insert Real/Fictional Zomato Records
-- Columns:
--   - id      : INT PRIMARY KEY
--   - name    : VARCHAR(255) (Restaurant brand name)
--   - cuisine : VARCHAR(100) (Type of food served)
--   - rating  : DECIMAL(2, 1) (Zomato user rating out of 5.0)
--   - city    : VARCHAR(100) (City location in Gujarat)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    cuisine VARCHAR(100) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    city VARCHAR(100) NOT NULL
);

-- Insert 8 representative Zomato restaurants
INSERT INTO Restaurants (id, name, cuisine, rating, city) VALUES
(1, 'Swagat Restaurant', 'North Indian', 4.3, 'Ahmedabad'),
(2, 'Swadisht Dining Hall', 'Gujarati', 4.5, 'Surat'),
(3, 'Swati Snacks', 'South Indian', 4.6, 'Ahmedabad'),
(4, 'Mainland China', 'Chinese', 4.2, 'Vadodara'),
(5, 'Little Italy', 'Italian', 4.4, 'Ahmedabad'),
(6, 'Dakshin Express', 'South Indian', 3.8, 'Surat'),
(7, 'Wok Express', 'Chinese', 3.4, 'Ahmedabad'),
(8, 'The Belgian Waffle Co.', 'Desserts', 4.1, 'Rajkot');

-- Inspect full table
SELECT * FROM Restaurants;


-- ----------------------------------------------------------------------------
-- TASK 2: Filter by Rating > 4.0 AND Located in 'Ahmedabad' or 'Surat'
-- Demonstrates compound Boolean logic using AND with OR / IN
-- ----------------------------------------------------------------------------
-- Method 1: Using IN operator for cities
SELECT * 
FROM Restaurants
WHERE rating > 4.0 
  AND city IN ('Ahmedabad', 'Surat');

-- Method 2: Equivalent query using parenthesized OR
SELECT * 
FROM Restaurants
WHERE rating > 4.0 
  AND (city = 'Ahmedabad' OR city = 'Surat');


-- ----------------------------------------------------------------------------
-- TASK 3: Pattern Matching with LIKE Operator (Names Starting with 'Swa%')
-- Wildcard '%' matches any sequence of zero or more characters
-- ----------------------------------------------------------------------------
SELECT * 
FROM Restaurants
WHERE name LIKE 'Swa%';


-- ----------------------------------------------------------------------------
-- TASK 4: Range Filtering with BETWEEN Keyword (Rating 3.5 to 4.5 Inclusive)
-- In SQL, BETWEEN is inclusive: equivalent to rating >= 3.5 AND rating <= 4.5
-- ----------------------------------------------------------------------------
SELECT * 
FROM Restaurants
WHERE rating BETWEEN 3.5 AND 4.5;


-- ----------------------------------------------------------------------------
-- TASK 5: Membership Filtering with IN Operator
-- Find all restaurants serving 'Chinese', 'Italian', or 'South Indian'
-- ----------------------------------------------------------------------------
SELECT * 
FROM Restaurants
WHERE cuisine IN ('Chinese', 'Italian', 'South Indian');
