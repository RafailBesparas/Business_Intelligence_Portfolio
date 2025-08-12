-- Performance Analysis
-- Comparing a current value against to a target value to check the performance in the specific category.
-- Helps measure the success and compare performances.

-- Task 1: Analyze the yearly performance of products by comparing each products sales to both its average sales performance and the previous years sales.

-- I need data from the dimension products and from the fact table sales
-- This is the yearly performance of the products part 1 of the query
select Year(f.order_date) as Order_Year, p.product_name, Sum(f.sales_amount) as Current_Sales
from gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
where order_date is not null
group by Year(f.order_date),  p.product_name;

-- Part 2 adding to the query the average sales performance
-- Utilize a CTE in order to find the average sales performance
with yearly_product_sales AS
(
select Year(f.order_date) as Order_Year, p.product_name, Sum(f.sales_amount) as Current_Sales
from gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
where order_date is not null
group by Year(f.order_date),  p.product_name
)

Select order_year, product_name, Current_Sales, 
Avg(Current_Sales) OVER(Partition By product_name) AS avg_sales,
Current_Sales - Avg(Current_Sales) OVER(Partition By product_name) AS difference_average,
CASE WHEN Current_Sales - Avg(Current_Sales) OVER(Partition By product_name)  > 0 Then 'Above the Average'
	 WHEN Current_Sales - Avg(Current_Sales) OVER(Partition By product_name)  < 0 Then 'Below the Average'
	 Else 'Average'
End average_yearly_change
from yearly_product_sales
order by product_name, Order_Year



-- Part 3 adding also to the comparison and the previous year sales
-- Utilize a CTE in order to find the average sales performance
with yearly_product_sales AS
(
select Year(f.order_date) as Order_Year, p.product_name, Sum(f.sales_amount) as Current_Sales
from gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
where order_date is not null
group by Year(f.order_date),  p.product_name
)

Select order_year, product_name, Current_Sales, 
Avg(Current_Sales) OVER(Partition By product_name) AS avg_sales,
Current_Sales - Avg(Current_Sales) OVER(Partition By product_name) AS difference_average,
CASE WHEN Current_Sales - Avg(Current_Sales) OVER(Partition By product_name)  > 0 Then 'Above the Average'
	 WHEN Current_Sales - Avg(Current_Sales) OVER(Partition By product_name)  < 0 Then 'Below the Average'
	 Else 'Average'
End average_yearly_change,
-- Year Over Year Analysis
LAG(Current_Sales) Over (Partition By product_name order by order_year ASC) as previous_year_sales, -- Lag helps to access the previous value of what the current value is
Current_Sales - LAG(Current_Sales) Over (Partition By product_name order by order_year ASC) as difference_previous_year_sales,
CASE WHEN Current_Sales - LAG(Current_Sales) Over (Partition By product_name order by order_year ASC)   > 0 Then 'Increasing Sales'
	 WHEN Current_Sales - LAG(Current_Sales) Over (Partition By product_name order by order_year ASC)   < 0 Then 'Decreasing Sales'
	 Else 'Remain the Same'
END previous_year_sales
from yearly_product_sales
order by product_name, Order_Year


