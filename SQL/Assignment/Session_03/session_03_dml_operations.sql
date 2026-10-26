-- ============================================================================
-- SESSION 3: INSERT, UPDATE & DELETE (DML Operations)
-- Preferred Technology: SQL (MySQL / MySQL Workbench)
-- Database Engine: MySQL Community Server 8.0 / 8.4
-- Target Database: music_streaming_app (or standalone session database)
-- ============================================================================

CREATE DATABASE IF NOT EXISTS spotify_db;
USE spotify_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'Playlist' Table & Insert Favorite Song
-- Columns:
--   - id        : INT PRIMARY KEY (Unique song ID)
--   - song_name : VARCHAR(255) (Title of the track)
--   - artist    : VARCHAR(255) (Artist name)
--   - duration  : INT (Track duration in seconds)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Playlist;

CREATE TABLE Playlist (
    id INT PRIMARY KEY,
    song_name VARCHAR(255) NOT NULL,
    artist VARCHAR(255) NOT NULL,
    duration INT NOT NULL
);

-- Insert favorite song (introducing intentional typo 'Arjit Singh' for Task 3)
INSERT INTO Playlist (id, song_name, artist, duration) VALUES
(1, 'Kesariya', 'Arjit Singh', 268);

-- View table after Task 1
SELECT * FROM Playlist;

-- ----------------------------------------------------------------------------
-- TASK 2: Insert 3+ New Rows for Recent Spotify Tracks
-- ----------------------------------------------------------------------------
INSERT INTO Playlist (id, song_name, artist, duration) VALUES
(2, 'Brown Munde', 'AP Dhillon', 262),       -- Duration > 180s
(3, 'Excuses', 'AP Dhillon', 236),           -- Duration > 180s
(4, 'Morning Acoustic Intro', 'Spotify', 95),-- Duration < 120s (for Task 4 DELETE)
(5, 'Insane', 'AP Dhillon', 175);            -- Duration < 180s (controls Task 5 condition)

-- View full playlist table
SELECT * FROM Playlist;

-- ----------------------------------------------------------------------------
-- TASK 3: Fix Artist Typo ('Arjit Singh' -> 'Arijit Singh') using UPDATE
-- ----------------------------------------------------------------------------
-- Note: In MySQL Workbench, disable safe updates if filtering by non-key column:
SET SQL_SAFE_UPDATES = 0;

UPDATE Playlist
SET artist = 'Arijit Singh'
WHERE artist = 'Arjit Singh';

-- Verify Task 3 update
SELECT * FROM Playlist WHERE id = 1;

-- ----------------------------------------------------------------------------
-- TASK 4: Delete Songs Shorter Than 120 Seconds (duration < 120)
-- ----------------------------------------------------------------------------
DELETE FROM Playlist
WHERE duration < 120;

-- Verify Task 4 deletion (Row 4 with 95 seconds should be removed)
SELECT * FROM Playlist;

-- ----------------------------------------------------------------------------
-- TASK 5: Update Song Name to Add '(Remix)' for 'AP Dhillon' Songs with duration > 180s
-- Uses CONCAT() function to append suffix conditionally
-- ----------------------------------------------------------------------------
UPDATE Playlist
SET song_name = CONCAT(song_name, ' (Remix)')
WHERE artist = 'AP Dhillon' AND duration > 180;

-- Re-enable safe updates mode
SET SQL_SAFE_UPDATES = 1;

-- Final Verification: Inspect complete table state
SELECT 
    id,
    song_name,
    artist,
    duration,
    CONCAT(FLOOR(duration / 60), 'm ', (duration % 60), 's') AS formatted_duration
FROM Playlist
ORDER BY id ASC;
