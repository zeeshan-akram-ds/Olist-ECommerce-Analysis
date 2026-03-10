-- BUSINESS QUESTION 4: Customer RFM Segmentation
-- How can we segment our customers based on their buying behavior (Recency, 
-- Frequency, Monetary) using purely SQL? 
--
-- BUSINESS VALUE:
-- Aligns with our Python RFM model. Allows marketing teams to create highly 
-- targeted campaigns, specifically separating our "Promising" one-time buyers 
-- from our "Lost" customers to optimize win-back ad spend.

WITH customer_rfm_base AS (
    SELECT 
        customer_unique_id,
        DATEDIFF(
        (SELECT MAX(order_purchase_timestamp) FROM olist_data),
        MAX(order_purchase_timestamp)
		) AS recency,
        COUNT(DISTINCT order_id) AS frequency,
        ROUND(SUM(price), 2) AS monetary
    FROM olist_data
    WHERE order_status = 'delivered'
    GROUP BY customer_unique_id
),
rfm_scores AS (
    SELECT 
        customer_unique_id,
        recency,
        frequency,
        monetary,
        -- NTILE(4) sorts into 4 buckets. 
        -- ORDER BY recency DESC ensures the lowest days (best) get a score of 4.
        NTILE(4) OVER (ORDER BY recency DESC) AS r_score,
        
        -- M_Score: ORDER BY monetary ASC ensures the highest spend (best) gets a 4.
        NTILE(4) OVER (ORDER BY monetary ASC) AS m_score
    FROM customer_rfm_base
)

SELECT
    customer_unique_id,
    recency,
    frequency,
    monetary,
    r_score,
    m_score,
    CASE
        WHEN frequency > 1 THEN 'Loyalists'
        WHEN frequency = 1 AND r_score = 4 AND m_score = 4 THEN 'Promising'
        WHEN frequency = 1 AND r_score = 4 THEN 'New Customers'
        WHEN frequency = 1 AND r_score IN (2, 3) THEN 'At Risk'
        WHEN frequency = 1 AND r_score = 1 THEN 'Lost'
        ELSE 'Other'
    END AS customer_segment
FROM rfm_scores
ORDER BY monetary DESC
LIMIT 20;