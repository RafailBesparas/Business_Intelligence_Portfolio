# 🧾 Step 2: Populate Dimension & Fact Tables

After creating the star schema structure, the next step is to **populate the tables with actual data** from the CSV files. This involves both:
1. Creating tables with the correct structure (`CREATE TABLE`)
2. Loading data into them via `COPY` or `INSERT` statements.

---

## 🗂️ Dimension Tables

### 📆 `DimDate` – Date Dimension  
- Script: `DimDateCreateAndLoad.sql`  
- Data: `DimDate.csv`

Captures a full date breakdown to support time-based grouping (day, month, year, etc.).

**Columns**:
```sql
- date_id
- full_date
- day
- month
- year
- month_name
- day_of_week

## ✅ Outcome of Step 2
- At the end of this step:
- All base tables are populated.
- The data warehouse is query-ready for OLAP-style reporting using cubes, rollups, grouping sets, and materialized views.
