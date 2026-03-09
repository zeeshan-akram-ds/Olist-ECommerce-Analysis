-- BUSINESS QUESTION 4: Customer RFM Segmentation
-- How can we segment our customers based on their buying behavior (Recency, 
-- Frequency, Monetary) using purely SQL? 
--
-- BUSINESS VALUE:
-- Allows marketing teams to create highly targeted campaigns. We can identify 
-- our "Whales" (high spend, frequent buyers) and our "Churn Risk" customers 
-- (high spend, but haven't bought recently).

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
)

SELECT
    customer_unique_id,
    recency,
    frequency,
    monetary,
    CASE
        WHEN monetary > 500 AND frequency > 1 THEN 'Whales'
        WHEN recency < 90 AND frequency > 1 THEN 'Loyalists'
        WHEN recency > 200 AND monetary > 300 THEN 'At-Risk High Value'
        ELSE 'Standard Customers'
    END AS customer_segment
FROM customer_rfm_base
ORDER BY monetary DESC
LIMIT 20;