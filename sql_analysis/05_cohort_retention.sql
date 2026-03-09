-- BUSINESS QUESTION 5: Cohort Retention Analysis
-- Out of the customers who made their first purchase in a given month, what 
-- percentage of them returned to make another purchase in the following months?
--
-- BUSINESS VALUE:
-- This is the most critical metric for startup growth. It reveals whether the 
-- business is actually retaining customers or just constantly paying to 
-- acquire new ones who never return.

WITH first_purchases AS (
    SELECT
        customer_unique_id,
        DATE_FORMAT(MIN(order_purchase_timestamp), '%Y-%m-01') AS cohort_month
    FROM olist_data
    WHERE order_status = 'delivered'
    GROUP BY customer_unique_id
),
all_purchases AS (
    SELECT
        customer_unique_id,
        DATE_FORMAT(order_purchase_timestamp, '%Y-%m-01') AS order_month
    FROM olist_data
    WHERE order_status = 'delivered'
),
cohort_activity AS (
    SELECT 
        fp.customer_unique_id,
        fp.cohort_month,
        TIMESTAMPDIFF(MONTH, fp.cohort_month, ap.order_month) AS month_number
    FROM first_purchases fp
    JOIN all_purchases ap
        ON fp.customer_unique_id = ap.customer_unique_id
),
cohort_counts AS (
    SELECT
        cohort_month,
        month_number,
        COUNT(DISTINCT customer_unique_id) AS active_customers
    FROM cohort_activity
    GROUP BY cohort_month, month_number
)

-- Adding the Percentage Calculation using FIRST_VALUE()
SELECT
    cohort_month,
    month_number,
    active_customers,
    FIRST_VALUE(active_customers) OVER (PARTITION BY cohort_month ORDER BY month_number) AS cohort_size,
    
    ROUND(
        (active_customers / FIRST_VALUE(active_customers) OVER (PARTITION BY cohort_month ORDER BY month_number)) * 100
    , 2) AS retention_pct
FROM cohort_counts
ORDER BY cohort_month, month_number;