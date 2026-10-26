-- ============================================================================
-- SESSION 4: SELECT Statement Basics
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: session04_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session04_db;
USE session04_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'MusicPlaylist' Table & Retrieve All Columns for All Songs
-- Columns:
--   - id        : INT PRIMARY KEY
--   - song_name : VARCHAR(255)
--   - artist    : VARCHAR(255)
--   - genre     : VARCHAR(100)
--   - duration  : INT (Track duration in seconds)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS MusicPlaylist;

CREATE TABLE MusicPlaylist (
    id INT PRIMARY KEY,
    song_name VARCHAR(255) NOT NULL,
    artist VARCHAR(255) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    duration INT NOT NULL
);

-- Insert 6 representative songs from favorite Spotify playlist
INSERT INTO MusicPlaylist (id, song_name, artist, genre, duration) VALUES
(1, 'Kesariya', 'Arijit Singh', 'Bollywood Romantic', 268),
(2, 'Brown Munde', 'AP Dhillon', 'Punjabi Pop', 262),
(3, 'Blinding Lights', 'The Weeknd', 'Synthwave / Pop', 200),
(4, 'Starboy', 'The Weeknd', 'R&B / Pop', 230),
(5, 'Apna Bana Le', 'Arijit Singh', 'Bollywood Soul', 261),
(6, 'Excuses', 'AP Dhillon', 'Punjabi Pop', 236);

-- Retrieve all columns for all songs
SELECT * 
FROM MusicPlaylist;


-- ----------------------------------------------------------------------------
-- TASK 2: Project Specific Columns (song_name, artist) with LIMIT 3
-- Restricts output to only the first 3 records
-- ----------------------------------------------------------------------------
SELECT song_name, artist
FROM MusicPlaylist
LIMIT 3;


-- ----------------------------------------------------------------------------
-- TASK 3: Unique Restaurant Names from 'FoodOrders' Table using DISTINCT
-- Columns:
--   - id         : INT PRIMARY KEY
--   - restaurant : VARCHAR(255)
--   - food_item  : VARCHAR(255)
--   - order_date : DATE
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS FoodOrders;

CREATE TABLE FoodOrders (
    id INT PRIMARY KEY,
    restaurant VARCHAR(255) NOT NULL,
    food_item VARCHAR(255) NOT NULL,
    order_date DATE NOT NULL
);

-- Insert sample orders (includes repeat visits to restaurants to demonstrate DISTINCT)
INSERT INTO FoodOrders (id, restaurant, food_item, order_date) VALUES
(101, 'Domino\'s Pizza', 'Farmhouse Pizza', '2026-10-15'),
(102, 'Burger King', 'Whopper Meal', '2026-10-18'),
(103, 'Domino\'s Pizza', 'Garlic Breadsticks', '2026-10-20'),
(104, 'Subway', 'Paneer Tikka Sub', '2026-10-21'),
(105, 'Burger King', 'Veg Crispy Burger', '2026-10-22'),
(106, 'Haldiram\'s', 'Chole Bhature', '2026-10-24'),
(107, 'Domino\'s Pizza', 'Farmhouse Pizza', '2026-10-25');

-- Retrieve unique restaurant names
SELECT DISTINCT restaurant
FROM FoodOrders;


-- ----------------------------------------------------------------------------
-- TASK 4: Column Aliases ('Dish' and 'Date Ordered')
-- Uses AS keyword and backticks/quotes for multi-word aliases
-- ----------------------------------------------------------------------------
SELECT 
    food_item AS Dish,
    order_date AS `Date Ordered`
FROM FoodOrders;


-- ----------------------------------------------------------------------------
-- TASK 5: Diagnostic & Fixed Query for DISTINCT + LIMIT
-- Problematic original query:
--   SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2
--
-- Identification:
-- 1. Placement Rule: In SQL, LIMIT must strictly appear at the very end of
--    the query (after FROM, WHERE, GROUP BY, HAVING, and ORDER BY).
-- 2. Non-Deterministic Order: Without ORDER BY, LIMIT returns arbitrary rows.
-- 3. Multi-Column Scope: DISTINCT evaluates the full (food_item, restaurant) pair.
-- ----------------------------------------------------------------------------

-- Corrected Solution A: Deterministic order by food_item with LIMIT 2
SELECT DISTINCT food_item, restaurant
FROM FoodOrders
ORDER BY food_item ASC
LIMIT 2;

-- Corrected Solution B: Recent unique orders ordered by date
SELECT DISTINCT food_item, restaurant, order_date
FROM FoodOrders
ORDER BY order_date DESC
LIMIT 2;

-- Corrected Solution C: If the user intended distinct food items only
SELECT DISTINCT food_item
FROM FoodOrders
ORDER BY food_item ASC
LIMIT 2;
