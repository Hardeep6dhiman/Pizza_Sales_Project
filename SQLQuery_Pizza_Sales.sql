select * from dbo.pizza_sales
--TOTAL REVENUE
SELECT 
SUM(pizza_sales.total_price) as Total_Revenue 
from dbo.pizza_sales

--AVERAGE ORDER VALUE
SELECT 
CAST(SUM(pizza_sales.total_price) / COUNT(DISTINCT pizza_sales.order_id) AS DECIMAL(10,2))
AS Average_Order_Value
FROM dbo.pizza_sales

--TOTAL PIZZA SOLD
SELECT
SUM(pizza_sales.quantity) 
AS Total_Pizza_Sold
FROM dbo.pizza_sales

--Total Orders
SELECT
COUNT(DISTINCT pizza_sales.order_id)
AS Total_Orders
FROM dbo.pizza_sales

--AVERAGE PIZZA PER ORDER
SELECT
CAST(
CAST(SUM(pizza_sales.quantity) 
AS DECIMAL(10,2))
/ 
CAST(COUNT(DISTINCT pizza_sales.order_id)
AS DECIMAL(10,2))
AS DECIMAL(10,2))
AS Avg_Pizzas_Per_Order
FROM dbo.pizza_sales

--DAILY TREND FOR TOTAL ORDERS
SELECT
DATENAME(WEEKDAY,pizza_sales.order_date)
AS order_day,
COUNT(DISTINCT pizza_sales.order_id) 
AS Total_Orders
FROM pizza_sales
GROUP BY
DATENAME(WEEKDAY,pizza_sales.order_date)

--MONTHLY TREND FOR TOTAL ORDERS
SELECT
DATENAME(MONTH,pizza_sales.order_date)
AS order_month,
COUNT(DISTINCT pizza_sales.order_id)
AS Total_Orders
FROM pizza_sales
GROUP BY 
DATENAME(MONTH,pizza_sales.order_date)
ORDER BY
Total_Orders DESC

--QUATERLY TREND FOR TOTAL ORDERS
SELECT
DATENAME(WEEKDAY,pizza_sales.order_date)
AS order_day,
COUNT(DISTINCT pizza_sales.order_id)
AS Total_Orders
FROM pizza_sales
WHERE DATEPART(QUARTER,pizza_sales.order_date)=1
GROUP BY DATENAME(WEEKDAY,pizza_sales.order_date)

--PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT pizza_sales.pizza_category,
SUM(pizza_sales.total_price) AS Total_Sales,
CAST(SUM(pizza_sales.total_price)* 100
/
(SELECT SUM(pizza_sales.total_price) FROM dbo.pizza_sales) AS DECIMAL(10,2))
AS Per_of_Sales
FROM dbo.pizza_sales
GROUP BY pizza_sales.pizza_category

--PERCENTAGE OF SALES BY PIZZA CATEGORY IN A MONTH
SELECT pizza_sales.pizza_category,
SUM(pizza_sales.total_price) AS Total_Sales,
CAST(SUM(pizza_sales.total_price)* 100
/
(SELECT SUM(pizza_sales.total_price) FROM dbo.pizza_sales WHERE MONTH(pizza_sales.order_date)=1) AS DECIMAL(10,2))
AS Per_of_Sales
FROM dbo.pizza_sales
WHERE MONTH(pizza_sales.order_date)=1
GROUP BY pizza_sales.pizza_category

--PERCENTAGE OF SALES BY PIZZA SIZE
SELECT pizza_sales.pizza_size,
SUM(pizza_sales.total_price) AS total_sales,
CAST(SUM(pizza_sales.total_price)* 100
/
(SELECT SUM(pizza_sales.total_price) FROM dbo.pizza_sales) AS DECIMAL(10,2))
AS Per_Of_Sales
FROM dbo.pizza_sales
WHERE DATEPART(QUARTER,pizza_sales.order_date)=1
GROUP BY pizza_sales.pizza_size
ORDER BY total_sales DESC

--TOTAL PIZZAS SOLD BY PIZZA CATEGORY
SELECT pizza_sales.pizza_name,
SUM(pizza_sales.total_price) 
AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY Total_Revenue DESC

--TOP 5 BEST SELLERS BY TOTAL QUANTITY, REVENUE, TOTAL ORDERS
--BY REVENUE
SELECT TOP 5 pizza_sales.pizza_name,
SUM(pizza_sales.total_price) 
AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY Total_Revenue DESC

--BY TOTTAL ORDERS
SELECT TOP 5 pizza_sales.pizza_name,
COUNT(DISTINCT pizza_sales.order_id) 
AS Total_Orders
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY Total_Orders DESC

--BY TOTAL QUANTITY
SELECT TOP 5 pizza_sales.pizza_name,
SUM(pizza_sales.quantity) 
AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY Total_Quantity DESC

--BOTTOM 5 WORST SELLERS BY TOTAL QUANTITY, REVENUE, TOTAL ORDERS
--BY REVENUE
SELECT TOP 5 pizza_sales.pizza_name,
SUM(pizza_sales.total_price) 
AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY Total_Revenue ASC

--BY TOTAL QUANTITY
SELECT TOP 5 pizza_sales.pizza_name,
SUM(pizza_sales.quantity) 
AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY Total_Quantity ASC

--BY TOTTAL ORDERS
SELECT TOP 5 pizza_sales.pizza_name,
COUNT(DISTINCT pizza_sales.order_id) 
AS Total_Orders
FROM pizza_sales
GROUP BY pizza_sales.pizza_name
ORDER BY Total_Orders ASC




















