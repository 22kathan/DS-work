"""
Section B - Task 3: Food Delivery Visualisation Dashboard
Preferred Language: Python 3 (Matplotlib & Seaborn)
Assessment: M4-A1 Data Science

Requirements:
- Using the cleaned DataFrame from Task 2 (or fresh simulation with same columns):
  create a 2x2 subplot figure using fig, axes = plt.subplots(2, 2, figsize=(14, 10)).
- Plot 1 (top-left): Seaborn countplot showing order count per category.
- Plot 2 (top-right): Seaborn boxplot showing delivery_time_mins distribution by category.
- Plot 3 (bottom-left): Matplotlib horizontal bar chart of average order_value per restaurant.
- Plot 4 (bottom-right): Seaborn heatmap of correlation matrix of all numeric columns with annot=True.
- Add descriptive title, x-label, and y-label to each subplot.
- Apply plt.tight_layout() to prevent overlapping.
- Save figure as food_delivery_dashboard.png with dpi=150, bbox_inches='tight' and confirm file is saved.
"""

import os
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

# Import the data cleaning pipeline from Task 2
from task2_data_cleaning import main as get_cleaned_data

def main():
    print("=" * 75)
    print("SECTION B - TASK 3: FOOD DELIVERY VISUALISATION DASHBOARD")
    print("=" * 75)

    # 1. Acquire cleaned dataset
    df = get_cleaned_data()

    # 2. Configure aesthetic styles
    sns.set_theme(style="whitegrid")
    palette = sns.color_palette("deep")

    # 3. Create 2x2 Subplot Figure
    fig, axes = plt.subplots(2, 2, figsize=(14, 10))
    fig.suptitle("Food Delivery Analytics & Performance Dashboard", fontsize=16, fontweight="bold", y=0.98)

    # --- Plot 1 (Top-Left): Seaborn countplot (Order count per category) ---
    ax1 = axes[0, 0]
    category_order = df["category"].value_counts().index
    sns.countplot(
        data=df,
        x="category",
        order=category_order,
        ax=ax1,
        hue="category",
        palette="Blues_r",
        legend=False
    )
    ax1.set_title("1. Total Orders by Restaurant Category", fontsize=12, fontweight="semibold")
    ax1.set_xlabel("Restaurant Category", fontsize=11)
    ax1.set_ylabel("Order Count", fontsize=11)
    ax1.tick_params(axis='x', rotation=25)
    # Add count labels on bars
    for p in ax1.patches:
        height = p.get_height()
        if height > 0:
            ax1.annotate(f"{int(height)}", (p.get_x() + p.get_width() / 2., height),
                         ha='center', va='bottom', fontsize=9, fontweight='bold', xytext=(0, 2),
                         textcoords='offset points')

    # --- Plot 2 (Top-Right): Seaborn boxplot (Delivery time by category) ---
    ax2 = axes[0, 1]
    sns.boxplot(
        data=df,
        x="category",
        y="delivery_time_mins",
        order=category_order,
        ax=ax2,
        hue="category",
        palette="Set2",
        legend=False
    )
    ax2.set_title("2. Delivery Time (Mins) Distribution by Category", fontsize=12, fontweight="semibold")
    ax2.set_xlabel("Restaurant Category", fontsize=11)
    ax2.set_ylabel("Delivery Time (Minutes)", fontsize=11)
    ax2.tick_params(axis='x', rotation=25)

    # --- Plot 3 (Bottom-Left): Matplotlib horizontal bar chart (Avg order_value per restaurant) ---
    ax3 = axes[1, 0]
    avg_order_per_restaurant = (
        df.groupby("restaurant_name")["order_value"]
        .mean()
        .sort_values(ascending=True)
    )
    bars = ax3.barh(
        avg_order_per_restaurant.index,
        avg_order_per_restaurant.values,
        color="#2b5c8f",
        edgecolor="#16324f"
    )
    ax3.set_title("3. Average Order Value per Restaurant", fontsize=12, fontweight="semibold")
    ax3.set_xlabel("Average Order Value (₹ / $)", fontsize=11)
    ax3.set_ylabel("Restaurant Name", fontsize=11)
    for bar in bars:
        width = bar.get_width()
        ax3.annotate(f"{width:.1f}", (width, bar.get_y() + bar.get_height() / 2.),
                     ha='left', va='center', fontsize=8, fontweight='bold', xytext=(3, 0),
                     textcoords='offset points')

    # --- Plot 4 (Bottom-Right): Seaborn correlation heatmap ---
    ax4 = axes[1, 1]
    numeric_cols = df.select_dtypes(include=["float64", "int64"]).columns
    # Drop order_id from correlation as it's an arbitrary primary key
    corr_cols = [c for c in numeric_cols if c != "order_id"]
    corr_matrix = df[corr_cols].corr()

    sns.heatmap(
        corr_matrix,
        annot=True,
        fmt=".2f",
        cmap="coolwarm",
        center=0,
        square=True,
        linewidths=1.0,
        cbar_kws={"shrink": 0.8},
        ax=ax4
    )
    ax4.set_title("4. Correlation Heatmap of Numeric Features", fontsize=12, fontweight="semibold")
    ax4.set_xlabel("Features", fontsize=11)
    ax4.set_ylabel("Features", fontsize=11)

    # 4. Prevent overlapping
    plt.tight_layout()

    # 5. Save the figure as required
    output_filename = "food_delivery_dashboard.png"
    # Save both locally in SQL directory and project root if needed
    save_path = os.path.join(os.path.dirname(__file__), output_filename)
    plt.savefig(save_path, dpi=150, bbox_inches='tight')
    plt.close()

    print(f"\n[CONFIRMATION] Successfully generated and saved figure to:")
    print(f" -> {os.path.abspath(save_path)}")
    print(f" -> File Size: {os.path.getsize(save_path):,} bytes")
    print("=" * 75)

if __name__ == "__main__":
    main()
