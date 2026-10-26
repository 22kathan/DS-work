# Session 19: Case Study – Zomato Bangalore Restaurants

**Course**: Data Science  
**Module**: Working with Databases  
**Preferred Technology**: **SQL (MySQL Community Server 8.0 & MySQL Workbench)**  
**Target Table**: `zomato_bangalore_restaurants`  
**Target Database**: `session19_db`  
**Source Files**:
* SQL Pipeline: [`session_19_zomato_bangalore.sql`](session_19_zomato_bangalore.sql)
* Dataset: [`zomato_bangalore_dataset.csv`](zomato_bangalore_dataset.csv)

---

## Task 1: Top 5 Highest-Rated North Indian Restaurants in Koramangala

### Objective
Write an SQL query to find the top 5 highest-rated restaurants in Koramangala that serve North Indian cuisine, using the Zomato Bangalore dataset.

### SQL Implementation
```sql
CREATE DATABASE IF NOT EXISTS session19_db;
USE session19_db;

DROP TABLE IF EXISTS zomato_bangalore_restaurants;

CREATE TABLE zomato_bangalore_restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    online_order VARCHAR(10) NOT NULL,
    book_table VARCHAR(10) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    votes INT NOT NULL,
    location VARCHAR(100) NOT NULL,
    cuisine VARCHAR(100) NOT NULL,
    approx_cost_for_two INT NOT NULL
);

-- Ingest dataset from zomato_bangalore_dataset.csv (or batch insert)
-- Query for Top 5 North Indian in Koramangala:
SELECT 
    name, 
    location, 
    cuisine, 
    rating, 
    votes, 
    approx_cost_for_two
FROM zomato_bangalore_restaurants
WHERE location LIKE '%Koramangala%'
  AND cuisine LIKE '%North Indian%'
ORDER BY rating DESC, votes DESC
LIMIT 5;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT name, location, cuisine, rating, votes, approx_cost_for_two FROM zomato_bangalore_restaurants WHERE location LIKE '%Koramangala%' AND cuisine LIKE '%North Indian%' ORDER BY rating DESC, votes DESC LIMIT 5;
+------------------+-----------------------+--------------+--------+-------+---------------------+
| name             | location              | cuisine      | rating | votes | approx_cost_for_two |
+------------------+-----------------------+--------------+--------+-------+---------------------+
| Punjab Grill     | Koramangala 5th Block | North Indian |    4.8 |  2450 |                1600 |
| Oye Amritsar     | Koramangala 7th Block | North Indian |    4.5 |  1890 |                 900 |
| Tandoori Taal    | Koramangala 4th Block | North Indian |    4.4 |  1250 |                 800 |
| Sultans of Spice | Koramangala 5th Block | North Indian |    4.3 |  1420 |                1300 |
| Kapoor's Cafe    | Koramangala 6th Block | North Indian |    4.2 |   980 |                 500 |
+------------------+-----------------------+--------------+--------+-------+---------------------+
5 rows in set (0.00 sec)
```

---

## Task 2: 3 Most Expensive Cuisines in Bangalore

### Objective
Using SQL, calculate the average cost for two people for each cuisine type and list the 3 most expensive cuisines to eat in Bangalore.

### SQL Implementation
```sql
SELECT 
    cuisine,
    ROUND(AVG(approx_cost_for_two), 2) AS avg_cost_for_two,
    COUNT(restaurant_id) AS restaurant_count
FROM zomato_bangalore_restaurants
GROUP BY cuisine
ORDER BY avg_cost_for_two DESC
LIMIT 3;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT cuisine, ROUND(AVG(approx_cost_for_two), 2) AS avg_cost_for_two, COUNT(restaurant_id) AS restaurant_count FROM zomato_bangalore_restaurants GROUP BY cuisine ORDER BY avg_cost_for_two DESC LIMIT 3;
+---------------+------------------+------------------+
| cuisine       | avg_cost_for_two | restaurant_count |
+---------------+------------------+------------------+
| Japanese      |          2650.00 |                2 |
| European      |          2350.00 |                2 |
| Mediterranean |          2050.00 |                2 |
+---------------+------------------+------------------+
3 rows in set (0.00 sec)
```

---

## Task 3: Low-Rated Online Delivery Outlets & Marketing Turnaround Strategy

### Objective
Find all restaurants that offer online delivery but have a rating below 3.0, and suggest a marketing strategy to improve their ratings based on your findings.

### SQL Implementation
```sql
SELECT 
    restaurant_id,
    name,
    location,
    cuisine,
    approx_cost_for_two,
    rating,
    votes
FROM zomato_bangalore_restaurants
WHERE online_order = 'Yes'
  AND rating < 3.0
ORDER BY rating ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT restaurant_id, name, location, cuisine, approx_cost_for_two, rating, votes FROM zomato_bangalore_restaurants WHERE online_order = 'Yes' AND rating < 3.0 ORDER BY rating ASC;
+---------------+--------------------+-----------------+--------------+---------------------+--------+-------+
| restaurant_id | name               | location        | cuisine      | approx_cost_for_two | rating | votes |
+---------------+--------------------+-----------------+--------------+---------------------+--------+-------+
|            15 | Quick Bite Corner  | Marathahalli    | Chinese      |                 250 |    2.5 |    95 |
|            13 | Midnight Munchies  | BTM 2nd Stage   | Fast Food    |                 300 |    2.6 |   120 |
|            14 | Daily Bowl Express | Electronic City | North Indian |                 350 |    2.8 |    85 |
|            16 | Rolls & Bowls      | HSR Layout      | Fast Food    |                 300 |    2.9 |   140 |
+---------------+--------------------+-----------------+--------------+---------------------+--------+-------+
4 rows in set (0.00 sec)
```

### Pattern Analysis & Diagnostic Findings
1. **Budget Pricing Squeeze**: All low-performing delivery outlets fall strictly into the ultra-budget category (`approx_cost_for_two <= 350 INR`). Thin profit margins frequently compromise ingredient freshness, portion sizes, and delivery container quality.
2. **High Transit & Traffic Choke Points**: Outlets operate in high-density IT/tech corridors (Marathahalli, Electronic City, BTM, HSR Layout) subject to severe peak-hour traffic bottlenecks, increasing order delivery latency and resulting in cold food complaints.
3. **Transit-Sensitive Cuisines**: Fast food, gravies, and rolls suffer rapid degradation (sogginess, spillage) during uninsulated two-wheeler transport.

### Actionable Marketing & Operational Strategies
1. **Packaging Quality Subsidies**: Partner with certified food packaging vendors to implement tamper-evident, steam-vented, and thermally insulated containers to eliminate sogginess and leakage.
2. **Dynamic Delivery Radii & SLAs**: Restrict the maximum delivery radius during peak traffic hours (e.g. from 7 km down to 3.5 km) to guarantee delivery times under 30 minutes.
3. **Targeted Review Recovery Campaigns**: Implement an automated feedback recapture workflow offering a 40% discount coupon and complimentary side dish to customers who gave 1-star or 2-star ratings, prompting them to re-evaluate after quality improvements.
4. **Menu Rationalization**: Remove bottom-selling dishes with high prep variability; focus kitchen throughput on the 5 highest-margin, travel-resilient signature items.

---

## Task 4: Market Segmentation by Average Cost for Two

### Objective
Write an SQL query to segment restaurants into three market segments based on average cost for two: budget (below 400), mid-range (400-800), and premium (above 800). Count how many restaurants fall into each segment.

### SQL Implementation
```sql
SELECT 
    CASE 
        WHEN approx_cost_for_two < 400 THEN 'Budget (< 400)'
        WHEN approx_cost_for_two BETWEEN 400 AND 800 THEN 'Mid-Range (400 - 800)'
        ELSE 'Premium (> 800)'
    END AS market_segment,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating), 2) AS avg_segment_rating,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM zomato_bangalore_restaurants), 2) AS percentage_share
FROM zomato_bangalore_restaurants
GROUP BY 
    CASE 
        WHEN approx_cost_for_two < 400 THEN 'Budget (< 400)'
        WHEN approx_cost_for_two BETWEEN 400 AND 800 THEN 'Mid-Range (400 - 800)'
        ELSE 'Premium (> 800)'
    END
ORDER BY MIN(approx_cost_for_two) ASC;
```

### Execution Output (MySQL Workbench / CLI)
```text
mysql> SELECT CASE WHEN approx_cost_for_two < 400 THEN 'Budget (< 400)' WHEN approx_cost_for_two BETWEEN 400 AND 800 THEN 'Mid-Range (400 - 800)' ELSE 'Premium (> 800)' END AS market_segment, COUNT(*) AS restaurant_count, ROUND(AVG(rating), 2) AS avg_segment_rating, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM zomato_bangalore_restaurants), 2) AS percentage_share FROM zomato_bangalore_restaurants GROUP BY CASE WHEN approx_cost_for_two < 400 THEN 'Budget (< 400)' WHEN approx_cost_for_two BETWEEN 400 AND 800 THEN 'Mid-Range (400 - 800)' ELSE 'Premium (> 800)' END ORDER BY MIN(approx_cost_for_two) ASC;
+-----------------------+------------------+--------------------+------------------+
| market_segment        | restaurant_count | avg_segment_rating | percentage_share |
+-----------------------+------------------+--------------------+------------------+
| Budget (< 400)        |                9 |               3.24 |            21.43 |
| Mid-Range (400 - 800) |               23 |               4.04 |            54.76 |
| Premium (> 800)       |               10 |               4.53 |            23.81 |
+-----------------------+------------------+--------------------+------------------+
3 rows in set (0.00 sec)
```

---

## Task 5: Top 10 Most Popular Restaurant Chains (AI-Assisted Query Validation)

### Objective
Use ChatGPT or Copilot to help you write an SQL query that lists the top 10 most popular restaurant chains (by number of outlets) in the dataset, then run and validate the query yourself.

### 1. AI Prompt Formulated
> *"I have a SQL table `zomato_bangalore_restaurants` containing restaurant data across Bangalore. Write an optimized MySQL query that identifies the top 10 most popular restaurant chains based on their total number of outlets. Include the chain name, total outlet count, average customer rating, and average cost for two. Ensure chains with only a single standalone outlet are excluded, and order results by outlet count descending."*

### 2. AI Code Suggestion
```sql
SELECT 
    name AS restaurant_chain,
    COUNT(*) AS total_outlets,
    ROUND(AVG(rating), 2) AS avg_chain_rating,
    ROUND(AVG(approx_cost_for_two), 2) AS avg_cost_for_two
FROM zomato_bangalore_restaurants
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY total_outlets DESC, avg_chain_rating DESC
LIMIT 10;
```

### 3. Execution & Verification Output (MySQL Workbench / CLI)
```text
mysql> SELECT name AS restaurant_chain, COUNT(*) AS total_outlets, ROUND(AVG(rating), 2) AS avg_chain_rating, ROUND(AVG(approx_cost_for_two), 2) AS avg_cost_for_two FROM zomato_bangalore_restaurants GROUP BY name HAVING COUNT(*) > 1 ORDER BY total_outlets DESC, avg_chain_rating DESC LIMIT 10;
+-------------------+---------------+------------------+------------------+
| restaurant_chain  | total_outlets | avg_chain_rating | avg_cost_for_two |
+-------------------+---------------+------------------+------------------+
| Cafe Coffee Day   |             4 |             3.65 |           450.00 |
| Onesta            |             3 |             4.40 |           600.00 |
| Empire Restaurant |             3 |             4.20 |           700.00 |
| Domino's Pizza    |             3 |             4.10 |           500.00 |
| Five Star Chicken |             3 |             3.60 |           250.00 |
| McDonald's        |             2 |             4.15 |           500.00 |
| KFC               |             2 |             4.05 |           550.00 |
| Pizza Hut         |             2 |             3.95 |           600.00 |
| Subway            |             2 |             3.95 |           400.00 |
| Just Bake         |             2 |             3.75 |           350.00 |
+-------------------+---------------+------------------+------------------+
10 rows in set (0.00 sec)
```

### 4. Technical Validation
* `GROUP BY name` aggregates across unique branch occurrences of identical multi-outlet brand names.
* `HAVING COUNT(*) > 1` excludes single-location standalone restaurants, isolating genuine multi-branch franchise chains.
* Multi-column tie-breaker ordering (`total_outlets DESC, avg_chain_rating DESC`) ensures deterministic and competitive ranking.
