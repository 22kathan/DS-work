"""
============================================================================
SESSION 15: SQL + Python Integration
Preferred Technology: Python 3 + SQLite3 + Pandas
Target Database: foodie.db
Author: Kathan Gadhiya <gadhiyakathan10@gmail.com>
============================================================================
"""

import sqlite3
import pandas as pd
import os

DB_NAME = "foodie.db"
CSV_NAME = "top_rated_restaurants.csv"


def task_1_create_database():
    """
    TASK 1:
    sqlite3 is a built-in module in Python's standard library.
    Create a new database called foodie.db with a table Restaurants (id, name, cuisine, rating).
    """
    print("\n--- TASK 1: Create Database & Restaurants Table ---")
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    cursor.execute("DROP TABLE IF EXISTS Restaurants")
    cursor.execute("""
        CREATE TABLE Restaurants (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            cuisine TEXT NOT NULL,
            rating REAL NOT NULL
        )
    """)
    conn.commit()
    conn.close()
    print(f"Database '{DB_NAME}' created with table 'Restaurants' successfully.")


def task_2_insert_and_fetch():
    """
    TASK 2:
    Insert three sample restaurants into the Restaurants table in foodie.db
    and fetch all restaurants with a rating above 4.0, then print their names.
    """
    print("\n--- TASK 2: Insert 3 Sample Restaurants & Fetch Rating > 4.0 ---")
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    sample_restaurants = [
        (1, "Little Italy", "Italian", 4.7),
        (2, "Honest Restaurant", "North Indian", 4.2),
        (3, "Sankalp South Indian", "South Indian", 3.9)
    ]

    cursor.executemany("""
        INSERT INTO Restaurants (id, name, cuisine, rating) 
        VALUES (?, ?, ?, ?)
    """, sample_restaurants)
    conn.commit()
    print("Inserted 3 sample restaurants successfully.")

    cursor.execute("SELECT name, rating FROM Restaurants WHERE rating > 4.0")
    results = cursor.fetchall()

    print("\nRestaurants with rating > 4.0:")
    for name, rating in results:
        print(f"- {name} (Rating: {rating})")

    conn.close()


def task_3_load_pandas_head():
    """
    TASK 3:
    Load all rows from the Restaurants table in foodie.db into a Pandas DataFrame
    and display the top 2 rows using DataFrame.head().
    """
    print("\n--- TASK 3: Load into Pandas DataFrame & head(2) ---")
    conn = sqlite3.connect(DB_NAME)
    df = pd.read_sql_query("SELECT * FROM Restaurants", conn)
    conn.close()

    print("Top 2 rows from Restaurants table:")
    print(df.head(2))
    return df


def task_4_feature_engineering(df):
    """
    TASK 4:
    Add a new column 'delivery_charge' to your DataFrame, setting it to 50 for all restaurants,
    and then calculate a new column 'final_rating' as rating + (0.1 if cuisine is 'Italian').
    """
    print("\n--- TASK 4: Add 'delivery_charge' & 'final_rating' ---")
    # Setting uniform delivery charge
    df["delivery_charge"] = 50

    # Conditional calculation using apply() with a lambda function
    df["final_rating"] = df.apply(
        lambda row: round(row["rating"] + 0.1, 2) if row["cuisine"] == "Italian" else row["rating"],
        axis=1
    )

    print("Updated DataFrame with 'delivery_charge' and 'final_rating':")
    print(df)
    return df


def task_5_automated_daily_summary():
    """
    TASK 5:
    Automate a daily summary: Connect to foodie.db, fetch all restaurants
    with rating above 4.5, load into a DataFrame, and save as top_rated_restaurants.csv.
    """
    print("\n--- TASK 5: Automate Daily Summary to CSV ---")
    conn = sqlite3.connect(DB_NAME)
    query = "SELECT * FROM Restaurants WHERE rating > 4.5"
    top_rated_df = pd.read_sql_query(query, conn)
    conn.close()

    top_rated_df.to_csv(CSV_NAME, index=False)
    print(f"Top-rated restaurants (rating > 4.5) successfully saved to '{CSV_NAME}':")
    print(top_rated_df)


if __name__ == "__main__":
    task_1_create_database()
    task_2_insert_and_fetch()
    df = task_3_load_pandas_head()
    df_transformed = task_4_feature_engineering(df)
    task_5_automated_daily_summary()
