/* The purpose of this script is to create a database called Warehouse Analytics
There is a check so when the database exists then it is not created. 
The script schema is Gold layer
Bronze -> Stores Raw Data
Silver -> Stores Cleaned, Processed and conformed data
Gold -> Stores aggrgated, analytics ready data
*/

-- Get admin rights
USE master;
GO

-- Drop and recreate the 'Date Warehouse Analytics' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseProject')
BEGIN
    ALTER DATABASE DataWarehouseProject SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouseProject;
END;
GO

-- Create the Data Warehouse Project Database
CREATE DATABASE DataWarehouseProject;
GO

-- Use the database
USE DataWarehouseProject;
GO

-- Create the schemas
Create Schema Gold
GO

-- Create Dimension Tables and Fact Tables
-- Fact Tables: Store measurable, quantitative events — the facts of the business.
-- Dimension Tables: Store descriptive, categorical attributes that give context to facts.

CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number nvarchar(50),
	first_name nvarchar(50),
	last_name nvarchar(50),
	country nvarchar(50),
	marital_status nvarchar(50),
	gender nvarchar(50),
	birthdate date,
	create_date date
);
GO

CREATE TABLE gold.dim_products(
	product_key int ,
	product_id int ,
	product_number nvarchar(50) ,
	product_name nvarchar(50) ,
	category_id nvarchar(50) ,
	category nvarchar(50) ,
	subcategory nvarchar(50) ,
	maintenance nvarchar(50) ,
	cost int,
	product_line nvarchar(50),
	start_date date 
);
GO

CREATE TABLE gold.fact_sales(
	order_number nvarchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint,
	price int 
);
GO

-- It deletes all rows from the table gold.dim_customers very quickly without logging each row deletion.
TRUNCATE TABLE gold.dim_customers;
GO

-- Insert from a csv in the dim customers
BULK INSERT gold.dim_customers
FROM 'C:\Users\user\Desktop\DataAnalyticsProjects\sql-data-analytics-project\sql-data-analytics-project\datasets\csv-files\gold.dim_customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

-- It deletes all rows from the table gold.dim_products very quickly without logging each row deletion.
TRUNCATE TABLE gold.dim_products;
GO

-- Insert from a csv in the dim customers
BULK INSERT gold.dim_products
FROM 'C:\Users\user\Desktop\DataAnalyticsProjects\sql-data-analytics-project\sql-data-analytics-project\datasets\csv-files\gold.dim_products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

-- Insert from a csv in the fact table fact sales
TRUNCATE TABLE gold.fact_sales;
GO

-- Insert from a csv in the fact table fact sales
BULK INSERT gold.fact_sales
FROM 'C:\Users\user\Desktop\DataAnalyticsProjects\sql-data-analytics-project\sql-data-analytics-project\datasets\csv-files\gold.fact_sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO