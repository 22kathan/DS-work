"""
Session 1: Database Introduction & SQL Basics - Verification Script
Verifies tasks 2, 3, and 4 programmatically using SQLite and formats output.
"""

import os
import sqlite3
import pandas as pd
from tabulate import tabulate

def main():
    print("=" * 70)
    print("SESSION 1: DATABASE INTRODUCTION & SQL BASICS VERIFICATION")
    print("=" * 70)

    db_path = os.path.join(os.path.dirname(__file__), "music_streaming_app.db")
    conn = sqlite3.connect(db_path)
    cur = conn.cursor()

    # Task 2: Create Table
    print("\n--- Task 2: Creating 'playlists' Table ---")
    cur.execute("DROP TABLE IF EXISTS playlists;")
    cur.execute("""
    CREATE TABLE playlists (
        playlist_id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        created_by TEXT NOT NULL
    );
    """)
    print("[SUCCESS] Table 'playlists' created successfully.")

    # Task 3: Insert Sample Rows
    print("\n--- Task 3: Inserting Sample Rows ---")
    playlists_data = [
        (1, "Bollywood Hits", "Amit"),
        (2, "Chill Vibes", "Neha"),
        (3, "Workout Mix", "Rohan")
    ]
    cur.executemany("INSERT INTO playlists VALUES (?, ?, ?)", playlists_data)
    conn.commit()
    print(f"[SUCCESS] Inserted {len(playlists_data)} playlists into 'playlists' table.")

    # Display all rows
    all_df = pd.read_sql_query("SELECT * FROM playlists;", conn)
    print("\nCurrent Table Contents:")
    print(tabulate(all_df, headers="keys", tablefmt="psql", showindex=False))

    # Task 4: Query Playlists Created by 'Amit'
    print("\n--- Task 4: SELECT Query with WHERE created_by = 'Amit' ---")
    query = "SELECT playlist_id, name, created_by FROM playlists WHERE created_by = 'Amit';"
    amit_df = pd.read_sql_query(query, conn)
    print(tabulate(amit_df, headers="keys", tablefmt="psql", showindex=False))

    conn.close()
    print("\n" + "=" * 70)
    print("SESSION 1 VERIFICATION COMPLETED SUCCESSFULLY")
    print("=" * 70)

if __name__ == "__main__":
    main()
