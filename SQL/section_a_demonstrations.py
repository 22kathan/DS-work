"""
Section A: Concept Application — Code Demonstrations & Verification
Assessment Code: M4-A1
Demonstrating runnable implementations and outputs for questions S1, S2, S4, S5, S6.
"""

import numpy as np
import pandas as pd
import sqlite3

def run_s1_demo():
    print("=" * 60)
    print("SECTION A - S1: Missing Values & Type Casting Demo")
    print("=" * 60)
    # Simulated dataset of orders with missing delivery times and string ratings
    data = {
        'order_id': [101, 102, 103, 104, 105, 106, 107, 108],
        'delivery_time_mins': [25.0, 32.0, np.nan, 45.0, 110.0, np.nan, 28.0, 35.0],
        'customer_rating': ['4.5', '5.0', '3.8', 'invalid_str', '4.2', '4.0', '4.9', '3.5']
    }
    df = pd.DataFrame(data)
    print("Initial DataFrame:")
    print(df)
    print("\nInitial dtypes:")
    print(df.dtypes)
    print(f"\nMissing delivery_time_mins count: {df['delivery_time_mins'].isna().sum()}")

    # 1. Median imputation for right-skewed delivery times
    median_val = df['delivery_time_mins'].median()
    df['delivery_time_mins'] = df['delivery_time_mins'].fillna(median_val)
    print(f"\n[Fixed] Imputed missing delivery_time_mins using median: {median_val:.1f} mins")

    # 2. Type casting for customer_rating to float64 with coercion
    df['customer_rating'] = pd.to_numeric(df['customer_rating'].astype(str).str.strip(), errors='coerce')
    # Impute coerced NaN rating with mean
    df['customer_rating'] = df['customer_rating'].fillna(round(df['customer_rating'].mean(), 1))
    print("[Fixed] Converted customer_rating to float64 (invalid strings coerced to NaN & imputed):")
    print(df)
    print("\nFinal dtypes:")
    print(df.dtypes)
    print()

def run_s2_demo():
    print("=" * 60)
    print("SECTION A - S2: NumPy Vectorized Surge Day Detection")
    print("=" * 60)
    np.random.seed(42)
    # 30 days of daily order counts and revenue
    order_counts = np.random.randint(100, 801, size=30)
    revenue = np.random.uniform(5000, 50000, size=30).round(2)

    mean_orders = np.mean(order_counts)
    std_orders = np.std(order_counts)
    surge_threshold = mean_orders + 1.5 * std_orders

    # Boolean mask without python loop
    surge_mask = order_counts > surge_threshold
    surge_days_indices = np.where(surge_mask)[0]
    surge_revenues = revenue[surge_mask]
    total_surge_revenue = np.sum(surge_revenues)

    print(f"Daily Orders Mean: {mean_orders:.2f}")
    print(f"Daily Orders Std Dev: {std_orders:.2f}")
    print(f"Surge Threshold (Mean + 1.5*Std): {surge_threshold:.2f}")
    print(f"Boolean Mask generated (first 10 days): {surge_mask[:10]}")
    print(f"Surge Days Detected (Day Indices): {surge_days_indices.tolist()}")
    print(f"Order counts on surge days: {order_counts[surge_mask].tolist()}")
    print(f"Revenues on surge days: {surge_revenues.tolist()}")
    print(f"Total Surge Revenue: ${total_surge_revenue:,.2f}")
    print()

def run_sql_demos():
    print("=" * 60)
    print("SECTION A - S4, S5, S6: SQL SQLite Demonstrations")
    print("=" * 60)
    conn = sqlite3.connect(":memory:")
    cursor = conn.cursor()

    # Create tables for S4 and S6
    cursor.execute("""
    CREATE TABLE restaurants (
        restaurant_id INTEGER PRIMARY KEY,
        name TEXT,
        category TEXT,
        city TEXT
    );
    """)
    cursor.execute("""
    CREATE TABLE orders (
        order_id INTEGER PRIMARY KEY,
        restaurant_id INTEGER,
        order_value REAL,
        delivery_time_mins REAL,
        rating REAL
    );
    """)

    # Populate restaurants (including restaurant 4 with 0 orders)
    restaurants_data = [
        (1, 'Pasta Palace', 'Italian', 'New York'),
        (2, 'Burger Barn', 'Fast Food', 'New York'),
        (3, 'Sushi Spot', 'Japanese', 'Chicago'),
        (4, 'Taco Town (Zero Orders)', 'Mexican', 'Chicago'),
        (5, 'Curry Corner', 'Indian', 'New York')
    ]
    cursor.executemany("INSERT INTO restaurants VALUES (?, ?, ?, ?)", restaurants_data)

    orders_data = [
        (101, 1, 45.0, 30.0, 4.5),
        (102, 1, 55.0, 35.0, 4.8),
        (103, 2, 20.0, 18.0, 4.0),
        (104, 2, 25.0, 22.0, 4.2),
        (105, 3, 60.0, 40.0, 4.7),
        (106, 5, 35.0, 28.0, 4.6),
        (107, 5, 40.0, 32.0, 4.3)
    ]
    cursor.executemany("INSERT INTO orders VALUES (?, ?, ?, ?, ?)", orders_data)
    conn.commit()

    # --- S4 DEMO: LEFT JOIN vs INNER JOIN ---
    print("--- S4: LEFT JOIN (includes restaurants with 0 orders) ---")
    query_left_join = """
    SELECT 
        r.restaurant_id,
        r.name AS restaurant_name,
        COALESCE(SUM(o.order_value), 0.0) AS total_revenue
    FROM restaurants r
    LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
    GROUP BY r.restaurant_id, r.name
    ORDER BY total_revenue DESC;
    """
    df_s4_left = pd.read_sql_query(query_left_join, conn)
    print(df_s4_left.to_string(index=False))

    print("\n--- S4: Comparison with INNER JOIN (drops Taco Town) ---")
    query_inner_join = """
    SELECT 
        r.restaurant_id,
        r.name AS restaurant_name,
        SUM(o.order_value) AS total_revenue
    FROM restaurants r
    INNER JOIN orders o ON r.restaurant_id = o.restaurant_id
    GROUP BY r.restaurant_id, r.name
    ORDER BY total_revenue DESC;
    """
    df_s4_inner = pd.read_sql_query(query_inner_join, conn)
    print(df_s4_inner.to_string(index=False))

    # --- S5 DEMO: WINDOW FUNCTIONS (DENSE_RANK & LAG) ---
    print("\n--- S5: Window Functions (DENSE_RANK & LAG with PARTITION BY) ---")
    cursor.execute("""
    CREATE TABLE delivery_agents (
        agent_id INTEGER PRIMARY KEY,
        agent_name TEXT,
        city TEXT,
        completed_deliveries INTEGER
    );
    """)
    agents_data = [
        (1, 'Alex', 'New York', 145),
        (2, 'Jordan', 'New York', 130),
        (3, 'Taylor', 'New York', 115),
        (4, 'Casey', 'Chicago', 150),
        (5, 'Morgan', 'Chicago', 140),
        (6, 'Riley', 'Chicago', 110)
    ]
    cursor.executemany("INSERT INTO delivery_agents VALUES (?, ?, ?, ?)", agents_data)
    conn.commit()

    query_s5 = """
    SELECT 
        agent_name,
        city,
        completed_deliveries,
        DENSE_RANK() OVER (
            PARTITION BY city 
            ORDER BY completed_deliveries DESC
        ) AS city_rank,
        LAG(completed_deliveries, 1) OVER (
            PARTITION BY city 
            ORDER BY completed_deliveries DESC
        ) AS prev_agent_deliveries,
        COALESCE(LAG(completed_deliveries, 1) OVER (
            PARTITION BY city 
            ORDER BY completed_deliveries DESC
        ) - completed_deliveries, 0) AS gap_to_above_agent
    FROM delivery_agents;
    """
    df_s5 = pd.read_sql_query(query_s5, conn)
    print(df_s5.to_string(index=False))

    # --- S6 DEMO: CTE vs SUBQUERY ---
    print("\n--- S6: CTE (WITH clause) for Top Categories ---")
    query_s6_cte = """
    WITH top_categories AS (
        SELECT r.category, COUNT(o.order_id) AS total_orders
        FROM orders o
        JOIN restaurants r ON o.restaurant_id = r.restaurant_id
        GROUP BY r.category
        ORDER BY total_orders DESC
        LIMIT 2
    )
    SELECT 
        o.order_id,
        r.name AS restaurant_name,
        r.category,
        o.order_value
    FROM orders o
    JOIN restaurants r ON o.restaurant_id = r.restaurant_id
    JOIN top_categories t ON r.category = t.category;
    """
    df_s6 = pd.read_sql_query(query_s6_cte, conn)
    print(df_s6.to_string(index=False))

    conn.close()

if __name__ == "__main__":
    run_s1_demo()
    run_s2_demo()
    run_sql_demos()
