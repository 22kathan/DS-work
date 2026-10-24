# Session 1: What is Data Science

This folder contains the complete solutions for **Session 1: What is Data Science** in both native Markdown format and interactive Jupyter Notebook (`session_1_what_is_data_science.ipynb`).

---

## 📌 Task 1: Daily Apps and Data-Driven Personalization

### 1. Instagram
- **Data Collected**: Real-time dwell time/watch time on Reels, post saves, shares, likes, comments, hashtag interactions, creator affinity vectors, and audio snippet tags.
- **Data Science Application**: Deep collaborative filtering, multi-task ranking neural networks, and graph embeddings for the *Explore* and *Reels* feeds.
- **User Experience Improvement**: Immediately presents short videos tailored to hyper-specific user interests without manual search queries.

### 2. Zomato
- **Data Collected**: Live delivery partner GPS coordinates, restaurant kitchen preparation latency, customer order history, weather conditions, and live street traffic.
- **Data Science Application**: Multivariate regression models for dynamic Estimated Time of Arrival (ETA) and spatial bipartite matching for rider dispatch.
- **User Experience Improvement**: Ensures accurate delivery time expectations, lowers average order wait times, and surfaces context-aware food recommendations (e.g., late-night cravings vs. lunchtime bowls).

### 3. Paytm
- **Data Collected**: Transaction amounts, timestamp velocity, merchant category IDs, device hardware IDs, IP addresses, and geolocation shifts.
- **Data Science Application**: Real-time unsupervised anomaly detection and graph neural networks for instantaneous fraud scoring.
- **User Experience Improvement**: Protects account balances against unauthorized access while preserving frictionless 1-tap UPI payment flows for routine transactions.

---

## 📌 Task 2: Data Science Pillars Table

| Statistics | Programming | Domain Knowledge |
| :--- | :--- | :--- |
| **1. Hypothesis Testing & A/B Testing**<br>• *Real-World Example*: Flipkart evaluates whether changing the checkout button color from blue to orange significantly boosts sales conversion using two-sample t-tests ($p < 0.05$). | **1. Vectorized Data Manipulation (Pandas / NumPy)**<br>• *Real-World Example*: An algorithmic trading firm processes and normalizes 10 million stock tick transactions per second using vectorized NumPy array operations instead of slow iterative loops. | **1. E-Commerce Customer Lifecycle & Funnel Economics**<br>• *Real-World Example*: Understanding Customer Acquisition Cost (CAC) and Lifetime Value (LTV) enables designing recommendation models that promote high-margin items over low-value impulse clicks. |
| **2. Probability Distributions & Bayesian Inference**<br>• *Real-World Example*: A credit card company models monthly payment default rates using Logistic / Binomial probability distributions to predict loan default risks given past late payments. | **2. SQL & Distributed Query Optimization**<br>• *Real-World Example*: Netflix engineers write complex window functions and joins across petabytes of viewer telemetry in BigQuery to quantify daily active user retention. | **2. Supply Chain & Last-Mile Delivery Dynamics**<br>• *Real-World Example*: Logistics managers at Delhivery incorporate fuel costs, maximum rider parcel capacities, and peak transit windows to formulate practical route optimization heuristics. |

---

## 📌 Task 3: Data-Driven Decision Making at Spotify

### Scenario:
At Spotify, our data science team continuously monitors implicit listener signals, specifically tracking whether a user skips a track within the first 30 seconds, listens to completion, or adds it to personal playlists alongside audio attributes such as acousticness and BPM. When telemetry indicates that a listener repeatedly skips upbeat pop after 10:00 PM and loops calm acoustic indie folk for over 45 minutes, the recommendation engine automatically registers a distinct late-night relaxation intent. By applying collaborative filtering and matrix factorization across millions of users exhibiting identical temporal habits, the system promotes personalized low-tempo ambient playlists to the user's home screen. This data-driven personalization improves user retention, lowers bounce rates, and introduces users to new emerging indie artists without requiring any manual searching.

---

## 📌 Task 4: Innovative Data Science in Sports Analytics

### Industry Selected: Sports Analytics (Professional Football & Basketball)

#### 1. Real-Time Optical Computer Vision Tracking:
Modern professional sports franchises (such as Premier League clubs like Liverpool FC and NBA basketball teams) deploy high-speed stadium optical camera tracking systems (like Hawk-Eye and Second Spectrum). These systems record the precise 3D spatial $(x, y, z)$ coordinates of every player and the ball at 25 to 60 frames per second, transforming previously unquantified movements into dense structured time-series data.

#### 2. Advanced Predictive In-Game Metrics (Expected Goals & Spacing):
Instead of relying on rudimentary box scores (such as shots or possession percentage), data science teams calculate probabilistic models:
- **Expected Goals ($xG$)**: Evaluates thousands of historical shot variables (shot angle, defender proximity, assist type, and goalkeeper positioning) to calculate the exact probability of a shot becoming a goal.
- **Pitch Control & Passing Lanes**: Models player velocity vectors and sprint acceleration to determine which team controls each square meter of the pitch, recommending optimal tactical passes in real time.

#### 3. Biomechanical Workload Monitoring & Proactive Injury Prevention:
Wearable GPS sensors and kinematic tracking quantify cumulative metabolic workload (acceleration, deceleration, heart rate recovery intervals). When predictive machine learning models detect abnormal biomechanical fatigue thresholds, coaching staffs receive proactive alerts to substitute players or adjust recovery routines, preventing soft-tissue hamstring or ACL injuries before they occur.
