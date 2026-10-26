"""
Section B - Task 2: Food Delivery Orders Data Cleaning Pipeline
Preferred Language: Python 3 (Pandas)
Assessment: M4-A1 Data Science

Requirements:
- Create a DataFrame of at least 20 rows with columns:
  order_id, customer_name, restaurant_name, category, delivery_time_mins, order_value, rating.
- Manually introduce at least 4 missing values across numeric and categorical columns and 3 duplicate rows.
- Handle missing values:
  - fill delivery_time_mins and order_value with their column medians
  - fill rating with its mean (rounded to 1 decimal)
  - fill category with the column mode
  - Print null count before and after filling.
- Remove duplicate rows using drop_duplicates() and print DataFrame shape before and after deduplication.
- Detect outliers in order_value using IQR method (Q1 - 1.5*IQR and Q3 + 1.5*IQR).
  Print the outlier rows and cap all outliers at the upper fence value using clip().
"""

import numpy as np
import pandas as pd

def main():
    print("=" * 75)
    print("SECTION B - TASK 2: FOOD DELIVERY ORDERS DATA CLEANING PIPELINE")
    print("=" * 75)

    # 1. Create simulated raw dataset with at least 20 rows, 4+ missing values, and 3 duplicates
    raw_data = [
        # (order_id, customer_name, restaurant_name, category, delivery_time_mins, order_value, rating)
        (101, "Aarav Sharma", "Spice Symphony", "Indian", 32.0, 450.0, 4.5),
        (102, "Diya Patel", "Burger Republic", "Fast Food", 22.0, 280.0, 4.2),
        (103, "Rohan Mehta", "Pizza Rustica", "Italian", np.nan, 850.0, 4.8),      # Missing delivery_time
        (104, "Ananya Iyer", "Dragon Express", "Chinese", 45.0, np.nan, 3.9),      # Missing order_value
        (105, "Kabir Singh", "Sushi Wave", "Japanese", 38.0, 1200.0, np.nan),      # Missing rating
        (106, "Neha Verma", "Taco Fiesta", np.nan, 29.0, 320.0, 4.0),              # Missing category
        (107, "Vikram Rao", "Spice Symphony", "Indian", 35.0, 620.0, 4.6),
        (108, "Pooja Joshi", "Sweet Treats", "Dessert", 18.0, 210.0, 4.9),
        (109, "Aditya Nair", "Burger Republic", "Fast Food", 26.0, 310.0, 4.1),
        (110, "Sanya Kapoor", "Pizza Rustica", "Italian", np.nan, 780.0, 4.4),     # Additional missing delivery_time
        (111, "Aryan Gupta", "Biryani Central", "Indian", 42.0, 540.0, 4.7),
        (112, "Tanvi Shah", "Dragon Express", "Chinese", 30.0, 460.0, 3.8),
        (113, "Kunal Bhatia", "Sushi Wave", "Japanese", 50.0, 3800.0, 4.9),        # Extreme order_value outlier
        (114, "Isha Sen", "Taco Fiesta", "Mexican", 25.0, 350.0, 4.3),
        (115, "Varun Chawla", "Spice Symphony", "Indian", 33.0, 580.0, 4.5),
        (116, "Riya Reddy", "Burger Republic", "Fast Food", 21.0, 290.0, 4.0),
        (117, "Manish Jain", "Pizza Rustica", "Italian", 40.0, 4200.0, 4.6),       # Extreme order_value outlier
        (118, "Priya Kulkarni", "Sweet Treats", "Dessert", 19.0, 240.0, 4.8),
        (119, "Siddharth Das", "Biryani Central", "Indian", 36.0, 610.0, 4.4),
        (120, "Meera Nambiar", "Dragon Express", "Chinese", 28.0, 490.0, 4.2),
        # 3 Duplicate rows:
        (101, "Aarav Sharma", "Spice Symphony", "Indian", 32.0, 450.0, 4.5),       # Duplicate of row 101
        (108, "Pooja Joshi", "Sweet Treats", "Dessert", 18.0, 210.0, 4.9),         # Duplicate of row 108
        (115, "Varun Chawla", "Spice Symphony", "Indian", 33.0, 580.0, 4.5),       # Duplicate of row 115
    ]

    columns = [
        "order_id", "customer_name", "restaurant_name", "category",
        "delivery_time_mins", "order_value", "rating"
    ]
    df = pd.DataFrame(raw_data, columns=columns)

    print("\n--- 1. Initial Raw Dataset (Shape: {}) ---".format(df.shape))
    print(df.head(10).to_string(index=False))
    print(f"\nTotal Rows: {len(df)} | Columns: {len(df.columns)}")

    # 2. Inspect and Handle Missing Values
    print("\n--- 2. Missing Values Analysis & Imputation ---")
    print("Null count BEFORE filling:")
    print(df.isna().sum())

    # Strategy calculations
    med_delivery = df["delivery_time_mins"].median()
    med_order_val = df["order_value"].median()
    mean_rating = round(df["rating"].mean(), 1)
    mode_category = df["category"].mode()[0]

    print(f"\nCalculated Imputation Parameters:")
    print(f"  - delivery_time_mins median : {med_delivery:.1f}")
    print(f"  - order_value median        : {med_order_val:.2f}")
    print(f"  - rating mean (rounded)     : {mean_rating:.1f}")
    print(f"  - category mode             : '{mode_category}'")

    # Apply imputations
    df["delivery_time_mins"] = df["delivery_time_mins"].fillna(med_delivery)
    df["order_value"] = df["order_value"].fillna(med_order_val)
    df["rating"] = df["rating"].fillna(mean_rating)
    df["category"] = df["category"].fillna(mode_category)

    print("\nNull count AFTER filling:")
    print(df.isna().sum())

    # 3. Deduplication
    print("\n--- 3. Deduplication ---")
    shape_before = df.shape
    df = df.drop_duplicates()
    shape_after = df.shape

    print(f"DataFrame Shape BEFORE deduplication : {shape_before}")
    print(f"DataFrame Shape AFTER deduplication  : {shape_after}")
    print(f"Duplicates removed                   : {shape_before[0] - shape_after[0]} rows")

    # 4. Outlier Detection and Capping via IQR
    print("\n--- 4. Outlier Detection & Capping in order_value (IQR Method) ---")
    Q1 = df["order_value"].quantile(0.25)
    Q3 = df["order_value"].quantile(0.75)
    IQR = Q3 - Q1
    lower_fence = Q1 - 1.5 * IQR
    upper_fence = Q3 + 1.5 * IQR

    print(f"Q1 (25th percentile) : {Q1:.2f}")
    print(f"Q3 (75th percentile) : {Q3:.2f}")
    print(f"IQR (Q3 - Q1)        : {IQR:.2f}")
    print(f"Lower Fence (Q1 - 1.5*IQR) : {lower_fence:.2f}")
    print(f"Upper Fence (Q3 + 1.5*IQR) : {upper_fence:.2f}")

    # Find outliers
    outlier_condition = (df["order_value"] < lower_fence) | (df["order_value"] > upper_fence)
    outlier_rows = df[outlier_condition]

    print(f"\nIdentified Outlier Rows (Count: {len(outlier_rows)}):")
    print(outlier_rows[["order_id", "restaurant_name", "category", "order_value"]].to_string(index=False))

    # Cap outliers at the upper fence value using clip()
    df["order_value_uncapped"] = df["order_value"]
    df["order_value"] = df["order_value"].clip(lower=lower_fence, upper=upper_fence)

    print("\nDataFrame sample after clipping outliers (capped at upper fence):")
    capped_samples = df[df["order_id"].isin(outlier_rows["order_id"].tolist())]
    print(capped_samples[["order_id", "restaurant_name", "order_value_uncapped", "order_value"]].to_string(index=False))
    df = df.drop(columns=["order_value_uncapped"])

    print("\n" + "=" * 75)
    print("TASK 2 COMPLETED SUCCESSFULLY. FINAL CLEANED DATASET SHAPE:", df.shape)
    print("=" * 75)

    return df

if __name__ == "__main__":
    main()
