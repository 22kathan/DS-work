-- ============================================================================
-- SESSION 15: SQL + Python Integration (Underlying SQL Statements)
-- Database Engine: SQLite3 / MySQL
-- Target Database: foodie.db / foodie_db
-- ============================================================================

-- TASK 1: DDL for Restaurants Table
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    cuisine TEXT NOT NULL,
    rating REAL NOT NULL
);

-- TASK 2: DML Insert 3 Sample Restaurants & DQL Filter (> 4.0)
INSERT INTO Restaurants (id, name, cuisine, rating) VALUES
(1, 'Little Italy', 'Italian', 4.7),
(2, 'Honest Restaurant', 'North Indian', 4.2),
(3, 'Sankalp South Indian', 'South Indian', 3.9);

SELECT name, rating 
FROM Restaurants 
WHERE rating > 4.0;

-- TASK 3: Fetch Full Table for Pandas Ingestion
SELECT * FROM Restaurants;

-- TASK 4: Equivalent SQL Transformation for Calculated Fields
SELECT 
    id,
    name,
    cuisine,
    rating,
    50 AS delivery_charge,
    ROUND(
        CASE 
            WHEN cuisine = 'Italian' THEN rating + 0.1 
            ELSE rating 
        END, 2
    ) AS final_rating
FROM Restaurants;

-- TASK 5: Automated Filter for Top-Rated Export (> 4.5)
SELECT 
    id,
    name,
    cuisine,
    rating 
FROM Restaurants 
WHERE rating > 4.5;
