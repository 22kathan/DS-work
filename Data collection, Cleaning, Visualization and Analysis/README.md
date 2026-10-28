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
| **Session-11** | **Data Visualization: Matplotlib (Part 2)** | [`session_11_matplotlib_visualization_part2.ipynb`](./Session-11/session_11_matplotlib_visualization_part2.ipynb), [`README.md`](./Session-11/README.md) | ✅ Completed |
| **Session-12** | **Data Visualization with Seaborn (Part 1)** | [`session_12_seaborn_visualization_part1.ipynb`](./Session-12/session_12_seaborn_visualization_part1.ipynb), [`README.md`](./Session-12/README.md) | ✅ Completed |
| **Session-13** | **Data Visualization with Seaborn (Part 2)** | [`session_13_seaborn_visualization_part2.ipynb`](./Session-13/session_13_seaborn_visualization_part2.ipynb), [`README.md`](./Session-13/README.md) | ✅ Completed |
| **Session-14** | **Exploratory Data Analysis (EDA) (Part 1)** | [`session_14_exploratory_data_analysis_part1.ipynb`](./Session-14/session_14_exploratory_data_analysis_part1.ipynb), [`README.md`](./Session-14/README.md) | ✅ Completed |
| **Session-15** | *Upcoming Session* | [Directory](./Session-15/) | ⏳ Pending |

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
├── Session-11/                               # Session 11: Data Visualization: Matplotlib (Part 2)
│   ├── README.md                             # Task documentation & outputs
│   ├── session_11_matplotlib_visualization_part2.ipynb # Interactive notebook (.ipynb)
│   ├── four_charts_sample.csv                # Multi-metric dataset for 2x2 grid (CSV)
│   ├── delivery_times.csv                    # Delivery duration and styling configurations (CSV)
│   ├── influencers_metrics.csv               # Influencer follower and daily post metrics (CSV)
│   ├── bollywood_movies.csv                  # Bollywood box office and ratings dataset (CSV)
│   ├── flipkart_monthly_sales.csv            # Monthly gross merchandise value dataset (CSV)
│   ├── grid_2x2_charts.png                   # Exported 2x2 grid multi-chart figure (PNG)
│   ├── delivery_time_comparison.png          # Exported delivery bar chart with edge styling (PNG)
│   ├── influencers_dual_axis.png             # Exported dual-axis comparison figure (PNG)
│   ├── bollywood_tickets_vs_rating.png       # Exported categorical vs numeric scatter plot (PNG)
│   └── flipkart_sales_annotation.png         # Exported annotated sales trajectory figure (PNG)
│
├── Session-12/                               # Session 12: Data Visualization with Seaborn (Part 1)
│   ├── README.md                             # Task documentation & outputs
│   ├── session_12_seaborn_visualization_part1.ipynb # Interactive notebook (.ipynb)
│   ├── zomato_delivery_times.csv             # 50 Zomato food delivery records (CSV)
│   ├── tips.csv                              # Seaborn canonical dining tips dataset (CSV)
│   ├── ipl_team_scores.csv                   # Simulated IPL match scores for 8 teams (CSV)
│   ├── spotify_tracks_genres.csv             # 40 Spotify tracks across 5 genres (CSV)
│   ├── fitness_daily_steps.csv               # Fitness wearable daily and hourly steps (CSV)
│   ├── zomato_delivery_histplot.png          # Exported delivery times histplot (PNG)
│   ├── total_bill_boxplot.png                # Exported weekday spending boxplot (PNG)
│   ├── ipl_scores_violinplot.png             # Exported IPL score violinplot (PNG)
│   ├── spotify_genre_countplot.png           # Exported Spotify genre countplot (PNG)
│   └── daily_steps_kdeplot.png               # Exported fitness steps KDE plot (PNG)
│
├── Session-13/                               # Session 13: Data Visualization with Seaborn (Part 2)
│   ├── README.md                             # Task documentation & outputs
│   ├── session_13_seaborn_visualization_part2.ipynb # Interactive notebook (.ipynb)
│   ├── tips.csv                              # Dining tips & bill dataset (CSV)
│   ├── flights.csv                           # 1949-1960 airline passengers dataset (CSV)
│   ├── fmri.csv                              # Human brain BOLD signal time series (CSV)
│   ├── titanic.csv                           # Titanic passenger demographics & survival (CSV)
│   ├── penguins.csv                          # Palmer Archipelago penguins morphometrics (CSV)
│   ├── tips_pairplot.png                     # Exported pairwise multivariate plot (PNG)
│   ├── flights_passenger_heatmap.png         # Exported passenger seasonality heatmap (PNG)
│   ├── fmri_signal_relplot.png               # Exported BOLD signal temporal trajectory (PNG)
│   ├── titanic_survival_catplot.png          # Exported survival rates by class/sex with CI (PNG)
│   └── penguins_jointplot_regression.png     # Exported joint distribution with OLS fit (PNG)
│
├── Session-14/                               # Session 14: Exploratory Data Analysis (EDA) (Part 1)
│   ├── README.md                             # Task documentation & outputs
│   ├── session_14_exploratory_data_analysis_part1.ipynb # Interactive notebook (.ipynb)
│   ├── ipl_matches.csv                       # 60 IPL cricket match records (CSV)
│   ├── flipkart_reviews.csv                  # 150 Flipkart customer review records (CSV)
│   ├── zomato_restaurants.csv                # 100 Zomato restaurant listings (CSV)
│   ├── bookmyshow_movies.csv                 # 70 BookMyShow box office movie records (CSV)
│   ├── spotify_songs.csv                     # 100 Spotify tracks with acoustic metrics (CSV)
│   ├── ipl_total_runs_univariate.png         # Exported univariate distribution figure (PNG)
│   ├── flipkart_rating_countplot.png         # Exported star rating countplot figure (PNG)
│   ├── zomato_cost_vs_rating_scatter.png     # Exported cost vs rating scatterplot (PNG)
│   ├── bookmyshow_genre_barchart.png         # Exported sorted genre box office bar chart (PNG)
│   └── spotify_audio_features_pairplot.png   # Exported multivariate pairplot figure (PNG)
│
└── Session-15/                               # Session 15: Upcoming Session
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

# Session 11 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-11/session_11_matplotlib_visualization_part2.ipynb"

# Session 12 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-12/session_12_seaborn_visualization_part1.ipynb"

# Session 13 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-13/session_13_seaborn_visualization_part2.ipynb"

# Session 14 Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-14/session_14_exploratory_data_analysis_part1.ipynb"
```
