# Session 01: NumPy Foundations (Part 1: Arrays & Creation)

**Module:** Data Collection, Cleaning, Visualization and Analysis  
**Session:** 01  
**Status:** ✅ Completed

---

## 📌 Topics Covered
- **What is NumPy & why it's essential for Data Science**
  - High-performance N-dimensional array processing (`ndarray`)
  - Vectorization and C-speed contiguous memory execution without Python loop overhead
- **Installing & importing NumPy**
  - Standard alias: `import numpy as np`
- **Creating NumPy arrays**
  - `np.array()`: Direct creation from Python lists / sequences
  - `np.arange()`: Sequential interval generator
  - `np.linspace()`: Evenly spaced numbers over a specified interval
  - `np.zeros()`, `np.ones()`, `np.full()`: Fixed value array initialization
  - `np.eye()`: 2D identity matrix generator
- **Array attributes**
  - `shape`, `ndim`, `size`, `dtype`, `itemsize`
- **Conversion between Python lists and NumPy arrays**
- **Understanding contiguous memory layout**

---

## 📋 Task Walkthrough & Implementation

### Task 1: Installing & Importing NumPy (`insta_likes.py`)
**Problem Statement:**  
*Install NumPy in your Python environment using pip, then create a Python file called `insta_likes.py` and import numpy as np at the top.*

```python
# Task 1: Install NumPy via pip and import with standard alias
import numpy as np
```

---

### Task 2: Instagram Influencer Followers Array (`np.array`)
**Problem Statement:**  
*Create a NumPy array called `followers` using `np.array()` that stores the follower counts for 5 Instagram influencers: `[1200, 15000, 67000, 340000, 1250000]`. Print the array, its shape, number of dimensions, and data type.*

```python
followers = np.array([1200, 15000, 67000, 340000, 1250000])

print("Followers Array        :", followers)
print("Array Shape            :", followers.shape)
print("Number of Dimensions   :", followers.ndim)
print("Data Type (dtype)      :", followers.dtype)
```

**Output:**
```text
Followers Array        : [   1200   15000   67000  340000 1250000]
Array Shape            : (5,)
Number of Dimensions   : 1
Data Type (dtype)      : int64
```

---

### Task 3: Consecutive Zomato Order IDs (`np.arange`)
**Problem Statement:**  
*Use `np.arange()` to generate an array of order IDs for 10 consecutive Zomato orders starting from 101. Print the array and its size.*

```python
# 10 consecutive orders starting from 101 (half-open range [101, 111))
zomato_orders = np.arange(101, 111)

print("Zomato Order IDs Array :", zomato_orders)
print("Total Number of Orders :", zomato_orders.size)
```

**Output:**
```text
Zomato Order IDs Array : [101 102 103 104 105 106 107 108 109 110]
Total Number of Orders : 10
```

---

### Task 4: Spotify Playlist 'Like' Identity Matrix (`np.eye`)
**Problem Statement:**  
*Create a 3x3 NumPy array using `np.eye()` to represent a 'like' identity matrix for a new Spotify playlist feature. Print the matrix and explain what the diagonal values represent in a comment.*

```python
spotify_like_matrix = np.eye(3)

# COMMENT EXPLANATION:
# In recommendation systems and collaborative filtering similarity matrices:
# - The diagonal elements (value 1.0) represent the self-affinity or direct self-similarity
#   of a playlist/track with itself (i.e., item i compared with item i is a 100% match / self-like).
# - The off-diagonal elements (value 0.0) represent neutral initial cross-similarity between
#   distinct items before collaborative filtering weights or user interactions are calculated.
print("Spotify 'Like' Identity Matrix (3x3):")
print(spotify_like_matrix)
print("Diagonal Values        :", spotify_like_matrix.diagonal())
```

**Output:**
```text
Spotify 'Like' Identity Matrix (3x3):
[[1. 0. 0.]
 [0. 1. 0.]
 [0. 0. 1.]]
Diagonal Values        : [1. 1. 1.]
```

---

### Task 5: Cricket Scores List Conversion & Memory Footprint (`.itemsize`)
**Problem Statement:**  
*Convert a Python list of cricket scores `[45, 67, 120, 89, 54]` to a NumPy array, then use the `.itemsize` attribute to print how many bytes each score takes in memory.*  
*Hint: Use `np.array()` for conversion and `.itemsize` for memory size.*

```python
cricket_scores_list = [45, 67, 120, 89, 54]
cricket_scores_array = np.array(cricket_scores_list)

print("Original Python List   :", cricket_scores_list)
print("Converted NumPy Array  :", cricket_scores_array)
print("Array Data Type (dtype):", cricket_scores_array.dtype)
print("Bytes per item (itemsize):", cricket_scores_array.itemsize, "bytes")
print("Total array memory     :", cricket_scores_array.nbytes, "bytes")
```

**Output:**
```text
Original Python List   : [45, 67, 120, 89, 54]
Converted NumPy Array  : [ 45  67 120  89  54]
Array Data Type (dtype): int64
Bytes per item (itemsize): 8 bytes
Total array memory     : 40 bytes
```

---

## 🧠 Memory Architecture: Python Lists vs. NumPy ndarrays

| Feature | Standard Python `list` | NumPy `ndarray` |
| :--- | :--- | :--- |
| **Memory Layout** | Array of pointers referencing discrete `PyObject` integers scattered across the heap | Contiguous linear memory buffer holding raw binary numeric data (`C_CONTIGUOUS`) |
| **Memory Overhead** | High (each integer has a 28-byte `PyObject` wrapper + 8-byte pointer = ~36 bytes per item) | Minimal (exactly 8 bytes per 64-bit integer, inspected via `.itemsize`) |
| **CPU Cache Efficiency** | Poor (cache misses due to pointer dereferencing) | Optimal (adjacent bytes are prefetched into CPU L1/L2 caches) |
| **Performance** | Slow interpreted iteration subject to Python GIL | SIMD vectorized operations executed in optimized C / Fortran routines |

---

## 📁 Files in this Directory

```text
Session-01/
├── README.md             # Session documentation & explanations
├── insta_likes.py        # Complete runnable standalone Python script
└── insta_likes.ipynb     # Interactive Jupyter Notebook with outputs & markdown
```

---

## 🚀 How to Run

```bash
# Execute standalone script
python "Data collection, Cleaning, Visualization and Analysis/Session-01/insta_likes.py"

# Or launch Jupyter Notebook
jupyter notebook "Data collection, Cleaning, Visualization and Analysis/Session-01/insta_likes.ipynb"
```
