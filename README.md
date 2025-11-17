# Olist E-commerce Analysis: A Deep Dive into Logistics, Satisfaction, and Profitability

**Author:** Zeeshan Akram  <br>
**LinkedIn:** [LinkedIn Profile](https://www.linkedin.com/in/zeeshan-akram-572bbb34a)

## 1. Project Objective

This project is a comprehensive analysis of the Olist e-commerce dataset, simulating a real-world business consultation. The primary goal is to move beyond surface-level metrics to identify the core drivers of **customer dissatisfaction** and **operational bottlenecks**.

The analysis provides actionable, data-driven recommendations to help Olist improve its logistics network, enhance customer satisfaction, and optimize its product and seller portfolio.

## 2. Key Business Questions

My analysis was structured to answer the most critical questions a business stakeholder would have:

1.  **The "Satisfaction" Problem:** What is the *true* relationship between delivery performance and customer satisfaction? Are low prices a more significant factor, or is it all about logistics?
2.  **The "Bottleneck" Problem:** Where do delays actually come from? Is it the sellers (`processing_time`), the shippers (`shipping_time`), or the regional network?
3.  **The "Portfolio" Problem:** Which product categories are our "Stars" (high revenue, high satisfaction) and which are our "Duds" (low revenue, low satisfaction)?
4.  **The "Customer" Problem:** Who are our most valuable customers, and what are their purchasing patterns? (To be answered in the RFM Analysis).

## 3. Technical Workflow & Methodology

This project followed a rigorous, professional data analysis workflow.

### A. Data Cleaning & ETL (Notebook 01)
* **Source:** 9 separate CSV files from Kaggle, representing 113k+ order items.
* **Process:**
    * Loaded and inspected all 9 tables, identifying all Primary and Foreign Keys.
    * Handled critical data integrity issues (e.g., imputed `0` installments, fixed impossible negative shipping times).
    * Optimized data types (`category`, `int8`, `float32`) to reduce the final memory footprint by over 60%.
    * De-duplicated one-to-many tables (e.g., `reviews`, `payments`, `geolocation`) to make them "merge-safe."
    * Dropped irrelevant columns to create a lean, focused master table.
* **Result:** A single, clean, and validated `master_df` folder.

### B. Feature Engineering (Notebook 02)
I engineered several new features to move from raw data to business metrics:
* `approval_time`, `processing_time`, `shipping_time`: To isolate bottlenecks in the fulfillment funnel.
* `delivery_delta`: The most critical feature, calculating the *days* an order was late or early.
* `freight_ratio`: A "customer friction" metric (`freight_value` / `price`).
* `purchase_month`, `purchase_day_of_week`, `purchase_hour`: For baseline business cycle analysis.
* `delivery_status`: A human-readable category ("Delivered On Time," "Delivered Late," "Not Delivered").

### C. Exploratory Data Analysis (EDA) (Notebook 02)
This is where the "story" was uncovered. My analysis was not just a collection of charts but a focused investigation to prove or disprove hypotheses.

---

## 4. Key Findings & Actionable Recommendations

This is the "so what?" of the analysis. I have uncovered several conclusive, high-impact insights.

### Finding 1: Logistics is the *Only* Driver of Satisfaction
My analysis is definitive: **customers care about delivery, not price.**

* **The Proof:** The correlation between `review_score` and `price` (or `freight_value`) is **zero**. The correlation with `delivery_delta` and `shipping_time` is significant.
* **The "Satisfaction Cliff":** Orders `Delivered On Time` have a high average review score of **~4.2**. The moment an order is `Delivered Late`, that score is cut almost in half to **~2.5**.

**Recommendation:** All business efforts to improve satisfaction must be focused on logistics.



### Finding 2: The "Inconsistency" Problem
The business doesn't have an "average" speed problem; it has an **unreliability problem.**

* **The Insight:** The *median* processing and shipping times are fast (1 and 10 days, respectively). However, the "long tail" of outliers is extreme, with some sellers taking 120+ days and shippers taking 200+ days.
* **The Action:** The business must focus on reducing these extreme outliers, as they are the source of the 1-star reviews.

### Finding 3: The Three Bottlenecks (Where, Who, & What)
I isolated the primary sources of delays:

* **WHERE (Geographic Failure):** The worst-performing states are **`RO` (Rondônia)** and **`AM` (Amazonas)**, with average delays of **+18 days**. This is a logistics network failure.
    * **Recommendation:** Immediately **increase the `estimated_delivery_date`** for these states. A customer promised 15 days is happier than a customer promised 5 days and getting it in 15.
* **WHO (Seller Failure):** The business relies on "mega-sellers." Our **2nd biggest seller (`...10ab`) is a critical bottleneck**, with an 11-day average processing lag.
    * **Recommendation:** Intervene with this high-volume seller immediately to fix their fulfillment process.
* **WHAT (Product Failure):** After filtering for significant sample sizes, the worst delays come from "unexpected" categories like **`fashion_shoes`** and **`art`**, which do not match customer expectations for small items.
    * **Recommendation:** Investigate the supply chain for these specific categories.

### Finding 4: The "High-Value" vs. "High-Volume" Categories
Not all products are created equal. My revenue analysis found two distinct business models.

* **Volume Driver:** `bed_bath_table` (Home Goods) is **#1 in sales volume** but only #3 in revenue.
* **Value Driver:** `watches_gifts` is only **#8 in sales volume** but is the **#2 largest source of revenue**.
* **Recommendation:** The business should protect its "Value Driver" categories and focus on a high-volume, low-margin strategy for its "Volume Drivers."

## 5. Tools & Technologies
* **Python 3.10**
* **Pandas:** For all data manipulation, cleaning, and aggregation.
* **NumPy:** For numerical operations and `np.select()` for feature engineering.
* **Seaborn & Matplotlib:** For all data visualizations.
* **JupyterLab:** As the primary development environment.
* **Git & GitHub:** For version control.

## 6. How to Run This Project
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/zeeshan-akram-ds/Olist-ECommerce-Analysis
    ```
2.  **Create the environment:**
    ```bash
    conda create -n olist python=3.10
    conda activate olist
    pip install -r requirements.txt
    ```
3.  **Download the data:**
    * Download the Olist dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
    * Unzip and place all 9 `.csv` files into the `raw_data/` folder.
4.  **Run the notebooks:**
    * Open `01_Data_Cleaning_and_Integration.ipynb` and run all cells. This will generate the `master_data.csv` in the `outputs/` folder.
    * Open `02_Analysis.ipynb` to review the complete exploratory data analysis.