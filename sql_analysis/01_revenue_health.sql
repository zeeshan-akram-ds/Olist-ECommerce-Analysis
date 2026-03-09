-- BUSINESS QUESTION 1: Month-over-Month (MoM) Revenue Growth
-- What is our historical revenue growth, and when are our peak sales periods?
--
-- BUSINESS VALUE:
-- Identifies seasonal trends and business momentum, allowing the marketing 
-- and logistics teams to plan capacity for peak months.

WITH MonthlyRevenue AS (
    SELECT 
        YEAR(order_purchase_timestamp) AS sales_year,
        MONTH(order_purchase_timestamp) AS sales_month,
        SUM(price) AS total_revenue
    FROM olist_data
    WHERE order_status = 'delivered'
    GROUP BY 
        YEAR(order_purchase_timestamp), 
        MONTH(order_purchase_timestamp)
),
RevenueWithLag AS (
    SELECT 
        sales_year,
        sales_month,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY sales_year, sales_month) AS prev_month_revenue
    FROM MonthlyRevenue
)

SELECT 
    sales_year,
    sales_month,
    ROUND(total_revenue, 2) AS current_revenue,
    ROUND(prev_month_revenue, 2) AS previous_revenue,
    ROUND(((total_revenue - prev_month_revenue) / prev_month_revenue) * 100, 2) AS mom_growth_pct
FROM RevenueWithLag
ORDER BY sales_year, sales_month;