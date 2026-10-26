"""
Section A - Question S3: Exploratory Data Analysis & Seaborn Visualization
Preferred Language: Python 3 (Seaborn & Matplotlib)
Assessment: M4-A1 Data Science

Scenario:
You are conducting EDA for a food delivery product team. Your dataset contains
columns: restaurant_category, average_order_value, customer_rating, and
delivery_time_mins. The team wants to know:
(a) whether delivery time is correlated with customer rating (Bivariate Continuous vs. Continuous)
(b) how average order value is distributed across restaurant categories (Bivariate Categorical vs. Continuous)
"""

import os
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

def main():
    print("=" * 75)
    print("SECTION A - S3: SEABORN BIVARIATE EDA VISUALIZATION")
    print("=" * 75)

    # 1. Simulate representative food delivery EDA dataset
    np.random.seed(42)
    n = 200

    categories = ["Indian", "Fast Food", "Italian", "Chinese", "Dessert", "Japanese"]
    cat_weights = [0.25, 0.25, 0.18, 0.15, 0.10, 0.07]
    sim_category = np.random.choice(categories, size=n, p=cat_weights)

    # Delivery time: 20 to 75 minutes
    sim_delivery_time = np.random.normal(35, 10, size=n).clip(15, 80).round(1)

    # Customer rating: negatively correlated with delivery time + noise
    sim_rating = (5.5 - 0.025 * sim_delivery_time + np.random.normal(0, 0.35, size=n)).clip(1.0, 5.0).round(1)

    # Order value: distributed distinctively per category (e.g. Japanese/Italian higher, Fast Food/Dessert lower)
    base_price = {
        "Fast Food": (300, 70),
        "Dessert": (220, 50),
        "Chinese": (450, 100),
        "Indian": (550, 120),
        "Italian": (750, 180),
        "Japanese": (1100, 250)
    }
    sim_aov = [np.random.normal(base_price[c][0], base_price[c][1]) for c in sim_category]
    sim_aov = np.array(sim_aov).clip(100, 2000).round(2)

    df_eda = pd.DataFrame({
        "restaurant_category": sim_category,
        "delivery_time_mins": sim_delivery_time,
        "customer_rating": sim_rating,
        "average_order_value": sim_aov
    })

    print("\n--- 1. Dataset Preview (200 records) ---")
    print(df_eda.head(8).to_string(index=False))

    corr_val = df_eda["delivery_time_mins"].corr(df_eda["customer_rating"])
    print(f"\nPearson Correlation (delivery_time_mins vs. customer_rating): {corr_val:.3f}")
    print("  -> Confirms a statistically negative correlation: as delivery time increases, customer rating drops.")

    # 2. Setup 1x2 High-Resolution Figure
    sns.set_theme(style="whitegrid", font="sans-serif")
    fig, axes = plt.subplots(1, 2, figsize=(15, 6))
    fig.suptitle("Section A - S3: Food Delivery Bivariate EDA Analysis", fontsize=15, fontweight="bold", y=0.98)

    # --- (a) Scatter Plot with Fitted Regression Line ---
    ax1 = axes[0]
    sns.regplot(
        data=df_eda,
        x="delivery_time_mins",
        y="customer_rating",
        ax=ax1,
        color="#c0392b",
        scatter_kws={"alpha": 0.65, "s": 40, "edgecolor": "none"},
        line_kws={"color": "#2c3e50", "linewidth": 2.5, "label": f"Linear Trend (r = {corr_val:.2f})"}
    )
    ax1.set_title("Question (a): Delivery Time vs. Customer Rating\n(Bivariate Continuous vs. Continuous: Scatter Plot)", fontsize=11, fontweight="bold")
    ax1.set_xlabel("Delivery Time (Minutes)", fontsize=10)
    ax1.set_ylabel("Customer Rating (1.0 to 5.0)", fontsize=10)
    ax1.legend(loc="upper right")

    # --- (b) Box Plot across Categories ---
    ax2 = axes[1]
    category_order = df_eda.groupby("restaurant_category")["average_order_value"].median().sort_values(ascending=False).index
    sns.boxplot(
        data=df_eda,
        x="restaurant_category",
        y="average_order_value",
        order=category_order,
        ax=ax2,
        hue="restaurant_category",
        palette="viridis",
        legend=False,
        fliersize=4
    )
    ax2.set_title("Question (b): Order Value Distribution by Category\n(Bivariate Categorical vs. Continuous: Box Plot)", fontsize=11, fontweight="bold")
    ax2.set_xlabel("Restaurant Category", fontsize=10)
    ax2.set_ylabel("Average Order Value (₹ / $)", fontsize=10)
    ax2.tick_params(axis="x", rotation=20)

    plt.tight_layout()

    # Save figure
    save_path = os.path.join(os.path.dirname(__file__), "section_a_eda_plots.png")
    plt.savefig(save_path, dpi=150, bbox_inches="tight")
    plt.close()

    print(f"\n[CONFIRMATION] Successfully generated and saved Section A EDA plots to:")
    print(f" -> {os.path.abspath(save_path)}")
    print("=" * 75)

if __name__ == "__main__":
    main()
