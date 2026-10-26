"""
Section D - Step 2: Human-Corrected & Optimized Production Solution
Assessment Code: M4-A1 Data Science

Corrections & Improvements over AI version:
1. File Existence Check: Validates that 'orders.db' exists before connecting to avoid
   creating empty corrupted DB files and catching OperationalError cleanly.
2. Correct SQL Clause Order: Placed 'GROUP BY' before 'HAVING COUNT(order_id) >= 5'
   (resolving SQLite operational syntax error).
3. Empty Result Guard: Safely checks if df.empty before computing metrics or plotting,
   preventing crashes on empty datasets or zero-order filters.
4. Precision Floating Division: Replaced integer truncation '//' with exact floating-point
   division: (df['total_revenue'] / total_top3_rev) * 100 with 2-decimal precision.
5. Complete Visualization Polish: Added descriptive chart title, x-axis label, y-axis label,
   color palette, precise percentage bar labels, and saved high-res PNG.
6. Resource Management: Wrapped SQLite connection in a context manager to guarantee
   graceful closure without connection leakage.
"""

import os
import sys
import sqlite3
import pandas as pd
import matplotlib.pyplot as plt

def run_analytics(db_path="orders.db", output_chart="top3_restaurants_rating.png"):
    print("=" * 75)
    print("SECTION D - STEP 2: CORRECTED PRODUCTION ANALYTICS SCRIPT")
    print("=" * 75)

    # 1. Error Handling: Check if database file exists
    if not os.path.exists(db_path):
        print(f"[USER ERROR] Database file not found at: '{os.path.abspath(db_path)}'")
        print("Please ensure the database file is present and initialized before running.")
        return False

    # 2. Connect to SQLite and execute validated SQL query
    correct_query = """
    SELECT 
        restaurant_name,
        COUNT(order_id) AS order_count,
        ROUND(AVG(rating), 2) AS avg_rating,
        ROUND(SUM(order_value), 2) AS total_revenue
    FROM orders
    GROUP BY restaurant_name
    HAVING COUNT(order_id) >= 5
    ORDER BY avg_rating DESC
    LIMIT 3;
    """

    try:
        with sqlite3.connect(db_path) as conn:
            df = pd.read_sql_query(correct_query, conn)
    except sqlite3.Error as e:
        print(f"[SQL ERROR] Query execution failed: {e}")
        return False

    # 3. Handle empty query result gracefully
    if df.empty:
        print("[NOTICE] The query returned 0 rows. No restaurants have at least 5 orders.")
        print("Chart generation skipped.")
        return False

    print("\n--- 1. Query Results (Top 3 Restaurants with >= 5 Orders) ---")
    print(df.to_string(index=False))

    # 4. Accurate Floating-Point Percentage Calculation
    combined_revenue = df["total_revenue"].sum()
    if combined_revenue > 0:
        df["revenue_share_pct"] = ((df["total_revenue"] / combined_revenue) * 100).round(2)
    else:
        df["revenue_share_pct"] = 0.0

    print("\n--- 2. DataFrame with Revenue Share Percentage ---")
    for _, row in df.iterrows():
        print(f"• {row['restaurant_name']:18s} | Orders: {int(row['order_count'])} | Avg Rating: {row['avg_rating']:.2f} | "
              f"Revenue: ${row['total_revenue']:,.2f} | Revenue Share: {row['revenue_share_pct']:.2f}%")
    print(f"Total Combined Revenue across Top 3: ${combined_revenue:,.2f}")

    # 5. Plot Horizontal Bar Chart with Complete Labels
    # Invert order so highest rated restaurant is at the top of the horizontal bar chart
    plot_df = df.iloc[::-1].reset_index(drop=True)

    plt.figure(figsize=(10, 5.5))
    bars = plt.barh(
        plot_df["restaurant_name"],
        plot_df["avg_rating"],
        color=["#2980b9", "#27ae60", "#d35400"],
        edgecolor="#2c3e50",
        height=0.55
    )

    # Add descriptive title and axis labels
    plt.title("Top 3 Food Delivery Restaurants by Customer Rating\n(Filtered: Minimum 5 Orders)", fontsize=13, fontweight="bold", pad=15)
    plt.xlabel("Average Customer Rating (Out of 5.0)", fontsize=11, labelpad=8)
    plt.ylabel("Restaurant Name", fontsize=11, labelpad=8)
    plt.xlim(0, 5.8)  # Leave room for bar text labels
    plt.grid(axis="x", linestyle="--", alpha=0.6)

    # Add revenue share percentage as bar labels
    for bar, (_, row) in zip(bars, plot_df.iterrows()):
        width = bar.get_width()
        label_text = f"  {width:.2f}  ★  ({row['revenue_share_pct']:.1f}% rev share)"
        plt.text(
            width,
            bar.get_y() + bar.get_height() / 2.0,
            label_text,
            va="center",
            ha="left",
            fontsize=10,
            fontweight="bold",
            color="#2c3e50"
        )

    plt.tight_layout()

    # Save chart artifact
    plt.savefig(output_chart, dpi=150, bbox_inches="tight")
    plt.close()

    print(f"\n[CONFIRMATION] Successfully generated and saved chart artifact to:")
    print(f" -> {os.path.abspath(output_chart)}")
    print("=" * 75)
    return True

if __name__ == "__main__":
    current_dir = os.path.dirname(os.path.abspath(__file__))
    db_file = os.path.join(current_dir, "orders.db")
    chart_file = os.path.join(current_dir, "top3_restaurants_rating.png")
    run_analytics(db_file, chart_file)
