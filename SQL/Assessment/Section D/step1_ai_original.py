"""
Section D - Step 1: AI's Original Generated Code
Assessment Code: M4-A1 Data Science

AI Tool: ChatGPT / Claude
Prompt:
"Write a complete Python program that connects to a SQLite database 'orders.db'
containing a food delivery table named 'orders' (columns: order_id, restaurant_name,
category, order_value, rating, delivery_time_mins).
Query the top 3 restaurants by average customer rating (filtering out any with fewer
than 5 orders), load into Pandas, compute each restaurant's revenue share percentage
of the top 3 combined, and plot a horizontal bar chart with the revenue share
percentage as bar labels. Handle cases where the database or rows are missing."
"""

import sqlite3
import pandas as pd
import matplotlib.pyplot as plt

def main():
    # Potential Bug 1: sqlite3.connect creates an empty file if missing,
    # causing an unhandled 'OperationalError: no such table: orders' crash.
    conn = sqlite3.connect("orders.db")

    # Potential Bug 2 (Syntax Error): Placing HAVING before GROUP BY in SQL
    query = """
    SELECT 
        restaurant_name,
        AVG(rating) AS avg_rating,
        SUM(order_value) AS total_revenue
    FROM orders
    HAVING COUNT(order_id) >= 5
    GROUP BY restaurant_name
    ORDER BY avg_rating DESC
    LIMIT 3;
    """

    try:
        df = pd.read_sql_query(query, conn)
    except Exception as e:
        print("Database query failed:", e)
        return

    # Potential Bug 3: No check for empty DataFrame before division and plotting
    # Potential Bug 4: Integer truncation or division issue
    total_rev = int(df['total_revenue'].sum())
    df['revenue_share'] = (df['total_revenue'] // total_rev) * 100  # Integer division bug!

    # Potential Bug 5: Plotting with unlabelled axes and no figure saving
    plt.barh(df['restaurant_name'], df['avg_rating'])
    
    # Missing labels on axes and unlabelled plot
    for i, v in enumerate(df['avg_rating']):
        plt.text(v, i, str(df['revenue_share'][i]) + "%")

    plt.show()
    # Missing conn.close()

if __name__ == "__main__":
    main()
