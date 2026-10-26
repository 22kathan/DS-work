-- ============================================================================
-- SESSION 9: JOINS - Part 1
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: session09_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session09_db;
USE session09_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'restaurants' and 'dishes' Tables & Insert Sample Records
-- Tables:
--   - restaurants (id, name, city)
--   - dishes (id, restaurant_id, dish_name, price)
-- Includes:
--   - 3 active restaurants with 2 dishes each
--   - 1 restaurant without dishes (The Belgian Waffle Co.) to demonstrate LEFT JOIN
--   - 1 dish without a matching restaurant (Mystery Dish) to demonstrate RIGHT JOIN
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS dishes;
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL
);

INSERT INTO restaurants (id, name, city) VALUES
(1, 'Domino\'s Pizza', 'Ahmedabad'),
(2, 'Burger King', 'Surat'),
(3, 'Haldiram\'s', 'Ahmedabad'),
(4, 'The Belgian Waffle Co.', 'Rajkot'); -- Newly onboarded restaurant with 0 dishes

CREATE TABLE dishes (
    id INT PRIMARY KEY,
    restaurant_id INT,                   -- Nullable / unconstrained to simulate orphan data
    dish_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

INSERT INTO dishes (id, restaurant_id, dish_name, price) VALUES
(101, 1, 'Farmhouse Pizza', 450.00),
(102, 1, 'Garlic Breadsticks', 150.00),
(103, 2, 'Whopper Burger', 220.00),
(104, 2, 'Crispy Veg Burger', 120.00),
(105, 3, 'Chole Bhature', 180.00),
(106, 3, 'Raj Kachori', 140.00),
(107, 999, 'Special Mystery Dish', 299.00); -- Orphan record (restaurant_id 999 does not exist)

-- View raw records
SELECT * FROM restaurants;
SELECT * FROM dishes;


-- ----------------------------------------------------------------------------
-- TASK 2: INNER JOIN Query (Zomato-Style Dish + Restaurant Info)
-- Returns only matched rows where dish has an existing restaurant
-- ----------------------------------------------------------------------------
SELECT 
    d.id AS dish_id,
    d.dish_name,
    d.price,
    r.name AS restaurant_name,
    r.city
FROM dishes d
INNER JOIN restaurants r ON d.restaurant_id = r.id
ORDER BY d.id ASC;


-- ----------------------------------------------------------------------------
-- TASK 3: LEFT JOIN Query (All Restaurants, Even Without Dishes)
-- Preserves all restaurants; displays NULL for dishes when menu is empty
-- ----------------------------------------------------------------------------
SELECT 
    r.id AS restaurant_id,
    r.name AS restaurant_name,
    r.city,
    d.dish_name,
    d.price
FROM restaurants r
LEFT JOIN dishes d ON r.id = d.restaurant_id
ORDER BY r.id ASC, d.id ASC;


-- ----------------------------------------------------------------------------
-- TASK 4: RIGHT JOIN Query (All Dishes, Including Unlinked Orphan Dishes)
-- Preserves all dishes from right table; displays NULL for restaurant info if unlinked
-- ----------------------------------------------------------------------------
SELECT 
    r.name AS restaurant_name,
    r.city,
    d.id AS dish_id,
    d.dish_name,
    d.price
FROM restaurants r
RIGHT JOIN dishes d ON r.id = d.restaurant_id
ORDER BY d.id ASC;


-- ----------------------------------------------------------------------------
-- TASK 5: Spotify Playlists Scenario (All Playlists Including Empty Ones)
-- Join Choice: LEFT JOIN (preserves all playlists from left table even if empty)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS playlist_songs;
DROP TABLE IF EXISTS playlists;

CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY,
    playlist_name VARCHAR(100) NOT NULL
);

INSERT INTO playlists (playlist_id, playlist_name) VALUES
(1, 'Gym Workout'),
(2, 'Chill Acoustic'),
(3, 'Roadtrip 2026'); -- Empty playlist with no songs

CREATE TABLE playlist_songs (
    song_id INT PRIMARY KEY,
    playlist_id INT,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL
);

INSERT INTO playlist_songs (song_id, playlist_id, song_name, artist) VALUES
(1, 1, 'Tauba Tauba', 'Karan Aujla'),
(2, 1, 'Winning Speech', 'Karan Aujla'),
(3, 2, 'Kesariya', 'Arijit Singh');

-- Query: Retrieve all playlists and their songs (empty playlists show NULL for song details)
SELECT 
    p.playlist_id,
    p.playlist_name,
    s.song_id,
    s.song_name,
    s.artist
FROM playlists p
LEFT JOIN playlist_songs s ON p.playlist_id = s.playlist_id
ORDER BY p.playlist_id ASC, s.song_id ASC;
