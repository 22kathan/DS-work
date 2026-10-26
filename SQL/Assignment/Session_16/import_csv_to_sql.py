"""
============================================================================
SESSION 16: SQL Project – Sales Analysis
Python Integration & CSV Import Script
Database: sales_analysis.db (SQLite) / session16_db (MySQL)
Author: Kathan Gadhiya <gadhiyakathan10@gmail.com>
============================================================================
"""

import sqlite3
import pandas as pd
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
CSV_FILE = os.path.join(BASE_DIR, "food_orders_data.csv")
DB_FILE = os.path.join(BASE_DIR, "sales_analysis.db")


def task_1_import_csv_to_sql():
    """Import CSV of food delivery orders into SQL table FoodOrders."""
    print("\n--- TASK 1: Import CSV into SQL Table 'FoodOrders' ---")
    if not os.path.exists(CSV_FILE):
        raise FileNotFoundError(f"CSV file not found: {CSV_FILE}")

    # Read CSV using Pandas
    df_orders = pd.read_csv(CSV_FILE)
    print(f"Loaded {len(df_orders)} rows from {os.path.basename(CSV_FILE)}.")

    # Connect to SQLite database
    conn = sqlite3.connect(DB_FILE)
    
    # Write to SQL table 'FoodOrders'
    df_orders.to_sql("FoodOrders", conn, if_exists="replace", index=False)
    print("Table 'FoodOrders' successfully created and populated in SQL database.")

    # Verify table
    df_check = pd.read_sql_query("SELECT * FROM FoodOrders", conn)
    print("\nInitial 5 rows in FoodOrders table:")
    print(df_check.head())
    conn.close()


def task_2_create_top_songs():
    """Create table TopSongs and insert at least 5 popular Spotify tracks."""
    print("\n--- TASK 2: Create Table 'TopSongs' & Insert Spotify Records ---")
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()

    cursor.execute("DROP TABLE IF EXISTS TopSongs")
    cursor.execute("""
        CREATE TABLE TopSongs (
            song_id INTEGER PRIMARY KEY,
            song_title TEXT NOT NULL,
            artist TEXT NOT NULL,
            streams BIGINT NOT NULL,
            release_date DATE NOT NULL
        )
    """)

    songs = [
        (1, "Blinding Lights", "The Weeknd", 4200000000, "2019-11-29"),
        (2, "Shape of You", "Ed Sheeran", 3800000000, "2017-01-06"),
        (3, "Starboy", "The Weeknd", 3100000000, "2016-09-21"),
        (4, "As It Was", "Harry Styles", 3000000000, "2022-04-01"),
        (5, "Stay", "The Kid LAROI & Justin Bieber", 2900000000, "2021-07-09")
    ]

    cursor.executemany("INSERT INTO TopSongs VALUES (?, ?, ?, ?, ?)", songs)
    conn.commit()

    df_songs = pd.read_sql_query("SELECT * FROM TopSongs", conn)
    print(df_songs)
    conn.close()


def task_3_top_3_customers():
    """Find top 3 customers who ordered the most based on total order_amount."""
    print("\n--- TASK 3: Top 3 Customers by Total Order Amount ---")
    conn = sqlite3.connect(DB_FILE)
    query = """
        SELECT 
            customer_name, 
            ROUND(SUM(order_amount), 2) AS total_spent
        FROM FoodOrders
        GROUP BY customer_name
        ORDER BY total_spent DESC
        LIMIT 3;
    """
    df_top_customers = pd.read_sql_query(query, conn)
    print(df_top_customers)
    conn.close()


def task_4_product_performance_report():
    """List each restaurant_name, number of orders, and total order_amount ordered descending."""
    print("\n--- TASK 4: Product / Restaurant Performance Report ---")
    conn = sqlite3.connect(DB_FILE)
    query = """
        SELECT 
            restaurant_name,
            COUNT(order_id) AS total_orders,
            ROUND(SUM(order_amount), 2) AS total_order_amount
        FROM FoodOrders
        GROUP BY restaurant_name
        ORDER BY total_order_amount DESC;
    """
    df_report = pd.read_sql_query(query, conn)
    print(df_report)
    conn.close()


def task_5_dashboard_kpis():
    """Calculate KPIs: average order_amount and total number of unique customers."""
    print("\n--- TASK 5: Dashboard KPIs Display ---")
    conn = sqlite3.connect(DB_FILE)
    query = """
        SELECT 
            'Average Order Amount (INR)' AS kpi_name,
            CAST(ROUND(AVG(order_amount), 2) AS TEXT) AS kpi_value
        FROM FoodOrders
        UNION ALL
        SELECT 
            'Total Unique Customers' AS kpi_name,
            CAST(COUNT(DISTINCT customer_name) AS TEXT) AS kpi_value
        FROM FoodOrders;
    """
    df_kpi = pd.read_sql_query(query, conn)
    print(df_kpi)
    conn.close()


if __name__ == "__main__":
    task_1_import_csv_to_sql()
    task_2_create_top_songs()
    task_3_top_3_customers()
    task_4_product_performance_report()
    task_5_dashboard_kpis()
