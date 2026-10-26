"""
Section A - Question S1: Data Cleaning Strategy with Pandas
Preferred Language: Python 3 (Pandas)
Assessment: M4-A1 Data Science

Scenario:
You are a Data Analyst at a food delivery startup. You have loaded a dataset of 50,000
order records into a Pandas DataFrame. The 'delivery_time_mins' column has 14% missing
values, and the 'customer_rating' column contains some entries stored as strings
(e.g., '4.5') instead of float64.
"""

import numpy as np
import pandas as pd

def main():
    print("=" * 75)
    print("SECTION A - S1: PANDAS DATA CLEANING STRATEGY IMPLEMENTATION")
    print("=" * 75)

    # 1. Simulate dataset matching the scenario (50,000 rows, 14% missing delivery_time_mins)
    np.random.seed(42)
    n_records = 50000

    # Right-skewed delivery times (log-normal distribution: typical 25-40 mins, long tail up to 120 mins)
    simulated_delivery_times = np.random.lognormal(mean=3.45, sigma=0.35, size=n_records).round(1)
    simulated_delivery_times = np.clip(simulated_delivery_times, 15.0, 130.0)

    # Inject exactly 14% missing values
    missing_indices = np.random.choice(n_records, size=int(0.14 * n_records), replace=False)
    simulated_delivery_times[missing_indices] = np.nan

    # Customer ratings with mixed string representations (e.g. '4.5', '3.8', and occasional dirty strings like 'NA', '4.0 ')
    base_ratings = np.random.choice([3.0, 3.5, 4.0, 4.2, 4.5, 4.8, 5.0], size=n_records)
    string_ratings = [str(r) if np.random.rand() > 0.1 else f"{r} " for r in base_ratings]
    # Introduce dirty non-numeric strings
    for idx in np.random.choice(n_records, size=50, replace=False):
        string_ratings[idx] = np.random.choice(['NA', 'null', 'None', 'missing', '?'])

    df = pd.DataFrame({
        'order_id': np.arange(100001, 100001 + n_records),
        'delivery_time_mins': simulated_delivery_times,
        'customer_rating': string_ratings
    })

    print(f"\n--- Initial Dataset Inspection (Total Records: {len(df):,}) ---")
    print(df.head(6).to_string(index=False))
    print("\nInitial Data Types:")
    print(df.dtypes)

    null_count_before = df['delivery_time_mins'].isna().sum()
    null_pct_before = (null_count_before / len(df)) * 100
    print(f"\nMissing 'delivery_time_mins': {null_count_before:,} rows ({null_pct_before:.1f}%)")

    # 2. Skewness and Distribution Check
    mean_delivery = df['delivery_time_mins'].mean()
    median_delivery = df['delivery_time_mins'].median()
    skew_delivery = df['delivery_time_mins'].skew()

    print("\n--- Distribution Metrics for 'delivery_time_mins' ---")
    print(f"Mean Delivery Time   : {mean_delivery:.2f} mins (sensitive to high outliers)")
    print(f"Median Delivery Time : {median_delivery:.2f} mins (robust to outliers)")
    print(f"Skewness Coefficient : {skew_delivery:.2f} (positive value indicates right-skewed)")

    # 3. Strategy Execution: Impute using Median (Dropping 7,000 rows loses 14% sample size)
    df['delivery_time_mins'] = df['delivery_time_mins'].fillna(median_delivery)
    print(f"\n[Fixed] Imputed missing values using Median: {median_delivery:.2f} mins")
    print(f"Missing 'delivery_time_mins' count AFTER imputation: {df['delivery_time_mins'].isna().sum()}")

    # 4. Fix 'customer_rating' Column Type to float64
    print("\n--- Fixing 'customer_rating' Column Type ---")
    # Clean whitespace and safely coerce invalid strings to NaN
    df['customer_rating'] = pd.to_numeric(df['customer_rating'].astype(str).str.strip(), errors='coerce')

    # Impute any coerced NaNs with rounded mean rating
    rating_mean = round(df['customer_rating'].mean(), 1)
    df['customer_rating'] = df['customer_rating'].fillna(rating_mean)

    print(f"[Fixed] Converted 'customer_rating' to numeric dtype: {df['customer_rating'].dtype}")
    print(f"Sample of Cleaned Ratings (first 6 rows):")
    print(df[['order_id', 'delivery_time_mins', 'customer_rating']].head(6).to_string(index=False))

    print("\nFinal Data Types:")
    print(df.dtypes)
    print("=" * 75)

if __name__ == "__main__":
    main()
