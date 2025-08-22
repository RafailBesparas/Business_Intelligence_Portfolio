# 🗑️ IBM Data Warehousing Project – Waste Collection & Fleet Efficiency Analytics

This project simulates the role of a **Data Engineer** for a solid waste management company in Brazil. The goal is to design and implement a **data warehouse** to generate key reports on waste collection, truck performance, recycling rates, and environmental impact across different cities and time periods.

---

## 🛠️ Files & SQL Scripts
- Script	Purpose
- CreateStarSchema.sql	Core schema creation: dimensions + fact
- DimCreateTruck.sql	DDL for truck dimension
- DimstationCreating.sql	DDL for collection station dimension
- FactTripsTableCreation.sql	DDL for main fact table
- DimDateCreateAndLoad.sql	Generate and populate DimDate
- CreateMaterializedView.sql	Generate materialized views for performance


### Tech Stack
- SQL (DB2/PostgreSQL) – Data warehousing and analytical queries
- Star Schema – For OLAP-style dimensional modeling
- Materialized Views – For performance optimization


## 🧱 Project Objectives

Build a star schema-based **data warehouse** that supports complex analytical queries such as:

- Total waste collected per **year**, **month**, **quarter**
- Waste collected per **city**, **truck type**, and **collection station**
- Analysis of operational **fleet efficiency**, **waste types**, and **recycling trends**

---

## 🗂️ Step-by-Step Breakdown

### ✅ Step 1: Create the Database Schema

- Establish the initial schema to capture key dimensions and the fact table.
- Focus on temporal (dates), spatial (zones), operational (waste type, truck, station), and quantitative (trip & tonnage) data.

---

### ✅ Step 2: Create Dimension and Fact Tables

#### 📆 `DimDate`
Stores date-based information to support time-based analytics.
```sql
- dateid (PK)
- date
- day
- month
- year
- monthname
- dayofweek


### ✅ Step 3: Schema Adjustments
- Due to changes in operations and data delivery (now via CSVs), the schema was updated to reflect new dimensions like DimTruck and DimStation. Deprecated tables (DimWaste, DimZone) were removed from the schema.

## ✅ Step 4: Reporting & Performance Views
- To support advanced reporting and data aggregation:

📘 Group Sets: Used to generate multi-level grouped aggregations.

📐 Rollup View: Implements hierarchical summaries (e.g., monthly → quarterly → yearly).

🧊 Cube View: Supports OLAP-style multidimensional analysis.

💾 Materialized View: Precomputes and stores expensive query results for performance.
