-- BUSINESS QUESTION 3: Seller Accountability & Performance
-- Which 10 sellers are generating the most revenue, and what is their
-- track record for late deliveries?
--
-- BUSINESS VALUE:
-- Identifies top-performing partners for potential rewards or exclusive
-- contracts, while exposing high-revenue sellers who might be hurting
-- the brand with high late-delivery rates.

SELECT
    seller_id,
    ROUND(SUM(price), 2) AS total_revenue,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 100.0 ELSE 0 END), 2) AS pct_late_deliveries
FROM olist_data
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;