-- Cumulative Analysis
/* Aggrating the data progresively over time
   Helps stakeholders understand whether the business is growing or declining over time.
 */

 -- Total Sales per month and running total sales over time
 SELECT
    Order_Month AS order_date,
    Total_Sales AS total_sales,
    -- Use Window Functions (currently in training)
    SUM(Total_Sales) OVER (ORDER BY Order_Month) AS running_total_sales  -- current row + all previous rows
FROM (
    SELECT
        DATETRUNC(month, order_date) AS Order_Month,
        SUM(sales_amount) AS Total_Sales
    FROM [Gold].[fact_sales]
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
) t
ORDER BY Order_Month;

-- Total Sales per year and running total sales over time
 SELECT
    Order_Year AS order_date,
    Total_Sales AS total_sales,
    -- Use Window Functions (currently in training)
    SUM(Total_Sales) OVER (ORDER BY Order_Year) AS running_total_sales  -- current row + all previous rows
FROM (
    SELECT
        DATETRUNC(year, order_date) AS Order_Year,
        SUM(sales_amount) AS Total_Sales
    FROM [Gold].[fact_sales]
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) t
ORDER BY Order_Year;


-- Total Sales per month 
-- Running total sales over time
-- Average price
-- Moving Average Price
 SELECT
    Order_Month AS order_date,
    Total_Sales AS total_sales,
    Average_price AS average_price,
    -- Use Window Functions (currently in training)
    SUM(Total_Sales) OVER (ORDER BY Order_Month) AS running_total_sales,      -- current row + all previous rows
    AVG(Average_price) OVER (ORDER BY Order_Month) AS moving_average_price    -- cumulative avg up to current month
FROM (
    SELECT
        DATETRUNC(month, order_date) AS Order_Month,
        SUM(sales_amount)            AS Total_Sales,
        AVG(price)                   AS Average_price
    FROM [Gold].[fact_sales]
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
) t
ORDER BY Order_Month;