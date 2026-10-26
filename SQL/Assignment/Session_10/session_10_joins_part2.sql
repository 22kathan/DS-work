-- ============================================================================
-- SESSION 10: JOINS - Part 2
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: session10_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session10_db;
USE session10_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Influencers and Collaborations (FULL JOIN)
-- Demonstrates listing all influencers and their partners, including those
-- without any collaborations.
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Collaborations;
DROP TABLE IF EXISTS Influencers;

CREATE TABLE Influencers (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO Influencers (id, name) VALUES
(1, 'CarryMinati'),
(2, 'Bhuvan Bam'),
(3, 'Ashish Chanchlani'),
(4, 'Prajakta Koli'),
(5, 'Ranveer Allahbadia'); -- Influencer with no collaborations

CREATE TABLE Collaborations (
    id INT PRIMARY KEY,
    influencer1_id INT,
    influencer2_id INT,
    collab_date DATE NOT NULL
);

INSERT INTO Collaborations (id, influencer1_id, influencer2_id, collab_date) VALUES
(101, 1, 2, '2026-05-10'),
(102, 2, 3, '2026-06-15'),
(103, 1, 4, '2026-07-20');

-- Query 1A: ANSI Standard SQL FULL OUTER JOIN
-- (Standard syntax supported in PostgreSQL, SQL Server, and Oracle)
/*
SELECT 
    i1.name AS influencer,
    i2.name AS collaborator,
    c.collab_date
FROM Influencers i1
FULL JOIN Collaborations c ON i1.id = c.influencer1_id
FULL JOIN Influencers i2 ON c.influencer2_id = i2.id;
*/

-- Query 1B: MySQL Native FULL JOIN Implementation (UNION of LEFT JOIN and RIGHT JOIN)
SELECT 
    i1.name AS influencer,
    i2.name AS collaborator,
    c.collab_date
FROM Influencers i1
LEFT JOIN Collaborations c ON i1.id = c.influencer1_id
LEFT JOIN Influencers i2 ON c.influencer2_id = i2.id
UNION
SELECT 
    i1.name AS influencer,
    i2.name AS collaborator,
    c.collab_date
FROM Influencers i1
RIGHT JOIN Collaborations c ON i1.id = c.influencer1_id
LEFT JOIN Influencers i2 ON c.influencer2_id = i2.id;


-- ----------------------------------------------------------------------------
-- TASK 2: Spotify Nested Playlists using SELF JOIN
-- Displays each child playlist alongside its parent playlist name
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Playlists;

CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    parent_playlist_id INT NULL -- NULL indicates a top-level parent playlist
);

INSERT INTO Playlists (id, user_id, playlist_name, parent_playlist_id) VALUES
(1, 101, 'Bollywood', NULL),
(2, 101, 'Arijit Singh Soul', 1),
(3, 101, '90s Romantic Hits', 1),
(4, 101, 'Fitness & Workout', NULL),
(5, 101, 'High Tempo Cardio', 4);

-- Query: Self join linking child.parent_playlist_id to parent.id
SELECT 
    child.id AS playlist_id,
    child.playlist_name AS playlist,
    parent.playlist_name AS parent_playlist
FROM Playlists child
LEFT JOIN Playlists parent ON child.parent_playlist_id = parent.id
ORDER BY child.id ASC;


-- ----------------------------------------------------------------------------
-- TASK 3: Three-Table Multiple LEFT JOINs (Users, Orders, Payments)
-- Displays all users even if they have no orders or payments
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL
);

INSERT INTO Users (id, username) VALUES
(1, 'kathan_g'),
(2, 'priya_s'),
(3, 'rahul_v'); -- User with 0 orders

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO Orders (id, user_id, order_date) VALUES
(101, 1, '2026-10-15'),
(102, 1, '2026-10-18'),
(103, 2, '2026-10-20');

CREATE TABLE Payments (
    id INT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO Payments (id, order_id, amount) VALUES
(501, 101, 1499.00),
(502, 103, 899.00); -- Order 102 has no payment record yet

-- Query: Multi-table cascading LEFT JOIN
SELECT 
    u.id AS user_id,
    u.username,
    o.order_date,
    p.amount AS payment_amount
FROM Users u
LEFT JOIN Orders o ON u.id = o.user_id
LEFT JOIN Payments p ON o.id = p.order_id
ORDER BY u.id ASC, o.order_date ASC;


-- ----------------------------------------------------------------------------
-- TASK 4: Eliminate Duplicate Rows in Zomato Restaurants & Reviews Join
-- Reason: Duplicates occur because the relationship is One-to-Many (1:N),
-- where one restaurant matches multiple review rows.
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

INSERT INTO Restaurants (id, name, city) VALUES
(1, 'Swagat Restaurant', 'Ahmedabad'),
(2, 'Burger King', 'Surat');

CREATE TABLE Reviews (
    id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT
);

INSERT INTO Reviews (id, restaurant_id, rating, comment) VALUES
(1, 1, 5, 'Great food!'),
(2, 1, 4, 'Nice ambience'),
(3, 1, 5, 'Loved the thali'),
(4, 2, 4, 'Tasty burgers');

-- Solution A: Eliminating duplicates using DISTINCT
SELECT DISTINCT 
    r.id, 
    r.name, 
    r.city
FROM Restaurants r
JOIN Reviews rv ON r.id = rv.restaurant_id
ORDER BY r.id ASC;

-- Solution B: Consolidating duplicates using GROUP BY with metrics
SELECT 
    r.id, 
    r.name, 
    r.city,
    COUNT(rv.id) AS total_reviews,
    ROUND(AVG(rv.rating), 1) AS avg_rating
FROM Restaurants r
JOIN Reviews rv ON r.id = rv.restaurant_id
GROUP BY r.id, r.name, r.city
ORDER BY r.id ASC;


-- ----------------------------------------------------------------------------
-- TASK 5: Two Different Join Conditions on Products and Categories
-- Query 1 (Join on Foreign Key INT ID): High efficiency (Indexed B-Tree integer)
-- Query 2 (Join on Category Name VARCHAR): Low efficiency (String collation scan)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

INSERT INTO Categories (category_id, category_name) VALUES
(10, 'Electronics'),
(20, 'Footwear'),
(30, 'Apparel');

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    category_name VARCHAR(100) NOT NULL
);

INSERT INTO Products (product_id, product_name, category_id, category_name) VALUES
(1, 'Smartwatch', 10, 'Electronics'),
(2, 'Running Shoes', 20, 'Footwear'),
(3, 'T-Shirt', 30, 'Apparel');

-- Condition 1: Joining on Primary Key / Foreign Key integer ID (Recommended)
SELECT 
    p.product_id, 
    p.product_name, 
    c.category_name
FROM Products p
INNER JOIN Categories c ON p.category_id = c.category_id;

-- Condition 2: Joining on category name string
SELECT 
    p.product_id, 
    p.product_name, 
    c.category_name
FROM Products p
INNER JOIN Categories c ON p.category_name = c.category_name;
