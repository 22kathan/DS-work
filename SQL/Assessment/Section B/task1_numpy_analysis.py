"""
Section B - Task 1: Daily Order Analysis with NumPy
Preferred Language: Python 3 (NumPy)
Assessment: M4-A1 Data Science

Requirements:
- Create two NumPy arrays of 30 elements each using np.random.seed(42):
  - daily order counts (integers between 100-800)
  - daily revenue (floats between 5000-50000)
- Calculate & print: total orders, total revenue, mean and std of daily orders,
  and the day number (index) with the highest single-day revenue.
- Boolean indexing: extract all days where order count exceeded mean + 1 standard deviation.
  Print the count of such peak days and their total combined revenue.
- Reshape the 30-element order array into a 5x6 matrix and use np.sum(axis=1)
  to print the total orders for each of the 5 weekly blocks.
"""

import numpy as np

def main():
    print("=" * 70)
    print("SECTION B - TASK 1: DAILY ORDER ANALYSIS WITH NUMPY")
    print("=" * 70)

    # 1. Set seed for exact reproducibility
    np.random.seed(42)

    # Generate daily order counts (integers between 100 and 800 inclusive)
    daily_orders = np.random.randint(100, 801, size=30)

    # Generate daily revenue (floats between 5000 and 50000)
    daily_revenue = np.random.uniform(5000, 50000, size=30).round(2)

    print("\n--- 1. Generated Data (30 Days) ---")
    print("Daily Orders (30 elements):")
    print(daily_orders)
    print("\nDaily Revenue (30 elements in $):")
    print(daily_revenue)

    # 2. Key Statistical Metrics
    total_orders = np.sum(daily_orders)
    total_revenue = np.sum(daily_revenue)
    mean_orders = np.mean(daily_orders)
    std_orders = np.std(daily_orders)
    highest_rev_day_idx = np.argmax(daily_revenue)  # 0-indexed day
    highest_rev_val = daily_revenue[highest_rev_day_idx]

    print("\n--- 2. Order & Revenue Summary Statistics ---")
    print(f"Total Orders across 30 days          : {total_orders:,}")
    print(f"Total Revenue across 30 days         : ${total_revenue:,.2f}")
    print(f"Mean Daily Orders                    : {mean_orders:.2f}")
    print(f"Standard Deviation of Daily Orders   : {std_orders:.2f}")
    print(f"Day with Highest Revenue (Day Index) : Day {highest_rev_day_idx} (${highest_rev_val:,.2f})")

    # 3. Boolean Indexing for Peak Days (Order Count > Mean + 1 Std)
    peak_threshold = mean_orders + 1.0 * std_orders
    peak_mask = daily_orders > peak_threshold
    peak_day_indices = np.where(peak_mask)[0]
    peak_day_count = np.sum(peak_mask)
    peak_combined_revenue = np.sum(daily_revenue[peak_mask])

    print("\n--- 3. Peak Days Analysis (Orders > Mean + 1 Std Dev) ---")
    print(f"Peak Threshold (Mean + 1 Std)        : {peak_threshold:.2f} orders")
    print(f"Number of Peak Days Identified       : {peak_day_count}")
    print(f"Peak Day Indices (0-indexed)         : {peak_day_indices.tolist()}")
    print(f"Order Counts on Peak Days            : {daily_orders[peak_mask].tolist()}")
    print(f"Revenues on Peak Days                : {daily_revenue[peak_mask].tolist()}")
    print(f"Total Combined Revenue on Peak Days  : ${peak_combined_revenue:,.2f}")

    # 4. Reshaping into 5x6 Matrix and Weekly Block Totals
    # 30 elements reshaped into 5 rows (weeks) x 6 columns (days/week)
    orders_matrix_5x6 = daily_orders.reshape(5, 6)
    weekly_block_orders = np.sum(orders_matrix_5x6, axis=1)

    print("\n--- 4. Weekly Blocks Analysis (5x6 Matrix Reshaping) ---")
    print("Reshaped 5x6 Matrix (Rows = Weekly Blocks, Cols = Days):")
    print(orders_matrix_5x6)
    print("\nTotal Orders for each of the 5 Weekly Blocks (np.sum(axis=1)):")
    for block_num, block_total in enumerate(weekly_block_orders, start=1):
        print(f"  • Weekly Block {block_num}: {block_total:,} orders")

    print("\n" + "=" * 70)
    print("TASK 1 COMPLETED SUCCESSFULLY")
    print("=" * 70)

if __name__ == "__main__":
    main()
