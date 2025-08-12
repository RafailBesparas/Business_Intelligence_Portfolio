-- Performance to Whole Analysis
-- Analyze how a part of the Business is performing compared to the overall business
-- It allows each stakeholder to understand which category has the greatest impact on the business

-- Task: Which category contribute more to the overall sales
with sales_categories as (
Select category,
SUM(sales_amount) as Total_Sales
from gold.fact_sales f
Left Join gold.dim_products p
On p.product_key = f.product_key
group by category
)
Select category, total_sales,
SUM(Total_Sales) OVER () overall_sales_number,
Concat(Round((CAST(total_sales AS float) / SUM(Total_Sales) Over () ) * 100, 2), '%') AS percentage_of_total
from sales_categories
order by Total_Sales desc

-- Task 2: Find which subcategories contribute more to the main(parent) category

-- Part 1: Find the subcategories of the categories
Select p.category,
		p.subcategory,
		SUM(f.sales_amount) as total_sales
	FROM gold.fact_sales f
	Left Join gold.dim_products p
	ON f.product_key = p.product_key
Group By p.category, p.subcategory


-- Part 2: Check turn the first querie into a CTE
-- Check into the second query which sub category contributes to the main category
-- Cleaned the query with chatgtp
WITH sales_subcategories AS (
    SELECT 
        p.category,
        p.subcategory,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    GROUP BY 
        p.category, 
        p.subcategory
)
SELECT 
    category,
    subcategory,
    total_sales,
    SUM(total_sales) OVER (PARTITION BY category) AS category_total_sales,
    ROUND(
        total_sales * 100.0 / NULLIF(SUM(total_sales) OVER (PARTITION BY category), 0),
        2
    ) AS percentage_of_category
FROM sales_subcategories
ORDER BY 
    category, 
    percentage_of_category DESC;

-- Pareto Analysis -- Top N Contributor
-- Find how many products make up 80% of sales.

-- Part 1 product sales by product name
Select p.product_name, 
	   Sum(f.sales_amount) as Total_Sales
From gold.fact_sales f
Left Join gold.dim_products p
ON f.product_key = p.product_key
Group By p.product_name

-- Part 2 Top N Contributor
with ranking_products as (
Select p.product_name, 
	   Sum(f.sales_amount) as Total_Sales
From gold.fact_sales f
Left Join gold.dim_products p
ON f.product_key = p.product_key
Group By p.product_name
),
ranked as (
Select product_name, Total_Sales, 
Sum(Total_Sales) Over () as Overall_Sales,
Sum(Total_Sales) Over (Order By Total_Sales DESC) as running_total
FROM ranking_products
)
Select product_name, 
Total_Sales,
Round (running_total * 100.0 / overall_sales, 2) AS Cumulative_Percentage_Of_Sales
from ranked
order by Total_Sales desc;