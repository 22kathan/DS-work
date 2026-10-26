# SQL & Relational Databases Module

Welcome to the **SQL & Relational Databases** module repository for the Data Science program.

---

## 📁 Repository Contents

### 📑 [**Assessment (M4-A1: Working with Databases)**](./Assessment/)
Contains the complete, verified, four-section submission for **Modules 3–4: Data Collection, Cleaning & Visualization › Working with Databases**:

* 📂 [**Section A (Concept Application)**](./Assessment/Section%20A/) — Detailed theoretical analyses, Python scripts, SQL queries, and generated visual charts for questions S1 through S6.
* 📂 [**Section B (Practical Coding Tasks)**](./Assessment/Section%20B/) — Standalone runnable scripts, database creation, $2 \times 2$ visualization dashboard, and exported ranking reports.
* 📂 [**Section C (Mini Capstone Project)**](./Assessment/Section%20C/) — Interactive console application integrating data cleaning, SQLite analytics, Seaborn charts, and multi-sheet Excel reporting.
* 📂 [**Section D (AI-Augmented Learning)**](./Assessment/Section%20D/) — AI prompt documentation, original vs. corrected code comparison, bug fixes, and horizontal rating bar chart.

For complete documentation, execution logs, and architecture breakdown, please view the [**Assessment README**](./Assessment/README.md).

---

### 📝 [**Assignments (Coursework Sessions)**](./Assignment/)
Contains ongoing weekly assignments and practical SQL exercises:

* 📂 [**Session 01: Database Introduction & SQL Basics**](./Assignment/Session_01/)
  - Task 1: Database installation and `music_streaming_app` creation
  - Task 2: DDL `CREATE TABLE playlists`
  - Task 3: DML `INSERT INTO playlists` (Bollywood Hits, Chill Vibes, Workout Mix)
  - Task 4: DQL `SELECT` query with `WHERE created_by = 'Amit'`
  - Task 5: AI Explanation — Difference between Table, Row, and Column using a Zomato example

* 📂 [**Session 02: Database Setup + CREATE TABLE**](./Assignment/Session_02/)
  - Task 1: Environment verification (MySQL Server 8.0 & MySQL Workbench)
  - Task 2: Create Zomato-style backend database (`foodie_app`)
  - Task 3: DDL `CREATE TABLE restaurants` (ID, name, cuisine, rating, location)
  - Task 4: Flipkart-style `users` table design (`UNIQUE` email/phone, `TIMESTAMP`)
  - Task 5: Intentional syntax error diagnosis (`ERROR 1064`) and resolution

* 📂 [**Session 03: INSERT, UPDATE & DELETE**](./Assignment/Session_03/)
  - Task 1: Create `Playlist` table and insert favorite song
  - Task 2: Multi-row `INSERT` for recent Spotify tracks
  - Task 3: `UPDATE` statement with `WHERE` for typo correction
  - Task 4: Safe `DELETE` statement with duration threshold (< 120s)
  - Task 5: Compound `UPDATE` combining `WHERE`, `AND`, and `CONCAT()` for AP Dhillon remixes

* 📂 [**Session 04: SELECT Statement Basics**](./Assignment/Session_04/)
  - Task 1: DDL `MusicPlaylist` table and full projection `SELECT *`
  - Task 2: Project `song_name` and `artist` with `LIMIT 3`
  - Task 3: DDL `FoodOrders` table and unique restaurant listing with `DISTINCT`
  - Task 4: Custom column aliases with `AS Dish` and `` `Date Ordered` ``
  - Task 5: Diagnostic analysis and bug fix for `SELECT DISTINCT ... LIMIT 2` syntax and non-deterministic sorting
