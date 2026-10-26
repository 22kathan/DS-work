-- ============================================================================
-- SESSION 2: Database Setup + CREATE TABLE
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: foodie_app
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TASK 2: Create a new database named 'foodie_app' (Zomato-style backend)
-- ----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS foodie_app;
USE foodie_app;

-- ----------------------------------------------------------------------------
-- TASK 3: CREATE TABLE 'restaurants'
-- Columns:
--   - id       : INT (Primary Key, Auto Increment)
--   - name     : VARCHAR(100) (Restaurant title)
--   - cuisine  : VARCHAR(50) (Cuisine category, e.g. North Indian, Italian)
--   - rating   : DECIMAL(2, 1) (Rating scale e.g. 4.5, check 0.0 to 5.0)
--   - location : VARCHAR(100) (City / neighborhood)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS restaurants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- Inspect 'restaurants' table schema
DESCRIBE restaurants;

-- Insert sample Zomato-style restaurant records
INSERT INTO restaurants (name, cuisine, rating, location) VALUES
('The Belgian Waffle Co.', 'Desserts', 4.5, 'Bandra West, Mumbai'),
('Punjab Grill', 'North Indian', 4.7, 'Connaught Place, Delhi'),
('Toscano', 'Italian', 4.6, 'Indiranagar, Bangalore'),
('Chai Point', 'Beverages', 4.2, 'Cyber Hub, Gurugram');

-- Verify inserted records
SELECT * FROM restaurants;

-- ----------------------------------------------------------------------------
-- TASK 4: Design and create a 'users' table for a Flipkart-style app
-- Design Considerations & Constraints:
--   - user_id      : INT PRIMARY KEY AUTO_INCREMENT (Unique numeric identifier)
--   - username     : VARCHAR(50) NOT NULL UNIQUE (Unique login handle)
--   - email        : VARCHAR(100) NOT NULL UNIQUE (Unique email address)
--   - phone_number : VARCHAR(15) NOT NULL UNIQUE (Stored as VARCHAR to preserve 
--                    leading zeros and international '+' prefixes; never INT)
--   - created_at   : TIMESTAMP DEFAULT CURRENT_TIMESTAMP (Audit timestamp)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inspect 'users' table schema
DESCRIBE users;

-- Insert sample Flipkart-style user accounts
INSERT INTO users (username, email, phone_number) VALUES
('kathan_gadhiya', 'kathan@example.com', '+919876543210'),
('priya_sharma', 'priya.s@example.com', '+919812345678'),
('rahul_verma', 'rahul.v@example.com', '+919890123456');

-- Verify inserted user accounts
SELECT * FROM users;

-- ----------------------------------------------------------------------------
-- TASK 5: Intentional Syntax Error Experiment and Resolution
-- ----------------------------------------------------------------------------

-- [INTENTIONAL ERROR EXAMPLE]:
-- Missing a comma after 'name VARCHAR(100)'
/*
CREATE TABLE orders_error_test (
    order_id INT PRIMARY KEY,
    name VARCHAR(100)
    amount DECIMAL(10, 2)
);
-- Resulting MySQL Error:
-- ERROR 1064 (42000): You have an error in your SQL syntax; check the manual
-- that corresponds to your MySQL server version for the right syntax to use
-- near 'amount DECIMAL(10, 2)' at line 4
*/

-- [CORRECTED & WORKING VERSION]:
-- Added the missing comma separating the column definitions
CREATE TABLE IF NOT EXISTS orders_error_test (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

-- Verify corrected table creation
DESCRIBE orders_error_test;
