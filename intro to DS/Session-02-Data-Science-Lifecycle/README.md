# Session 2: Data Science Lifecycle

This directory contains the solutions for **Session 2: Data Science Lifecycle** in both native Markdown format and interactive Jupyter Notebook (`session_2_data_science_lifecycle.ipynb`).

---

## 📌 Task 1: Problem Definition (Zomato Food Delivery ETA Optimization)

### 1. Selected App:
- **Zomato**: Food Delivery & Hyperlocal Logistics

### 2. Problem Statement:
Customers frequently experience anxiety and dissatisfaction when estimated delivery times fluctuate unpredictably during peak dinner/lunch rush hours or during adverse weather events, leading to high cancellation rates and customer support escalations.

### 3. Business Goal:
Reduce the Mean Absolute Error (MAE) of delivery arrival predictions by **25%** and lower late-delivery cancellations by **15%**, increasing customer retention and repeat order frequency.

### 4. Data Required:
- **Kitchen & Order Telemetry**: Dish cooking complexity, order item count, historical restaurant preparation latency, and active kitchen queue size.
- **Rider Telemetry**: Real-time rider GPS coordinates, transit speed, vehicle type, and pickup acceptance latency.
- **Contextual Signals**: Live Google Maps traffic density API, rain/weather flags, and day-of-week / rush-hour surge indicators.

---

## 📌 Task 2: REST API Data Ingestion (`requests`)

Fetched the latest 5 posts from `https://jsonplaceholder.typicode.com/posts`:
- **Post #1 (ID: 1)**: `sunt aut facere repellat provident occaecati excepturi optio reprehenderit`
- **Post #2 (ID: 2)**: `qui est esse`
- **Post #3 (ID: 3)**: `ea molestias quasi exercitationem repellat qui ipsa sit aut`
- **Post #4 (ID: 4)**: `eum et est occaecati`
- **Post #5 (ID: 5)**: `nesciunt quas odio`

---

## 📌 Task 3: Mini Spotify Dataset Ingestion with Pandas

- Simulated `spotify_mini.csv` containing 12 tracks across 3 musical genres.
- **Genre Breakdown**:
  - **Pop**: 4 songs (33.3%)
  - **Rock**: 4 songs (33.3%)
  - **Hip-Hop**: 4 songs (33.3%)

---

## 📌 Task 4: BookMyShow Movie Listings Bar Chart (`matplotlib`)

- Visualized 12 movies across 4 genres:
  - **Action**: 4 movies (*Jawan*, *Pathaan*, *Fighter*, *KGF Chapter 2*)
  - **Comedy**: 3 movies (*Stree 2*, *Bhool Bhulaiyaa 3*, *Fukrey 3*)
  - **Drama**: 3 movies (*12th Fail*, *Dunki*, *Animal*)
  - **Sci-Fi**: 2 movies (*Kalki 2898 AD*, *Brahmāstra*)
- Generated a custom bar chart with distinct color palettes and count labels embedded in the notebook.

---

## 📌 Task 5: Feature Engineering for Online Food Orders (Zomato)

Given columns: `order time`, `restaurant`, `cuisine`, `delivery time`, `rating`:

1. **`is_peak_meal_rush` (Binary Flag / Categorical Bucket)**:
   - *Derivation*: Extracted from `order time` (1 for Lunch 12:30–14:30 and Dinner 19:30–22:30; else 0).
   - *Model Benefit*: Captures non-linear traffic and kitchen congestion spikes to improve ETA regression accuracy and surge pricing models.

2. **`restaurant_historical_avg_delay` (Rolling Float Metric)**:
   - *Derivation*: Rolling 30-day mean of $(Actual\text{ }Delivery\text{ }Time - Promised\text{ }ETA)$ grouped by `restaurant`.
   - *Model Benefit*: Quantifies vendor operational speed and preparation reliability, removing vendor-specific ETA bias.

3. **`cuisine_prep_complexity_score` (Ordinal 1–3 Score)**:
   - *Derivation*: Domain mapped from `cuisine` (Level 1: Beverages/Desserts, Level 2: Pizzas/Burgers, Level 3: Tandoori/Biryani).
   - *Model Benefit*: Solves the cold-start problem by providing an accurate prep-time baseline for newly registered restaurants.
