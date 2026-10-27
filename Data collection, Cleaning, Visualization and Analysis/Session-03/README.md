# Session 03: NumPy Advanced (Part 3: Matrix Ops & Manipulation)

**Module:** Data Collection, Cleaning, Visualization and Analysis  
**Session:** 03  
**Status:** ✅ Completed

---

## 📌 Topics Covered
- **Mathematical operations**:
  - Element-wise addition, subtraction, multiplication, division
  - Element-wise vs. matrix multiplication
- **Matrix operations**:
  - `dot()`, `matmul()`
  - Transpose (`.T`)
- **Statistical functions**:
  - `mean`, `median`, `std`, `var`
- **Linear algebra module**:
  - `np.linalg.inv()`, `np.linalg.det()`, `np.linalg.eig()`
- **Array manipulation**:
  - `reshape()`, `flatten()`
  - `split()`, `vstack()`

---

## 📋 Task Walkthrough & Implementation

### Task 1: Element-wise Arithmetic Operations (Step Counts)
**Problem Statement:**  
*Create two NumPy arrays representing the daily step counts of two friends over a week and use element-wise addition, subtraction, multiplication, and division to compare their activity levels.*

```python
import numpy as np

# Daily step counts over 7 days for two friends
friend_a = np.array([8500, 9200, 7800, 10500, 8900, 6400, 11200])
friend_b = np.array([7200, 8800, 8100, 9800, 9500, 7000, 10100])

print("Friend A Steps        :", friend_a)
print("Friend B Steps        :", friend_b)

# Element-wise operations
print("\nElement-wise Addition (Combined Daily Steps):")
print(friend_a + friend_b)

print("\nElement-wise Subtraction (Step Difference A - B):")
print(friend_a - friend_b)

print("\nElement-wise Multiplication (Activity Product):")
print(friend_a * friend_b)

print("\nElement-wise Division (Activity Ratio A / B):")
print(friend_a / friend_b)
```

**Output:**
```text
Friend A Steps        : [ 8500  9200  7800 10500  8900  6400 11200]
Friend B Steps        : [ 7200  8800  8100  9800  9500  7000 10100]

Element-wise Addition (Combined Daily Steps):
[15700 18000 15900 20300 18400 13400 21300]

Element-wise Subtraction (Step Difference A - B):
[1300  400 -300  700 -600 -600 1100]

Element-wise Multiplication (Activity Product):
[ 61200000  80960000  63180000 102900000  84550000  44800000 113120000]

Element-wise Division (Activity Ratio A / B):
[1.18055556 1.04545455 0.96296296 1.07142857 0.93684211 0.91428571 1.10891089]
```

---

### Task 2: Matrix Multiplication — dot() vs matmul() (Spotify Recommendations)
**Problem Statement:**  
*Simulate a Spotify-like 'Recommended Songs' feature: Given two 3x3 matrices representing user-song interaction scores (user preferences and song popularity), use dot() and matmul() to compute the final recommendation matrix and explain the difference between the two results.*

```python
# Two 3x3 matrices: User preferences and song popularity
user_preferences = np.array([
    [0.8, 0.4, 0.6],
    [0.2, 0.9, 0.5],
    [0.7, 0.3, 0.8]
])

song_popularity = np.array([
    [0.9, 0.5, 0.7],
    [0.3, 0.8, 0.4],
    [0.6, 0.2, 0.9]
])

recommendation_dot = np.dot(user_preferences, song_popularity)
recommendation_matmul = np.matmul(user_preferences, song_popularity)

print("Recommendation Matrix via dot():\n", recommendation_dot)
print("\nRecommendation Matrix via matmul():\n", recommendation_matmul)
print("\nAre results identical for 2D matrices?:", np.allclose(recommendation_dot, recommendation_matmul))

# Difference between dot() and matmul():
# - For 2D matrices, dot() and matmul() compute identical matrix products.
# - For N-dimensional arrays (N > 2), matmul treats trailing dimensions as 2D matrices and broadcasts batch dimensions,
#   whereas dot performs inner sum-products over the last axis of A and second-to-last axis of B.
# - In addition, matmul does not support scalar multiplication, while dot can multiply arrays by a scalar.
```

**Output:**
```text
Recommendation Matrix via dot():
 [[1.2  0.84 1.26]
 [0.75 0.92 0.95]
 [1.2  0.75 1.33]]

Recommendation Matrix via matmul():
 [[1.2  0.84 1.26]
 [0.75 0.92 0.95]
 [1.2  0.75 1.33]]

Are results identical for 2D matrices?: True
```

---

### Task 3: Transpose & Statistical Functions (Instagram Image Pixels)
**Problem Statement:**  
*Given a 4x4 NumPy matrix representing the pixel brightness of a small Instagram image, use transpose (.T) to rotate the image and then calculate the mean, median, standard deviation, and variance of the pixel values.*

```python
# 4x4 Instagram image pixel brightness matrix
insta_pixels = np.array([
    [120, 145, 180, 200],
    [110, 135, 175, 195],
    [90, 125, 160, 185],
    [80, 100, 140, 170]
])

# Transpose matrix to rotate axes
transposed_image = insta_pixels.T

print("Original 4x4 Image Pixels:\n", insta_pixels)
print("\nTransposed Image Pixels (.T):\n", transposed_image)

print("\nStatistical Metrics of Pixel Values:")
print("Mean               :", np.mean(transposed_image))
print("Median             :", np.median(transposed_image))
print("Standard Deviation :", np.std(transposed_image))
print("Variance           :", np.var(transposed_image))
```

**Output:**
```text
Original 4x4 Image Pixels:
 [[120 145 180 200]
 [110 135 175 195]
 [ 90 125 160 185]
 [ 80 100 140 170]]

Transposed Image Pixels (.T):
 [[120 110  90  80]
 [145 135 125 100]
 [180 175 160 140]
 [200 195 185 170]]

Statistical Metrics of Pixel Values:
Mean               : 144.375
Median             : 142.5
Standard Deviation : 36.86440525764658
Variance           : 1358.984375
```

---

### Task 4: Linear Algebra — Inverse, Determinant, Eigenvalues (Zomato Grid)
**Problem Statement:**  
*Take a 3x3 NumPy matrix representing a Zomato restaurant rating correlation grid and use np.linalg.inv(), np.linalg.det(), and np.linalg.eig() to compute its inverse, determinant, and eigenvalues/eigenvectors.*  
*Hint: If the matrix is not invertible, modify one value and try again.*

```python
# 3x3 Zomato restaurant rating correlation matrix (invertible with non-zero determinant)
zomato_correlation = np.array([
    [1.0, 0.4, 0.2],
    [0.4, 1.0, 0.3],
    [0.2, 0.3, 1.0]
])

# Determinant
det_val = np.linalg.det(zomato_correlation)

# Inverse matrix
inv_matrix = np.linalg.inv(zomato_correlation)

# Eigenvalues and eigenvectors
eigenvalues, eigenvectors = np.linalg.eig(zomato_correlation)

print("Zomato Correlation Grid (3x3):\n", zomato_correlation)
print("\nDeterminant (np.linalg.det):", det_val)
print("\nInverse Matrix (np.linalg.inv):\n", inv_matrix)
print("\nEigenvalues:\n", eigenvalues)
print("\nEigenvectors:\n", eigenvectors)
```

**Output:**
```text
Zomato Correlation Grid (3x3):
 [[1.  0.4 0.2]
 [0.4 1.  0.3]
 [0.2 0.3 1. ]]

Determinant (np.linalg.det): 0.7580000000000001

Inverse Matrix (np.linalg.inv):
 [[ 1.2005277  -0.44854881 -0.1055409 ]
 [-0.44854881  1.26649077 -0.29023747]
 [-0.1055409  -0.29023747  1.10817942]]

Eigenvalues:
 [1.60754228 0.58117765 0.81128007]

Eigenvectors:
 [[-0.58437021 -0.60133499 -0.54488349]
 [-0.63462947  0.75716172 -0.1550478 ]
 [-0.50580796 -0.25524314  0.8240375 ]]
```

---

### Task 5: Array Manipulation — Reshape, Flatten, Split, Stack (Swiggy Orders)
**Problem Statement:**  
*Create a NumPy array of shape (2, 6) representing the number of orders placed on Swiggy in two cities over 6 days. Reshape it to (3, 4), flatten it, split it into two equal parts, and then stack both parts vertically.*

```python
# Swiggy orders in 2 cities over 6 days (shape: 2, 6)
swiggy_orders = np.array([
    [120, 150, 180, 200, 220, 250],  # City 1
    [90, 110, 130, 140, 160, 175]    # City 2
])

print("Original Orders Array (shape 2, 6):\n", swiggy_orders)

# 1. Reshape to (3, 4)
reshaped_orders = swiggy_orders.reshape(3, 4)
print("\n1. Reshaped Array (shape 3, 4):\n", reshaped_orders)

# 2. Flatten array
flattened_orders = reshaped_orders.flatten()
print("\n2. Flattened Array (shape 12,):\n", flattened_orders)

# 3. Split into two equal parts (6 elements each)
part1, part2 = np.split(flattened_orders, 2)
print("\n3. Split into Two Equal Parts:")
print("Part 1:", part1)
print("Part 2:", part2)

# 4. Stack both parts vertically (shape 2, 6)
stacked_vertically = np.vstack((part1, part2))
print("\n4. Vertically Stacked (np.vstack):\n", stacked_vertically)
```

**Output:**
```text
Original Orders Array (shape 2, 6):
 [[120 150 180 200 220 250]
 [ 90 110 130 140 160 175]]

1. Reshaped Array (shape 3, 4):
 [[120 150 180 200]
 [220 250  90 110]
 [130 140 160 175]]

2. Flattened Array (shape 12,):
 [120 150 180 200 220 250  90 110 130 140 160 175]

3. Split into Two Equal Parts:
Part 1: [120 150 180 200 220 250]
Part 2: [ 90 110 130 140 160 175]

4. Vertically Stacked (np.vstack):
 [[120 150 180 200 220 250]
 [ 90 110 130 140 160 175]]
```

---

## 📁 Files in this Directory

```text
Session-03/
├── README.md                        # Session documentation & explanations
└── session_3_numpy_advanced.ipynb   # Interactive Jupyter Notebook with outputs & markdown
```

---

## 🚀 How to Run

```bash
# Launch Jupyter Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-03/session_3_numpy_advanced.ipynb"
```
