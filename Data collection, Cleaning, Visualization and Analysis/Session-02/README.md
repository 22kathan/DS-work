# Session 02: NumPy Intermediate (Part 2: Indexing, Slicing, Broadcasting)

**Module:** Data Collection, Cleaning, Visualization and Analysis  
**Session:** 02  
**Status:** ✅ Completed

---

## 📌 Topics Covered
- **Indexing in 1D, 2D, and nD arrays**
- **Slicing arrays**: `[:]`, `[start:end]`, `[start:end:step]`
- **Selecting rows & columns**
- **Boolean indexing**
- **Fancy indexing**
- **Broadcasting rules**: Scalar-to-array broadcasting & array-to-array broadcasting
- **Practical examples**:
  - Masking out negative values
  - Broadcasting for vector calculations

---

## 📋 Task Walkthrough & Implementation

### Task 1: 2D Array Slicing (Zomato Food Ratings)
**Problem Statement:**  
*Create a 2D NumPy array representing the ratings (out of 5) given by 4 users to 5 different food items on Zomato. Use slicing to extract the ratings given by the second and third users only.*

```python
import numpy as np

# 4 users (rows) x 5 food items (columns)
zomato_ratings = np.array([
    [4.5, 3.0, 5.0, 4.0, 2.5],  # User 1
    [3.5, 4.0, 4.5, 5.0, 3.0],  # User 2
    [5.0, 2.5, 4.0, 3.5, 4.5],  # User 3
    [2.0, 4.5, 3.0, 4.0, 5.0]   # User 4
])

# Slicing rows at indices 1 and 2 (second and third users)
second_and_third_users = zomato_ratings[1:3]

print("Zomato Ratings (4 users x 5 items):\n", zomato_ratings)
print("\nRatings given by second and third users only:\n", second_and_third_users)
```

**Output:**
```text
Zomato Ratings (4 users x 5 items):
 [[4.5 3.  5.  4.  2.5]
 [3.5 4.  4.5 5.  3. ]
 [5.  2.5 4.  3.5 4.5]
 [2.  4.5 3.  4.  5. ]]

Ratings given by second and third users only:
 [[3.5 4.  4.5 5.  3. ]
 [5.  2.5 4.  3.5 4.5]]
```

---

### Task 2: Boolean Indexing (Daily Steps Filter)
**Problem Statement:**  
*Given a NumPy array of daily steps tracked for 10 days, use boolean indexing to select only the days where the steps were greater than 8000.*  
*Hint: Use an array like `steps = np.array([7500, 8200, 9000, ...])` and apply a boolean condition.*

```python
# Daily steps tracked for 10 days
steps = np.array([7500, 8200, 9000, 6500, 10200, 8100, 7900, 9500, 6800, 8800])

# Boolean indexing condition
steps_above_8000 = steps[steps > 8000]

print("Daily steps recorded      :", steps)
print("Days with steps > 8000    :", steps_above_8000)
```

**Output:**
```text
Daily steps recorded      : [ 7500  8200  9000  6500 10200  8100  7900  9500  6800  8800]
Days with steps > 8000    : [ 8200  9000 10200  8100  9500  8800]
```

---

### Task 3: Fancy Indexing (IPL Match Scores)
**Problem Statement:**  
*Create a NumPy array of IPL team scores for 8 matches. Use fancy indexing to select the scores from matches 2, 5, and 7, and print them.*

```python
# IPL team scores for 8 consecutive matches
ipl_scores = np.array([165, 182, 145, 198, 205, 174, 210, 158])

# Matches 2, 5, and 7 correspond to 0-based indices 1, 4, and 6
selected_scores = ipl_scores[[1, 4, 6]]

print("All IPL match scores       :", ipl_scores)
print("Scores for matches 2, 5, 7 :", selected_scores)
```

**Output:**
```text
All IPL match scores       : [165 182 145 198 205 174 210 158]
Scores for matches 2, 5, 7 : [182 205 210]
```

---

### Task 4: Scalar-to-Array Broadcasting (Flipkart Discounts)
**Problem Statement:**  
*Suppose you have a NumPy array of product prices from Flipkart. Use broadcasting to apply a 10% discount to all prices and print the new array.*  
*Constraint: Do not use any loops.*

```python
# Original Flipkart product prices
flipkart_prices = np.array([499, 1299, 2499, 799, 14999])

# Broadcasting scalar multiplication (10% discount -> 90% of price) without loops
discounted_prices = flipkart_prices * 0.90

print("Original Flipkart prices :", flipkart_prices)
print("Prices after 10% discount:", discounted_prices)
```

**Output:**
```text
Original Flipkart prices : [  499  1299  2499   799 14999]
Prices after 10% discount: [  449.1  1169.1  2249.1   719.1 13499.1]
```

---

### Task 5: Boolean Masking In-Place (Spotify Negative Ratings)
**Problem Statement:**  
*Given a NumPy array of user ratings (can be negative, zero, or positive) for songs on Spotify, use boolean masking to set all negative ratings to zero, keeping other ratings unchanged.*

```python
# Spotify song ratings with negative, zero, and positive values
spotify_ratings = np.array([3, -2, 5, 0, -4, 2, -1, 4])

print("Original Spotify ratings :", spotify_ratings)

# In-place boolean mask assignment: replace negative values with 0
spotify_ratings[spotify_ratings < 0] = 0

print("Cleaned Spotify ratings  :", spotify_ratings)
```

**Output:**
```text
Original Spotify ratings : [ 3 -2  5  0 -4  2 -1  4]
Cleaned Spotify ratings  : [3 0 5 0 0 2 0 4]
```

---

## 📁 Files in this Directory

```text
Session-02/
├── README.md                          # Session documentation & explanations
└── session_2_numpy_intermediate.ipynb # Interactive Jupyter Notebook with outputs & markdown
```

---

## 🚀 How to Run

```bash
# Launch Jupyter Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-02/session_2_numpy_intermediate.ipynb"
```
