# Data Science Coursework — `DS-work`

Welcome to the **Data Science Coursework (`DS-work`)** repository. This repository acts as the central hub containing all coursework, assignments, and practical notebooks across all 12 sessions.

---

## 📊 Sessions Roadmap & Index

| # | Session Title | Topic Highlights | Notebook / Directory | Status |
|---|---|---|---|---|
| **01** | **Introduction to Statistics in Data Science** | Data classification (Numerical vs. Categorical), Nominal data analysis, Bayesian rating systems, Central tendency & dispersion (Mean, Mode, Variance) | [📂 Session 01](./Session-01-Introduction-to-Statistics/session_1_statistics.ipynb) | ✅ Completed |
| **02** | **Mean, Median & Mode** | Spotify playlist plays mean, Zomato median delivery time, Flipkart mode rating function, YouTube outlier sensitivity, Kaggle Swiggy dataset Pandas analysis | [📂 Session 02](./Session-02-Mean-Median-Mode/session_2_mean_median_mode.ipynb) | ✅ Completed |
| **03** | **Variance & Standard Deviation** | Fitness step counts manual variance derivation, `calculate_standard_deviation` function, Zomato spending consistency, Startup salary dispersion analysis | [📂 Session 03](./Session-03-Variance-and-Standard-Deviation/session_3_variance_standard_deviation.ipynb) | ✅ Completed |
| **04** | **Skewness (Basic)** | Swiggy order count plot & right-skew classification, Instagram follower mean vs. median analysis, YouTube video views right-skewed case study, Flipkart ratings left-skew distribution plot | [📂 Session 04](./Session-04-Skewness-Basic/session_4_skewness_basic.ipynb) | ✅ Completed |
| **05** | **Sampling** | Population vs. Sample definitions (Zomato, Instagram, Flipkart), Python random sampling simulation (`random.sample`), Swiggy delivery times sampling justification, Spotify selection bias analysis, BookMyShow stratified & systematic sampling strategies | [📂 Session 05](./Session-05-Sampling/session_5_sampling.ipynb) | ✅ Completed |
| **06** | **Hypothesis Testing (Basic)** | Null & alternative hypotheses for Instagram vs. YouTube screen time, two-sample t-test ($t = 2.3238, p = 0.0237$) on Zomato AOV, Paytm 1-Tap Pay A/B test framework, Flipkart Wishlist button p-value interpretation | [📂 Session 06](./Session-06-Hypothesis-Testing-Basic/session_6_hypothesis_testing_basic.ipynb) | ✅ Completed |
| **07** | **Correlation** | Instagram hours vs. posts scatter plot & positive correlation, Zomato vs. Swiggy order count correlation ($r = +0.9984$), daily screen time vs. study hours trade-off, Spotify hours vs. test marks strong negative correlation ($r = -0.9996$) | [📂 Session 07](./Session-07-Correlation/session_7_correlation.ipynb) | ✅ Completed |
| **08** | **Probability Basics** | Probability function `calculate_probability`, 100-roll dice simulation (experimental vs. theoretical), Spotify genre picking probability, Zomato Food & Dessert intersection probability, Flipkart conditional probability ($P(\text{Headphones} \mid \text{Phone})$) recommendation logic | [📂 Session 08](./Session-08-Probability-Basics/session_8_probability_basics.ipynb) | ✅ Completed |
| **09** | **Normal Distribution** | Generating $N(50, 10^2)$ bell curve with PDF overlay plot, fitness step counts Mean $\approx$ Median $\approx$ Mode symmetry check, 200 gamer scores 68-95-99.7 empirical rule verification ($1\sigma \in [55, 85]$), Spotify song durations normal distribution modeling | [📂 Session 09](./Session-09-Normal-Distribution/session_9_normal_distribution.ipynb) | ✅ Completed |
| **10** | **Bayes Theorem (Basic)** | General `bayes_posterior` function, Swiggy premium restaurant discount inference ($P(\text{Premium} \mid \text{Discount}) = 30.77\%$), 20-email Naive Bayes spam keyword filter, Flipkart fake review fraud detection model & prompt | [📂 Session 10](./Session-10-Bayes-Theorem-Basic/session_10_bayes_theorem_basic.ipynb) | ✅ Completed |
| **11** | Session 11 | *Upcoming Module* | `Session-11/` | ⏳ Pending |
| **12** | Session 12 | *Upcoming Module* | `Session-12/` | ⏳ Pending |

---

## 📁 Repository Structure

```text
DS-work/
│
├── README.md                                       # Master Table of Contents & Progress Tracker
│
├── Session-01-Introduction-to-Statistics/          # Session 1 Deliverables
│   ├── session_1_statistics.ipynb                  # Task 1-4 Notebook with Code & Outputs
│   └── README.md                                   # Session 1 Task Overview
│
├── Session-02-Mean-Median-Mode/                    # Session 2 Deliverables
│   ├── session_2_mean_median_mode.ipynb            # Task 1-5 Notebook with Code & Outputs
│   ├── playlist_stats.py                           # Python script requested in Task 1
│   └── swiggy_restaurants.csv                      # Kaggle Swiggy Restaurant Dataset
│
├── Session-03-Variance-and-Standard-Deviation/      # Session 3 Deliverables
│   └── session_3_variance_standard_deviation.ipynb # Task 1-4 Notebook with Code & Outputs
│
├── Session-04-Skewness-Basic/                       # Session 4 Deliverables
│   └── session_4_skewness_basic.ipynb              # Task 1-4 Notebook with Plots & Outputs
│
├── Session-05-Sampling/                            # Session 5 Deliverables
│   ├── session_5_sampling.ipynb                    # Task 1-5 Notebook with Code & Outputs
│   └── random_sampling_sim.py                      # Python sampling script
│
├── Session-06-Hypothesis-Testing-Basic/             # Session 6 Deliverables
│   └── session_6_hypothesis_testing_basic.ipynb    # Task 1-4 Notebook with Code & Outputs
│
├── Session-07-Correlation/                         # Session 7 Deliverables
│   └── session_7_correlation.ipynb                 # Task 1-4 Notebook with Plots & Outputs
│
├── Session-08-Probability-Basics/                  # Session 8 Deliverables
│   └── session_8_probability_basics.ipynb          # Task 1-5 Notebook with Code & Outputs
│
├── Session-09-Normal-Distribution/                 # Session 9 Deliverables
│   └── session_9_normal_distribution.ipynb         # Task 1-4 Notebook with Plots & Outputs
│
├── Session-10-Bayes-Theorem-Basic/                 # Session 10 Deliverables
│   └── session_10_bayes_theorem_basic.ipynb        # Task 1-4 Notebook with Code & Outputs
│
├── Session-11-.../                                 # (Upcoming)
│
└── ...
```

---

## 🛠️ Environment & Prerequisites

* Python 3.9+
* Jupyter Notebook / JupyterLab / Google Colab
* Core Libraries: `statistics`, `collections` (built-in)
