# Section A: Concept Application — Assessment M4-A1
**Program**: Data Science  
**Module 3–4**: Data Collection, Cleaning & Visualization › Working with Databases  
**Stack**: Python 3 (NumPy, Pandas, Seaborn) / SQL (SQLite)

---

## Question S1: Data Cleaning Strategy (Pandas)

### Scenario
> You are a Data Analyst at a food delivery startup. You have loaded a dataset of 50,000 order records into a Pandas DataFrame. The `'delivery_time_mins'` column has 14% missing values, and the `'customer_rating'` column contains some entries stored as strings (e.g., `'4.5'`) instead of `float64`.

### 1. Strategy for Handling Missing Values in `'delivery_time_mins'`
**Decision: Median Imputation** (Do **not** drop rows; do **not** use mean imputation).

#### Justification:
1. **Percentage of Missing Data (14%)**:
   - In a dataset of 50,000 records, 14% missing represents **7,000 lost records**.
   - Dropping 7,000 rows causes substantial sample loss, diminishes statistical power, and risks introducing severe **selection bias** (e.g., missing delivery times may systematically correlate with cancelled orders, extreme weather delays, or specific vendor logistics rather than being Missing Completely at Random [MCAR]).
   - As a standard data science practice, row deletion is only justified when missingness is negligible ($< 3\text{--}5\%$).
2. **Distribution Skewness**:
   - Food delivery duration is inherently **right-skewed (positively skewed)**: the majority of orders complete within a standard window (e.g., 25–40 minutes), but long-tail delivery times (e.g., 80–120+ minutes due to rain, peak-hour gridlock, or long delivery distances) pull the distribution to the right.
   - The **mean** is highly sensitive to extreme outliers and will overestimate central delivery times.
   - The **median** is robust to extreme outliers and accurately reflects the typical customer experience.

### 2. Exact Pandas Steps to Fix `'customer_rating'`
To safely convert `'customer_rating'` from string/object to `float64`, handle any invalid non-numeric strings (e.g., `'NA'`, `'None'`, `'?'`, whitespace) by coercing them to `NaN`, and verify data types:

```python
import pandas as pd

# Step 1: Impute missing delivery times using the column median
median_delivery = df['delivery_time_mins'].median()
df['delivery_time_mins'] = df['delivery_time_mins'].fillna(median_delivery)

# Step 2: Convert customer_rating to numeric float64, coercing invalid strings to NaN
df['customer_rating'] = pd.to_numeric(df['customer_rating'].astype(str).str.strip(), errors='coerce')

# Step 3: Verify the conversion and data types
print("Missing delivery times after imputation:", df['delivery_time_mins'].isna().sum())
print("Data type of customer_rating:", df['customer_rating'].dtype)
```

---

## Question S2: Vectorized Surge Day Detection (NumPy)

### Scenario
> You are building a weekly performance report for a food delivery platform. You have a NumPy array of daily order counts across 30 days. Your manager wants to flag 'surge days' — days where the order count exceeds the mean by more than 1.5 standard deviations — and compute the total revenue only for those surge days using a matching revenue array.

### 1. How NumPy Boolean Indexing & Statistical Functions Work Together
Without writing any explicit `for` loops, NumPy executes this workflow through array broadcasting and element-wise comparisons:

1. **Calculate Threshold**:
   ```python
   surge_threshold = np.mean(order_counts) + 1.5 * np.std(order_counts)
   ```
2. **Generate Boolean Mask**:
   ```python
   surge_mask = order_counts > surge_threshold
   ```
3. **Filter and Aggregate Matching Revenue**:
   ```python
   total_surge_revenue = np.sum(revenue[surge_mask])
   ```

### 2. What is a Boolean Mask?
A **boolean mask** is a NumPy array consisting strictly of `True` and `False` values with the exact same shape (or broadcastable shape) as the source array. When indexed into an array (`revenue[surge_mask]`), NumPy inspects each element's corresponding boolean slot and extracts only elements positioned at `True` indices.

### 3. Why Vectorized Element-wise Operations Outperform Python Loops
| Feature | Native Python `for` Loop | NumPy Vectorized Array Operations |
| :--- | :--- | :--- |
| **Memory Layout** | Array of pointers to fragmented Python heap objects (`PyObject`). | Continuous, contiguous memory blocks (C-style buffers) maximizing CPU cache locality. |
| **Execution Layer** | Interpreted Python Virtual Machine (bytecode execution). | Pre-compiled, highly optimized C / Fortran routines. |
| **Type Checking** | Dynamically checks data types and unwraps objects on **every single iteration**. | Homogeneous datatypes (`dtype`); type checking occurs only once at invocation. |
| **Hardware Acceleration** | Sequential execution on a single core; no automatic vectorization. | Leverages modern CPU **SIMD (Single Instruction, Multiple Data)** registers (e.g., AVX2 / AVX-512) to evaluate multiple items per clock cycle. |

---

## Question S3: Exploratory Data Analysis & Visualization (Seaborn)

### Scenario
> You are conducting EDA for a food delivery product team. Your dataset contains columns: `restaurant_category`, `average_order_value`, `customer_rating`, and `delivery_time_mins`. The team wants to know (a) whether delivery time is correlated with customer rating, and (b) how average order value is distributed across restaurant categories.

### Analysis & Chart Selection Table

| Question | Business Goal | Analysis Type | Recommended Seaborn Chart | Justification & Why a Line Plot Fails |
| :--- | :--- | :--- | :--- | :--- |
| **(a)** | Correlate `delivery_time_mins` with `customer_rating`. | **Bivariate Analysis** (Continuous vs. Continuous) | `sns.scatterplot()` (or `sns.regplot()` with a trendline) | • **Why Scatter Plot**: Maps each individual order as a coordinate point $(x, y)$, revealing correlation patterns, clustering, heteroscedasticity, and non-linear trends.<br>• **Why Line Plot Fails**: A line plot connects sequential points under the assumption of continuous, ordered data (e.g., time-series). Unordered customer orders sharing similar delivery times would create a chaotic, zigzagging "spaghetti" plot. |
| **(b)** | Distribution of `average_order_value` across `restaurant_category`. | **Bivariate Analysis** (Categorical vs. Continuous) | `sns.boxplot()` (or `sns.violinplot()`) | • **Why Box Plot**: Compactly displays key five-number summary statistics (minimum, $Q_1$, median, $Q_3$, maximum) along with outlier dots for each category.<br>• **Why Line Plot Fails**: Restaurant categories are discrete, nominal classes (e.g., Italian, Fast Food, Bakery). Connecting them with lines falsely implies a mathematical continuity or progression between categories. |

---

## Question S4: SQL Joins for Comprehensive Reporting

### Scenario
> You are managing a food delivery database with three tables: `orders` (`order_id`, `customer_id`, `restaurant_id`, `order_value`), `restaurants` (`restaurant_id`, `name`, `city`, `category`), and `customers` (`customer_id`, `name`, `area`). A business team asks for a report showing every restaurant's name and total revenue, including restaurants that have not yet received any orders.

### 1. Required SQL JOIN Type
**`LEFT OUTER JOIN`** (or simply `LEFT JOIN`), placing `restaurants` on the left and `orders` on the right:

```sql
SELECT 
    r.name AS restaurant_name,
    COALESCE(SUM(o.order_value), 0.0) AS total_revenue
FROM restaurants r
LEFT JOIN orders o 
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name
ORDER BY total_revenue DESC;
```

### 2. What Would Happen If an `INNER JOIN` Were Used?
* An `INNER JOIN` strictly outputs rows where the join predicate (`r.restaurant_id = o.restaurant_id`) evaluates to `TRUE` in **both** tables.
* If a restaurant has 0 orders, no corresponding records exist in `orders`.
* Consequently, an `INNER JOIN` **silently filters out and discards** all restaurants with zero orders. This violates the business requirement to report on *all* restaurants (e.g., newly onboarded or underperforming merchants).

### 3. Handling of Unmatched Rows
* A `LEFT JOIN` guarantees that **every record from the left table (`restaurants`) is retained** regardless of matches in the right table (`orders`).
* For restaurants with zero orders, the engine populates all attributes from the `orders` table with `NULL`.
* Using `COALESCE(SUM(o.order_value), 0.0)` gracefully converts `NULL` sums into a numerical `0.00`, ensuring valid reporting.

---

## Question S5: SQL Window Functions vs. GROUP BY

### Scenario
> You are working on a food delivery analytics dashboard. Management wants to rank all delivery agents within each city by their number of completed deliveries for the current month, and also display how each agent's count compares to the agent ranked directly above them in that city.

### 1. Identification of the Two Window Functions
1. **Ranking Function**: `DENSE_RANK() OVER (PARTITION BY city ORDER BY completed_deliveries DESC)`  
   *(Assigns consecutive ordinal rankings without gaps in the event of ties).*
2. **Lag Function (Previous Row Retrieval)**: `LAG(completed_deliveries, 1) OVER (PARTITION BY city ORDER BY completed_deliveries DESC)`  
   *(Fetches the completed delivery count of the agent immediately preceding in rank within that city).*

#### SQL Implementation:
```sql
SELECT 
    agent_id,
    agent_name,
    city,
    completed_deliveries,
    DENSE_RANK() OVER (
        PARTITION BY city 
        ORDER BY completed_deliveries DESC
    ) AS city_rank,
    LAG(completed_deliveries, 1) OVER (
        PARTITION BY city 
        ORDER BY completed_deliveries DESC
    ) AS prev_agent_deliveries,
    (LAG(completed_deliveries, 1) OVER (
        PARTITION BY city 
        ORDER BY completed_deliveries DESC
    ) - completed_deliveries) AS gap_to_above_agent
FROM delivery_agents_monthly;
```

### 2. Advantages over `GROUP BY` with Self-Joins or Correlated Subqueries
1. **Preservation of Row Grain**: `GROUP BY` collapses individual agent records into aggregated group summaries. Window functions calculate partition-level rankings while preserving each individual agent's row identity.
2. **Computational Performance ($\mathcal{O}(N \log N)$ vs. $\mathcal{O}(N^2)$)**:
   - Window functions sort the dataset within partitions once and iterate linearly.
   - A self-join or correlated subquery evaluates matching conditions against the full dataset for every row, triggering an expensive $\mathcal{O}(N^2)$ Cartesian comparison that degrades rapidly on large datasets.
3. **Robust Handling of Ties & Nulls**: Window functions deterministically handle rank ties and automatically output `NULL` for the top-ranked agent without requiring complex conditional subquery logic.
4. **Code Maintainability**: Declarative window syntax is concise, readable, and less prone to edge-case bugs compared to multi-layered subqueries.

---

## Question S6: CTE (WITH Clause) vs. Nested Subquery

### Scenario
> You are optimising a SQL report for a food delivery operations team. The report first identifies the top 5 restaurant categories by total order count, and then retrieves the full order details only for restaurants belonging to those top categories. A colleague has written this as a deeply nested subquery inside the WHERE clause.

### 1. SQL Implementations Comparison

#### CTE Approach (Recommended):
```sql
WITH top_5_categories AS (
    SELECT r.category
    FROM orders o
    JOIN restaurants r ON o.restaurant_id = r.restaurant_id
    GROUP BY r.category
    ORDER BY COUNT(o.order_id) DESC
    LIMIT 5
)
SELECT 
    o.order_id,
    o.order_value,
    o.delivery_time_mins,
    r.name AS restaurant_name,
    r.category
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN top_5_categories t ON r.category = t.category;
```

#### Nested Subquery Approach:
```sql
SELECT 
    o.order_id,
    o.order_value,
    o.delivery_time_mins,
    r.name AS restaurant_name,
    r.category
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE r.category IN (
    SELECT category
    FROM (
        SELECT r_sub.category, COUNT(o_sub.order_id) AS order_cnt
        FROM orders o_sub
        JOIN restaurants r_sub ON o_sub.restaurant_id = r_sub.restaurant_id
        GROUP BY r_sub.category
        ORDER BY order_cnt DESC
        LIMIT 5
    )
);
```

### 2. Trade-Off Evaluation

| Metric | CTE (`WITH` clause) | Nested Subquery (inside `WHERE`) |
| :--- | :--- | :--- |
| **Readability** | **High**: Follows a linear, top-to-bottom procedural flow (modular logic matches human thought process). | **Low**: Reads inside-out with nested parentheses, creating cognitive overhead and harder code reviews. |
| **Reusability** | **High**: The named CTE (`top_5_categories`) can be joined or referenced multiple times within the query without re-declaring. | **Zero**: Scoped strictly to the specific `IN` clause; reusing it requires copying and pasting the full subquery. |
| **Debuggability** | **High**: Developers can isolate and test `SELECT * FROM top_5_categories` independently during troubleshooting. | **Low**: Extracting and testing internal subqueries requires manually stripping outer statements. |

### 3. Specific Situations Where a Nested Subquery is Preferred
1. **Simple Scalar Comparisons**: When comparing against a single aggregated value (e.g., `WHERE order_value > (SELECT AVG(order_value) FROM orders)`), writing a CTE introduces unnecessary verbosity.
2. **Correlated `EXISTS` Semi-Joins**: When filtering with `WHERE EXISTS (...)`, database query planners can perform short-circuit evaluation (stopping at the first match) rather than materializing a CTE buffer.
3. **One-Off Ephemeral Conditions**: In lightweight queries where an intermediate result is only referenced once and does not impact query clarity.
