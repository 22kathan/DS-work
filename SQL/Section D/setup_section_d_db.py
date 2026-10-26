"""
Section D: Helper script to set up SQLite database for AI-Augmented Learning task.
Creates orders.db with realistic records, ensuring some restaurants have >= 5 orders
and some have < 5 orders (to validate the HAVING filter).
"""

import os
import sqlite3

def setup_db(db_path):
    conn = sqlite3.connect(db_path)
    cur = conn.cursor()
    
    cur.execute("DROP TABLE IF EXISTS orders;")
    cur.execute("""
    CREATE TABLE orders (
        order_id INTEGER PRIMARY KEY,
        restaurant_name TEXT NOT NULL,
        category TEXT NOT NULL,
        order_value REAL NOT NULL,
        rating REAL NOT NULL,
        delivery_time_mins REAL NOT NULL
    );
    """)
    
    orders = [
        # Biryani Central (6 orders, avg rating ~4.85) -> QUALIFIES
        (101, "Biryani Central", "Indian", 650.0, 4.8, 32.0),
        (102, "Biryani Central", "Indian", 720.0, 5.0, 35.0),
        (103, "Biryani Central", "Indian", 580.0, 4.9, 30.0),
        (104, "Biryani Central", "Indian", 810.0, 4.7, 38.0),
        (105, "Biryani Central", "Indian", 900.0, 4.8, 34.0),
        (106, "Biryani Central", "Indian", 750.0, 4.9, 36.0),

        # Pizza Rustica (5 orders, avg rating ~4.74) -> QUALIFIES
        (107, "Pizza Rustica", "Italian", 850.0, 4.8, 35.0),
        (108, "Pizza Rustica", "Italian", 920.0, 4.9, 38.0),
        (109, "Pizza Rustica", "Italian", 780.0, 4.6, 33.0),
        (110, "Pizza Rustica", "Italian", 890.0, 4.7, 37.0),
        (111, "Pizza Rustica", "Italian", 940.0, 4.7, 40.0),

        # Spice Symphony (5 orders, avg rating ~4.62) -> QUALIFIES
        (112, "Spice Symphony", "Indian", 520.0, 4.6, 28.0),
        (113, "Spice Symphony", "Indian", 610.0, 4.7, 30.0),
        (114, "Spice Symphony", "Indian", 480.0, 4.5, 29.0),
        (115, "Spice Symphony", "Indian", 690.0, 4.8, 33.0),
        (116, "Spice Symphony", "Indian", 550.0, 4.5, 31.0),

        # Burger Republic (5 orders, avg rating ~4.12) -> QUALIFIES, but lower rating
        (117, "Burger Republic", "Fast Food", 280.0, 4.1, 22.0),
        (118, "Burger Republic", "Fast Food", 340.0, 4.2, 25.0),
        (119, "Burger Republic", "Fast Food", 310.0, 4.0, 21.0),
        (120, "Burger Republic", "Fast Food", 290.0, 4.1, 24.0),
        (121, "Burger Republic", "Fast Food", 380.0, 4.2, 26.0),

        # Sushi Wave (ONLY 3 orders, avg rating 5.0!) -> MUST BE FILTERED OUT by HAVING count >= 5
        (122, "Sushi Wave", "Japanese", 1200.0, 5.0, 45.0),
        (123, "Sushi Wave", "Japanese", 1400.0, 5.0, 48.0),
        (124, "Sushi Wave", "Japanese", 1150.0, 5.0, 42.0),

        # Sweet Treats (ONLY 2 orders, avg rating 4.95) -> MUST BE FILTERED OUT by HAVING count >= 5
        (125, "Sweet Treats", "Dessert", 220.0, 5.0, 18.0),
        (126, "Sweet Treats", "Dessert", 260.0, 4.9, 19.0),
    ]
    
    cur.executemany("INSERT INTO orders VALUES (?, ?, ?, ?, ?, ?)", orders)
    conn.commit()
    conn.close()
    print(f"Successfully initialized '{db_path}' with {len(orders)} orders.")

if __name__ == "__main__":
    db_file = os.path.join(os.path.dirname(__file__), "orders.db")
    setup_db(db_file)
