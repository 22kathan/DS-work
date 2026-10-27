# Session 1: NumPy Foundations (Part 1: Arrays & Creation)

This directory contains the solutions, runnable Python implementations, and interactive Jupyter notebook for **Session 1: NumPy Foundations (Part 1: Arrays & Creation)** under the **Data collection, Cleaning, Visualization and Analysis** curriculum.

---

## 📋 Table of Contents
- [Session Overview & Topics Covered](#-session-overview--topics-covered)
- [Task 1: Installing & Importing NumPy (`insta_likes.py`)](#-task-1-installing--importing-numpy-insta_likespy)
- [Task 2: Instagram Influencer Followers Array (`np.array`)](#-task-2-instagram-influencer-followers-array-nparray)
- [Task 3: Consecutive Zomato Order IDs (`np.arange`)](#-task-3-consecutive-zomato-order-ids-nparange)
- [Task 4: Spotify Playlist 'Like' Identity Matrix (`np.eye`)](#-task-4-spotify-playlist-like-identity-matrix-npeye)
- [Task 5: Cricket Scores List-to-Array Conversion & Memory Footprint (`.itemsize`)](#-task-5-cricket-scores-list-to-array-conversion--memory-footprint-itemsize)
- [Contiguous Memory Architecture: NumPy vs. Python Lists](#-contiguous-memory-architecture-numpy-vs-python-lists)
- [Summary Table](#-summary-table)
- [Files in this Directory](#-files-in-this-directory)

---

## 🎯 Session Overview & Topics Covered

NumPy (**Numerical Python**) is the backbone of the scientific Python and Data Science ecosystem (forming the foundation for Pandas, SciPy, Scikit-learn, TensorFlow, and PyTorch).

### Key Concepts Covered:
1. **Why NumPy is Essential**: Vectorization, SIMD CPU instruction acceleration, avoidance of Python GIL loop overhead, and cache-friendly memory locality.
2. **Import Conventions**: Standard aliased import `import numpy as np`.
3. **Array Creation Family**:
   - `np.array()`: Converting standard Python sequences into fixed-type homogeneous n-dimensional arrays.
   - `np.arange(start, stop, step)`: Sequential sequence generator over half-open intervals $[start, stop)$.
   - `np.linspace(start, stop, num)`: Linearly spaced floating-point samples.
   - `np.zeros()`, `np.ones()`, `np.full()`: Uniform matrix initializers.
   - `np.eye(N)`: Identity matrix generator with ones on the main diagonal.
4. **Essential Array Attributes**:
   - `shape`: Tuple denoting dimensions (e.g., `(5,)`, `(3, 3)`).
   - `ndim`: Number of array axes/dimensions ($1$ for vectors, $2$ for 2D matrices).
   - `size`: Total number of elements across all axes.
   - `dtype`: Element data type (`int64`, `float64`, etc.).
   - `itemsize`: Memory consumption per element in bytes.
5. **Memory Layout**: C-contiguous packed buffers vs. pointer references in Python lists.

---

## 🛠️ Task 1: Installing & Importing NumPy (`insta_likes.py`)

**Task Description:**  
*Install NumPy in your Python environment using pip, then create a Python file called `insta_likes.py` and import numpy as np at the top.*

```python
# Task 1: Import NumPy
import numpy as np
```

* NumPy is installed in the project virtual environment (`.venv`).
* Standard alias `np` provides access to all vectorized submodules and data types.

---

## 📸 Task 2: Instagram Influencer Followers Array (`np.array`)

**Task Description:**  
*Create a NumPy array called `followers` using `np.array()` that stores the follower counts for 5 Instagram influencers: `[1200, 15000, 67000, 340000, 1250000]`. Print the array, its shape, number of dimensions, and data type.*

### Implementation:
```python
followers = np.array([1200, 15000, 67000, 340000, 1250000])

print("Followers Array        :", followers)
print("Array Shape            :", followers.shape)
print("Number of Dimensions   :", followers.ndim)
print("Data Type (dtype)      :", followers.dtype)
```

### Execution Output:
```text
Followers Array        : [   1200   15000   67000  340000 1250000]
Array Shape            : (5,)
Number of Dimensions   : 1
Data Type (dtype)      : int64
```

### Explanation:
* **`shape = (5,)`**: Indicates a 1D vector containing 5 distinct entries.
* **`ndim = 1`**: Represents 1 axis of traversal.
* **`dtype = int64`**: Automatically inferred as 64-bit signed integers based on platform architecture and integer magnitude.

---

## 🍕 Task 3: Consecutive Zomato Order IDs (`np.arange`)

**Task Description:**  
*Use `np.arange()` to generate an array of order IDs for 10 consecutive Zomato orders starting from 101. Print the array and its size.*

### Implementation:
```python
# 10 consecutive orders starting from 101: [101, 102, ..., 110]
# Range is [101, 111) because stop boundary is exclusive
zomato_orders = np.arange(101, 111)

print("Zomato Order IDs Array :", zomato_orders)
print("Total Number of Orders :", zomato_orders.size)
```

### Execution Output:
```text
Zomato Order IDs Array : [101 102 103 104 105 106 107 108 109 110]
Total Number of Orders : 10
```

### Explanation:
* Like Python's built-in `range()`, `np.arange()` generates values up to but not including `stop`. Setting `start=101` and `stop=111` guarantees exactly 10 consecutive integer order IDs.
* `zomato_orders.size` returns `10`.

---

## 🎵 Task 4: Spotify Playlist 'Like' Identity Matrix (`np.eye`)

**Task Description:**  
*Create a 3x3 NumPy array using `np.eye()` to represent a 'like' identity matrix for a new Spotify playlist feature. Print the matrix and explain what the diagonal values represent in a comment.*

### Implementation:
```python
spotify_like_matrix = np.eye(3)

# COMMENT EXPLANATION:
# In a Spotify collaborative recommendation or user-track interaction matrix:
# - The diagonal elements (value 1.0) represent the self-similarity or direct self-affinity
#   of a playlist/track with itself (i.e., track i compared with track i is a 100% match / self-like).
# - The off-diagonal elements (value 0.0) represent neutral initial cross-similarity between
#   distinct items before collaborative filtering weights or user interactions are calculated.

print("Spotify 'Like' Identity Matrix (3x3):")
print(spotify_like_matrix)
print("Diagonal Elements      :", spotify_like_matrix.diagonal())
```

### Execution Output:
```text
Spotify 'Like' Identity Matrix (3x3):
[[1. 0. 0.]
 [0. 1. 0.]
 [0. 0. 1.]]
Diagonal Elements      : [1. 1. 1.]
```

### Domain Explanation:
* An identity matrix $I_n$ satisfies $I_{i,j} = 1$ when $i = j$ and $0$ when $i \neq j$.
* In music recommendation systems, self-similarity is maximal ($1.0$). Each song or playlist is intrinsically identical to itself. Off-diagonal zeros indicate no baseline cross-match until user listening signals (co-occurrence, skips, completions) are factored into the matrix.

---

## 🏏 Task 5: Cricket Scores List-to-Array Conversion & Memory Footprint (`.itemsize`)

**Task Description:**  
*Convert a Python list of cricket scores `[45, 67, 120, 89, 54]` to a NumPy array, then use the `.itemsize` attribute to print how many bytes each score takes in memory.*  
*(Hint: Use `np.array()` for conversion and `.itemsize` for memory size.)*

### Implementation:
```python
cricket_scores_list = [45, 67, 120, 89, 54]
cricket_scores_array = np.array(cricket_scores_list)

print("Original Python List   :", cricket_scores_list)
print("Converted NumPy Array  :", cricket_scores_array)
print("Array Data Type (dtype):", cricket_scores_array.dtype)
print("Bytes per item (itemsize):", cricket_scores_array.itemsize, "bytes")
print("Total array memory     :", cricket_scores_array.nbytes, "bytes")
```

### Execution Output:
```text
Original Python List   : [45, 67, 120, 89, 54]
Converted NumPy Array  : [ 45  67 120  89  54]
Array Data Type (dtype): int64
Bytes per item (itemsize): 8 bytes
Total array memory     : 40 bytes
```

---

## 🧠 Contiguous Memory Architecture: NumPy vs. Python Lists

| Metric / Dimension | Python Native `list` | NumPy `ndarray` |
|---|---|---|
| **Memory Allocation** | Discontiguous pointers pointing to boxed `PyObject` wrappers across the heap | Contiguous linear memory buffer in C RAM |
| **Per-Element Size** | 28 bytes (`PyLongObject`) + 8 bytes (pointer) = **36 bytes/int** | Exactly **8 bytes** (`int64`) or **4 bytes** (`int32`) |
| **Memory Locality** | Cache misses due to pointer dereferencing | High CPU L1/L2/L3 cache hit rate |
| **Vectorization** | Requires slow iterative bytecode evaluation (`for` loops) | SIMD hardware vectorization (AVX, SSE) |
| **Contiguous Flag** | Not applicable | `flags['C_CONTIGUOUS'] == True` |

---

## 📊 Summary Table

| Task | Target Context | Method / Attribute | Value / Result | Practical Significance |
| :---: | :--- | :--- | :--- | :--- |
| **1** | Environment & Imports | `import numpy as np` | NumPy 2.5.4 | Baseline dependency for fast numeric analytics |
| **2** | Instagram Influencers | `np.array()`, `shape`, `ndim`, `dtype` | `(5,)`, `ndim=1`, `int64` | Ingesting follower metrics into vectorized vectors |
| **3** | Zomato Delivery Orders | `np.arange(101, 111)`, `size` | `[101..110]`, `size=10` | Ordered tracking ID generation |
| **4** | Spotify Playlist Identity | `np.eye(3)` | $3 \times 3$ Identity Matrix | Diagonal ($1.0$) encodes self-similarity baseline |
| **5** | Cricket Scores Memory | `.itemsize`, `.nbytes` | $8$ bytes/item, $40$ bytes total | Efficient memory allocation in linear C buffer |

---

## 📂 Files in this Directory

* [`insta_likes.py`](./insta_likes.py) — Standalone executable Python script demonstrating all 5 session tasks.
* [`session_1_numpy_foundations.ipynb`](./session_1_numpy_foundations.ipynb) — Fully executed Jupyter Notebook with comprehensive notes, theory, and outputs.
* [`README.md`](./README.md) — Documentation and task breakdowns.
