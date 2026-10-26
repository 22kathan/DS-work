"""
Section B - Task 4: SQL + Python Restaurant Performance Report
Preferred Language: Python 3 (sqlite3 & pandas) + SQL (SQLite)
Assessment: M4-A1 Data Science

Requirements:
- Using Python's sqlite3 module, create database food_delivery.db with two tables:
  restaurants (restaurant_id INTEGER PRIMARY KEY, name TEXT, category TEXT, city TEXT)
  orders (order_id INTEGER PRIMARY KEY, restaurant_id INTEGER, order_value REAL,
          delivery_time_mins REAL, rating REAL).
- Insert at least 8 restaurants and 25 orders.
- Write a SQL query using GROUP BY with COUNT(), SUM(), ROUND(AVG(), 2) to compute:
  total_orders, total_revenue, and avg_rating per restaurant.
- Load the result into a Pandas DataFrame using pd.read_sql_query().
- Add a rank column:
  df['revenue_rank'] = df['total_revenue'].rank(ascending=False, method='min').astype(int)
- Sort by rank ascending and print full table.
- Print Top 5 restaurants by total revenue in a formatted table.
- Export complete report to restaurant_performance_report.csv using df.to_csv(index=False).
"""

import os
import sqlite3
import pandas as pd
from tabulate import tabulate

def main():
    print("=" * 80)
    print("SECTION B - TASK 4: SQL + PYTHON RESTAURANT PERFORMANCE REPORT")
    print("=" * 80)

    db_path = os.path.join(os.path.dirname(__file__), "food_delivery.db")
    csv_path = os.path.join(os.path.dirname(__file__), "restaurant_performance_report.csv")

    # Connect to SQLite database
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Drop existing tables to ensure clean execution
    cursor.execute("DROP TABLE IF EXISTS orders;")
    cursor.execute("DROP TABLE IF EXISTS restaurants;")

    # 1. Create tables
    cursor.execute("""
    CREATE TABLE restaurants (
        restaurant_id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        city TEXT NOT NULL
    );
    """)

    cursor.execute("""
    CREATE TABLE orders (
        order_id INTEGER PRIMARY KEY,
        restaurant_id INTEGER,
        order_value REAL NOT NULL,
        delivery_time_mins REAL NOT NULL,
        rating REAL NOT NULL,
        FOREIGN KEY (restaurant_id) REFERENCES restaurants (restaurant_id)
    );
    """)

    # 2. Insert at least 8 restaurants (we insert 10 for rich analytical depth)
    restaurants = [
        (1, "Spice Symphony", "Indian", "Mumbai"),
        (2, "Burger Republic", "Fast Food", "Delhi"),
        (3, "Pizza Rustica", "Italian", "Bangalore"),
        (4, "Dragon Express", "Chinese", "Mumbai"),
        (5, "Sushi Wave", "Japanese", "Bangalore"),
        (6, "Taco Fiesta", "Mexican", "Delhi"),
        (7, "Sweet Treats", "Dessert", "Mumbai"),
        (8, "Biryani Central", "Indian", "Hyderabad"),
        (9, "Wok & Roll", "Chinese", "Delhi"),
        (10, "Green Bowl Organics", "Salad", "Bangalore")
    ]
    cursor.executemany("INSERT INTO restaurants VALUES (?, ?, ?, ?)", restaurants)

    # 3. Insert at least 25 orders (we insert 30 orders across restaurants)
    orders = [
        # (order_id, restaurant_id, order_value, delivery_time_mins, rating)
        (101, 1, 650.0, 32.0, 4.6),
        (102, 1, 480.0, 28.0, 4.4),
        (103, 1, 720.0, 35.0, 4.8),
        (104, 1, 550.0, 30.0, 4.5),
        (105, 2, 290.0, 22.0, 4.1),
        (106, 2, 340.0, 25.0, 4.2),
        (107, 2, 410.0, 20.0, 4.0),
        (108, 3, 850.0, 38.0, 4.7),
        (109, 3, 920.0, 42.0, 4.9),
        (110, 3, 760.0, 36.0, 4.6),
        (111, 4, 380.0, 29.0, 3.8),
        (112, 4, 450.0, 31.0, 4.0),
        (113, 5, 1400.0, 45.0, 4.9),
        (114, 5, 1250.0, 40.0, 4.8),
        (115, 5, 1600.0, 50.0, 5.0),
        (116, 6, 320.0, 24.0, 4.2),
        (117, 6, 280.0, 26.0, 4.1),
        (118, 7, 210.0, 18.0, 4.9),
        (119, 7, 260.0, 19.0, 4.8),
        (120, 8, 780.0, 34.0, 4.7),
        (121, 8, 690.0, 37.0, 4.5),
        (122, 8, 840.0, 33.0, 4.8),
        (123, 8, 590.0, 31.0, 4.6),
        (124, 9, 310.0, 27.0, 3.9),
        (125, 9, 420.0, 30.0, 4.1),
        (126, 10, 350.0, 25.0, 4.3),
        (127, 3, 670.0, 34.0, 4.5),
        (128, 5, 950.0, 38.0, 4.7),
        (129, 2, 380.0, 23.0, 4.3),
        (130, 8, 920.0, 39.0, 4.9)
    ]
    cursor.executemany("INSERT INTO orders VALUES (?, ?, ?, ?, ?)", orders)
    conn.commit()

    print(f"Successfully inserted {len(restaurants)} restaurants and {len(orders)} orders into '{db_path}'.")

    # 4. Write and Execute SQL Query with GROUP BY, COUNT, SUM, ROUND(AVG(), 2)
    sql_query = """
    SELECT 
        r.restaurant_id,
        r.name AS restaurant_name,
        r.category,
        r.city,
        COUNT(o.order_id) AS total_orders,
        COALESCE(ROUND(SUM(o.order_value), 2), 0.0) AS total_revenue,
        COALESCE(ROUND(AVG(o.rating), 2), 0.0) AS avg_rating
    FROM restaurants r
    LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
    GROUP BY r.restaurant_id, r.name, r.category, r.city;
    """

    # 5. Load result into Pandas DataFrame
    df = pd.read_sql_query(sql_query, conn)

    # 6. Add revenue_rank column
    df['revenue_rank'] = df['total_revenue'].rank(ascending=False, method='min').astype(int)

    # Sort by rank ascending
    df = df.sort_values(by='revenue_rank', ascending=True).reset_index(drop=True)

    print("\n--- 1. Full Ranked Restaurant Performance Table ---")
    print(tabulate(df, headers='keys', tablefmt='psql', showindex=False))

    # 7. Print Top 5 Restaurants by Total Revenue
    top_5_df = df.head(5)
    print("\n--- 2. Top 5 Restaurants by Total Revenue ---")
    print(tabulate(top_5_df, headers='keys', tablefmt='psql', showindex=False))

    # 8. Export complete report to CSV using df.to_csv(index=False)
    df.to_csv(csv_path, index=False)
    print(f"\n[CONFIRMATION] Successfully exported complete report to CSV:")
    print(f" -> {os.path.abspath(csv_path)}")

    conn.close()
    print("\n" + "=" * 80)
    print("TASK 4 COMPLETED SUCCESSFULLY")
    print("=" * 80)

if __name__ == "__main__":
    main()
