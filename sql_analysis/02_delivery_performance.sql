-- BUSINESS QUESTION 2: Logistics Performance and Customer Satisfaction
-- How do delivery delays impact customer review scores? Specifically, what 
-- is the average review score and the percentage of 1-star reviews for 
-- orders delivered on time versus orders delivered late?
--
-- BUSINESS VALUE:
-- Quantifies the exact financial and reputational cost of poor logistics. 
-- Proves to management that investing in faster shipping directly prevents 
-- customer churn and protects the brand rating.

SELECT 
    CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
        
    COUNT(order_id) AS total_orders,
    
    ROUND(AVG(review_score), 2) AS avg_review_score,
    
    ROUND(AVG(CASE WHEN review_score = 1 THEN 100.0 ELSE 0 END), 2) AS pct_1_star_reviews

FROM olist_data
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL 
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY 
    CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Late'
        ELSE 'On Time'
    END;

