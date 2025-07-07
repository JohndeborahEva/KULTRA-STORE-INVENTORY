----SQL DSA PROJECT---
---CASE SCENARIO 1---

CREATE DATABASE DSA_PROJECT_DB

----------IMPORT TABLE NAME SQL_RECORDS INTO MY DSA_PROJECT_DB-------

SELECT * FROM SQL_RECORDS

---------------------------ANALYSIS---------------------------

----------Q1: Highest Sales By Product Category------------
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

----comment on Q4----
-----ways to increase revenue using bottom 10 performing customers---
---1.Loyalty incentives
---2.Customer feedback collection
---3.Account based follow up
---4.Engagement focused campaigns
---5.Customer profiling and segmentation
---6.Availability of products in these areas to drive more sales----

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

------- COMMENT ON NUMBER 11----
-----From this report it is clear that the company neither regullary used express air nor delivery truck,instead the company most frequently used Regular air.
---- NO,the company did not follow order priory, they did what was best for them and still kept their customers.
--- they used Regular air,which was in fact the best shipping decision they made.
--By using regular air they were able to streamline too many expenses on their side and on overcharging their customers,the company still deliver to their customers in due time. 
---yes Delivery truck is way cheaper but with how slow it is, it would have not been sustainable for the company because it 
--would create a long list of dissastisfied customers that may most likely never purchase again and then the Express air would have taken the company's profit and if not careful might have run them bankrupt because of how expensive it is.
--the Regular air would not have saved the company much compared to the delivery truck but it still delivers in due time(1-2weeks)and this would have been stated in the delivery condition so that the customers are aware. 
--This saves more compared to the express air and saves them from loosing customers like the use of the delivery truck.
-- I personall feel like the company used Express air when the customer requst for it and was ready to pay additional cost because from the report,express air were used in both critical,high,low,medium and not specifiedorder priority




