# Data Collection, Cleaning, Visualization and Analysis

This module covers practical end-to-end data workflows in Python: array manipulation with **NumPy**, dataset ingestion, wrangling and cleansing with **Pandas**, and data visualization with **Matplotlib** and **Seaborn**.

---

## 📅 Curriculum Roadmap

| Session | Title / Focus | Deliverables | Status |
| :---: | :--- | :--- | :---: |
| **Session-01** | **NumPy Foundations (Part 1: Arrays & Creation)** | [`insta_likes.ipynb`](./Session-01/insta_likes.ipynb), [`README.md`](./Session-01/README.md) | ✅ Completed |
| **Session-02** | **NumPy Intermediate (Part 2: Indexing, Slicing, Broadcasting)** | [`session_2_numpy_intermediate.ipynb`](./Session-02/session_2_numpy_intermediate.ipynb), [`README.md`](./Session-02/README.md) | ✅ Completed |
| **Session-03** | **NumPy Advanced (Part 3: Matrix Ops & Manipulation)** | [`session_3_numpy_advanced.ipynb`](./Session-03/session_3_numpy_advanced.ipynb), [`README.md`](./Session-03/README.md) | ✅ Completed |
| **Session-04** | **Data Collection using Pandas (Part 1)** | [`session_4_data_collection_pandas.ipynb`](./Session-04/session_4_data_collection_pandas.ipynb), [`README.md`](./Session-04/README.md) | ✅ Completed |
| **Session-05** | **Data Collection using Pandas (Part 2)** | [`session_5_data_collection_pandas.ipynb`](./Session-05/session_5_data_collection_pandas.ipynb), [`README.md`](./Session-05/README.md) | ✅ Completed |
| **Session-06** | **Data Cleaning (Part 1: Missing Values)** | [`session_6_data_cleaning_missing_values.ipynb`](./Session-06/session_6_data_cleaning_missing_values.ipynb), [`README.md`](./Session-06/README.md) | ✅ Completed |
| **Session-07** | **Data Cleaning (Part 2: Outliers & Data Types)** | [`session_7_data_cleaning_outliers_datatypes.ipynb`](./Session-07/session_7_data_cleaning_outliers_datatypes.ipynb), [`README.md`](./Session-07/README.md) | ✅ Completed |
| **Session-08** | **Data Cleaning (Part 3: Duplicates, Typos, Consistency)** | [`session_8_data_cleaning_duplicates_consistency.ipynb`](./Session-08/session_8_data_cleaning_duplicates_consistency.ipynb), [`README.md`](./Session-08/README.md) | ✅ Completed |
| **Session-09** | **Working with Date & Time Data** | [`session_9_date_time_data.ipynb`](./Session-09/session_9_date_time_data.ipynb), [`README.md`](./Session-09/README.md) | ✅ Completed |
| **Session-10** | **Data Visualization: Matplotlib (Part 1)** | [`session_10_matplotlib_visualization_part1.ipynb`](./Session-10/session_10_matplotlib_visualization_part1.ipynb), [`README.md`](./Session-10/README.md) | ✅ Completed |
| **Session-11** | *Upcoming Session* | [Directory](./Session-11/) | ⏳ Pending |

---

## 📁 Directory Structure

```text
Data collection, Cleaning, Visualization and Analysis/
├── README.md                                 # Module Curriculum & Roadmap
│
├── Session-01/                               # Session 01: NumPy Foundations
│   ├── README.md                             # Task documentation & outputs
│   └── insta_likes.ipynb                     # Interactive notebook (.ipynb)
│
├── Session-02/                               # Session 02: NumPy Intermediate
│   ├── README.md                             # Task documentation & outputs
│   └── session_2_numpy_intermediate.ipynb    # Interactive notebook (.ipynb)
│
├── Session-03/                               # Session 03: NumPy Advanced
│   ├── README.md                             # Task documentation & outputs
│   └── session_3_numpy_advanced.ipynb        # Interactive notebook (.ipynb)
│
├── Session-04/                               # Session 04: Data Collection using Pandas (Part 1)
│   ├── README.md                             # Task documentation & outputs
│   ├── session_4_data_collection_pandas.ipynb # Interactive notebook (.ipynb)
│   ├── ipl_matches.csv                       # IPL matches dataset (CSV)
│   ├── spotify_trending.json                 # Trending songs dataset (JSON)
│   ├── zomato_restaurants.tsv                # Zomato restaurant data (TSV)
│   ├── flipkart_products.xlsx                # 10,000-row catalog (Excel)
│   └── paytm_transactions.csv                # Semicolon-separated transactions with nulls
│
├── Session-05/                               # Session 05: Data Collection using Pandas (Part 2)
│   ├── README.md                             # Task documentation & outputs
│   ├── session_5_data_collection_pandas.ipynb # Interactive notebook (.ipynb)
│   ├── orders.csv                            # Order transactions dataset (CSV)
│   ├── users.csv                             # User profiles dataset (CSV)
│   ├── restaurants.csv                       # Zomato restaurants database seed (CSV)
│   └── movies.csv                            # BookMyShow movies database seed (CSV)
│
├── Session-06/                               # Session 06: Data Cleaning (Part 1: Missing Values)
│   ├── README.md                             # Task documentation & outputs
│   ├── session_6_data_cleaning_missing_values.ipynb # Interactive notebook (.ipynb)
│   ├── ipl_player_stats.csv                  # IPL player stats dataset with nulls (CSV)
│   └── zomato_ratings.csv                    # Simulated Zomato ratings with nulls (CSV)
│
├── Session-07/                               # Session 07: Data Cleaning (Part 2: Outliers & Data Types)
│   ├── README.md                             # Task documentation & outputs
│   ├── session_7_data_cleaning_outliers_datatypes.ipynb # Interactive notebook (.ipynb)
│   ├── zomato_user_ratings.csv               # Zomato user ratings with outliers (CSV)
│   ├── swiggy_orders.csv                     # Swiggy orders dataset for boxplot (CSV)
│   ├── paytm_transactions.csv                # Paytm transactions for Winsorization (CSV)
│   ├── flipkart_prices.csv                   # Flipkart product prices as string (CSV)
│   ├── spotify_users.csv                     # Spotify users with mixed boolean types (CSV)
│   └── swiggy_order_boxplot.png              # Generated boxplot visualization (PNG)
│
├── Session-08/                               # Session 08: Data Cleaning (Part 3: Duplicates, Typos, Consistency)
│   ├── README.md                             # Task documentation & outputs
│   ├── session_8_data_cleaning_duplicates_consistency.ipynb # Interactive notebook (.ipynb)
│   ├── zomato_order_history.csv              # Zomato orders dataset with duplicate dates (CSV)
│   ├── flipkart_reviews.csv                  # Product reviews with repeated text (CSV)
│   ├── spotify_playlists.csv                 # Spotify playlists dataset with exact duplicates (CSV)
│   ├── instagram_users.csv                   # Instagram usernames containing typos (CSV)
│   └── paytm_payment_status.csv              # Mixed boolean/string payment statuses (CSV)
│
├── Session-09/                               # Session 09: Working with Date & Time Data
│   ├── README.md                             # Task documentation & outputs
│   ├── session_9_date_time_data.ipynb        # Interactive notebook (.ipynb)
│   ├── flipkart_orders.csv                   # Flipkart orders with timestamps (CSV)
│   └── instagram_posts.csv                   # Instagram posts with UTC timestamps (CSV)
│
├── Session-10/                               # Session 10: Data Visualization: Matplotlib (Part 1)
│   ├── README.md                             # Task documentation & outputs
│   ├── session_10_matplotlib_visualization_part1.ipynb # Interactive notebook (.ipynb)
│   ├── daily_steps.csv                       # 7-day step counts dataset (CSV)
│   ├── zomato_restaurants.csv                # Restaurant ratings and meal prices (CSV)
│   ├── food_delivery_orders.csv              # Monthly order volume per platform (CSV)
│   ├── spotify_sessions.csv                  # 20 Spotify session duration records (CSV)
│   ├── instagram_usage.csv                   # Weekly screen time and engagement records (CSV)
│   ├── steps_lineplot.png                    # Exported daily steps line chart (PNG)
│   ├── restaurant_scatter.png                # Exported restaurant scatter plot (PNG)
│   ├── food_delivery_barchart.png            # Exported platform delivery bar chart (PNG)
│   ├── spotify_session_histogram.png         # Exported session duration histogram (PNG)
│   └── social_media_usage.png                # Exported multi-subplot dashboard (PNG)
│
└── Session-11/                               # Session 11: Upcoming Session
    └── README.md                             # Placeholder awaiting session tasks
```

---

## 🚀 Getting Started

To launch the session notebooks:
```bash
# Session 1 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-01/insta_likes.ipynb"

# Session 2 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-02/session_2_numpy_intermediate.ipynb"

# Session 3 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-03/session_3_numpy_advanced.ipynb"

# Session 4 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-04/session_4_data_collection_pandas.ipynb"

# Session 5 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-05/session_5_data_collection_pandas.ipynb"

# Session 6 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-06/session_6_data_cleaning_missing_values.ipynb"

# Session 7 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-07/session_7_data_cleaning_outliers_datatypes.ipynb"

# Session 8 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-08/session_8_data_cleaning_duplicates_consistency.ipynb"

# Session 9 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-09/session_9_date_time_data.ipynb"

# Session 10 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-10/session_10_matplotlib_visualization_part1.ipynb"
```
