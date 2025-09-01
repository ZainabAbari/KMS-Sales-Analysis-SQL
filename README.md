#  KMS Sales Analysis

## Introduction

This project analyzes the sales performance of **KMS**, a retail company, using SQL queries to extract insights on customers, products, revenue, and shipping efficiency. The goal is to answer critical business questions and provide data-driven recommendations to improve profitability and operational efficiency.
---

###  Business Questions Answered
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
### Tools I Used
To explore the retail company, I relied on a set of powerful tools:
- **SQL** – The foundation of my analysis, enabling me to query databases and extract meaningful insights.
- **Python** – using Seaborn for visualisation.
- **GitHub** – Essential for version control, collaboration, and tracking the progress of my SQL scripts and analysis.
---
###  The Analysis
Each query in this project was crafted to answer a specific business question for the KMS retail company. Below is an overview of how I approached each question and the corresponding SQL logic.

### 1. Top Product Category: 
I started by looking at all product categories to see which one contributed the most to revenue. Technology stood out as top, showing where the company’s strength lies.
```sql
SELECT TOP 1 Product_Category, SUM(Sales) AS TotalSales
FROM KMS
GROUP BY Product_Category
ORDER BY TotalSales DESC
```
<img width="295" height="228" alt="image" src="https://github.com/user-attachments/assets/947f36c1-2c29-4870-b020-7d0ca18d03d7" />
*Bar graph visualizing Product Categories by Total sales*
Recommendation:
Focus marketing and promotional campaigns on Technology products to maximize revenue.

### 2. Top 3 and Bottom 3 Regions by Sales: 
I compared regions to identify the strongest and weakest performers. The East and West regions dominated, while the Central region lagged behind, signaling an opportunity for targeted growth.
```sql
SELECT region, total_sales, 'Top' AS category
FROM (
    SELECT TOP 3 region, SUM(sales) AS total_sales
    FROM KMS
    GROUP BY region
    ORDER BY SUM(sales) DESC
) AS top_regions
UNION ALL
SELECT region, total_sales, 'Bottom' AS category
FROM (
    SELECT TOP 3 region, SUM(sales) AS total_sales
    FROM KMS
    GROUP BY region
    ORDER BY SUM(sales) ASC
) AS bottom_regions
ORDER BY category, total_sales DESC;
```
<img width="290" height="229" alt="image" src="https://github.com/user-attachments/assets/ea70aa67-34d2-4076-806b-ba90a0d7428f" />
*Bar graph visualizing Top 3 and Bottom 3 Regions by Sales*
Recommendation:
Introduce targeted campaigns and better distribution strategies in underperforming regions.

### 3. Total sales of appliances in Ontario: 
Zooming into Ontario, I checked how appliances performed. This helped me understand regional demand for specific product lines.
```sql
SELECT Product_Sub_Category, SUM(Sales) AS TotalSales
FROM KMS
WHERE Province = 'Ontario'
GROUP BY Product_Sub_Category;
```
<img width="235" height="204" alt="image" src="https://github.com/user-attachments/assets/9aed6b84-183e-41d5-9e04-ce40dab0a166" />
*Pie Chart visualizing Total sales of appliances in Ontario*
Recommendation:
Boost sales with regional promotions or bundle offers on appliances.

### 4. Bottom 10 customers by revenue:
I then focused on the least profitable customers. These are clients who need attention—perhaps through loyalty programs, discounts, or personalized offers to boost their engagement.
```sql
SELECT TOP 10 Customer_Name, SUM(Sales) AS Revenue
FROM KMS
GROUP BY Customer_Name
ORDER BY Revenue ASC;
```
Recommendation:
Engage these customers with personalized discounts or loyalty programs to increase spending.

### 5. Shipping method with the highest cost: 
Shipping costs can eat into profits, so I analyzed the shipping modes. Express Air turned out to be the most expensive, raising questions about whether it’s being used efficiently.
```sql
SELECT TOP 1 Ship_Mode, SUM(Shipping_Cost) AS TotalShippingCost
FROM KMS
GROUP BY Ship_Mode
ORDER BY TotalShippingCost DESC;
```
Recommendation:
Use Express Air only for critical orders; consider switching to economical options for low-priority deliveries.

### 6. Most valuable customers and products purchased:
High-value customers drive growth, so I identified them and examined their favorite products. Knowing what they buy most often helps in creating personalized promotions.
```sql
SELECT TOP 10 Customer_Name, Product_Name, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM KMS
GROUP BY Customer_Name, Product_Name
ORDER BY TotalSales DESC
```
Recommendation:
Offer loyalty rewards, early access to new products, and exclusive deals to retain these customers.

### 7. Small business customer with highest sales:
Among small business clients, I found the top spender. This insight is useful for building strong partnerships and offering tailored deals.
```sql
SELECT TOP 1 Customer_Name, SUM(Sales) AS TotalSales
FROM KMS
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY TotalSales DESC;
```
Recommendation:
Build partnerships and offer volume-based discounts for small business clients.

### 8. Corporate customer with most orders between 2009 and 2012:
For corporate clients, I wanted to see who had been the most consistent over time. One customer stood out with frequent orders during this period, showing loyalty that can be nurtured further.
```sql
SELECT TOP 1 Customer_Name, COUNT(Order_ID) AS TotalOrders
FROM KMS
WHERE Customer_Segment = 'Corporate'
AND YEAR(Order_Date) BETWEEN 2009 AND 2012
GROUP BY Customer_Name
ORDER BY TotalOrders DESC;
```
Recommendation:
Create a tailored corporate plan or retention package to maintain long-term engagement.

### 9. Most profitable consumer customer: 
For corporate clients, I wanted to see who had been the most consistent over time. One customer stood out with frequent orders during this period, showing loyalty that can be nurtured further.
```sql
SELECT TOP 1 Customer_Name, SUM(Profit) AS TotalProfit
FROM KMS
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY TotalProfit DESC;
```
Recommendation:
Introduce VIP benefits and personalized offers to maintain their loyalty.

### 10. Customers who returned items and their segments: 
Returns can reduce margins, so I looked at customers who return products often. Understanding their segments helps in managing expectations and improving satisfaction.
```sql
SELECT k.Customer_Name, k.Customer_Segment, s.Status, COUNT(s.Order_ID) AS No_of_Returns
FROM KMS k
JOIN OrderStatus s ON k.Order_ID = s.Order_ID
GROUP BY k.Customer_Name, k.Customer_Segment, s.Status
ORDER BY COUNT(s.Order_ID) DESC;
```
<img width="287" height="223" alt="image" src="https://github.com/user-attachments/assets/34f0dc22-b7dd-4e69-8025-f53ac6c720cd" />
Insight:
Customers across all segments returned items, with some patterns of frequent returns.
Recommendation:
Review product quality and implement stricter return policies for high-return customers.

### 11. Shipping cost analysis based on order priority:
Finally, I checked if shipping matched order urgency. Surprisingly, critical orders often went by slower delivery methods, while low-priority orders used costly Express Air. This highlighted an area for operational improvement.
```sql
SELECT Ship_Mode, Order_Priority, SUM(Shipping_Cost) AS TotalShippingCost, COUNT(Order_ID) AS No_of_Orders
FROM KMS
GROUP BY Ship_Mode, Order_Priority
ORDER BY TotalShippingCost DESC;
```
<img width="295" height="218" alt="image" src="https://github.com/user-attachments/assets/805055c5-1960-4d42-a64e-7e558ff48912" />
Recommendation:
Align shipping method with order priority to reduce cost and improve delivery efficiency.

##  Recommendations
- **Match shipping method to priority:** Use Express Air for high-priority orders only.  
- **Boost low-performing regions:** Target promotions in Central region.  
- **Engage low-value customers:** Loyalty programs or bundle offers.  
- **Focus on profitable categories:** Increase marketing for Technology and Office Supplies.  
---
##  How to Use
- Open `[KMS SQL.sql](https://github.com/user-attachments/files/22028931/KMS.SQL.sql)` to view all queries.
- Run queries in any SQL environment (SQL Server, MySQL, PostgreSQL).
---
##  Conclusion
This project explored key business questions for the KMS retail dataset using SQL and Python visualizations. The analysis provided insights into sales performance, customer value, shipping cost efficiency, and return patterns.

###  Future Work:
- Build interactive dashboards (Power BI or Tableau) for real-time monitoring.
- Incorporate predictive analytics to forecast sales trends.
- Perform deeper customer segmentation for personalized recommendations.

Thank you for viewing this project! Feedback and suggestions are welcome. 
