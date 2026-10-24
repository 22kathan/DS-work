# Data Science Coursework — `DS-work`

Welcome to the **Data Science Coursework (`DS-work`)** repository. This repository acts as the central hub containing all coursework, assignments, and practical notebooks across all 12 sessions.

---

---

## 📘 Module 1: Introduction to Data Science (`intro to DS`)

| # | Session Title | Topic Highlights | Notebook / Directory | Status |
|---|---|---|---|---|
| **01** | **What is Data Science** | Daily apps & telemetry (Instagram, Zomato, Paytm), Core pillars of data science (Statistics, Programming, Domain Knowledge), Spotify data-driven song recommendation scenario, Sports analytics innovations (Optical kinematic tracking & injury prevention) | [📂 Session 01](./intro%20to%20DS/Session-01-What-is-Data-Science/session_1_what_is_data_science.ipynb) | ✅ Completed |
| **02** | **Data Science Lifecycle** | Problem formulation for Zomato delivery ETA, REST API data ingestion with `requests`, mini Spotify dataset analysis with `pandas`, BookMyShow movie genre bar chart with `matplotlib`, and feature engineering for online food orders | [📂 Session 02](./intro%20to%20DS/Session-02-Data-Science-Lifecycle/session_2_data_science_lifecycle.ipynb) | ✅ Completed |
| **03** | **Git & GitHub** | Git verification & configuration, local `music-recommendation` repository initialization & commit, remote GitHub connection (`foodie-favorites`), team collaboration simulation & Issue drafting, and eliminating notebook versioning anti-patterns | [📂 Session 03](./intro%20to%20DS/Session-03-Git-GitHub/session_3_git_github.ipynb) | ✅ Completed |
| **04** | **Git Installation + Fundamentals** | Git verification on OS, global author setup (`user.name`, `user.email`), `InstaCloneRepo` initialization and `.git` architecture inspection, cloning `public-apis` and analyzing `git status`, staging and committing `playlist.txt` with best practices | [📂 Session 04](./intro%20to%20DS/Session-04-Git-Installation-Fundamentals/session_4_git_installation_fundamentals.ipynb) | ✅ Completed |

---

## 📊 Module 2: Statistics & Linear Algebra (`statistics`)

| # | Session Title | Topic Highlights | Notebook / Directory | Status |
|---|---|---|---|---|
| **01** | **Introduction to Statistics in Data Science** | Data classification (Numerical vs. Categorical), Nominal data analysis, Bayesian rating systems, Central tendency & dispersion (Mean, Mode, Variance) | [📂 Session 01](./statistics/Session-01-Introduction-to-Statistics/session_1_statistics.ipynb) | ✅ Completed |
| **02** | **Mean, Median & Mode** | Spotify playlist plays mean, Zomato median delivery time, Flipkart mode rating function, YouTube outlier sensitivity, Kaggle Swiggy dataset Pandas analysis | [📂 Session 02](./statistics/Session-02-Mean-Median-Mode/session_2_mean_median_mode.ipynb) | ✅ Completed |
| **03** | **Variance & Standard Deviation** | Fitness step counts manual variance derivation, `calculate_standard_deviation` function, Zomato spending consistency, Startup salary dispersion analysis | [📂 Session 03](./statistics/Session-03-Variance-and-Standard-Deviation/session_3_variance_standard_deviation.ipynb) | ✅ Completed |
| **04** | **Skewness (Basic)** | Swiggy order count plot & right-skew classification, Instagram follower mean vs. median analysis, YouTube video views right-skewed case study, Flipkart ratings left-skew distribution plot | [📂 Session 04](./statistics/Session-04-Skewness-Basic/session_4_skewness_basic.ipynb) | ✅ Completed |
| **05** | **Sampling** | Population vs. Sample definitions (Zomato, Instagram, Flipkart), Python random sampling simulation (`random.sample`), Swiggy delivery times sampling justification, Spotify selection bias analysis, BookMyShow stratified & systematic sampling strategies | [📂 Session 05](./statistics/Session-05-Sampling/session_5_sampling.ipynb) | ✅ Completed |
| **06** | **Hypothesis Testing (Basic)** | Null & alternative hypotheses for Instagram vs. YouTube screen time, two-sample t-test ($t = 2.3238, p = 0.0237$) on Zomato AOV, Paytm 1-Tap Pay A/B test framework, Flipkart Wishlist button p-value interpretation | [📂 Session 06](./statistics/Session-06-Hypothesis-Testing-Basic/session_6_hypothesis_testing_basic.ipynb) | ✅ Completed |
| **07** | **Correlation** | Instagram hours vs. posts scatter plot & positive correlation, Zomato vs. Swiggy order count correlation ($r = +0.9984$), daily screen time vs. study hours trade-off, Spotify hours vs. test marks strong negative correlation ($r = -0.9996$) | [📂 Session 07](./statistics/Session-07-Correlation/session_7_correlation.ipynb) | ✅ Completed |
| **08** | **Probability Basics** | Probability function `calculate_probability`, 100-roll dice simulation (experimental vs. theoretical), Spotify genre picking probability, Zomato Food & Dessert intersection probability, Flipkart conditional probability ($P(\text{Headphones} \mid \text{Phone})$) recommendation logic | [📂 Session 08](./statistics/Session-08-Probability-Basics/session_8_probability_basics.ipynb) | ✅ Completed |
| **09** | **Normal Distribution** | Generating $N(50, 10^2)$ bell curve with PDF overlay plot, fitness step counts Mean $\approx$ Median $\approx$ Mode symmetry check, 200 gamer scores 68-95-99.7 empirical rule verification ($1\sigma \in [55, 85]$), Spotify song durations normal distribution modeling | [📂 Session 09](./statistics/Session-09-Normal-Distribution/session_9_normal_distribution.ipynb) | ✅ Completed |
| **10** | **Bayes Theorem (Basic)** | General `bayes_posterior` function, Swiggy premium restaurant discount inference ($P(\text{Premium} \mid \text{Discount}) = 30.77\%$), 20-email Naive Bayes spam keyword filter, Flipkart fake review fraud detection model & prompt | [📂 Session 10](./statistics/Session-10-Bayes-Theorem-Basic/session_10_bayes_theorem_basic.ipynb) | ✅ Completed |
| **11** | **Vectors & Matrices (Basic)** | 1D playlist duration vector operations, 3x3 Swiggy ratings matrix column slicing, 3x4 restaurant dishes order aggregation (`axis=0`), 5x2 Flipkart product sales matrix & revenue calculation function | [📂 Session 11](./statistics/Session-11-Vectors-Matrices-Basic/session_11_vectors_matrices_basic.ipynb) | ✅ Completed |
| **12** | **Matrix Multiplication & Linear Regression Math Intuition** | 2x2 matrix multiplication for Instagram engagement ($A \times B$), `linear_regression_predict(x, m, c)` function ($y = mx + c$), Zomato delivery time prediction ($y = 4x + 10$) with regression visualization, Flipkart price prediction slope & intercept intuition, and Spotify recommendation system matrix factorization intuition | [📂 Session 12](./statistics/Session-12-Matrix-Multiplication-Linear-Regression/session_12_matrix_multiplication_linear_regression.ipynb) | ✅ Completed |

---

## 📁 Repository Structure

```text
DS-work/
│
├── README.md                                       # Master Table of Contents & Progress Tracker
│
├── intro to DS/                                    # 📘 Module 1: Introduction to Data Science
│   ├── README.md                                   # Module Overview
│   ├── Session-01-What-is-Data-Science/            # Session 1 Deliverables
│   │   ├── README.md                               # Markdown Reference
│   │   └── session_1_what_is_data_science.ipynb    # Tasks 1-4 Notebook with Code & Outputs
│   │
│   ├── Session-02-Data-Science-Lifecycle/          # Session 2 Deliverables
│   │   ├── README.md                               # Markdown Reference
│   │   ├── spotify_mini.csv                        # Mini Spotify Dataset
│   │   └── session_2_data_science_lifecycle.ipynb  # Tasks 1-5 Notebook with Plots & Outputs
│   │
│   ├── Session-03-Git-GitHub/                      # Session 3 Deliverables
│   │   ├── README.md                               # Markdown Reference
│   │   └── session_3_git_github.ipynb              # Tasks 1-5 Notebook with Code & Outputs
│   │
│   └── Session-04-Git-Installation-Fundamentals/   # Session 4 Deliverables
│       ├── README.md                               # Markdown Reference
│       └── session_4_git_installation_fundamentals.ipynb # Tasks 1-5 Notebook with Code & Outputs
│
└── statistics/                                     # 📊 Module 2: Statistics & Linear Algebra (12 Sessions)
    ├── README.md                                   # Module Overview & Index
    │
    ├── Session-01-Introduction-to-Statistics/      # Session 1 Deliverables
    │   ├── session_1_statistics.ipynb              # Task 1-4 Notebook with Code & Outputs
    │   └── README.md                               # Session 1 Task Overview
    │
    ├── Session-02-Mean-Median-Mode/                # Session 2 Deliverables
    │   ├── session_2_mean_median_mode.ipynb        # Task 1-5 Notebook with Code & Outputs
    │   ├── playlist_stats.py                       # Python script requested in Task 1
    │   └── swiggy_restaurants.csv                  # Kaggle Swiggy Restaurant Dataset
    │
    ├── Session-03-Variance-and-Standard-Deviation/ # Session 3 Deliverables
    │   └── session_3_variance_standard_deviation.ipynb # Task 1-4 Notebook with Code & Outputs
    │
    ├── Session-04-Skewness-Basic/                  # Session 4 Deliverables
    │   └── session_4_skewness_basic.ipynb          # Task 1-4 Notebook with Plots & Outputs
    │
    ├── Session-05-Sampling/                        # Session 5 Deliverables
    │   ├── session_5_sampling.ipynb                # Task 1-5 Notebook with Code & Outputs
    │   └── random_sampling_sim.py                  # Python sampling script
    │
    ├── Session-06-Hypothesis-Testing-Basic/         # Session 6 Deliverables
    │   └── session_6_hypothesis_testing_basic.ipynb # Task 1-4 Notebook with Code & Outputs
    │
    ├── Session-07-Correlation/                     # Session 7 Deliverables
    │   └── session_7_correlation.ipynb             # Task 1-4 Notebook with Plots & Outputs
    │
    ├── Session-08-Probability-Basics/              # Session 8 Deliverables
    │   └── session_8_probability_basics.ipynb      # Task 1-5 Notebook with Code & Outputs
    │
    ├── Session-09-Normal-Distribution/             # Session 9 Deliverables
    │   └── session_9_normal_distribution.ipynb     # Task 1-4 Notebook with Plots & Outputs
    │
    ├── Session-10-Bayes-Theorem-Basic/             # Session 10 Deliverables
    │   └── session_10_bayes_theorem_basic.ipynb    # Task 1-4 Notebook with Code & Outputs
    │
    ├── Session-11-Vectors-Matrices-Basic/          # Session 11 Deliverables
    │   └── session_11_vectors_matrices_basic.ipynb # Task 1-4 Notebook with Code & Outputs
    │
    └── Session-12-Matrix-Multiplication-Linear-Regression/ # Session 12 Deliverables
        └── session_12_matrix_multiplication_linear_regression.ipynb # Task 1-5 Notebook with Plots & Outputs
```

---

## 🛠️ Environment & Prerequisites

* Python 3.9+
* Jupyter Notebook / JupyterLab / Google Colab
* Core Libraries: `statistics`, `collections` (built-in)
