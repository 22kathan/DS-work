"""
============================================================================
SESSION 15 - TASK 5: Automated Daily Summary Script
Description: Connects to foodie.db, extracts restaurants with rating > 4.5,
             and exports the filtered report as top_rated_restaurants.csv.
Author: Kathan Gadhiya <gadhiyakathan10@gmail.com>
============================================================================
"""

import sqlite3
import pandas as pd
import os

DB_PATH = os.path.join(os.path.dirname(__file__), "foodie.db")
OUTPUT_CSV = os.path.join(os.path.dirname(__file__), "top_rated_restaurants.csv")


def export_top_rated_summary():
    """Extracts top rated restaurants and generates a CSV summary report."""
    if not os.path.exists(DB_PATH):
        raise FileNotFoundError(f"Database file not found at {DB_PATH}")

    # Connect to SQLite database
    conn = sqlite3.connect(DB_PATH)

    # Query restaurants with rating above 4.5
    query = "SELECT id, name, cuisine, rating FROM Restaurants WHERE rating > 4.5"
    df_top_rated = pd.read_sql_query(query, conn)
    conn.close()

    # Save to CSV
    df_top_rated.to_csv(OUTPUT_CSV, index=False)
    print(f"[SUCCESS] Exported {len(df_top_rated)} top-rated restaurants to: {OUTPUT_CSV}")
    print(df_top_rated)


if __name__ == "__main__":
    export_top_rated_summary()
