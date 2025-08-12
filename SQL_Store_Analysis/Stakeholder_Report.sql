-- Customer Report
-- Purpose : This report will provide key insights and behavior

-- Base Query will retrieve all the necessary columns from all the tables
with base_view as (
select f.order_number, f.product_key, f.order_date,
f.sales_amount, f.quantity, c.customer_key, c.customer_number, 
Concat(c.first_name, ' ', c.last_name) as customer_name,
c.birthdate, 
DATEDIFF(year, c.birthdate, GETDATE()) as age
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
where order_date is not null
)

---Aggregate Customer Level Metrics
WITH base_view AS (
    SELECT
        f.order_number,
        f.product_key,
        f.order_date,
        f.sales_amount,
        f.quantity,
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.birthdate,
        DATEDIFF(year, c.birthdate, GETDATE()) AS age
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_customers AS c
        ON c.customer_key = f.customer_key
    WHERE f.order_date IS NOT NULL
)
SELECT
    customer_key,
    customer_number,
    customer_name,
    age,
    COUNT(DISTINCT order_number)      AS total_orders,
    SUM(sales_amount)                 AS total_sales,
    SUM(quantity)                     AS total_quantity,
    COUNT(DISTINCT product_key)       AS total_products,
	MAX(order_date)                   AS last_order_date,
	DATEDIFF(month, min(order_date), max(order_date)) AS customer_lifespan
FROM base_view
GROUP BY
    customer_key,
    customer_number,
    customer_name,
    age;
	

-- Calculate KPIs for stakeholders --------------------------------------------------------------------------------------------------------------------

-- Create an enriched view
Create or alter view gold.v_sales_enriched as
Select f.order_number, f.product_key, f.customer_key, f.order_date, f.shipping_date, f.due_date,
Cast(f.sales_amount as decimal(18,2)) as sales_amount,
Cast(f.quantity as int) as quantity,
Cast(f.price as decimal(18,2)) as unit_price,
p.product_name, p.category, p.subcategory, p.product_line,
CAST(p.cost AS decimal(18,2))  AS unit_cost,
c.customer_number, c.first_name, c.last_name,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
c.country, c.gender, c.marital_status, c.birthdate,
c.create_date AS customer_create_date,
DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age_years,
CAST(f.quantity * p.cost AS decimal(18,2)) AS cost_amount,
CAST(f.sales_amount - (f.quantity * p.cost) AS decimal(18,2)) AS gross_margin
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products  AS p ON p.product_key  = f.product_key
LEFT JOIN gold.dim_customers AS c ON c.customer_key = f.customer_key
WHERE f.order_date IS NOT NULL;

-- KPI - SNAPSHOT - Date Bound
WITH profit AS (
  SELECT *
  FROM gold.v_sales_enriched
)
Select 
Count(Distinct order_number) as total_orders,
SUM(quantity) as total_units,
SUM(sales_amount) as total_revenue,
SUM(cost_amount) as total_cost,
SUM(gross_margin) as total_margin,
CASE WHEN SUM(sales_amount) = 0 THEN 0
ELSE SUM(gross_margin) / SUM(sales_amount) 
END AS margin_percentage_of_change,
COUNT(DISTINCT customer_key) as unique_customers,
CASE WHEN COUNT(DISTINCT order_number)=0 THEN 0
ELSE SUM(sales_amount) * 1.0 / COUNT(DISTINCT order_number) END AS average_order_value,
CASE WHEN SUM(quantity)=0 THEN 0
ELSE SUM(sales_amount) * 1.0 / SUM(quantity) END AS average_selling_price,
CASE WHEN COUNT(DISTINCT customer_key)=0 THEN 0
ELSE SUM(sales_amount) * 1.0 / COUNT(DISTINCT customer_key) END AS revenue_per_customer,
AVG(CASE WHEN shipping_date IS NOT NULL
THEN DATEDIFF(day, order_date, shipping_date) END)  AS average_order_to_ship_in_days,
AVG(CASE WHEN due_date IS NOT NULL AND shipping_date IS NOT NULL
THEN CASE WHEN shipping_date <= due_date THEN 1.0 ELSE 0.0 END END) AS on_time_ship_rate
FROM profit;
