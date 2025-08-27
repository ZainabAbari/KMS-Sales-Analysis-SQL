#  KMS Sales Analysis

## Introduction
This project analyzes the sales performance of **KMS**, a retail company, using **SQL queries** to extract insights on customers, products, revenue, and shipping efficiency. The goal is to answer critical business questions and provide **data-driven recommendations** to improve profitability and operational efficiency.
---

##  Business Questions Answered
1. Which product category had the highest sales?
2. What are the top and bottom 3 regions by total sales?
3. What were the total sales of appliances in Ontario?
4. Who are the bottom 10 customers and how can revenue be improved?
5. Which shipping method incurred the highest cost?
6. Who are the most valuable customers and what do they buy?
7. Which small business customer had the highest sales?
8. Which corporate customer placed the most orders (2009–2012)?
9. Which consumer customer was the most profitable?
10. Which customers returned items and their segments?
11. Did the company spend shipping costs appropriately based on order priority?
---

# Tools I Used
To explore the retail company, I relied on a set of powerful tools:
- **SQL** – The foundation of my analysis, enabling me to query databases and extract meaningful insights.
- **Python** – using Seaborn for visualisation.
- **GitHub** – Essential for version control, collaboration, and tracking the progress of my SQL scripts and analysis.
---

#  The Analysis
Each query in this project was crafted to answer a specific business question for the KMS retail company. Below is an overview of how I approached each question and the corresponding SQL logic.

## 1. Top Product Category
```sql
SSELECT TOP 1 Product_Category, SUM(Sales) AS TotalSales
FROM KMS
GROUP BY Product_Category
ORDER BY TotalSales DESC
```
- **Category:** Technology
- **Action:** Increase inventory and marketing budget for Technology products.





##  Key Insights
- **Top Product Category:** Technology had the highest total sales.
- **Regional Performance:** East and West regions lead in revenue; Central region underperformed.
- **Shipping Cost:** Express Air is the most expensive method but often used for low-priority orders.
- **Customer Value:** High-value customers primarily buy Technology and Office Supplies.
- **Returns Analysis:** Certain customers returned multiple items, impacting profit.
---

##  Recommendations
- **Match shipping method to priority:** Use Express Air for high-priority orders only.  
- **Boost low-performing regions:** Target promotions in Central region.  
- **Engage low-value customers:** Loyalty programs or bundle offers.  
- **Focus on profitable categories:** Increase marketing for Technology and Office Supplies.  
---

## ▶ How to Use
- Open `KMS_SQL_Queries.sql` to view all queries.
- Run queries in any SQL environment (SQL Server, MySQL, PostgreSQL).
- Check `Insights.md` for summarized findings and recommendations.
---

##  Optional Visualizations
Dashboards and charts can be added in the `Visualizations/` folder using **Power BI, Tableau, or Python**.
---

## 📁 Repository Structure
