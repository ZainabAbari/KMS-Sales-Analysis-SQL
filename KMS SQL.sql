Select * from KMS

---- Which product category had the highest sales?-------
Select Top 1 [Product_category],SUM(sales) totalsale
From KMS
Group by Product_Category

Select Top 3 Region,SUM(sales) totalsale
From KMS
Group by Region

;
-- Top 3 and bottom 3--------
SELECT region, total_sales, 'Top' AS category
FROM (
    SELECT TOP 3 region, SUM(sales) AS total_sales
    FROM KMS
    GROUP BY region
    ORDER BY SUM(sales) DESC) AS top_regions
UNION ALL
SELECT region, total_sales, 'Bottom' AS category
FROM (
    SELECT TOP 3 region, SUM(sales) AS total_sales
    FROM KMS
    GROUP BY region
    ORDER BY SUM(sales) ASC) AS bottom_regions
ORDER BY category, total_sales DESC;

--- What were the total sales of appliances in Ontario? ----

SELECT Product_Sub_Category, SUM(Sales) AS TotalSales
FROM KMS
WHERE Province = 'Ontario'
GROUP BY Product_Sub_Category;

---- Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers ----------

SELECT TOP 10 Customer_Name, SUM(Sales) AS Revenue
FROM KMS
GROUP BY Customer_Name
ORDER BY Revenue ASC;

-------KMS incurred the most shipping cost using which shipping method----------

SELECT Top 1 Ship_Mode, SUM(Shipping_Cost) AS TotalShippingCost
FROM KMS
GROUP BY Ship_Mode
ORDER BY TotalShippingCost DESC

----------Who are the most valuable customers, and what products or services do they typically purchase? ------

SELECT Top 10 Customer_Name,Product_Name, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM KMS
GROUP BY Customer_Name,Product_Name
ORDER BY TotalSales DESC

------ Which small business customer had the highest sales? ---------

select TOP 1 Customer_Name, SUM(Sales) as total_sales
from KMS
where Customer_Segment = 'Small Business'
Group by  Customer_Segment,Customer_Name
order by total_sales Desc

----Which Corporate Customer placed the most number of orders in 2009 – 2012? ----

Select Top 1 Customer_Name,Customer_Segment,COUNT(Order_ID) as Total_orders
from KMS
Where Customer_Segment = 'Corporate'
AND YEAR(Order_Date) BETWEEN 2009 AND 2012
Group by Customer_Segment,Customer_Name
order by Total_orders Desc

------Which consumer customer was the most profitable one? -------

SELECT Top 1 Customer_Name,Customer_Segment, SUM(Profit) AS TotalProfit
FROM KMS
where Customer_Segment = 'Consumer'
GROUP BY Customer_Name, Customer_Segment
ORDER BY TotalProfit DESC

-----Which customer returned items, and what segment do they belong to------

Select k.Customer_Name,k.Customer_Segment,s.Status,COUNT(s.Order_ID) as no_of_returns
from KMS k
join
OrderStatus s
on k.Order_ID= s.Order_ID
Group by k.Customer_Name, k.Customer_Segment,s.Status
order by COUNT(s.Order_ID) Desc

-- If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer---
select * from KMS
Select Ship_Mode, Order_Priority ,Sum(Shipping_Cost) as Total_shipping_cost,Count(Order_ID) as No_of_Orders
From KMS
Group by Ship_Mode, Order_Priority
order by sum(Shipping_Cost) Desc

------ The company did NOT always spend shipping costs appropriately based on Order Priority.
Critical orders were often shipped using Delivery Truck, which is too slow.
Low-priority orders were also shipped using Express Air, which is too expensive.
No consistent pattern of matching fast shipping to high priority and economical shipping to low priority.
----suggestions
Reserve Express Air strictly for Critical/High priority.
Use Delivery Truck mainly for Low/Medium.
Use Regular Air for a balance — especially for Medium priority.
