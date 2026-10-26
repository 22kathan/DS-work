-- ============================================================================
-- SESSION 1: Database Introduction & SQL Basics
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Course: Data Science
-- Database: music_streaming_app
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TASK 1: Create a new database named 'music_streaming_app'
-- ----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS music_streaming_app;
USE music_streaming_app;

-- ----------------------------------------------------------------------------
-- TASK 2: Create a table called 'playlists'
-- Columns:
--   - playlist_id : INT (Primary Key)
--   - name        : VARCHAR(255) (Playlist title)
--   - created_by  : VARCHAR(100) (User name who created playlist)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS playlists (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_by VARCHAR(100) NOT NULL
);

-- Inspect table schema definition
DESCRIBE playlists;

-- ----------------------------------------------------------------------------
-- TASK 3: Insert three sample rows representing playlists
-- 'Bollywood Hits', 'Chill Vibes', and 'Workout Mix', each by different users
-- ----------------------------------------------------------------------------
INSERT INTO playlists (playlist_id, name, created_by) VALUES
(1, 'Bollywood Hits', 'Amit'),
(2, 'Chill Vibes', 'Neha'),
(3, 'Workout Mix', 'Rohan');

-- Display all inserted rows
SELECT * FROM playlists;

-- ----------------------------------------------------------------------------
-- TASK 4: Write an SQL SELECT query to display all playlists created by 'Amit'
-- Using the WHERE clause to filter by the 'created_by' column
-- ----------------------------------------------------------------------------
SELECT 
    playlist_id,
    name,
    created_by
FROM playlists
WHERE created_by = 'Amit';
