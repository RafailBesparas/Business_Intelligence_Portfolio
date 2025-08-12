-- CHANGE OVER TIME ANALYSIS --

/* A change over time analysis is a type of analysis that uncovers how a measure changes over time 
We perform this analysis in order to uncover trends and seasonality in our data.
Goal: Check how business is doing over time
*/

-- Analyze Sales Performance Over Time

-- Aggrgated on Daily Level
Select order_date, 
Sum(sales_amount) as Total_Sales
from [Gold].[fact_sales]
where order_date is not null
group by order_date
order by order_date;

-- Aggregated on a yearly level
Select
	Sum(sales_amount) as Total_Sales,
	YEAR(order_date) as Order_Year
from [Gold].[fact_sales]
where order_date is not null
group by YEAR(order_date)
order by YEAR(order_date);

-- Aggregate sales on  yearly level and also check the number of distinct customers
Select
	Sum(sales_amount) as Total_Sales,
	YEAR(order_date) as Order_Year,
	Count(Distinct customer_key) as Total_Customers
from [Gold].[fact_sales]
where order_date is not null
group by YEAR(order_date)
order by YEAR(order_date);

-- Aggregate sales on  yearly level, check the number of distinct customers, check also what quantities where sold
Select
	Sum(sales_amount) as Total_Sales,
	YEAR(order_date) as Order_Year,
	Count(Distinct customer_key) as Total_Customers,
	Sum(quantity) as Total_Quantity_Sold
from [Gold].[fact_sales]
where order_date is not null
group by YEAR(order_date)

-- Aggregate sales on  monthly level, check the number of distinct customers, check also what quantities where sold
Select
	Sum(sales_amount) as Total_Sales,
	Month(order_date) as Order_Month,
	Count(Distinct customer_key) as Total_Customers,
	Sum(quantity) as Total_Quantity_Sold
from [Gold].[fact_sales]
where order_date is not null
group by Month(order_date) 
order by Month(order_date) ;

-- Aggregate sales on yearly level also having the months, check the number of distinct customers, check also what quantities where sold
Select
	Year(order_date) as Order_Year,
	Month(order_date) as Order_Month,
	Sum(sales_amount) as Total_Sales,
	Count(Distinct customer_key) as Total_Customers,
	Sum(quantity) as Total_Quantity_Sold
from [Gold].[fact_sales]
where order_date is not null
group by Month(order_date), Year(order_date)
order by Month(order_date), Year(order_date) ;

-- Use DateTrunc to avoid Cast/Format, Using DDL
-- Aggregate sales on yearly level
-- Having the months
-- Check the number of distinct customers
-- Check also what quantities where sold
Select
	DATETRUNC(year, order_date) as Order_Date,
	Sum(sales_amount) as Total_Sales,
	Count(Distinct customer_key) as Total_Customers,
	Sum(quantity) as Total_Quantity_Sold
from [Gold].[fact_sales]
where order_date is not null
group by DATETRUNC(year, order_date)
order by DATETRUNC(year, order_date) ;


-- Change the month format
-- Aggregate sales on yearly level
-- Having the months
-- Check the number of distinct customers
-- Check also what quantities where sold
Select
	Format(order_date, 'yyyy-MMM') as Order_Date,
	Sum(sales_amount) as Total_Sales,
	Count(Distinct customer_key) as Total_Customers,
	Sum(quantity) as Total_Quantity_Sold
from [Gold].[fact_sales]
where order_date is not null
group by Format(order_date, 'yyyy-MMM') 
order by Format(order_date, 'yyyy-MMM')  ;

-- Analyze Distinct Customers per Year
Select Year(order_date) as Starting_Period, COUNT(DISTINCT customer_key) AS Number_Of_Distinct_Customers
from [Gold].[fact_sales]
WHERE order_date IS NOT NULL
GROUP BY Year(order_date)
ORDER BY Starting_Period;

-- Find the new and the returing customers (Advanced needed the help from chat gtp)
-- Idea: find each customer’s first-ever order date, align both first orders and current orders to a period, then classify.
WITH orders AS (
    SELECT
        customer_key,
        order_date,
        DATETRUNC(month, order_date) AS Starting_Period
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
),
first_order AS (
    SELECT
        customer_key,
        DATETRUNC(month, MIN(order_date)) AS first_time_seen
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY customer_key
),
label_adding AS (
    -- one row per (customer, period) to avoid double-counting
    SELECT DISTINCT
        o.customer_key,
        o.Starting_Period,
        CASE
            WHEN f.first_time_seen = o.Starting_Period THEN 'New'
            ELSE 'Returning'
        END AS customer_type
    FROM orders o
    JOIN first_order f
      ON f.customer_key = o.customer_key
)
SELECT
    Starting_Period,
    SUM(CASE WHEN customer_type = 'New' THEN 1 ELSE 0 END)       AS new_customers,
    SUM(CASE WHEN customer_type = 'Returning' THEN 1 ELSE 0 END) AS returning_customers,
    COUNT(DISTINCT customer_key)                                  AS total_active_customers
FROM label_adding
GROUP BY Starting_Period
ORDER BY Starting_Period;

-- Sales and Revenue
-- Idea check how many quantity is being sold and how much revenue I have

-- Revenue and Sales Yearly
Select DATETRUNC(year, order_date) AS Order_Year, 
	Sum(quantity) as Units_Sold,
	Sum(sales_amount) as Revenue
from gold.fact_sales
WHERE order_date IS NOT NULL
group by DATETRUNC(year, order_date)
order by Order_Year;

-- Revenue and Sales Monthly
Select DATETRUNC(month, order_date) AS Order_Month, 
	Sum(quantity) as Units_Sold,
	Sum(sales_amount) as Revenue
from gold.fact_sales
WHERE order_date IS NOT NULL
group by DATETRUNC(month, order_date)
order by Order_Month;

-- Change Over Time - Analysis on Order Processing Times over time -------------------------------------------------------------
-- Idea use Shipping date and due_date

-- Processing time per Montly
SELECT DATETRUNC(month, order_date) AS Order_Month,
       AVG(DATEDIFF(day, order_date, shipping_date)) AS Avg_Shipping_Days
FROM gold.fact_sales
WHERE order_date IS NOT NULL AND shipping_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY Order_Month;

-- Processing time per yearly
SELECT DATETRUNC(year, order_date) AS Order_Year,
       AVG(DATEDIFF(day, order_date, shipping_date)) AS Avg_Shipping_Days
FROM gold.fact_sales
WHERE order_date IS NOT NULL AND shipping_date IS NOT NULL
GROUP BY DATETRUNC(year, order_date)
ORDER BY Order_Year;

-- Year Over Year Growth -----------------------------------------------------------------
-- Check the sales of the previous Year VS the sales of one year after =  (n, n+1) 
-- Find whether there is a growth or not
-- Needed tweaking from chatgtp 
WITH yearly_growth AS (
    SELECT
        YEAR(order_date) AS Order_Year,
        SUM(sales_amount) AS Total_Sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date)
)
SELECT
    y1.Order_Year,
    y1.Total_Sales,
    y1.Total_Sales - y0.Total_Sales AS Year_Over_Year_Change,
    CASE
        WHEN NULLIF(y0.Total_Sales, 0) IS NULL THEN NULL
        ELSE ROUND( (y1.Total_Sales - y0.Total_Sales) * 100.0 / y0.Total_Sales, 2)
    END AS Year_Over_Year_Percent
FROM yearly_growth y1
LEFT JOIN yearly_growth y0
  ON y1.Order_Year = y0.Order_Year + 1
ORDER BY y1.Order_Year;
