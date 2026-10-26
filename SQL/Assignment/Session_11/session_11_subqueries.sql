-- ============================================================================
-- SESSION 11: Subqueries
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: session11_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session11_db;
USE session11_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Correlated Subquery in WHERE Clause
-- Find all restaurants whose rating is higher than the average rating of
-- all restaurants in their respective city.
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL
);

INSERT INTO Restaurants (id, name, city, rating) VALUES
(1, 'Swagat Restaurant', 'Ahmedabad', 4.5),
(2, 'Honest Restaurant', 'Ahmedabad', 3.8),
(3, 'Agashiye', 'Ahmedabad', 4.8),
(4, 'Burger King', 'Surat', 4.1),
(5, 'Kansar Gujarati Thali', 'Surat', 4.6),
(6, 'De Brand', 'Surat', 3.7);

-- Correlated Subquery: compares each restaurant's rating with its city's average
SELECT 
    r1.id, 
    r1.name, 
    r1.city, 
    r1.rating
FROM Restaurants r1
WHERE r1.rating > (
    SELECT AVG(r2.rating)
    FROM Restaurants r2
    WHERE r2.city = r1.city
)
ORDER BY r1.city ASC, r1.rating DESC;


-- ----------------------------------------------------------------------------
-- TASK 2: Subquery in SELECT Statement (Zomato User Profile Order Summary)
-- Displays each user's name along with total number of orders placed.
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO Users (id, name) VALUES
(1, 'Kathan Gadhiya'),
(2, 'Priya Sharma'),
(3, 'Rahul Verma'); -- User with 0 orders

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO Orders (id, user_id, order_date) VALUES
(101, 1, '2026-10-15'),
(102, 1, '2026-10-18'),
(103, 1, '2026-10-22'),
(104, 2, '2026-10-20');

-- Scalar Subquery in SELECT list:
SELECT 
    u.id AS user_id,
    u.name AS user_name,
    (
        SELECT COUNT(*) 
        FROM Orders o 
        WHERE o.user_id = u.id
    ) AS total_orders
FROM Users u
ORDER BY u.id ASC;


-- ----------------------------------------------------------------------------
-- TASK 3: IN with a Subquery (BookMyShow 5-Star Rated Movies)
-- Lists all movies having at least one 5-star review.
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Movies;

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT NOT NULL
);

INSERT INTO Movies (movie_id, title, release_year) VALUES
(1, 'Dune: Part Two', 2024),
(2, 'Oppenheimer', 2023),
(3, 'Stree 2', 2024),
(4, 'Jawan', 2023);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    movie_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT
);

INSERT INTO Reviews (review_id, movie_id, rating, comment) VALUES
(101, 1, 5, 'Masterpiece visual spectacle!'),
(102, 2, 5, 'Incredible storytelling and sound'),
(103, 3, 4, 'Fun horror comedy'),
(104, 4, 3, 'Average action flick'),
(105, 1, 4, 'Great pacing');

-- Subquery with IN operator:
SELECT 
    movie_id, 
    title, 
    release_year
FROM Movies
WHERE movie_id IN (
    SELECT DISTINCT movie_id
    FROM Reviews
    WHERE rating = 5
)
ORDER BY movie_id ASC;


-- ----------------------------------------------------------------------------
-- TASK 4: Nested Subquery for Relational Division (Flipkart Platform Sellers)
-- Finds sellers who have sold products in every category listed in Categories table.
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Sellers;
DROP TABLE IF EXISTS Categories;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Fashion'),
(3, 'Home & Kitchen');

CREATE TABLE Sellers (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(100) NOT NULL
);

INSERT INTO Sellers (seller_id, seller_name) VALUES
(101, 'SuperCom Retail'), -- Sells in all 3 categories (1, 2, 3)
(102, 'Apex Footwear'),   -- Sells only in Fashion (2)
(103, 'OmniStore India'); -- Sells in all 3 categories (1, 2, 3)

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    seller_id INT NOT NULL,
    category_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL
);

INSERT INTO Products (product_id, seller_id, category_id, product_name) VALUES
(1, 101, 1, 'Noise Smartwatch'),
(2, 101, 2, 'Puma T-Shirt'),
(3, 101, 3, 'Prestige Cooker'),
(4, 102, 2, 'Running Shoes'),
(5, 103, 1, 'boAt Earphones'),
(6, 103, 2, 'Denim Jeans'),
(7, 103, 3, 'Non-stick Frying Pan');

-- Method 1: Nested Category Count Comparison (Matches Hint)
SELECT 
    s.seller_id, 
    s.seller_name
FROM Sellers s
WHERE (
    SELECT COUNT(DISTINCT p.category_id)
    FROM Products p
    WHERE p.seller_id = s.seller_id
) = (
    SELECT COUNT(*) 
    FROM Categories
)
ORDER BY s.seller_id ASC;

-- Method 2: Classic Relational Division with Double NOT EXISTS
SELECT 
    s.seller_id, 
    s.seller_name
FROM Sellers s
WHERE NOT EXISTS (
    SELECT c.category_id
    FROM Categories c
    WHERE NOT EXISTS (
        SELECT p.product_id
        FROM Products p
        WHERE p.seller_id = s.seller_id 
          AND p.category_id = c.category_id
    )
)
ORDER BY s.seller_id ASC;
