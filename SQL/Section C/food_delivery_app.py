"""
Section C: Mini Capstone Project
Food Delivery Analytics Console Application
Assessment Code: M4-A1 Data Science

A unified, interactive, menu-driven CLI application integrating:
1. Data Cleaning & Quality Auditing (Module 3 - Pandas)
2. SQL Database Analytics & Multi-table Joins (Module 4 - SQLite)
3. Data Visualization Dashboard (Module 3 - Seaborn & Matplotlib)
4. Multi-sheet Excel Report Generation (Pandas ExcelWriter)
"""

import os
import sys
import sqlite3
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from tabulate import tabulate

class FoodDeliveryApp:
    def __init__(self):
        self.base_dir = os.path.dirname(os.path.abspath(__file__))
        self.db_path = os.path.join(self.base_dir, "food_delivery.db")
        self.excel_path = os.path.join(self.base_dir, "food_delivery_report.xlsx")
        self.chart_path = os.path.join(self.base_dir, "section_c_charts.png")
        
        self.raw_df = None
        self.cleaned_df = None
        self.sql_summary_df = None
        self.sql_join_df = None
        
        # Initialize database tables
        self._init_sqlite_db()

    def _init_sqlite_db(self):
        """Initializes SQLite database with restaurants and orders tables."""
        conn = sqlite3.connect(self.db_path)
        cur = conn.cursor()
        
        cur.execute("DROP TABLE IF EXISTS orders;")
        cur.execute("DROP TABLE IF EXISTS restaurants;")
        
        cur.execute("""
        CREATE TABLE restaurants (
            restaurant_id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            category TEXT NOT NULL,
            city TEXT NOT NULL
        );
        """)
        
        cur.execute("""
        CREATE TABLE orders (
            order_id INTEGER PRIMARY KEY,
            restaurant_id INTEGER,
            customer_name TEXT NOT NULL,
            order_value REAL NOT NULL,
            delivery_time_mins REAL NOT NULL,
            rating REAL NOT NULL,
            FOREIGN KEY (restaurant_id) REFERENCES restaurants (restaurant_id)
        );
        """)
        
        restaurants = [
            (1, "Spice Symphony", "Indian", "Mumbai"),
            (2, "Burger Republic", "Fast Food", "Delhi"),
            (3, "Pizza Rustica", "Italian", "Bangalore"),
            (4, "Dragon Express", "Chinese", "Mumbai"),
            (5, "Sushi Wave", "Japanese", "Bangalore"),
            (6, "Taco Fiesta", "Mexican", "Delhi"),
            (7, "Sweet Treats", "Dessert", "Mumbai"),
            (8, "Biryani Central", "Indian", "Hyderabad")
        ]
        cur.executemany("INSERT INTO restaurants VALUES (?, ?, ?, ?)", restaurants)
        
        orders = [
            (101, 1, "Aarav Sharma", 450.0, 32.0, 4.5),
            (102, 2, "Diya Patel", 280.0, 22.0, 4.2),
            (103, 3, "Rohan Mehta", 850.0, 35.0, 4.8),
            (104, 4, "Ananya Iyer", 475.0, 45.0, 3.9),
            (105, 5, "Kabir Singh", 1173.75, 38.0, 4.4),
            (106, 6, "Neha Verma", 320.0, 29.0, 4.0),
            (107, 1, "Vikram Rao", 620.0, 35.0, 4.6),
            (108, 7, "Pooja Joshi", 210.0, 18.0, 4.9),
            (109, 2, "Aditya Nair", 310.0, 26.0, 4.1),
            (110, 3, "Sanya Kapoor", 780.0, 36.0, 4.4),
            (111, 8, "Aryan Gupta", 540.0, 42.0, 4.7),
            (112, 4, "Tanvi Shah", 460.0, 30.0, 3.8),
            (113, 5, "Kunal Bhatia", 1173.75, 50.0, 4.9),
            (114, 6, "Isha Sen", 350.0, 25.0, 4.3),
            (115, 1, "Varun Chawla", 580.0, 33.0, 4.5),
            (116, 2, "Riya Reddy", 290.0, 21.0, 4.0),
            (117, 3, "Manish Jain", 1173.75, 40.0, 4.6),
            (118, 7, "Priya Kulkarni", 240.0, 19.0, 4.8),
            (119, 8, "Siddharth Das", 610.0, 36.0, 4.4),
            (120, 4, "Meera Nambiar", 490.0, 28.0, 4.2),
            (121, 5, "Rajesh Khanna", 950.0, 44.0, 4.7),
            (122, 8, "Sunita Rao", 820.0, 38.0, 4.8),
            (123, 1, "Deepak Joshi", 670.0, 31.0, 4.7),
            (124, 2, "Gauri Shinde", 360.0, 24.0, 4.2),
            (125, 3, "Arun Kumar", 910.0, 39.0, 4.9)
        ]
        cur.executemany("INSERT INTO orders VALUES (?, ?, ?, ?, ?, ?)", orders)
        conn.commit()
        conn.close()

    def generate_raw_dataset(self):
        """Generates realistic food delivery dataset with missing values, duplicates, and outliers."""
        raw_records = [
            (101, "Aarav Sharma", "Spice Symphony", "Indian", "Mumbai", 32.0, 450.0, 4.5),
            (102, "Diya Patel", "Burger Republic", "Fast Food", "Delhi", 22.0, 280.0, 4.2),
            (103, "Rohan Mehta", "Pizza Rustica", "Italian", "Bangalore", np.nan, 850.0, 4.8),
            (104, "Ananya Iyer", "Dragon Express", "Chinese", "Mumbai", 45.0, np.nan, 3.9),
            (105, "Kabir Singh", "Sushi Wave", "Japanese", "Bangalore", 38.0, 1200.0, np.nan),
            (106, "Neha Verma", "Taco Fiesta", np.nan, "Delhi", 29.0, 320.0, 4.0),
            (107, "Vikram Rao", "Spice Symphony", "Indian", "Mumbai", 35.0, 620.0, 4.6),
            (108, "Pooja Joshi", "Sweet Treats", "Dessert", "Mumbai", 18.0, 210.0, 4.9),
            (109, "Aditya Nair", "Burger Republic", "Fast Food", "Delhi", 26.0, 310.0, 4.1),
            (110, "Sanya Kapoor", "Pizza Rustica", "Italian", "Bangalore", np.nan, 780.0, 4.4),
            (111, "Aryan Gupta", "Biryani Central", "Indian", "Hyderabad", 42.0, 540.0, 4.7),
            (112, "Tanvi Shah", "Dragon Express", "Chinese", "Mumbai", 30.0, 460.0, 3.8),
            (113, "Kunal Bhatia", "Sushi Wave", "Japanese", "Bangalore", 50.0, 3800.0, 4.9),
            (114, "Isha Sen", "Taco Fiesta", "Mexican", "Delhi", 25.0, 350.0, 4.3),
            (115, "Varun Chawla", "Spice Symphony", "Indian", "Mumbai", 33.0, 580.0, 4.5),
            (116, "Riya Reddy", "Burger Republic", "Fast Food", "Delhi", 21.0, 290.0, 4.0),
            (117, "Manish Jain", "Pizza Rustica", "Italian", "Bangalore", 40.0, 4200.0, 4.6),
            (118, "Priya Kulkarni", "Sweet Treats", "Dessert", "Mumbai", 19.0, 240.0, 4.8),
            (119, "Siddharth Das", "Biryani Central", "Indian", "Hyderabad", 36.0, 610.0, 4.4),
            (120, "Meera Nambiar", "Dragon Express", "Chinese", "Mumbai", 28.0, 490.0, 4.2),
            # 3 Duplicates
            (101, "Aarav Sharma", "Spice Symphony", "Indian", "Mumbai", 32.0, 450.0, 4.5),
            (108, "Pooja Joshi", "Sweet Treats", "Dessert", "Mumbai", 18.0, 210.0, 4.9),
            (115, "Varun Chawla", "Spice Symphony", "Indian", "Mumbai", 33.0, 580.0, 4.5)
        ]
        columns = [
            "order_id", "customer_name", "restaurant_name", "category",
            "city", "delivery_time_mins", "order_value", "rating"
        ]
        return pd.DataFrame(raw_records, columns=columns)

    def option_1_load_and_clean_data(self):
        """Option 1: Load, clean data, impute missing values, deduplicate, and cap outliers."""
        print("\n" + "=" * 70)
        print("OPTION 1: LOAD & CLEAN DATA")
        print("=" * 70)
        
        self.raw_df = self.generate_raw_dataset()
        df = self.raw_df.copy()
        
        # --- Pre-Cleaning Audit ---
        total_rows_before = len(df)
        null_counts_before = df.isna().sum().to_dict()
        duplicate_count = df.duplicated().sum()
        
        q1_raw = df["order_value"].quantile(0.25)
        q3_raw = df["order_value"].quantile(0.75)
        iqr_raw = q3_raw - q1_raw
        upper_fence_raw = q3_raw + 1.5 * iqr_raw
        lower_fence_raw = q1_raw - 1.5 * iqr_raw
        outlier_count_before = ((df["order_value"] < lower_fence_raw) | (df["order_value"] > upper_fence_raw)).sum()

        print("\n[DATA QUALITY AUDIT - BEFORE CLEANING]")
        print(f"• Total Rows in Raw Dataset : {total_rows_before}")
        print(f"• Duplicate Rows Detected   : {duplicate_count}")
        print(f"• Outlier Rows (order_value): {outlier_count_before} (Upper Fence: {upper_fence_raw:.2f})")
        print("• Missing Value Breakdown   :")
        for col, count in null_counts_before.items():
            if count > 0:
                print(f"    - {col:20s}: {count} nulls")

        # --- Cleaning Operations ---
        # 1. Missing value imputation
        med_delivery = df["delivery_time_mins"].median()
        med_order_val = df["order_value"].median()
        mean_rating = round(df["rating"].mean(), 1)
        mode_category = df["category"].mode()[0]
        
        df["delivery_time_mins"] = df["delivery_time_mins"].fillna(med_delivery)
        df["order_value"] = df["order_value"].fillna(med_order_val)
        df["rating"] = df["rating"].fillna(mean_rating)
        df["category"] = df["category"].fillna(mode_category)
        
        # 2. Deduplication
        df = df.drop_duplicates().reset_index(drop=True)
        
        # 3. Outlier capping using IQR clip()
        Q1 = df["order_value"].quantile(0.25)
        Q3 = df["order_value"].quantile(0.75)
        IQR = Q3 - Q1
        lower_fence = Q1 - 1.5 * IQR
        upper_fence = Q3 + 1.5 * IQR
        
        df["order_value"] = df["order_value"].clip(lower=lower_fence, upper=upper_fence)
        self.cleaned_df = df
        
        # --- Post-Cleaning Audit ---
        total_rows_after = len(df)
        null_counts_after = df.isna().sum().sum()
        outlier_count_after = ((df["order_value"] < lower_fence) | (df["order_value"] > upper_fence)).sum()

        print("\n[DATA QUALITY AUDIT - AFTER CLEANING]")
        print(f"• Total Cleaned Rows        : {total_rows_after} (Removed {total_rows_before - total_rows_after} duplicate rows)")
        print(f"• Total Missing Values Left : {null_counts_after}")
        print(f"• Remaining Uncapped Outliers: {outlier_count_after} (All capped at {upper_fence:.2f})")
        print(f"• Applied Imputations       : delivery_time_mins (median={med_delivery}), order_value (median={med_order_val}), rating (mean={mean_rating}), category (mode='{mode_category}')")
        
        print("\nCleaned Dataset Sample (First 5 Rows):")
        print(tabulate(self.cleaned_df.head(5), headers='keys', tablefmt='psql', showindex=False))
        print("\n[SUCCESS] Data pipeline executed cleanly.")

    def option_2_run_sql_analysis(self):
        """Option 2: Execute SQL GROUP BY aggregation and multi-table JOIN queries."""
        print("\n" + "=" * 70)
        print("OPTION 2: RUN SQL ANALYSIS")
        print("=" * 70)
        
        conn = sqlite3.connect(self.db_path)
        
        # Query 1: GROUP BY with aggregate functions (COUNT, SUM, AVG)
        print("\n--- Query 1: Category & Restaurant Performance (GROUP BY with COUNT, SUM, AVG) ---")
        q1 = """
        SELECT 
            r.category,
            COUNT(DISTINCT r.restaurant_id) AS total_restaurants,
            COUNT(o.order_id) AS total_orders,
            ROUND(SUM(o.order_value), 2) AS total_revenue,
            ROUND(AVG(o.order_value), 2) AS avg_order_value,
            ROUND(AVG(o.delivery_time_mins), 2) AS avg_delivery_time,
            ROUND(AVG(o.rating), 2) AS avg_rating
        FROM restaurants r
        LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
        GROUP BY r.category
        ORDER BY total_revenue DESC;
        """
        self.sql_summary_df = pd.read_sql_query(q1, conn)
        print(tabulate(self.sql_summary_df, headers='keys', tablefmt='psql', showindex=False))

        # Query 2: Multi-table JOIN between restaurants and orders
        print("\n--- Query 2: Top Customer Orders by Value (JOIN between restaurants and orders) ---")
        q2 = """
        SELECT 
            o.order_id,
            o.customer_name,
            r.name AS restaurant_name,
            r.category,
            r.city,
            o.order_value,
            o.delivery_time_mins,
            o.rating
        FROM orders o
        JOIN restaurants r ON o.restaurant_id = r.restaurant_id
        ORDER BY o.order_value DESC, o.rating DESC
        LIMIT 8;
        """
        self.sql_join_df = pd.read_sql_query(q2, conn)
        print(tabulate(self.sql_join_df, headers='keys', tablefmt='psql', showindex=False))
        
        conn.close()
        print("\n[SUCCESS] SQLite analytics queries executed successfully.")

    def option_3_view_charts(self):
        """Option 3: Generate side-by-side Seaborn charts (Countplot & Barplot)."""
        print("\n" + "=" * 70)
        print("OPTION 3: VIEW & GENERATE CHARTS")
        print("=" * 70)
        
        if self.cleaned_df is None:
            print("[INFO] Cleaned dataset not found in memory. Automatically running Option 1...")
            self.option_1_load_and_clean_data()
            
        df = self.cleaned_df
        sns.set_theme(style="whitegrid")
        
        # Create 1x2 Subplot Grid
        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))
        fig.suptitle("Food Delivery Analytics — Section C Mini Capstone", fontsize=15, fontweight="bold", y=0.98)
        
        # Chart 1: Seaborn countplot showing orders by category
        cat_order = df["category"].value_counts().index
        sns.countplot(
            data=df,
            x="category",
            order=cat_order,
            ax=ax1,
            hue="category",
            palette="Blues_r",
            legend=False
        )
        ax1.set_title("1. Order Count by Restaurant Category", fontsize=12, fontweight="bold")
        ax1.set_xlabel("Restaurant Category", fontsize=11)
        ax1.set_ylabel("Total Number of Orders", fontsize=11)
        ax1.tick_params(axis='x', rotation=25)
        
        for p in ax1.patches:
            h = p.get_height()
            if h > 0:
                ax1.annotate(f"{int(h)}", (p.get_x() + p.get_width() / 2., h),
                             ha='center', va='bottom', fontsize=9, fontweight='bold', xytext=(0, 2),
                             textcoords='offset points')
        
        # Chart 2: Seaborn barplot showing average delivery time by city
        city_order = df.groupby("city")["delivery_time_mins"].mean().sort_values(ascending=False).index
        sns.barplot(
            data=df,
            x="city",
            y="delivery_time_mins",
            order=city_order,
            ax=ax2,
            hue="city",
            palette="Oranges_r",
            errorbar=None,
            legend=False
        )
        ax2.set_title("2. Average Delivery Time by City", fontsize=12, fontweight="bold")
        ax2.set_xlabel("City", fontsize=11)
        ax2.set_ylabel("Average Delivery Time (Minutes)", fontsize=11)
        ax2.tick_params(axis='x', rotation=20)
        
        for p in ax2.patches:
            h = p.get_height()
            if h > 0:
                ax2.annotate(f"{h:.1f}m", (p.get_x() + p.get_width() / 2., h),
                             ha='center', va='bottom', fontsize=9, fontweight='bold', xytext=(0, 2),
                             textcoords='offset points')
        
        plt.tight_layout()
        plt.savefig(self.chart_path, dpi=150, bbox_inches='tight')
        plt.close()
        
        print(f"[SUCCESS] Side-by-side charts generated and saved:")
        print(f" -> {self.chart_path}")
        print("• Chart 1: Seaborn countplot of orders by category")
        print("• Chart 2: Seaborn barplot of average delivery time by city")

    def option_4_export_report(self):
        """Option 4: Export cleaned DataFrame and SQL analysis to multi-sheet Excel file."""
        print("\n" + "=" * 70)
        print("OPTION 4: EXPORT REPORT TO EXCEL")
        print("=" * 70)
        
        if self.cleaned_df is None:
            print("[INFO] Cleaned dataset not found. Running Option 1 first...")
            self.option_1_load_and_clean_data()
            
        if self.sql_summary_df is None or self.sql_join_df is None:
            print("[INFO] SQL analysis results not found. Running Option 2 first...")
            self.option_2_run_sql_analysis()
            
        # Export as separate sheets in a single Excel file using pandas.ExcelWriter
        with pd.ExcelWriter(self.excel_path, engine="openpyxl") as writer:
            self.cleaned_df.to_excel(writer, sheet_name="Cleaned_Orders", index=False)
            self.sql_summary_df.to_excel(writer, sheet_name="Category_SQL_Summary", index=False)
            self.sql_join_df.to_excel(writer, sheet_name="Top_Orders_JOIN", index=False)
            
        print(f"\n[CONFIRMATION] Successfully exported multi-sheet report:")
        print(f" -> Path: {os.path.abspath(self.excel_path)}")
        print(f" -> File Size: {os.path.getsize(self.excel_path):,} bytes")
        print(" -> Sheets Generated:")
        print("     1. 'Cleaned_Orders'        : Full cleaned orders DataFrame (20 rows)")
        print("     2. 'Category_SQL_Summary' : Aggregated revenue & ratings by category")
        print("     3. 'Top_Orders_JOIN'      : Detailed orders joined with restaurant & city")

    def run_menu(self):
        """Runs the interactive console application menu loop."""
        while True:
            print("\n" + "#" * 60)
            print("   FOOD DELIVERY ANALYTICS CONSOLE APPLICATION (M4-A1)")
            print("#" * 60)
            print("  [1] Load & Clean Data")
            print("  [2] Run SQL Analysis")
            print("  [3] View Charts")
            print("  [4] Export Report")
            print("  [0] Exit")
            print("-" * 60)
            
            try:
                choice = input("Enter your choice (0-4): ").strip()
            except (EOFError, KeyboardInterrupt):
                print("\nExiting application...")
                break
                
            if choice == "1":
                self.option_1_load_and_clean_data()
            elif choice == "2":
                self.option_2_run_sql_analysis()
            elif choice == "3":
                self.option_3_view_charts()
            elif choice == "4":
                self.option_4_export_report()
            elif choice == "0":
                print("\nThank you for using the Food Delivery Analytics Application. Goodbye!")
                break
            else:
                print("\n[INVALID INPUT] Please enter a valid option number between 0 and 4.")

def main():
    app = FoodDeliveryApp()
    app.run_menu()

if __name__ == "__main__":
    main()
