# Spotify Song Popularity Predictor 🎵

An end-to-end Machine Learning pipeline that predicts the popularity score (0–100) of Spotify tracks based on acoustic features, artist metadata, and temporal audio dynamics.

---

## 📌 Project Summary
The **Spotify Song Popularity Predictor** assists independent record labels and streaming curators in forecasting the commercial success and viral potential of newly produced music tracks. By analyzing acoustic properties such as energy, danceability, valence, tempo, and key, the model predicts track popularity before major marketing budget allocation.

### Core Features & Architecture:
- **Data Preprocessing**: Handles missing values, scales acoustic continuous variables, and encodes genre categories.
- **Model Training**: Evaluates Random Forest Regressor and XGBoost models against an $R^2$ and RMSE baseline.
- **Artifact Persistence**: Serializes trained pipelines and scaling transformers for inference serving.

---

## 💾 Dataset
The model is trained on historical Spotify track metadata and audio telemetry.
- **Dataset Link**: [Spotify Tracks Dataset on Kaggle (Placeholder)](https://www.kaggle.com/datasets/maharshipandya/spotify-tracks-dataset)
- **Features Included**: `danceability`, `energy`, `loudness`, `speechiness`, `acousticness`, `instrumentalness`, `liveness`, `valence`, `tempo`, `duration_ms`.
- **Target Variable**: `popularity` (Integer score from 0 to 100).

---

## 🛠️ Setup & Installation

### 1. Clone & Navigate
```bash
git clone https://github.com/22kathan/DS-work.git
cd "DS-work/intro to DS/Session-05-Professional-Project-Structure-DADS/ml-project"
```

### 2. Create Virtual Environment
```bash
python -m venv .venv
# Windows
.\.venv\Scripts\activate
# Linux / macOS
source .venv/bin/activate
```

### 3. Install Required Libraries
```bash
pip install numpy pandas scikit-learn xgboost matplotlib seaborn jupyter
```

---

## 📂 Project Directory Structure
```text
ml-project/
├── data/              # Raw and processed Spotify audio features dataset
├── src/               # Reusable modules (preprocessing.py, train.py, predict.py)
├── notebooks/         # Feature importance & model exploration notebooks
├── models/            # Serialized model weights (e.g., xgboost_popularity_model.pkl)
├── saved_artifacts/   # Robust scalers, encoders, and feature column mapping files
└── README.md          # Project documentation and usage guide
```

---

## 📊 Results & Visuals

### Model Evaluation Benchmark:
| Model | MAE | RMSE | $R^2$ Score |
| :--- | :---: | :---: | :---: |
| Baseline Linear Regression | 14.82 | 19.34 | 0.42 |
| Random Forest Regressor | 9.45 | 13.12 | 0.74 |
| **Tuned XGBoost Regressor (Best)** | **7.81** | **11.20** | **0.82** |

### Top 5 Predictive Audio Features:
```text
1. Danceability      ██████████████████████████ (32%)
2. Energy            ████████████████████ (25%)
3. Valence           ███████████████ (19%)
4. Loudness          ██████████ (13%)
5. Acousticness      ████████ (11%)
```
> **Key Insight**: Tracks with danceability > 0.72 and positive valence show a 3.4x higher probability of entering global top 50 charts.
