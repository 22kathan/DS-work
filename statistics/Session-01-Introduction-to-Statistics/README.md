# Session 1: Introduction to Statistics in Data Science

This repository contains solutions and explanations for the **Session 1 - Introduction to Statistics in Data Science** assignment.

---

## 📋 Table of Contents
- [Task 1: Daily App Actions & Data Classification](#task-1-daily-app-actions--data-classification)
- [Task 2: Classification of Music App Sample Data](#task-2-classification-of-music-app-sample-data)
- [Task 3: Enhancing App Features Using Statistics](#task-3-enhancing-app-features-using-statistics)
- [Task 4: Statistical Metrics for Music Recommendation](#task-4-statistical-metrics-for-music-recommendation)
- [Python Implementation & Code Verification](#python-implementation--code-verification)

---

## 📱 Task 1: Daily App Actions & Data Classification

**Prompt:** *List 5 daily actions you perform on apps like Instagram, Zomato, or Flipkart, and for each, identify whether the data generated is numerical or categorical.*

| # | App & User Action | Data Generated | Classification | Detailed Type | Description & Reasoning |
|---|---|---|---|---|---|
| **1** | **Instagram**: Watching a Reel | Video watch time (e.g., `18.4 seconds`) | **Numerical** | **Continuous** | Measurable duration on an unbroken, continuous scale with possible decimal values. |
| **2** | **Flipkart**: Adding products to cart | Total item quantity (e.g., `3 items`) | **Numerical** | **Discrete** | Countable discrete integers. You cannot add fractional (e.g., `2.5`) items. |
| **3** | **Zomato**: Selecting payment method | Payment mode (e.g., `UPI`, `Credit Card`, `COD`) | **Categorical** | **Nominal** | Qualitative labels/categories with no inherent mathematical order or ranking. |
| **4** | **Zomato**: Rating restaurant delivery | Rating score (e.g., `1 to 5 stars`) | **Categorical** | **Ordinal** | Ordered categories (`5 stars > 4 stars`), though satisfaction intervals between stars are qualitative. |
| **5** | **Instagram**: Toggling a post like | Interaction state (`Liked` / `Not Liked`) | **Categorical** | **Binary / Nominal** | Two qualitative mutually exclusive states representing user engagement. |

---

## 🎵 Task 2: Classification of Music App Sample Data

**Prompt:** *Given this sample data from a music app: `['Pop', 'Rock', 'Jazz', 'Hip-Hop', 'Pop', 'Rock', 'Jazz', 'Pop']`, classify the type of data and explain your reasoning in 2-3 lines.*

### Classification
- **Data Type:** **Categorical (Qualitative) Data**
- **Sub-Type:** **Nominal Data**

### Reasoning
> The sample consists of distinct text labels designating music genres without any inherent numerical value, natural ranking, or mathematical hierarchy (e.g., *Pop* is not numerically greater or smaller than *Jazz*). Arithmetic operations like addition or calculating a mathematical mean are invalid; only frequency counts, proportions, and identifying the **Mode** (`'Pop'`, frequency = 3) apply.

---

## 🍽️ Task 3: Enhancing App Features Using Statistics

**Prompt:** *Pick any one feature from an app you use (such as the number of likes on an Instagram post, or the rating of a restaurant on Zomato) and describe how statistics could help improve that feature for users.*

### Chosen Feature: **Restaurant Rating System on Zomato**

### The Core Problem
1. **Low Sample-Size Bias:** A newly opened restaurant with a single 5-star review appears ahead of a renowned restaurant with a 4.7-star rating across 2,500 reviews.
2. **Review Bombing & Outlier Distortion:** Unusually high or low ratings from bots or angry one-off incidents skew the arithmetic mean significantly.

### How Statistics Improves the Feature
1. **Bayesian Weighted Average (Empirical Bayes):**  
   Instead of using a simple mean $\bar{x}$, calculate a weighted rating $W$:
   $$W = \frac{v \cdot R + m \cdot C}{v + m}$$
   *(Where $v$ = number of reviews, $R$ = average restaurant rating, $m$ = minimum review threshold, $C$ = platform-wide average rating).*  
   This shrinks low-volume ratings towards the platform baseline until sufficient statistical confidence is gathered.
2. **Interquartile Range (IQR) & Outlier Trimming:**  
   By trimming values beyond $1.5 \times \text{IQR}$ or computing a **Trimmed Mean / Median**, sudden anomalous bursts of 1-star ratings (e.g., external boycott campaigns) are neutralized.
3. **Statistical Confidence Intervals:**  
   Displaying a confidence band (e.g., *"4.6 ± 0.1 stars based on 1,500+ orders"*) provides transparent statistical reliability for diners.

---

## 🎧 Task 4: Statistical Metrics for Music Recommendation

**Prompt:** *Suppose you are building a new playlist recommendation feature for a Spotify-like app. List 3 basic statistical terms (such as mean, median, mode, variance, etc.) that would be useful in analyzing user listening data, and explain each with a one-line example.*

1. **Mode (Most Frequent Value):**  
   * **Role:** Detects the user's most frequently recurring musical attributes (e.g., favorite genre, artist, or language).  
   * *One-line example:* Identifying that a user's most listened-to genre during work hours (9 AM–5 PM) is *"Lo-Fi Instrumental"* to auto-queue a focus playlist.

2. **Mean (Average):**  
   * **Role:** Establishes a baseline central tendency for continuous audio characteristics such as Tempo (BPM), Energy, and Acousticness.  
   * *One-line example:* Computing a runner's mean track tempo of `130 BPM` during workout sessions to curate high-tempo running playlists.

3. **Variance / Standard Deviation (Spread / Dispersion):**  
   * **Role:** Measures whether the user's taste is tightly focused on a specific vibe or broad and eclectic.  
   * *One-line example:* A low variance in acousticness suggests the listener prefers uniform soothing music for sleep, while high variance triggers a varied *"Discover Weekly"* mix.

---

## 📓 Jupyter Notebook Implementation

All tasks, mathematical models, and Python code executions are available in the interactive Jupyter Notebook:

* [`session_1_statistics.ipynb`](./session_1_statistics.ipynb)
