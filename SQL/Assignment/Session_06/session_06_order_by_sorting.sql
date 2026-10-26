-- ============================================================================
-- SESSION 6: ORDER BY + Sorting
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: session06_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session06_db;
USE session06_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Display Products Sorted by Price Ascending (Lowest to Highest)
-- Simulates Flipkart's 'Price -- Low to High' catalog sort
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'boAt Bassheads 100 Wired Earphones', 'Audio', 399.00),
(2, 'SanDisk 64GB Pen Drive', 'Accessories', 489.00),
(3, 'Noise ColorFit Pulse Smartwatch', 'Wearables', 1499.00),
(4, 'Puma Men Running Shoes', 'Footwear', 2199.00),
(5, 'Sony WH-1000XM5 Headphones', 'Audio', 26990.00),
(6, 'Samsung Galaxy S24 Ultra', 'Smartphones', 129999.00),
(7, 'Apple iPhone 16 Pro', 'Smartphones', 119900.00),
(8, 'Dell XPS 15 Laptop', 'Computers', 174990.00);

-- Query: Products from lowest to highest price
SELECT * 
FROM products 
ORDER BY price ASC;


-- ----------------------------------------------------------------------------
-- TASK 2: Top 5 Most Expensive Products using ORDER BY DESC and LIMIT
-- Simulates Flipkart's 'Price -- High to Low' premium filter
-- ----------------------------------------------------------------------------
SELECT * 
FROM products 
ORDER BY price DESC 
LIMIT 5;


-- ----------------------------------------------------------------------------
-- TASK 3: Movies Sorted by Release Year (Latest First), then Rating (Highest First)
-- Demonstrates multi-level sorting with independent descending directions
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT NOT NULL,
    rating DECIMAL(3, 1) NOT NULL
);

INSERT INTO movies (movie_id, title, release_year, rating) VALUES
(1, 'Dune: Part Two', 2024, 8.6),
(2, 'Stree 2', 2024, 7.7),
(3, 'Deadpool & Wolverine', 2024, 7.9),
(4, 'Oppenheimer', 2023, 8.9),
(5, 'Jawan', 2023, 7.1),
(6, 'Spider-Man: Across the Spider-Verse', 2023, 8.7),
(7, 'RRR', 2022, 7.8),
(8, 'Top Gun: Maverick', 2022, 8.3);

-- Query: Sorted by year DESC, then rating DESC
SELECT title, release_year, rating 
FROM movies 
ORDER BY release_year DESC, rating DESC;


-- ----------------------------------------------------------------------------
-- TASK 4: First 10 Restaurants Sorted Alphabetically by Name (Zomato A-Z)
-- Uses ORDER BY with LIMIT 10
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    cuisine VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

INSERT INTO restaurants (restaurant_id, name, cuisine, city) VALUES
(1, 'Subway', 'Sandwiches', 'Ahmedabad'),
(2, 'Burger King', 'Fast Food', 'Ahmedabad'),
(3, 'Domino\'s Pizza', 'Pizza', 'Surat'),
(4, 'Haldiram\'s', 'Mithai / Fast Food', 'Ahmedabad'),
(5, 'Swagat Restaurant', 'North Indian', 'Ahmedabad'),
(6, 'KFC', 'Fast Food', 'Vadodara'),
(7, 'Barbeque Nation', 'Buffet', 'Surat'),
(8, 'The Belgian Waffle Co.', 'Desserts', 'Rajkot'),
(9, 'Mainland China', 'Chinese', 'Vadodara'),
(10, 'McDonald\'s', 'Fast Food', 'Ahmedabad'),
(11, 'Pizza Hut', 'Pizza', 'Surat'),
(12, 'Chai Point', 'Beverages', 'Ahmedabad');

-- Query: First 10 restaurants sorted alphabetically (A-Z)
SELECT * 
FROM restaurants 
ORDER BY name ASC 
LIMIT 10;


-- ----------------------------------------------------------------------------
-- TASK 5: Top 3 Trending Songs with Play Count Tie-Breaker by Recency
-- Primary sort: play_count DESC
-- Secondary sort (tie-breaker): added_date DESC (more recent comes first)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS songs;

CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    artist VARCHAR(255) NOT NULL,
    play_count INT NOT NULL,
    added_date DATE NOT NULL
);

INSERT INTO songs (song_id, title, artist, play_count, added_date) VALUES
(1, 'Tauba Tauba', 'Karan Aujla', 15000000, '2026-07-10'),
(2, 'Millionaire', 'Yo Yo Honey Singh', 18500000, '2026-08-15'),
(3, 'Big Dawgs', 'Hanumankind', 18500000, '2026-08-28'), -- Same play count as Millionaire, but newer!
(4, 'Winning Speech', 'Karan Aujla', 12000000, '2026-06-20'),
(5, 'Illuminati', 'Sushin Shyam', 14200000, '2026-05-12');

-- Query: Top 3 trending songs with tie-breaking
SELECT song_id, title, artist, play_count, added_date 
FROM songs 
ORDER BY play_count DESC, added_date DESC 
LIMIT 3;
