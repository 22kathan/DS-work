# Session 12: Data Visualization with Seaborn (Part 1)

**Module:** Data Collection, Cleaning, Visualization and Analysis  
**Session:** 12  
**Status:** ✅ Completed

---

## 🎯 Topics Covered
- **Introduction to Seaborn**:
  - High-level statistical visualization layer built on top of Matplotlib
  - Semantic property mapping (`x`, `y`, `hue`, `style`, `size`) and direct Pandas integration
- **Axes-Level vs. Figure-Level APIs**:
  - Distinguishing between axes-level plotters (`histplot`, `kdeplot`, `boxplot`, `violinplot`, `countplot`) and figure-level faceting wrappers (`displot`, `catplot`)
- **Distribution Plots**:
  - `sns.histplot()` with Gaussian Kernel Density Estimates (`kde=True`)
  - `sns.kdeplot()` for continuous non-parametric density estimation
  - Overview of modern replacements for legacy `sns.distplot()`
- **Categorical Plots**:
  - `sns.boxplot()` for five-number summaries (Q1, Median, Q3, Whiskers) and IQR outlier detection
  - `sns.violinplot()` for combining boxplot quartiles with mirrored probability densities
  - `sns.countplot()` for quick categorical frequency enumeration
- **Styling & Aesthetic Themes**:
  - Applying global themes: `sns.set_theme(style='darkgrid')` and `sns.set_theme(style='whitegrid')`
  - Color palette selection (`'Spectral'`, `'viridis'`, `'Set2'`), alpha adjustments, and `sns.despine()`

---

## 📝 Task Walkthrough & Implementation

### Task 1: Zomato Delivery Times Distribution (Histplot)
**Problem Statement:**  
*Install Seaborn in your Python environment and use it to create a `histplot` showing the distribution of delivery times (in minutes) for 50 Zomato food orders. Generate random data if needed.*

```python
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

# Verify environment
print(f"Seaborn Version: {sns.__version__}")

# Load 50 Zomato delivery records
df_deliv = pd.read_csv("zomato_delivery_times.csv")

# Plot delivery distribution using histplot with KDE curve
plt.figure(figsize=(9, 5), dpi=150)
sns.set_theme(style="ticks")

ax = sns.histplot(
    data=df_deliv,
    x="delivery_time_mins",
    kde=True,
    bins=10,
    color="#E23744", # Zomato brand red
    edgecolor="black",
    alpha=0.65,
    line_kws={"linewidth": 2.5, "color": "#880E4F"}
)

# Reference benchmark lines
mean_val = df_deliv["delivery_time_mins"].mean()
median_val = df_deliv["delivery_time_mins"].median()

plt.axvline(mean_val, color="#1A237E", linestyle="--", linewidth=2, label=f"Mean: {mean_val:.1f} mins")
plt.axvline(median_val, color="#2E7D32", linestyle="-.", linewidth=2, label=f"Median: {median_val:.1f} mins")

plt.title("Distribution of Delivery Times for 50 Zomato Food Orders (Histplot)", fontsize=13, fontweight="bold", pad=12)
plt.xlabel("Delivery Time (Minutes)", fontsize=11)
plt.ylabel("Order Frequency (Count)", fontsize=11)
plt.legend(loc="upper right", frameon=True)
sns.despine()
plt.tight_layout()
plt.savefig("zomato_delivery_histplot.png", bbox_inches="tight")
plt.show()
```

![Zomato Delivery Histplot](zomato_delivery_histplot.png)

**Key Observations:**
- Mean delivery duration centers at ~33.5 minutes, with the central 50% (IQR) of deliveries arriving between 29.0 and 38.0 minutes.
- The overlaid KDE curve demonstrates an approximately normal distribution around the 30–35 minute sweet spot, reflecting typical urban delivery SLAs.

---

### Task 2: Dining Spending Patterns Across Weekdays vs Weekends (Boxplot)
**Problem Statement:**  
*Load the 'tips' dataset from Seaborn and create a `boxplot` to visualize the distribution of total bill amounts by day of the week, similar to how Zomato might analyze spending patterns across weekdays.*

```python
# Load Seaborn's canonical 'tips' dataset
df_tips = sns.load_dataset("tips")

plt.figure(figsize=(9, 5.2), dpi=150)
sns.set_theme(style="whitegrid")

days_order = ["Thur", "Fri", "Sat", "Sun"]
palette_days = {"Thur": "#42A5F5", "Fri": "#26A69A", "Sat": "#FFA726", "Sun": "#EF5350"}

ax = sns.boxplot(
    data=df_tips,
    x="day",
    y="total_bill",
    hue="day",
    order=days_order,
    palette=palette_days,
    showmeans=True,
    meanprops={"marker": "D", "markerfacecolor": "white", "markeredgecolor": "black", "markersize": "7"},
    width=0.55,
    boxprops=dict(alpha=0.85, edgecolor="black"),
    legend=False
)

# Overlay individual transaction points using stripplot with jitter
sns.stripplot(
    data=df_tips,
    x="day",
    y="total_bill",
    order=days_order,
    color="black",
    alpha=0.35,
    size=5,
    jitter=0.2
)

plt.title("Total Bill Distribution Across Days of the Week (Zomato Dining Analysis)", fontsize=13, fontweight="bold", pad=12)
plt.xlabel("Day of the Week", fontsize=11)
plt.ylabel("Total Bill Amount ($ / Normalized ₹)", fontsize=11)
plt.ylim(0, 55)
plt.tight_layout()
plt.savefig("total_bill_boxplot.png", bbox_inches="tight")
plt.show()
```

![Total Bill Boxplot](total_bill_boxplot.png)

**Key Observations:**
- **Weekday Lunches (Thur & Fri)**: Have tighter distributions and lower median ticket sizes (~$16), representing quick office meals.
- **Weekend Evenings (Sat & Sun)**: Show elevated medians (~$18–$19) alongside multiple high-value outliers extending up to $48–$50, indicating larger family/party orders.

---

### Task 3: IPL Match Score Distributions per Team (Violinplot - Darkgrid Theme)
**Problem Statement:**  
*Simulate IPL match scores for 8 teams and use a `violinplot` to compare the run distributions per team. Style your plot using the 'darkgrid' Seaborn theme.*

```python
# Load simulated IPL match scores
df_ipl = pd.read_csv("ipl_team_scores.csv")

plt.figure(figsize=(10.5, 5.5), dpi=150)
sns.set_theme(style="darkgrid")

teams_order = ["CSK", "MI", "RCB", "KKR", "DC", "RR", "SRH", "PK"]

ax = sns.violinplot(
    data=df_ipl,
    x="team",
    y="total_runs",
    hue="team",
    order=teams_order,
    palette="Spectral",
    inner="quartile",
    cut=0,
    linewidth=1.2,
    legend=False
)

plt.axhline(200, color="#FFEB3B", linestyle=":", linewidth=2, label="200-Run High Scoring Benchmark")
plt.title("IPL Team Score Distribution Across 15 Matches (Violinplot - Darkgrid Theme)", fontsize=13, fontweight="bold", pad=12)
plt.xlabel("IPL Team", fontsize=11)
plt.ylabel("Match Score (Total Runs)", fontsize=11)
plt.legend(loc="upper left")
plt.tight_layout()
plt.savefig("ipl_scores_violinplot.png", bbox_inches="tight")
plt.show()
```

![IPL Scores Violinplot](ipl_scores_violinplot.png)

**Key Observations:**
- The violin plot's symmetrical density wings reveal teams with wide, aggressive scoring distributions (e.g. SRH with peaks extending towards 250+ runs) versus teams with consistent, moderate innings totals (e.g. KKR and DC clustering between 160–180 runs).
- Internal dashed lines indicate 25th percentile, median (50th), and 75th percentile markers.

---

### Task 4: Spotify Songs per Genre Distribution (Countplot)
**Problem Statement:**  
*Create a `countplot` that displays the number of songs per genre from a list of 40 Spotify tracks, with at least 4 different genres represented.*  
*Hint: Use a Python list or pandas DataFrame to store your data, then plot with Seaborn.*

```python
# Load Spotify tracks dataset
df_spotify = pd.read_csv("spotify_tracks_genres.csv")

plt.figure(figsize=(9, 5), dpi=150)
sns.set_theme(style="white")

genre_order = df_spotify["genre"].value_counts().index

ax = sns.countplot(
    data=df_spotify,
    x="genre",
    hue="genre",
    order=genre_order,
    palette="viridis",
    edgecolor="black",
    legend=False
)

# Label exact counts directly above each bar
for p in ax.patches:
    height = int(p.get_height())
    ax.annotate(
        f"{height} tracks",
        (p.get_x() + p.get_width() / 2., height),
        ha="center", va="bottom",
        fontsize=10, fontweight="bold",
        xytext=(0, 4), textcoords="offset points"
    )

plt.title("Spotify Track Distribution by Genre (Countplot of 40 Tracks)", fontsize=13, fontweight="bold", pad=12)
plt.xlabel("Music Genre", fontsize=11)
plt.ylabel("Number of Tracks", fontsize=11)
plt.ylim(0, 12)
sns.despine(top=True, right=True)
plt.tight_layout()
plt.savefig("spotify_genre_countplot.png", bbox_inches="tight")
plt.show()
```

![Spotify Genre Countplot](spotify_genre_countplot.png)

**Key Observations:**
- Bollywood (10 tracks, 25.0%), Pop (8 tracks, 20.0%), Hip-Hop (8 tracks, 20.0%), Indie Rock (7 tracks, 17.5%), and EDM (7 tracks, 17.5%) provide a balanced distribution across 5 core genres.

---

### Task 5: Daily Step Counts Density Distribution (KDE Plot - Whitegrid Theme)
**Problem Statement:**  
*Use Seaborn's `kdeplot` to visualize the distribution of daily step counts for a week, as if analyzing data from a fitness app. Apply the 'whitegrid' theme and customize the plot color.*

```python
# Load Fitness daily step records
df_fitness = pd.read_csv("fitness_daily_steps.csv")
df_daily_agg = df_fitness.groupby("day", sort=False)["daily_total_steps"].first().reset_index()

plt.figure(figsize=(9, 5), dpi=150)
sns.set_theme(style="whitegrid")

ax = sns.kdeplot(
    data=df_daily_agg,
    x="daily_total_steps",
    fill=True,
    color="#008080", # Customized Teal Plot Color
    alpha=0.45,
    linewidth=2.8,
    label="Estimated Step Density (KDE)"
)

target_steps = 10000
mean_steps = df_daily_agg["daily_total_steps"].mean()

plt.axvline(target_steps, color="#D32F2F", linestyle="--", linewidth=2, label=f"Health Target: {target_steps:,} steps")
plt.axvline(mean_steps, color="#1976D2", linestyle="-.", linewidth=2, label=f"Weekly Mean: {mean_steps:,.0f} steps")

plt.title("Daily Step Counts Density Distribution over a Week (KDE Plot - Whitegrid Theme)", fontsize=13, fontweight="bold", pad=12)
plt.xlabel("Daily Step Count", fontsize=11)
plt.ylabel("Probability Density", fontsize=11)
plt.legend(loc="upper right", frameon=True)
plt.tight_layout()
plt.savefig("daily_steps_kdeplot.png", bbox_inches="tight")
plt.show()
```

![Daily Steps KDE Plot](daily_steps_kdeplot.png)

**Key Observations:**
- The density curve highlights two activity zones: weekdays clustering around 8,500–9,200 steps, and active weekends pushing past 11,000 steps.
- The weekly mean of ~9,600 steps demonstrates high adherence close to the recommended 10,000 steps/day benchmark.

---

## 📁 Files in this Directory

```text
Session-12/
├── README.md                                           # Session documentation & explanations
├── session_12_seaborn_visualization_part1.ipynb        # Interactive Jupyter Notebook (.ipynb)
├── zomato_delivery_times.csv                           # 50 Zomato food delivery records (CSV)
├── tips.csv                                            # Seaborn canonical dining tips dataset (CSV)
├── ipl_team_scores.csv                                 # Simulated IPL match scores for 8 teams (CSV)
├── spotify_tracks_genres.csv                           # 40 Spotify tracks across 5 genres (CSV)
├── fitness_daily_steps.csv                             # Fitness wearable daily and hourly steps (CSV)
├── zomato_delivery_histplot.png                        # Exported delivery times histplot (PNG)
├── total_bill_boxplot.png                              # Exported weekday spending boxplot (PNG)
├── ipl_scores_violinplot.png                           # Exported IPL score violinplot (PNG)
├── spotify_genre_countplot.png                         # Exported Spotify genre countplot (PNG)
└── daily_steps_kdeplot.png                             # Exported fitness steps KDE plot (PNG)
```

---

## 🚀 How to Run

```bash
# Launch Jupyter Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-12/session_12_seaborn_visualization_part1.ipynb"
```
