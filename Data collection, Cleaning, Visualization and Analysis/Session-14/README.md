# Session 14: Exploratory Data Analysis (EDA) (Part 1)

**Module:** Data Collection, Cleaning, Visualization and Analysis  
**Session:** 14  
**Status:** ✅ Completed

---

## 🎯 Topics Covered
- **Foundations of Exploratory Data Analysis (EDA)**:
  - Formulated by John Tukey; uncovering latent structures, testing preliminary assumptions, and spotting anomalies
  - Distinguishing between univariate, bivariate, and multivariate analysis pipelines
- **Univariate Analysis (Numerical & Categorical)**:
  - Computing central tendency (mean, median), dispersion (std, IQR, min/max), and distribution shape
  - Assessing categorical frequency tables, proportions, and Pareto distributions
- **Bivariate Analysis (Continuous & Discrete)**:
  - Pearson correlation coefficients ($r$) and trendline estimation via ordinary least squares
  - Grouped aggregations (`df.groupby()`) for comparative cross-category analytics
- **Multivariate Analysis**:
  - Pairwise cross-feature interactions using `sns.pairplot()`
  - Audio feature correlation matrices across streaming telemetry
- **Domain Pattern Detection**:
  - Translating raw statistical metrics into actionable business insights (IPL match dynamics, e-commerce rating hygiene, box office performance tiers, acoustic mood correlation)

---

## 📝 Task Walkthrough & Implementation

### Task 1: Univariate Analysis of IPL Match Total Runs
**Problem Statement:**  
*Download a small dataset of IPL cricket matches (CSV or Excel), load it into a pandas DataFrame, and perform univariate analysis by printing the summary statistics (mean, median, min, max, std) for the 'total_runs' column.*

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Ingest IPL matches dataset
df_ipl = pd.read_csv("ipl_matches.csv")
runs_col = df_ipl["total_runs"]

# Compute univariate summary statistics
stats_dict = {
    "Count": runs_col.count(),
    "Mean": round(runs_col.mean(), 2),
    "Median": round(runs_col.median(), 2),
    "Std Dev": round(runs_col.std(), 2),
    "Min": runs_col.min(),
    "Max": runs_col.max(),
    "25th % (Q1)": round(runs_col.quantile(0.25), 1),
    "75th % (Q3)": round(runs_col.quantile(0.75), 1),
    "IQR": round(runs_col.quantile(0.75) - runs_col.quantile(0.25), 1)
}

for k, v in stats_dict.items():
    print(f"  • {k:15}: {v}")

# Visualizing univariate distribution (Dual Subplot: Boxplot + Histplot)
fig, (ax_box, ax_hist) = plt.subplots(2, 1, figsize=(9, 5.5), sharex=True, gridspec_kw={"height_ratios": [0.25, 0.75]}, dpi=150)
sns.set_theme(style="ticks")

sns.boxplot(data=df_ipl, x="total_runs", ax=ax_box, color="#42A5F5", fliersize=5)
ax_box.axvline(runs_col.mean(), color="#D32F2F", linestyle="--", linewidth=1.8, label=f"Mean: {runs_col.mean():.1f}")
ax_box.axvline(runs_col.median(), color="#2E7D32", linestyle="-.", linewidth=1.8, label=f"Median: {runs_col.median():.1f}")
ax_box.set(xlabel="")
ax_box.set_title("IPL Match Total Runs Univariate Distribution (Histplot & Boxplot)", fontsize=13, fontweight="bold", pad=12)
ax_box.legend(loc="upper right", frameon=True)

sns.histplot(data=df_ipl, x="total_runs", kde=True, ax=ax_hist, color="#1976D2", edgecolor="black", bins=12, alpha=0.65)
ax_hist.axvline(runs_col.mean(), color="#D32F2F", linestyle="--", linewidth=2)
ax_hist.axvline(runs_col.median(), color="#2E7D32", linestyle="-.", linewidth=2)
ax_hist.set_xlabel("Total Match Runs (Both Innings)", fontsize=11)
ax_hist.set_ylabel("Match Frequency (Count)", fontsize=11)

sns.despine(ax=ax_box, left=True)
sns.despine(ax=ax_hist)
plt.tight_layout()
plt.savefig("ipl_total_runs_univariate.png", bbox_inches="tight")
plt.show()
```

![IPL Total Runs Univariate](ipl_total_runs_univariate.png)

**Key Observations:**
- Match totals exhibit a symmetric, bell-shaped distribution with Mean = **345.2 runs** and Median = **344.0 runs** (IQR: 320.0 to 369.0 runs).
- Reflects consistent competitive balance in modern 20-over cricket, where each side reliably targets 170–175 runs.

---

### Task 2: Flipkart Product Reviews Star Rating Distribution (Bar Plot)
**Problem Statement:**  
*Using a dataset of Flipkart product reviews (at least columns: 'rating', 'category'), create a bar plot showing the count of reviews for each rating (1-5 stars) using matplotlib or seaborn.*

```python
# Ingest Flipkart product reviews
df_flipkart = pd.read_csv("flipkart_reviews.csv")

plt.figure(figsize=(8.5, 4.8), dpi=150)
sns.set_theme(style="whitegrid")

palette_stars = {1: "#D32F2F", 2: "#F57C00", 3: "#FBC02D", 4: "#7CB342", 5: "#388E3C"}

ax = sns.countplot(
    data=df_flipkart,
    x="rating",
    hue="rating",
    palette=palette_stars,
    edgecolor="black",
    legend=False
)

total_revs = len(df_flipkart)
for p in ax.patches:
    height = int(p.get_height())
    pct = (height / total_revs) * 100
    ax.annotate(
        f"{height}\n({pct:.1f}%)",
        (p.get_x() + p.get_width() / 2., height),
        ha="center", va="bottom",
        fontsize=9.5, fontweight="bold",
        xytext=(0, 4), textcoords="offset points"
    )

plt.title("Flipkart Product Review Distribution by Star Rating (1-5 Stars)", fontsize=13, fontweight="bold", pad=12)
plt.xlabel("Star Rating (1 = Lowest, 5 = Highest)", fontsize=11)
plt.ylabel("Number of Customer Reviews", fontsize=11)
plt.ylim(0, max(df_flipkart["rating"].value_counts()) + 15)
plt.tight_layout()
plt.savefig("flipkart_rating_countplot.png", bbox_inches="tight")
plt.show()
```

![Flipkart Rating Countplot](flipkart_rating_countplot.png)

**Key Observations:**
- Demonstrates a classic e-commerce J-shaped feedback curve: 4-star (32.0%) and 5-star (28.0%) ratings encompass 60% of volume.
- 1-star reviews (10.0%) represent targeted product defects or delivery issues rather than a uniform negative sentiment.

---

### Task 3: Zomato Cost vs Rating Bivariate Relationship (Scatterplot)
**Problem Statement:**  
*Take a dataset of Zomato restaurant listings (with 'average_cost_for_two' and 'user_rating' columns) and create a scatterplot to visualize the relationship between cost and user rating.*  
*Hint: Use seaborn's scatterplot() function and label the axes clearly.*

```python
from scipy import stats

# Ingest Zomato listings
df_zomato = pd.read_csv("zomato_restaurants.csv")

# Compute Pearson correlation
r_val, p_val = stats.pearsonr(df_zomato["average_cost_for_two"], df_zomato["user_rating"])

plt.figure(figsize=(9.5, 5.2), dpi=150)
sns.set_theme(style="whitegrid")

ax = sns.scatterplot(
    data=df_zomato,
    x="average_cost_for_two",
    y="user_rating",
    hue="city",
    size="votes",
    sizes=(40, 220),
    palette="tab10",
    alpha=0.85,
    edgecolor="black"
)

# Linear trendline
z = np.polyfit(df_zomato["average_cost_for_two"], df_zomato["user_rating"], 1)
p = np.poly1d(z)
x_vals = np.linspace(df_zomato["average_cost_for_two"].min(), df_zomato["average_cost_for_two"].max(), 100)
plt.plot(x_vals, p(x_vals), color="#D32F2F", linestyle="--", linewidth=2.2, label=f"Trendline (r = {r_val:.2f})")

plt.title("Zomato Restaurant Listings: Cost for Two vs User Rating (Scatterplot)", fontsize=13, fontweight="bold", pad=12)
plt.xlabel("Average Cost for Two (₹ INR)", fontsize=11)
plt.ylabel("User Rating (out of 5.0)", fontsize=11)
plt.ylim(2.2, 5.2)
plt.legend(bbox_to_anchor=(1.02, 1), loc="upper left", frameon=True, fontsize=8.5)
plt.tight_layout()
plt.savefig("zomato_cost_vs_rating_scatter.png", bbox_inches="tight")
plt.show()
```

![Zomato Cost vs Rating](zomato_cost_vs_rating_scatter.png)

**Key Observations:**
- A positive correlation exists ($r = 0.441$, $p < 10^{-5}$) between average meal pricing and diner rating.
- Fine-dining establishments priced above ₹1,500 consistently score above 4.0, while affordable dining options (₹400–₹800) offer significant value variability.

---

### Task 4: BookMyShow Average Box Office by Genre (Groupby Analysis)
**Problem Statement:**  
*For a BookMyShow movie dataset (with 'genre' and 'box_office_collection' columns), use groupby analysis to find the average box office collection for each genre and display the results as a sorted table.*

```python
# Ingest movie dataset
df_movies = pd.read_csv("bookmyshow_movies.csv")

# Groupby analysis sorted by average collection
genre_sorted = df_movies.groupby("genre")["box_office_collection"].agg(
    movie_count="count",
    mean_collection="mean",
    median_collection="median",
    std_collection="std",
    min_collection="min",
    max_collection="max",
    total_gross="sum"
).reset_index().sort_values(by="mean_collection", ascending=False).reset_index(drop=True)

display(genre_sorted)

# Bar chart of sorted average collections
plt.figure(figsize=(9, 4.8), dpi=150)
sns.set_theme(style="whitegrid")

ax = sns.barplot(
    data=genre_sorted,
    x="genre",
    y="mean_collection",
    hue="genre",
    palette="magma",
    edgecolor="black",
    legend=False
)

for p in ax.patches:
    height = p.get_height()
    ax.annotate(
        f"₹{height:.1f} Cr",
        (p.get_x() + p.get_width() / 2., height),
        ha="center", va="bottom",
        fontsize=9.5, fontweight="bold",
        xytext=(0, 4), textcoords="offset points"
    )

plt.title("Average Box Office Collection by Movie Genre (BookMyShow Groupby Analysis)", fontsize=13, fontweight="bold", pad=12)
plt.xlabel("Movie Genre", fontsize=11)
plt.ylabel("Mean Box Office Collection (₹ Crores)", fontsize=11)
plt.ylim(0, genre_sorted["mean_collection"].max() * 1.15)
plt.tight_layout()
plt.savefig("bookmyshow_genre_barchart.png", bbox_inches="tight")
plt.show()
```

![BookMyShow Genre Bar Chart](bookmyshow_genre_barchart.png)

**Key Observations:**
- **Action** (mean ~₹350 Cr) and **Sci-Fi** (mean ~₹280 Cr) dominate theatrical revenues due to spectacle-driven theater attendance.
- **Romance** (~₹120 Cr) and **Horror** (~₹95 Cr) demonstrate lower average earnings but operate at significantly leaner production budgets.

---

### Task 5: Spotify Audio Features Multivariate Analysis (Pairplot)
**Problem Statement:**  
*Use the seaborn 'pairplot' function on a Spotify songs dataset (with at least 'danceability', 'energy', 'valence', and 'popularity' columns) to visualize pairwise relationships between these features. Briefly describe one interesting pattern you observe.*

```python
# Ingest Spotify audio features
df_spotify = pd.read_csv("spotify_songs.csv")
features = ["danceability", "energy", "valence", "popularity"]

# Pairplot across audio features
sns.set_theme(style="ticks")
g = sns.pairplot(
    data=df_spotify,
    vars=features,
    diag_kind="kde",
    plot_kws={"alpha": 0.75, "s": 42, "color": "#1DB954", "edgecolor": "black", "linewidth": 0.5},
    diag_kws={"fill": True, "color": "#1DB954", "alpha": 0.35}
)

g.fig.subplots_adjust(top=0.93)
g.fig.suptitle("Multivariate Audio Feature Pairwise Relationships (Spotify Pairplot)", fontsize=12, fontweight="bold")
plt.savefig("spotify_audio_features_pairplot.png", bbox_inches="tight", dpi=150)
plt.show()
```

![Spotify Audio Features Pairplot](spotify_audio_features_pairplot.png)

**Key Observations & Pattern Description:**
- **Energy vs. Valence Correlation ($r = 0.395$)**: Tracks characterized by high acoustic energy consistently express positive musical valence (cheerful, uplifting mood), demonstrating that high-tempo electronic percussion tracks align with positive emotional valence.
- **Danceability vs. Energy ($r = 0.284$)**: Shows a steady upward trend where rhythmic danceability co-occurs with driving rhythmic intensity.
- **Popularity**: Exhibits a normal distribution independent of individual acoustic properties, showing that high-streaming virality occurs across diverse genres and tempos.

---

## 📁 Files in this Directory

```text
Session-14/
├── README.md                                           # Session documentation & explanations
├── session_14_exploratory_data_analysis_part1.ipynb    # Interactive Jupyter Notebook (.ipynb)
├── ipl_matches.csv                                     # 60 IPL cricket match records (CSV)
├── flipkart_reviews.csv                                # 150 Flipkart customer review records (CSV)
├── zomato_restaurants.csv                              # 100 Zomato restaurant listings (CSV)
├── bookmyshow_movies.csv                               # 70 BookMyShow box office movie records (CSV)
├── spotify_songs.csv                                   # 100 Spotify tracks with acoustic metrics (CSV)
├── ipl_total_runs_univariate.png                       # Exported univariate distribution figure (PNG)
├── flipkart_rating_countplot.png                       # Exported star rating countplot figure (PNG)
├── zomato_cost_vs_rating_scatter.png                   # Exported cost vs rating scatterplot (PNG)
├── bookmyshow_genre_barchart.png                       # Exported sorted genre box office bar chart (PNG)
└── spotify_audio_features_pairplot.png                 # Exported multivariate pairplot figure (PNG)
```

---

## 🚀 How to Run

```bash
# Launch Jupyter Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-14/session_14_exploratory_data_analysis_part1.ipynb"
```
