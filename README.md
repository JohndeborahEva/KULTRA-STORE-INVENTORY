# KULTRA-STORE-INVENTORY
This project utilizes SQL to analyze and manage the inventory of KULTRA MEGA STORES. The goal is to provide insights into  inventory levels, product trends and sales performance to inform better business decisions.
## Analyzing the data set using SQLQuery

### Project Overview
By leveraging SQL Queries,this project aims to optimise iventory management, identify areas for improvement and enhance overall opreational efficiency

### Goals 
-  Set up Customer and Product Order Tables
-  Query for Top Products Category,Most Valuable Customers
-  Generate insights to improve products Order and Revenue

  ### Project Structure 
  ```SQL
  CREATE DATABASE DSA_PROJECT_DB

----------IMPORT TABLE NAME SQL_RECORDS INTO MY DSA_PROJECT_DB-------

SELECT * FROM SQL_RECORDS

---------------------------ANALYSIS---------------------------

----------Q1: Highest Sales By Product Category------------


SELECT Product_Category, sum(SALES) AS Total_Sales
fROM SQL_RECORDS
GROUP BY Product_Category
ORDER BY Total_Sales DESC

----------TOP 1 Products category by total sales----------

SELECT TOP 1 Product_Category, sum(Sales) as total_Sales
FROM [SQL_RECORDS]
GROUP BY [Product_Category]
ORDER BY total_Sales DESC

---------Q2: TOP 3 REGIONS IN TERMS OF SALE--------

SELECT TOP 3 Region, SUM(SALES) AS [TOP 3]
FROM SQL_RECORDS
GROUP BY Region
ORDER BY [TOP 3] DESC

----------BOTTOM 3 REGIONS IN TERMS OF SALE -------

SELECT TOP 3 Region, SUM(SALES) AS [BOTTOM 3]
FROM SQL_RECORDS
GROUP BY Region
ORDER BY [BOTTOM 3]ASC

--------Q3: TOTAL SALES OF APPLIANCES BY PROVINCE IN ONTARIO--------

SELECT SUM(SALES) AS Total_Sales_Ontario
FROM SQL_RECORDS
WHERE Product_Sub_Category = 'Appliances' 
AND Province = 'Ontario'

--------Q4: BOTTOM 10 CUSTOMERS BY REVENUE ---------

-----------CREATE A REVENUE COLUMN FIRST AND FILL-----------

ALTER TABLE SQL_RECORDS
ADD Revenue AS (Unit_Price * Order_Quantity)

SELECT TOP 10 Order_ID, Customer_Name,SUM(Unit_Price * Order_Quantity) AS TOTAL_REVENUE
FROM SQL_RECORDS
GROUP BY Order_ID, Customer_Name
ORDER BY TOTAL_REVENUE ASC

SELECT TOP 10 Order_ID, Customer_Name,SUM(Revenue) AS TOTAL_REVENUE
FROM SQL_RECORDS
GROUP BY Order_ID, Customer_Name
ORDER BY TOTAL_REVENUE ASC

SELECT TOP 10 Row_ID, Customer_Name,SUM(Revenue) AS TOTAL_REVENUE
FROM SQL_RECORDS
GROUP BY Row_ID, Customer_Name
ORDER BY TOTAL_REVENUE ASC

-------------ADDING ORDER FIELDS TO CUSTOMER NAME---------------

SELECT Order_ID, Customer_Name, Province, Region, Customer_Segment, Product_Category, 
Product_Sub_Category, Product_Container, Product_Base_Margin, Order_Priority, Discount, Unit_Price,
SUM(Unit_Price * Order_Quantity) AS Revenue
FROM SQL_RECORDS
GROUP BY Order_ID, Customer_Name, Province, Region, Customer_Segment, Product_Category, 
Product_Sub_Category, Product_Container, Product_Base_Margin, Order_Priority, Discount, Unit_Price
ORDER BY Revenue ASC

---------Q5: HIGHEST COST BY SHIPPING MODE-----------

SELECT Order_ID, Ship_Mode, SUM(Shipping_Cost) AS TOTAL_Cost
FROM SQL_RECORDS
GROUP BY Order_ID, Ship_Mode
ORDER BY TOTAL_Cost DESC

SELECT TOP 1 Order_ID, Ship_Mode, SUM(Shipping_Cost) AS TOTAL_Cost
FROM SQL_RECORDS
GROUP BY Order_ID, Ship_Mode
ORDER BY TOTAL_Cost DESC

SELECT * FROM SQL_RECORDS

----------------CASE SCENARIO 2---------------

------Q6: MOST VALUABLE CUSTOMERS AND THIER TYPICAL PRODUCT PURCHASE---

SELECT Customer_Name,
SUM(Revenue) AS Total_Revenue,
SUM(Order_Quantity) AS Total_Quantity,
COUNT(DISTINCT Product_Sub_Category) AS Products_Purchased
FROM SQL_RECORDS
GROUP BY Customer_Name
ORDER BY Total_Revenue DESC;

SELECT TOP 10 Customer_Name,
SUM(Revenue) AS Total_Revenue,
COUNT(DISTINCT Product_Sub_Category) AS Quantity_Purchased,
STRING_AGG(Product_Sub_Category, ',') AS Product_Name  
FROM SQL_RECORDS
GROUP BY Customer_Name
ORDER BY Total_Revenue DESC


---------Q7: SMALL BUSINESS CUSTOMER WITH HIGHEST SALES-------------------

SELECT TOP 1 Customer_Name,
SUM(Revenue) AS Total_Sales
FROM SQL_RECORDS
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY Total_Sales DESC

-------Q8: CORPORATE CUSTOMER THAT PLACED MOST ORDERS IN 2009-2012-----

SELECT TOP 1 Customer_Name,
COUNT(Order_ID) AS Total_Orders
FROM SQL_RECORDS
WHERE Customer_Segment = 'Corporate'
AND YEAR(Order_Date) BETWEEN 2009 AND 2012
GROUP BY Customer_Name
ORDER BY Total_Orders DESC

---------Q9;THE MOST PROFITABLE CONSUMER CUSTOMER -----------

SELECT TOP 1 Customer_Name,
SUM(Revenue) AS Total_Revenue
FROM SQL_RECORDS
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY Total_Revenue DESC

   ----IMPORT ORDER STATUS DATA [NAMED; KMS_ORDER] TO ANSWER Q10----

SELECT * FROM KMS_ORDER

---------CREATE VIEW KMS--------------

CREATE VIEW KMS
AS
SELECT KMS_ORDER.Order_ID,
       SQL_RECORDS.Row_ID,
       SQL_RECORDS. Customer_Name,
	   SQL_RECORDS. Customer_Segment,
	   KMS_ORDER. [Status]
FROM SQL_RECORDS
JOIN KMS_ORDER
ON SQL_RECORDS.Order_ID = KMS_ORDER.Order_ID

SELECT * FROM KMS

----------Q10: CUSTOMERS THAT RETURNED ITEMS AND THEIR SEGMENT----------

SELECT Customer_Name, Customer_Segment, [Status]
FROM KMS
WHERE [Status] = 'Returned'

----------Q11:IF SHIPPING METHOD MATCHES ORDER PRIORITY -----------

SELECT Order_Priority, Ship_Mode,
COUNT(*) AS Total_Orders
FROM SQL_RECORDS
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority, Total_Orders DESC
```

  


### KeySQL Tasks

-  Joins between customers and orders
-  Aggregate funtions (SUM,COUNT,AVERAGE,ROUND)
-  Grouping and ordering

## Tools Used
- SQL Management Studio


## Sample Query



































































































































































































## Insights 

-  Advise the management of KMS on what to do to increase the revenue from the bottom 10 Customers
-  we are identifying low perfoming customers in terms of sales
-  A few reasons why these 10 customers are under performing may be due to:
   1. They are new customers with low purchase history
   2. the products are not widely available to customers in that locality or area,
   3. they are buy once customers or inactive customers that probably just wanted to try the product
   4. Dissatisfied customers that did not border to comeback due to their first experience
 
-  Recommendation to increase revenue using the bottom performimg customers
   1. Loyalty incentives
   2. Customer feedback collection
   3. Account based follow up
   4. Engagement focused campaigns
   5. Customer profiling and segmentation
   6. Availability of products in these areas to drive more sales
 
## Contact
For questions,clarifications and collaboration [johndeborahdennis1022@gmail.com](mail to : johndeborahdennis1022@gmail.com)
