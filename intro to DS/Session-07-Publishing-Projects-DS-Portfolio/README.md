# Session 7: Publishing Projects & Building Your DS Portfolio

This directory contains the complete implementation, scripts, datasets, and deliverables for **Session 7: Publishing Projects & Building Your DS Portfolio** in both Markdown documentation and interactive Jupyter Notebook ([`session_7_publishing_projects_portfolio.ipynb`](./session_7_publishing_projects_portfolio.ipynb)).

---

## 📌 Task 1: Create 'my-movie-ratings' Repository & Push `movie_ratings.ipynb`

### 1. Repository Initialization & Initial Commit
```bash
# Navigate to local workspace / scratch directory
mkdir my-movie-ratings
cd my-movie-ratings

# Initialize local Git repository
git init

# Stage and commit the movie ratings analysis notebook
git add movie_ratings.ipynb
git commit -m "feat: initial commit of movie ratings analysis notebook"

# Rename branch to main
git branch -M main

# Connect to GitHub remote origin
git remote add origin https://github.com/22kathan/my-movie-ratings.git

# Push to GitHub
git push -u origin main
```

### 2. Output & Verification
```text
Initialized empty Git repository in C:/Users/gadhi/.gemini/antigravity-ide/scratch/my-movie-ratings/.git/
[main (root-commit) b1bf4c3] feat: initial commit of movie ratings analysis notebook
 1 file changed, 89 insertions(+)
 create mode 100644 movie_ratings.ipynb
origin  https://github.com/22kathan/my-movie-ratings.git (fetch)
origin  https://github.com/22kathan/my-movie-ratings.git (push)
```

---

## 📌 Task 2: Git LFS Tracking & Raw Data Anti-Patterns

### 1. Why Raw Data Files Must NOT Be Uploaded Directly to GitHub
* **Storage Limits & Repo Bloat**:
  * GitHub imposes a strict **100 MB hard limit** on individual file uploads and strongly advises keeping repository size below **1 GB** (hard ceiling at 5 GB).
  * Standard Git stores every historical revision of a file inside its packfiles (`.git/objects/`). Even if a file is deleted in a later commit, the large binary payload remains permanently lodged in the repository history, bloating the clone size indefinitely.
* **Bandwidth & Clone Latency**:
  * Every team member cloning or fetching from the repository must download the complete historical log of large binary blobs. This severely degrades CI/CD pipeline runtimes and causes high network latency.
* **Privacy, Compliance & Governance (PII Risks)**:
  * Raw datasets from production telemetry frequently contain unmasked Personally Identifiable Information (PII) such as customer email addresses, device IDs, GPS coordinates, IP addresses, and transaction histories.
  * Pushing raw data to a public or team repository violates data compliance regulations (**GDPR, HIPAA, and DPDP Act**). Removing leaked PII from Git history requires destructive history rewriting (`git filter-repo` / `BFG Repo-Cleaner`).
* **Immutability & Poor Diffing**:
  * Git is optimized for textual source code where differences are computed line-by-line. Large CSVs, binary Parquet files, or image dumps do not diff efficiently, defeating the fundamental purpose of version control.
  * **Industry Best Practice**: Store raw datasets in cloud object stores (Google Cloud Storage `gs://`, AWS S3 `s3://`, Azure Blob) or use specialized Data Version Control tools (**DVC** or **Git LFS**).

### 2. Git LFS Workflow for Files Over 100MB
```bash
# 1. Install Git LFS hooks
git lfs install

# 2. Track large CSV files with Git LFS
git lfs track "large_spotify_playlists.csv"

# 3. Stage and commit .gitattributes
git add .gitattributes
git commit -m "build: configure Git LFS tracking for large Spotify CSV"

# 4. Add large CSV file (112.01 MB sample data)
git add large_spotify_playlists.csv
git commit -m "feat(lfs): track and commit 112MB sample Spotify playlist dataset via Git LFS"
```

### 3. Verification Logs
```text
$ git lfs ls-files
d011657718 * large_spotify_playlists.csv

$ Get-Item large_spotify_playlists.csv | Select-Object Name, Length, @{Name="MB"; Expression={[math]::round($_.Length / 1MB, 2)}}
Name                         Length         MB
----                         ------         --
large_spotify_playlists.csv  117450070  112.01
```

---

## 📌 Task 3: Jupyter Notebook Diffing with `nbdime`

### 1. Installation
```bash
# Install nbdime in virtual environment
.\.venv\Scripts\pip.exe install nbdime
```

### 2. Notebook Diff Execution
```bash
nbdiff ipl_player_runs_v1.ipynb ipl_player_runs_v2.ipynb
```

### 3. Exact `nbdime` Diff Output
```text
nbdiff C:\Users\gadhi\.gemini\antigravity-ide\scratch\ipl_player_runs_v1.ipynb C:\Users\gadhi\.gemini\antigravity-ide\scratch\ipl_player_runs_v2.ipynb
--- C:\Users\gadhi\.gemini\antigravity-ide\scratch\ipl_player_runs_v1.ipynb  2026-10-24 13:55:23.859457
+++ C:\Users\gadhi\.gemini\antigravity-ide\scratch\ipl_player_runs_v2.ipynb  2026-10-24 13:55:23.859457
## inserted before /cells/0:
+  markdown cell:
+    source:
+      # 🏏 IPL Player Runs Analysis (Version 2)
+      Comprehensive summary with statistical tables and visual comparison chart.

## deleted /cells/0:
-  markdown cell:
-    source:
-      # 🏏 IPL Player Runs Analysis (Version 1)
-      Basic tabular summary of batsman runs and strike rates.

## inserted before /cells/2:
+  markdown cell:
+    source:
+      ### 📊 Visualization: Top IPL Run Scorers Comparison
+  code cell:
+    execution_count: 2
+    source:
+      import matplotlib.pyplot as plt
+      
+      plt.figure(figsize=(8, 4.5))
+      colors = ['#d90429', '#003049', '#f77f00', '#2a9d8f', '#7209b7']
+      bars = plt.bar(df_ipl['Batsman'], df_ipl['Runs'], color=colors, edgecolor='black', width=0.6)
+      plt.title('IPL Season Total Runs by Batsman (Top 5)', fontsize=13, fontweight='bold', pad=12)
+      plt.xlabel('Player', fontsize=11)
+      plt.ylabel('Runs Scored', fontsize=11)
+      plt.grid(axis='y', linestyle='--', alpha=0.5)
+      for bar in bars:
+          yval = bar.get_height()
+          plt.text(bar.get_x() + bar.get_width()/2.0, yval + 10, int(yval), ha='center', va='bottom', fontweight='bold')
+      plt.tight_layout()
+      plt.savefig('ipl_runs_chart.png', dpi=150)
+      print('Bar plot generated and saved to ipl_runs_chart.png')
+    outputs:
+      output 0:
+        output_type: stream
+        name: stdout
+        text:
+          Bar plot generated and saved to ipl_runs_chart.png
```

---

## 📌 Task 4: Showcase Data Science Work (Modular Code & Clean Data)

**Strict Constraint Adherence**: *No raw or unprocessed data files are included.*

### Repository Showcase Files:
1. [`helper_functions.py`](./helper_functions.py):
   * `calculate_strike_rate(runs, balls)`
   * `calculate_boundary_percentage(fours, sixes, runs)`
   * `categorize_batsman_impact(runs, strike_rate)`
   * `generate_performance_summary(df)`
2. [`processed_data.csv`](./processed_data.csv):
   * Curated, feature-engineered dataset of top IPL batsmen (Includes `Strike_Rate`, `Boundary_Pct`, `Impact_Role`).
3. [`plot.png`](./plot.png):
   * High-resolution exported scatter visualizer scaling boundary dominance bubbles and annotating top performers.
4. [`analysis.ipynb`](./analysis.ipynb):
   * Self-contained Jupyter notebook importing modular helper functions, exploring aggregated insights, and generating the visualization.

---

## 📌 Task 5: GitHub Pages Portfolio Site & Downloadable Resume

### 1. Portfolio Assets
* **Live HTML Site**: [`portfolio/index.html`](./portfolio/index.html)
* **Downloadable Resume (PDF)**: [`portfolio/resume.pdf`](./portfolio/resume.pdf)

### 2. Featured Project Cards Included in Portfolio
| Project Card | Focus Area | Key Metrics Highlighted |
| :--- | :--- | :--- |
| **Instagram Follower Analysis** | Exploratory Data Analysis & Skewness Modeling | 94.2% $R^2$ accuracy, 1.2M+ creator telemetry records, power-law distribution detection |
| **Zomato Restaurant Ratings & Delivery ETA** | Predictive Modeling & Statistical Inference | -8.4 min ETA variance reduction, two-sample t-test ($p = 0.0237$) on AOV lift |
| **IPL Batsman Impact & Boundary Dominance** | Quantitative Sports Analytics & Data Versioning | 81.3% peak boundary dominance, modular Python pipeline, Git LFS integration |

### 3. Deploying to GitHub Pages
1. Go to repository **Settings** $\rightarrow$ **Pages**.
2. Select Source: **Deploy from a branch**.
3. Branch: `main` | Folder: `/docs` (or `/root`).
4. Click **Save**. Your portfolio site is published live at:
   `https://22kathan.github.io/my-movie-ratings/`
