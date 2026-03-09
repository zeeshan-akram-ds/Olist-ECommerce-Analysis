# **Olist E-commerce Analysis: Revenue, Logistics, and Retention**

**Author:** Zeeshan Akram

**LinkedIn:** [LinkedIn Profile](https://www.linkedin.com/in/zeeshan-akram-572bbb34a)

## **📌 Executive Summary**

This project is a full-stack data analysis of 113,000+ orders from Olist, a Brazilian e-commerce platform. I built this project to move beyond basic charts and find the actual reasons behind customer churn and flatlining revenue.

The project is split into two phases:

1. **Python:** Used for deep data cleaning, merging 5 relational tables, and exploratory data analysis.  
2. **SQL (MySQL):** Used to write advanced business intelligence queries (CTEs, Window Functions) to extract executive-level metrics.

**Key Project Numbers:**

* **113,425** total orders analyzed  
* **5** complex SQL business queries written  
* **99.5%** customer churn rate identified  
* **4** distinct customer segments created (RFM)

## **Phase 1: SQL Business Intelligence**

*(All SQL scripts are located in the sql\_analysis/ folder)*

I exported the cleaned dataset into MySQL to answer five critical business questions using advanced SQL techniques.

### **1\. Month-over-Month (MoM) Revenue Growth**

* **SQL Used:** LAG() Window Function, Date formatting.  
* **The Finding:** The platform saw massive growth in 2017, peaking at nearly $1M in revenue during November (Black Friday). However, the hyper-growth stopped in 2018\. From March to August 2018, revenue flattened completely to low single-digit growth.

### **2\. Logistics Impact on Reviews**

* **SQL Used:** CASE WHEN, Advanced Aggregations.  
* **The Finding:** Shipping speed is the absolute biggest driver of customer happiness. Deliveries that arrive late cause a massive spike in 1-star reviews, directly damaging the company's reputation.

### **3\. Top Seller Accountability**

* **SQL Used:** Aggregations, ORDER BY logic.  
* **The Finding:** I ranked the top 10 sellers who bring in the most money, and calculated their specific late-delivery rates. This shows which top partners are helping the brand and which ones are hurting it through poor logistics.

### **4\. RFM Customer Segmentation**

* **SQL Used:** Common Table Expressions (CTEs), Conditional Logic.  
* **The Finding:** I successfully replicated Python-based RFM (Recency, Frequency, Monetary) segmentation using pure SQL. I grouped the customer base into "Whales", "Loyalists", and "At-Risk" buyers based on their total spend and order history.

### **5\. Cohort Retention Analysis**

* **SQL Used:** Advanced CTEs, FIRST\_VALUE() Window Function, Date Math.  
* **The Finding:** The business has a severe retention problem. Over 99% of customers never make a second purchase. For example, the November 2017 promo acquired 7,060 new customers, but only 40 (0.57%) came back the next month. The business relies entirely on acquiring new users because it fails to keep old ones.

## **Phase 2: Python Exploratory Data Analysis**

*(Jupyter Notebooks located in the notebooks/ folder)*

Before running the SQL analysis, I used Python (Pandas, Seaborn) to clean the raw data and perform initial data exploration.

### **1\. The "Satisfaction Cliff"**

I mapped review scores against delivery times. The data shows a clear cliff: when an order takes longer than 15 days to deliver, the average review score drops from a healthy 4.2 stars down to 2.5 stars.

### **2\. Freight vs. Price Ratio**

Many customers left 1-star reviews even when the product was delivered on time. The data revealed this happens when the shipping cost (freight) is higher than the actual product price. Customers feel cheated by high shipping fees on cheap items.

## **Strategic Business Recommendations**

Based on the combined SQL and Python analysis, Olist should take the following actions:

1. **improve retention:** Since 99.5% of customers do not return, the marketing team must create an aggressive "Second Purchase" campaign. Offer a massive discount (e.g., 30% off) that only unlocks if they buy a second item within 30 days of their first order.  
2. **Warn Underperforming Sellers:** Use the SQL Seller Performance report to send automated warnings to high-revenue sellers who have high late-delivery rates. If they do not improve their shipping times, lower their ranking in the search results.  
3. **Set Safer Delivery Expectations:** The business is failing to meet estimated delivery dates in specific regions. By adding just 3 extra buffer days to the estimated delivery date at checkout, **Olist** can manage customer expectations and prevent 1-star reviews.

## **Tools & Technologies**

* **Database:** MySQL (Window Functions, CTEs, Joins)  
* **Programming:** Python  
* **Libraries:** Pandas, NumPy, Seaborn, Matplotlib  
* **Environment:** JupyterLab  
* **Version Control:** Git & GitHub

## **How to Run This Project**

1. **Clone the repository:**  
   git clone \[https://github.com/zeeshan-akram-ds/Olist-ECommerce-Analysis\](https://github.com/zeeshan-akram-ds/Olist-ECommerce-Analysis)

2. **Install requirements:**  
   pip install \-r requirements.txt

3. **Data Setup:**  
   * Download the Olist dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).  
   * Place the raw .csv files into a raw\_data/ folder.  
   * Run the Python notebooks to clean the data and generate cleaned\_data.csv.  
4. **SQL Setup:**  
   * Import cleaned\_data.csv into a MySQL database.  
   * Run the scripts located in the sql\_analysis/ folder to generate the business insights.