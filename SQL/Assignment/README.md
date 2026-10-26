# SQL Coursework & Assignments

This directory contains weekly session assignments and practical database coursework.

---

## 📁 Assignments Index

| Session | Topic | Key Concepts | Status | Link |
| :---: | :--- | :--- | :---: | :---: |
| **01** | **Database Introduction & SQL Basics** | • Database Creation (`music_streaming_app`)<br>• DDL: `CREATE TABLE playlists`<br>• DML: `INSERT INTO playlists`<br>• DQL: `SELECT ... WHERE created_by = 'Amit'`<br>• Concept Analysis: Table vs. Row vs. Column (Zomato Example) | ✅ **Completed** | [Session 01](./Session_01/) |
| **02** | **Database Setup + CREATE TABLE** | • MySQL Environment Setup & Verification<br>• Database Creation (`foodie_app`)<br>• Zomato-style `restaurants` Table (`DECIMAL`, constraints)<br>• Flipkart-style `users` Table (`UNIQUE`, `VARCHAR` phone, `TIMESTAMP`)<br>• Intentional Syntax Error & Error Resolution (`ERROR 1064`) | ✅ **Completed** | [Session 02](./Session_02/) |
| **03** | **INSERT, UPDATE & DELETE** | • DML Operations on `Playlist` table<br>• Multi-row `INSERT` for Spotify tracks<br>• Targeted `UPDATE` with `WHERE` for typo correction<br>• Safe `DELETE` with duration threshold (< 120s)<br>• Compound condition `UPDATE` with `CONCAT()` & `AND` | ✅ **Completed** | [Session 03](./Session_03/) |
| **04** | **SELECT Statement Basics** | • Full Projections (`SELECT * FROM MusicPlaylist`)<br>• Column Projection with `LIMIT 3`<br>• De-duplication using `DISTINCT restaurant`<br>• Output Aliases (`AS Dish`, `` `Date Ordered` ``)<br>• Troubleshooting `DISTINCT` + `LIMIT` syntax & non-deterministic queries | ✅ **Completed** | [Session 04](./Session_04/) |
| **05** | **WHERE Clause + LIKE** | • Filtering with relational operators (`rating > 4.0`)<br>• Compound conditions & operator precedence (`AND (city = ... OR ...)` / `IN`)<br>• Pattern matching with wildcards (`LIKE 'Swa%'`)<br>• Range testing (`BETWEEN 3.5 AND 4.5`)<br>• Set membership testing (`IN ('Chinese', 'Italian', 'South Indian')`) | ✅ **Completed** | [Session 05](./Session_05/) |
