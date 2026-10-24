# Instagram Analytics (`insta-analytics`)

A professional Data Analytics (DA) project analyzing engagement telemetry, reach, and user retention for Instagram marketing campaigns.

## Recommended DA Project Structure
```text
insta-analytics/
├── data/
│   ├── raw/             # Immutable raw data dumps (git-ignored)
│   └── processed/       # Cleaned, transformed, and feature-ready datasets
├── notebooks/           # Jupyter notebooks for exploratory data analysis (EDA)
├── scripts/             # Modular Python / SQL ETL and ingestion pipelines
├── dashboards/          # BI dashboard assets (Tableau / PowerBI / Streamlit)
├── reports/             # Generated PDFs, summaries, and executive decks
├── .gitignore           # Git ignore rules for raw data, checkpoints, and models
└── README.md            # Project documentation and navigation guide
```

## Setup & Workflow
1. Raw exports are stored under `data/raw/` and excluded from version control.
2. Cleaning scripts in `scripts/` output standardized datasets to `data/processed/`.
3. Exploratory analyses are documented in `notebooks/`.
4. Final KPIs and visual decks are published to `dashboards/` and `reports/`.
