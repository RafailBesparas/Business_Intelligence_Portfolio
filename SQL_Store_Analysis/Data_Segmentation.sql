-- Data Segmentation
-- Group the data based on specific criteria
-- Helps to understand the correlation between two measures
-- If one goes up whether the other goes up(positive), goes down(negative), stays the same

-- Segment the products into cost ranges  and how many products fall into each segment.

-- Part 1 : Create the cost range
Select product_key, product_name, cost,
CASE WHEN cost < 100 THEN 'Below 100 Euro'
	 WHEN cost between 100 And 500 THEN '100-500'
	 WHEN cost between 500 and 1000 Then '500-1000'
	 ELSE 'Above 1000'
END range_of_cost
from gold.dim_products

-- Part 2 use the CTE to check how many products fall into each segment
with product_segments as (
Select product_key, product_name, cost,
CASE WHEN cost < 100 THEN 'Below 100 Euro'
	 WHEN cost between 100 And 500 THEN '100-500'
	 WHEN cost between 500 and 1000 Then '500-1000'
	 ELSE 'Above 1000'
END range_of_cost
from gold.dim_products
)
Select range_of_cost, 
Count(product_key) as total_number_of_products
from product_segments
group by range_of_cost
order by total_number_of_products desc


/* Group Customers into segments based on their spending behaviour:
- VIP: Customers with at least 12 months of history and spending more than 5000
- Regular: Customers with at least 12 months of history but spending 5000 or less
- New: Customers with a lifespan less than 12 months
*/

-- Part 1 find the first order, last order, total spending per client
-- Part 2 adding the lifespans and flags
with customer_spending_table as(
Select c.customer_key,
sum(f.sales_amount) as total_spending,
MIN(order_date) as first_order,
MAX(order_date) as last_order,
DATEDIFF(month, min(order_date), max(order_date)) as customer_lifespan
from gold.fact_sales f
Left Join gold.dim_customers c
on f.customer_key = c.customer_key
group by c.customer_key
)
Select 
customer_key,
total_spending,
customer_lifespan,
CASE when customer_lifespan >= 12 and total_spending > 5000 THEN 'VIP Customer'
	 when customer_lifespan >= 12 and total_spending <= 5000 THEN 'Regular Customer'
	 ELSE 'NEW Customer'
END segments_of_customers
from customer_spending_table


