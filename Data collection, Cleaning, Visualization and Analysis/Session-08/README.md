# Session 08: Data Cleaning (Part 3: Duplicates, Typos, Consistency)

**Module:** Data Collection, Cleaning, Visualization and Analysis  
**Session:** 08  
**Status:** ✅ Completed

---

## 📋 Topics Covered
- **Detecting Duplicates**:
  - Identifying repeated records using `.duplicated()` (`keep='first'`, `keep=False`, `subset=[...]`)
  - Finding duplicate patterns and frequencies using `.value_counts()`
- **Removing Duplicates**:
  - Deduplicating rows via `.drop_duplicates()`
  - Key-based vs full-row deduplication
- **Fixing Typos in Categorical Columns**:
  - Standardizing spelling and naming variants using `.replace()` with dictionary mappings
  - Overview of fuzzy matching concepts for large datasets
- **Ensuring Data Consistency**:
  - Trimming leading and trailing whitespaces using `.str.strip()`
  - Harmonizing letter case variations with `.str.lower()`
  - Unifying categorical flags (e.g. `'Yes'`, `'y'`, `'No'`, `'N'`) into numeric indicators (`1` / `0`) via `.map()`

---

## 🛠️ Task Walkthrough & Implementation

### Task 1: Find Duplicate Zomato Orders with `duplicated()`
**Problem Statement:**  
*Download a small sample of your recent Zomato order history as a CSV (or create a mock CSV with restaurant names and order dates), then use pandas' `duplicated()` function to find and print any duplicate orders based on restaurant name and date.*

```python
import pandas as pd

# Load Zomato orders dataset
df_zomato = pd.read_csv("zomato_order_history.csv")

# Find duplicate orders based on restaurant name and order date
duplicate_mask = df_zomato.duplicated(subset=['restaurant_name', 'order_date'], keep=False)
duplicate_orders = df_zomato[duplicate_mask].sort_values(by=['restaurant_name', 'order_date'])

print(f"Total duplicate order records found: {len(duplicate_orders)}")
print(duplicate_orders)
```

**Output:**
```text
Total duplicate order records found: 6
  order_id restaurant_name  order_date  amount   cuisine
4     Z105        Bawarchi  2026-10-18   550.0   Biryani
7     Z108        Bawarchi  2026-10-18   550.0   Biryani
1     Z102   Meghana Foods  2026-10-16   620.0   Biryani
5     Z106   Meghana Foods  2026-10-16   320.0   Biryani
0     Z101        Truffles  2026-10-15   450.0   Burgers
2     Z103        Truffles  2026-10-15   450.0   Burgers
```

---

### Task 2: Identify Repeated Reviews with `value_counts()`
**Problem Statement:**  
*Given a list of Flipkart product reviews with some duplicate entries, use `value_counts()` in pandas to identify which review texts are repeated most often and display the top 3 most common duplicate reviews.*

```python
# Load Flipkart reviews dataset
df_reviews = pd.read_csv("flipkart_reviews.csv")

# Count frequency per review text
review_counts = df_reviews['review_text'].value_counts()

# Top 3 most frequent reviews
top_3_reviews = review_counts.head(3)
print("Top 3 Most Common Duplicate Reviews:")
for rank, (text, count) in enumerate(top_3_reviews.items(), 1):
    print(f"{rank}. \"{text}\" -> Repeated {count} times")
```

**Output:**
```text
Top 3 Most Common Duplicate Reviews:
1. "Value for money." -> Repeated 5 times
2. "Great product, highly recommend!" -> Repeated 4 times
3. "Worst quality, do not buy!" -> Repeated 3 times
```

---

### Task 3: Exact Duplicate Removal with `drop_duplicates()`
**Problem Statement:**  
*Create a DataFrame with mock data for Spotify playlists, including playlist names and creator usernames, where some rows are exact duplicates. Use `drop_duplicates()` to remove duplicate playlists and print the cleaned DataFrame.*

```python
# Load Spotify playlists with exact duplicate rows
df_spotify = pd.read_csv("spotify_playlists.csv")

print(f"Initial shape: {df_spotify.shape}")

# Drop exact duplicate rows
df_spotify_cleaned = df_spotify.drop_duplicates().reset_index(drop=True)

print(f"Cleaned shape: {df_spotify_cleaned.shape}")
print(f"Removed {df_spotify.shape[0] - df_spotify_cleaned.shape[0]} duplicate rows.")
print(df_spotify_cleaned)
```

**Output:**
```text
Initial shape: (10, 4)
Cleaned shape: (7, 4)
Removed 3 duplicate rows.

      playlist_name creator_username      genre  tracks_count
0       Lo-Fi Beats         kathan_g      Lo-Fi            45
1    Workout Energy           arav_m    Fitness            60
2   Bollywood Retro          priya_s  Bollywood            80
3  Late Night Chill          rohit_k    Ambient            35
4     Rock Classics         vikram_r       Rock            95
5     Pop Hits 2026          sneha_p        Pop            50
6  Acoustic Morning         ananya_d   Acoustic            40
```

---

### Task 4: Standardize Typos in Categorical Data with `replace()`
**Problem Statement:**  
*Suppose you have a DataFrame of Instagram usernames where some entries have typos (like `'insta_queen'`, `'insta queen'`, `'instaqueen'`). Use the `replace()` function to standardize all these variants to `'instaqueen'`.*

```python
# Load Instagram usernames dataset
df_insta = pd.read_csv("instagram_users.csv")

# Define dictionary mapping typo variations to canonical form
typo_map = {
    'insta_queen': 'instaqueen',
    'insta queen': 'instaqueen'
}

# Standardize username column
df_insta['username_clean'] = df_insta['username'].replace(typo_map)

print(df_insta[['user_id', 'username', 'username_clean']])
print(f"\nUnique values before cleaning: {df_insta['username'].nunique()}")
print(f"Unique values after cleaning:  {df_insta['username_clean'].nunique()}")
```

**Output:**
```text
   user_id        username username_clean
0      101     insta_queen     instaqueen
1      102      travel_bug     travel_bug
2      103     insta queen     instaqueen
3      104      tech_geek      tech_geek
4      105      instaqueen     instaqueen
5      106     foodie_life    foodie_life
6      107     insta_queen     instaqueen
7      108  fitness_freak  fitness_freak
8      109     insta queen     instaqueen
9      110       coder_hub      coder_hub

Unique values before cleaning: 8
Unique values after cleaning:  6
```

---

### Task 5: Normalize Inconsistent Payment Status to Binary Flags
**Problem Statement:**  
*You have a DataFrame column for payment status from a Paytm-like app with mixed values: `'Yes'`, `'yes'`, `'Y'`, `'No'`, `'no'`, `'N'`, and some with extra spaces. Write code to unify this column so all paid statuses become 1 and all unpaid statuses become 0, trimming whitespace and fixing capitalization where needed.*  
*Hint: Use `str.strip()`, `str.lower()`, and map/replace methods in pandas.*

```python
# Load Paytm transactions
df_paytm = pd.read_csv("paytm_payment_status.csv")

# Clean whitespace, lowercase, and map to binary indicator flags
status_map = {
    'yes': 1,
    'y': 1,
    'no': 0,
    'n': 0
}

df_paytm['is_paid'] = (
    df_paytm['payment_status']
    .str.strip()
    .str.lower()
    .map(status_map)
)

print(df_paytm[['txn_id', 'customer_id', 'payment_status', 'is_paid']])
print(f"\nTarget dtype: {df_paytm['is_paid'].dtype}")
```

**Output:**
```text
   txn_id customer_id payment_status  is_paid
0  TXN801        C101            Yes        1
1  TXN802        C102           yes         1
2  TXN803        C103              Y        1
3  TXN804        C104             No        0
4  TXN805        C105            no         0
5  TXN806        C106              N        0
6  TXN807        C107           YES         1
7  TXN808        C108             y         1
8  TXN809        C109            NO         0
9  TXN810        C110              n        0

Target dtype: int64
```

---

## 📁 Files in this Directory

```text
Session-08/
├── README.md                                           # Session documentation & explanations
├── session_8_data_cleaning_duplicates_consistency.ipynb # Interactive Jupyter Notebook (.ipynb)
├── zomato_order_history.csv                            # Zomato orders dataset with duplicate dates (CSV)
├── flipkart_reviews.csv                                # Product reviews with repeated text (CSV)
├── spotify_playlists.csv                               # Spotify playlists dataset with exact duplicates (CSV)
├── instagram_users.csv                                 # Instagram usernames containing typos (CSV)
└── paytm_payment_status.csv                            # Mixed boolean/string payment statuses (CSV)
```

---

## 🚀 How to Run

```bash
# Launch Jupyter Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-08/session_8_data_cleaning_duplicates_consistency.ipynb"
```
