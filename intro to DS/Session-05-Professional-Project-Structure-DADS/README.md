# Session 5: Professional Project Structure for DA/DS

This directory contains the complete walkthrough and implementation for **Professional Project Structure for DA/DS** in both Markdown format and interactive Jupyter Notebook (`session_5_project_structure_dads.ipynb`).

---

## 📌 Task 1: Data Analytics Project Structure (`insta-analytics`)

Created the full Data Analytics project hierarchy in `insta-analytics/`:
```text
insta-analytics/
├── data/
│   ├── raw/                       # Immutable raw data dumps (git-ignored)
│   │   └── sample_instagram_posts.csv
│   └── processed/                 # Cleaned, standardized data ready for BI/analytics
├── notebooks/                     # Exploratory Data Analysis (EDA) notebooks
│   └── exploratory_analysis.ipynb
├── scripts/                       # Modular Python & SQL ETL processing scripts
├── dashboards/                    # Tableau, PowerBI, or Streamlit visualization code
├── reports/                       # Generated executive summaries, PDFs, and slide decks
├── .gitignore                     # Git exclusion rules
└── README.md                      # Project documentation and navigation guide
```

---

## 📌 Task 2: Machine Learning Project Structure (`ml-project`)

Constructed the specialized Machine Learning hierarchy for the *Spotify Song Popularity Predictor*:
```text
ml-project/
├── data/                          # Raw and preprocessed feature stores
│   └── dummy.txt
├── src/                           # Reusable modules (preprocessing, train, evaluate)
│   └── dummy.txt
├── notebooks/                     # Experimentation & hyperparameter tuning
│   └── dummy.txt
├── models/                        # Serialized model binary weights (.pkl, .h5)
│   └── dummy.txt
├── saved_artifacts/               # Fitted scalers, encoders, and metric plots
│   └── dummy.txt
└── README.md                      # Comprehensive project guide & benchmarks
```

---

## 📌 Task 3: Git Ignore Configuration (`.gitignore`)

Configured in `insta-analytics/.gitignore`:
```gitignore
# Ignore all files in data/raw
data/raw/*

# Ignore all Jupyter Notebook checkpoints anywhere in the project
.ipynb_checkpoints/
*/.ipynb_checkpoints/
**/.ipynb_checkpoints/

# Ignore serialized machine learning models and pickle binaries
*.h5
*.pkl
```

### Pattern Matching Rationale:
- `data/raw/*`: Prevents confidential or massive raw datasets from entering Git history.
- `**/.ipynb_checkpoints/`: Recursively excludes auto-saved checkpoint files created by Jupyter kernels.
- `*.h5` & `*.pkl`: Blocks heavy binary weights from bloating Git history, enforcing artifact storage best practices (DVC / S3 / GCS).

---

## 📌 Task 4: Professional Machine Learning README.md

Created [`ml-project/README.md`](./ml-project/README.md) featuring:
- **Project Summary**: Forecasting Spotify popularity scores (0–100) from acoustic features before marketing budget deployment.
- **Dataset Link**: Kaggle Spotify Tracks Dataset placeholder and feature dictionary.
- **Setup Instructions**: Python environment creation and library installation.
- **Model Evaluation Table**: Baseline vs. Random Forest vs. Tuned XGBoost ($R^2 = 0.82$, $\text{RMSE} = 11.20$).
- **Visuals**: ASCII bar chart illustrating feature importance (Danceability 32%, Energy 25%).

---

## 📌 Task 5: Trending Open-Source Project Audit (`ageron/handson-ml3`)

Audited **`ageron/handson-ml3`** (*Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow*, 40k+ ⭐):

### 1. Three Observations (Alignment vs. Divergence):
1. **Differs (Flat Notebook Layout)**: All 25+ chapter notebooks reside directly in the root directory instead of an isolated `notebooks/` folder, causing severe top-level clutter.
2. **Differs (Lack of Modular `src/`)**: Helper routines (e.g., custom data fetchers and loss functions) are duplicated in notebook cells rather than packaged into importable `.py` modules.
3. **Follows (Container & Environment Reproducibility)**: Excellent dependency management with `requirements.txt`, `environment.yml`, and `docker/`.

### 2. Recommended Organizational Improvement:
Move all chapter notebooks into `notebooks/` and extract shared data-loading and plotting utilities into a clean `src/` package:
```python
from src.utils import fetch_dataset, plot_decision_boundary
```
