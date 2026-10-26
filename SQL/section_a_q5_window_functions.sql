-- ============================================================================
-- Section A - Question S5: SQL Window Functions vs. GROUP BY
-- Preferred Technology: SQL (SQLite)
-- Assessment: M4-A1 Data Science
-- ============================================================================
-- SCENARIO:
-- Food delivery analytics dashboard.
-- Requirements:
-- 1. Rank all delivery agents within each city by their completed deliveries.
-- 2. Display how each agent's count compares to the agent ranked directly above.
-- Functions used: DENSE_RANK() and LAG() with PARTITION BY city.
-- ============================================================================

-- 1. Table Schema
CREATE TABLE IF NOT EXISTS delivery_agents_monthly (
    agent_id INTEGER PRIMARY KEY,
    agent_name TEXT NOT NULL,
    city TEXT NOT NULL,
    completed_deliveries INTEGER NOT NULL
);

-- 2. Populate Sample Agent Delivery Records
INSERT INTO delivery_agents_monthly (agent_id, agent_name, city, completed_deliveries) VALUES
(1, 'Aarav (Mumbai Top)', 'Mumbai', 185),
(2, 'Rohit (Mumbai 2nd)', 'Mumbai', 160),
(3, 'Kavita (Mumbai 3rd)', 'Mumbai', 145),
(4, 'Siddharth (Mumbai Tie)', 'Mumbai', 145),
(5, 'Vikram (Delhi Top)', 'Delhi', 190),
(6, 'Neha (Delhi 2nd)', 'Delhi', 175),
(7, 'Ananya (Delhi 3rd)', 'Delhi', 130),
(8, 'Kabir (Bangalore Top)', 'Bangalore', 210),
(9, 'Pooja (Bangalore 2nd)', 'Bangalore', 195);

-- ============================================================================
-- WINDOW FUNCTION QUERY:
-- 1. DENSE_RANK() OVER (PARTITION BY city ORDER BY completed_deliveries DESC)
-- 2. LAG(completed_deliveries, 1) OVER (PARTITION BY city ORDER BY completed_deliveries DESC)
-- ============================================================================
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
    ) AS above_agent_deliveries,
    COALESCE(
        LAG(completed_deliveries, 1) OVER (
            PARTITION BY city 
            ORDER BY completed_deliveries DESC
        ) - completed_deliveries, 
        0
    ) AS delivery_gap_to_above
FROM delivery_agents_monthly
ORDER BY city ASC, city_rank ASC;

-- EXPECTED RESULT:
-- +----------+------------------------+-----------+----------------------+-----------+------------------------+-----------------------+
-- | agent_id | agent_name             | city      | completed_deliveries | city_rank | above_agent_deliveries | delivery_gap_to_above |
-- +----------+------------------------+-----------+----------------------+-----------+------------------------+-----------------------+
-- | 8        | Kabir (Bangalore Top)  | Bangalore | 210                  | 1         | NULL                   | 0                     |
-- | 9        | Pooja (Bangalore 2nd)  | Bangalore | 195                  | 2         | 210                    | 15                    |
-- | 5        | Vikram (Delhi Top)     | Delhi     | 190                  | 1         | NULL                   | 0                     |
-- | 6        | Neha (Delhi 2nd)       | Delhi     | 175                  | 2         | 190                    | 15                    |
-- | 7        | Ananya (Delhi 3rd)     | Delhi     | 130                  | 3         | 175                    | 45                    |
-- | 1        | Aarav (Mumbai Top)     | Mumbai    | 185                  | 1         | NULL                   | 0                     |
-- | 2        | Rohit (Mumbai 2nd)     | Mumbai    | 160                  | 2         | 185                    | 25                    |
-- | 3        | Kavita (Mumbai 3rd)    | Mumbai    | 145                  | 3         | 160                    | 15                    |
-- | 4        | Siddharth (Mumbai Tie) | Mumbai    | 145                  | 3         | 145                    | 0                     |
-- +----------+------------------------+-----------+----------------------+-----------+------------------------+-----------------------+
