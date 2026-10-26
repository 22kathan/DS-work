-- ============================================================================
-- SESSION 13: Window Functions - Part 1
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: session13_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS session13_db;
USE session13_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create Table 'Playlists' and Insert Sample Data
-- Requirements: Columns (id, user_id, playlist_name, total_likes)
-- At least 8 sample rows with multiple users and shared user_ids
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Playlists;

CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    total_likes INT NOT NULL
);

INSERT INTO Playlists (id, user_id, playlist_name, total_likes) VALUES
(1, 101, 'Bollywood Hits', 4500),
(2, 101, 'Punjabi Party', 3200),
(3, 101, 'Lo-Fi Chill', 3200),
(4, 101, 'Workout Beats', 1800),
(5, 102, 'Acoustic Morning', 2500),
(6, 102, 'Indie Folk', 2500),
(7, 102, 'Late Night Drives', 1200),
(8, 103, 'Classic Rock Anthems', 5000),
(9, 103, 'Jazz Classics', 3200);

-- Verify Table Population:
SELECT * FROM Playlists;


-- ----------------------------------------------------------------------------
-- TASK 2: ROW_NUMBER() with OVER() Clause
-- Assigns a unique, sequential row number to each playlist ordered by total_likes DESC
-- ----------------------------------------------------------------------------
SELECT 
    id,
    playlist_name,
    user_id,
    total_likes,
    ROW_NUMBER() OVER (
        ORDER BY total_likes DESC, id ASC
    ) AS row_num
FROM Playlists;


-- ----------------------------------------------------------------------------
-- TASK 3: RANK() with OVER() Clause
-- Ranks all playlists by total_likes (leaves gaps after tied ranks)
-- Displays: playlist_name, user_id, total_likes, and their rank
-- ----------------------------------------------------------------------------
SELECT 
    playlist_name,
    user_id,
    total_likes,
    RANK() OVER (
        ORDER BY total_likes DESC
    ) AS playlist_rank
FROM Playlists;


-- ----------------------------------------------------------------------------
-- TASK 4: DENSE_RANK() with PARTITION BY user_id
-- Ranks playlists per user by total_likes without skipping rank values after ties
-- Displays: playlist_name, user_id, total_likes, and dense rank
-- ----------------------------------------------------------------------------
SELECT 
    playlist_name,
    user_id,
    total_likes,
    DENSE_RANK() OVER (
        PARTITION BY user_id 
        ORDER BY total_likes DESC
    ) AS user_dense_rank
FROM Playlists
ORDER BY user_id ASC, user_dense_rank ASC, playlist_name ASC;


-- ----------------------------------------------------------------------------
-- TASK 5: Top 2 Playlists Per User (Spotify 'Your Top Playlists' Feature)
-- Uses a Window Function inside a CTE to filter only the top 2 playlists per user
-- ----------------------------------------------------------------------------
WITH RankedUserPlaylists AS (
    SELECT 
        id,
        user_id,
        playlist_name,
        total_likes,
        ROW_NUMBER() OVER (
            PARTITION BY user_id 
            ORDER BY total_likes DESC, id ASC
        ) AS playlist_rank
    FROM Playlists
)
SELECT 
    user_id,
    playlist_name,
    total_likes,
    playlist_rank
FROM RankedUserPlaylists
WHERE playlist_rank <= 2
ORDER BY user_id ASC, playlist_rank ASC;
