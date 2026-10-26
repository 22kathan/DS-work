"""
Section A - Question S2: NumPy Boolean Indexing & Vectorization
Preferred Language: Python 3 (NumPy)
Assessment: M4-A1 Data Science

Scenario:
You are building a weekly performance report for a food delivery platform. You have a
NumPy array of daily order counts across 30 days. Your manager wants to flag 'surge
days' — days where the order count exceeds the mean by more than 1.5 standard
deviations — and compute the total revenue only for those surge days using a
matching revenue array.
"""

import time
import numpy as np

def main():
    print("=" * 75)
    print("SECTION A - S2: NUMPY VECTORIZATION & BOOLEAN INDEXING")
    print("=" * 75)

    # 1. Setup reproducible arrays for 30 days
    np.random.seed(42)
    daily_order_counts = np.random.randint(100, 801, size=30)
    matching_revenue = np.random.uniform(5000, 50000, size=30).round(2)

    print("\n--- 1. Input Daily Arrays (30 Days) ---")
    print("Daily Orders Array:")
    print(daily_order_counts)
    print("\nMatching Revenue Array ($):")
    print(matching_revenue)

    # 2. Vectorized Statistical Computation
    mean_orders = np.mean(daily_order_counts)
    std_orders = np.std(daily_order_counts)
    surge_threshold = mean_orders + 1.5 * std_orders

    print("\n--- 2. Statistical Analysis ---")
    print(f"Mean Daily Orders (np.mean)          : {mean_orders:.2f}")
    print(f"Standard Deviation (np.std)          : {std_orders:.2f}")
    print(f"Surge Cutoff (Mean + 1.5 * Std Dev)  : {surge_threshold:.2f} orders")

    # 3. Boolean Mask Creation without loops
    # An element-wise evaluation producing a boolean array
    surge_mask = daily_order_counts > surge_threshold

    print("\n--- 3. Boolean Mask Representation ---")
    print(f"Surge Boolean Mask (dtype: {surge_mask.dtype}, shape: {surge_mask.shape}):")
    print(surge_mask)
    print(f"Count of Surge Days Identified: {np.sum(surge_mask)}")

    # 4. Boolean Indexing into Matching Revenue Array
    surge_days_indices = np.where(surge_mask)[0]
    surge_orders = daily_order_counts[surge_mask]
    surge_revenues = matching_revenue[surge_mask]
    total_surge_revenue = np.sum(surge_revenues)

    print("\n--- 4. Surge Days Extracted Data ---")
    for day_idx, orders, rev in zip(surge_days_indices, surge_orders, surge_revenues):
        print(f"  - Day {day_idx:2d}: Orders = {orders} | Revenue = ${rev:,.2f}")

    print(f"\nTotal Combined Revenue on Surge Days: ${total_surge_revenue:,.2f}")

    # 5. Benchmark: NumPy Vectorized vs. Python Explicit Loop (scaled to 1,000,000 elements)
    print("\n--- 5. Performance Benchmark: Vectorized vs. Python Loop (1,000,000 items) ---")
    large_orders = np.random.randint(100, 800, size=1_000_000)
    large_rev = np.random.uniform(5000, 50000, size=1_000_000)
    threshold = np.mean(large_orders) + 1.5 * np.std(large_orders)

    # Method A: NumPy Vectorization
    t0 = time.perf_counter()
    mask = large_orders > threshold
    vec_rev = np.sum(large_rev[mask])
    t_numpy = (time.perf_counter() - t0) * 1000

    # Method B: Pure Python Loop
    t0 = time.perf_counter()
    py_rev = 0.0
    for i in range(len(large_orders)):
        if large_orders[i] > threshold:
            py_rev += large_rev[i]
    t_loop = (time.perf_counter() - t0) * 1000

    speedup = t_loop / t_numpy if t_numpy > 0 else float('inf')
    print(f"NumPy Vectorized Execution Time : {t_numpy:.2f} ms")
    print(f"Python Loop Execution Time       : {t_loop:.2f} ms")
    print(f"Vectorized Speedup Factor        : ~{speedup:.1f}x FASTER than Python loop")
    print("=" * 75)

if __name__ == "__main__":
    main()
