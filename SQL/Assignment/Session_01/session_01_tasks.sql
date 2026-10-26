-- ============================================================================
-- SESSION 1: Database Introduction & SQL Basics
-- Course: Data Science (Module: Working with Databases)
-- Database Engine: MySQL / PostgreSQL / SQLite Compatible
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TASK 1: Create a new database named 'music_streaming_app'
-- ----------------------------------------------------------------------------
-- For MySQL:
CREATE DATABASE IF NOT EXISTS music_streaming_app;
USE music_streaming_app;

-- For PostgreSQL:
-- CREATE DATABASE music_streaming_app;
-- \c music_streaming_app;

-- ----------------------------------------------------------------------------
-- TASK 2: Create a table called 'playlists'
-- Columns:
--   - playlist_id: Integer, Primary Key
--   - name       : VARCHAR (Playlist title)
--   - created_by : VARCHAR (User creator name)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS playlists (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_by VARCHAR(100) NOT NULL
);

-- ----------------------------------------------------------------------------
-- TASK 3: Insert three sample rows into 'playlists'
-- Sample Playlists: 'Bollywood Hits', 'Chill Vibes', 'Workout Mix'
-- Created by different users (including user 'Amit')
-- ----------------------------------------------------------------------------
INSERT INTO playlists (playlist_id, name, created_by) VALUES
(1, 'Bollywood Hits', 'Amit'),
(2, 'Chill Vibes', 'Neha'),
(3, 'Workout Mix', 'Rohan');

-- ----------------------------------------------------------------------------
-- TASK 4: SQL SELECT query to display all playlists created by 'Amit'
-- Using the WHERE clause to filter by the 'created_by' column
-- ----------------------------------------------------------------------------
SELECT 
    playlist_id,
    name,
    created_by
FROM playlists
WHERE created_by = 'Amit';

-- EXPECTED RESULT:
-- +-------------+----------------+------------+
-- | playlist_id | name           | created_by |
-- +-------------+----------------+------------+
-- | 1           | Bollywood Hits | Amit       |
-- +-------------+----------------+------------+
