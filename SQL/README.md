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

* 📂 [**Session 05: WHERE Clause + LIKE**](./Assignment/Session_05/)
  - Task 1: DDL `Restaurants` table and sample Zomato insertions
  - Task 2: Filter by rating > 4.0 and city in Ahmedabad or Surat with boolean precedence
  - Task 3: Pattern matching using `LIKE 'Swa%'`
  - Task 4: Continuous range filtering with `BETWEEN 3.5 AND 4.5`
  - Task 5: Discrete set membership with `IN ('Chinese', 'Italian', 'South Indian')`

* 📂 [**Session 06: ORDER BY + Sorting**](./Assignment/Session_06/)
  - Task 1: DDL `products` table and Flipkart ascending price sort (`ORDER BY price ASC`)
  - Task 2: Top 5 most expensive products (`ORDER BY price DESC LIMIT 5`)
  - Task 3: DDL `movies` table and multi-level sorting (`release_year DESC, rating DESC`)
  - Task 4: DDL `restaurants` table and alphabetical A-Z listing (`ORDER BY name ASC LIMIT 10`)
  - Task 5: DDL `songs` table and tie-breaker sorting (`play_count DESC, added_date DESC LIMIT 3`)

* 📂 [**Session 07: Aggregate Functions**](./Assignment/Session_07/)
  - Task 1: DDL `Orders` table with sample data and `NULL` amount handling
  - Task 2: Grouped order volume per user with `COUNT(*) GROUP BY user_name`
  - Task 3: Mean order calculation with `AVG()` ignoring `NULL` values
  - Task 4: Flipkart dashboard extremes with `MAX()` and `MIN()` in a single result row
  - Task 5: Total sales calculation with `SUM()` and `WHERE total_amount IS NOT NULL`

* 📂 [**Session 08: GROUP BY + HAVING**](./Assignment/Session_08/)
  - Task 1: DDL `Orders` table with payment methods (UPI, Card, Wallet, COD)
  - Task 2: Order frequency breakdown by payment instrument (`COUNT(*) GROUP BY payment_method`)
  - Task 3: Customer cumulative spend calculation (`SUM(amount) GROUP BY user_id`)
  - Task 4: Group threshold filtering on average order value (`HAVING AVG(amount) > 300`)
  - Task 5: Pipeline comparison and query examples for row-level `WHERE` vs. group-level `HAVING`

* 📂 [**Session 09: JOINS - Part 1**](./Assignment/Session_09/)
  - Task 1: DDL `restaurants` & `dishes` tables with multi-table relationships
  - Task 2: Zomato dish and restaurant pairing with `INNER JOIN`
  - Task 3: Preserving menu-less restaurants with `LEFT JOIN`
  - Task 4: Preserving unlinked orphan records with `RIGHT JOIN`
  - Task 5: Spotify dashboard join strategy (handling empty playlists with `LEFT JOIN`)

* 📂 [**Session 10: JOINS - Part 2**](./Assignment/Session_10/)
  - Task 1: DDL `Influencers` & `Collaborations` tables and `FULL JOIN` simulation with `UNION`
  - Task 2: DDL `Playlists` table and `SELF JOIN` for nested Spotify playlists
  - Task 3: DDL `Users`, `Orders`, and `Payments` with cascading multiple `LEFT JOIN`s
  - Task 4: Duplicate row diagnosis and elimination on 1:N relations (`DISTINCT` & `GROUP BY`)
  - Task 5: Join condition performance benchmarking (Integer Primary Key vs. String column)

* 📂 [**Session 11: Subqueries**](./Assignment/Session_11/)
  - Task 1: DDL `Restaurants` table and correlated subquery in `WHERE` comparing city average ratings
  - Task 2: DDL `Users` and `Orders` tables with scalar subquery in `SELECT` for total orders
  - Task 3: DDL `Movies` and `Reviews` tables with subquery in `IN` for 5-star movies
  - Task 4: DDL `Categories`, `Sellers`, and `Products` with nested subqueries for relational division

* 📂 [**Session 12: CTE (WITH Clause)**](./Assignment/Session_12/)
  - Task 1: DDL `Products` table and `WITH` clause for top-rated items (`rating > 4.5`)
  - Task 2: DDL `Restaurants` table and readability comparison of subquery vs. CTE for delivery charges under 50
  - Task 3: DDL `Users` & `Posts` tables and multiple CTEs with `UNION ALL` for top 3 users and posts
  - Task 4: Recursive CTE (`WITH RECURSIVE`) generating 7-day movie booking schedule
  - Task 5: Refactoring nested, redundant follower queries into modular CTE pipelines

* 📂 [**Session 13: Window Functions - Part 1**](./Assignment/Session_13/)
  - Task 1: DDL `Playlists` table and sample data generation across multiple users
  - Task 2: Unique row indexing with `ROW_NUMBER() OVER (ORDER BY total_likes DESC)`
  - Task 3: Standard rank calculation with gaps using `RANK() OVER (ORDER BY total_likes DESC)`
  - Task 4: User-level dense ranking without gaps using `DENSE_RANK() OVER (PARTITION BY user_id)`
  - Task 5: Top 2 playlists per user filter using window ranking in CTE (Spotify 'Your Top Playlists')

* 📂 [**Session 14: Window Functions - Part 2**](./Assignment/Session_14/)
  - Task 1: DDL `Orders` table and Zomato/Swiggy order history dataset
  - Task 2: Prior order value tracking with `LAG() OVER (PARTITION BY user_id ORDER BY order_date)`
  - Task 3: Subsequent order anticipation with `LEAD() OVER (PARTITION BY user_id ORDER BY order_date)`
  - Task 4: Cumulative lifetime spend with `SUM() OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`
  - Task 5: 3-order moving average calculation using bounded window frames (`ROWS BETWEEN 2 PRECEDING AND CURRENT ROW`)

* 📂 [**Session 15: SQL + Python Integration**](./Assignment/Session_15/)
  - Task 1: SQLite3 standard module integration & `Restaurants` table creation (`foodie.db`)
  - Task 2: DML batch insertion and rating threshold filtering via Python cursor
  - Task 3: Direct tabular loading into Pandas with `pd.read_sql_query` & `df.head(2)`
  - Task 4: Feature engineering: Static delivery charges & conditional rating boosts via `apply()` and lambda
  - Task 5: Automated daily analytics pipeline exporting top-rated restaurants (`rating > 4.5`) to CSV

* 📂 [**Session 16: SQL Project – Sales Analysis**](./Assignment/Session_16/)
  - Task 1: Import food delivery CSV into SQL table `FoodOrders`
  - Task 2: DDL `TopSongs` table and insert 5 popular Spotify tracks
  - Task 3: Identify top 3 customers by total spending with `SUM(order_amount)`
  - Task 4: Restaurant sales performance breakdown (`COUNT`, `SUM`, `GROUP BY`, `ORDER BY`)
  - Task 5: Normalized business KPI summary cards (`UNION ALL` key-value format)

* 📂 [**Session 17: SQL Project – HR Analysis**](./Assignment/Session_17/)
  - Task 1: DDL `Restaurant` table and sample Zomato restaurant dataset
  - Task 2: Cuisine frequency analysis (`COUNT(id) GROUP BY cuisine ORDER BY count DESC`)
  - Task 3: DDL `Review` table with foreign key linkage and 10+ user reviews
  - Task 4: Relational sentiment aggregation with `INNER JOIN` and `AVG(rv.rating)`
  - Task 5: Intra-cuisine ranking using window functions (`DENSE_RANK() OVER (PARTITION BY cuisine)`)

* 📂 [**Session 18: Interview Questions + Final Revision**](./Assignment/Session_18/)
  - Task 1: Upload threshold filtering with `GROUP BY artist_name HAVING COUNT(*) > 3`
  - Task 2: Customer total spend aggregation using `LEFT JOIN` on `users` and `orders`
  - Task 3: Scalar subquery identifying restaurants exceeding catalog mean rating
  - Task 4: Cumulative transaction running total via `SUM() OVER(PARTITION BY user_id)`
  - Task 5: Query optimization strategies: B-Tree composite indexing & SARGable query design

* 📂 [**Case-Study Dataset: Zomato Bangalore Restaurants**](./Assignment/Case_Study_Dataset/)
  - Task 1: Top 5 highest-rated North Indian restaurants in Koramangala
  - Task 2: Top 3 most expensive cuisines by average cost for two
  - Task 3: Operational diagnosis & marketing recovery strategy for sub-3.0 online delivery outlets
  - Task 4: 3-tier demographic market segmentation (Budget, Mid-Range, Premium) via `CASE WHEN`
  - Task 5: Top 10 popular restaurant chains by outlet count (AI-assisted query validation)









