# 📊 Step 3: Perform Grouping Sets, Rollups, Cubes & Materialized Views

After populating the dimension and fact tables, this step introduces **analytical SQL techniques** to enable fast, flexible, and insightful reporting on waste collection data.

---

## 📈 Benefits
- 🔁 Reduced redundancy in queries using GROUPING SETS
- 📊 Simplified time-series analysis with ROLLUP
- 🧊 Powerful multidimensional slicing with CUBE
- ⚡ Improved dashboard/reporting performance using MATERIALIZED VIEW


## 🧩 1. Grouping Sets – `GroupingDataSets.sql`

**Grouping Sets** allow combining multiple `GROUP BY` queries into one. It's useful for generating reports at different levels of aggregation in a single pass.

### ✅ Example Use Cases:
- Total waste by **city**
- Total waste by **truck type**
- Total waste by **year and city**

```sql
SELECT
  year,
  city,
  truck_type,
  SUM(waste_collected_tons) AS total_waste
FROM
  FactTrips
  JOIN DimDate USING (date_id)
  JOIN DimTruck USING (truck_id)
  JOIN DimStation USING (station_id)
GROUP BY GROUPING SETS (
  (year),
  (city),
  (truck_type),
  (year, city),
  (year, truck_type)
);

## 🔃 2. Rollup Query – rollupquery.sql
ROLLUP creates a hierarchy of subtotals from more detailed levels to higher levels — perfect for time-based reporting.

✅ Example Use Cases:
- Total waste collected by month, quarter, year

## 🧊 3. Cube Query – cubequery.sql
CUBE generates all possible combinations of aggregations for specified dimensions — similar to an OLAP cube.

✅ Example Use Cases:
- Total waste across all combinations of:
- Year
- City
- Truck Type

## 💾 4. Materialized View – CreateMaterializedView.sql
Materialized views pre-compute and store the results of expensive aggregation queries for fast performance.

✅ Use Case:
- Store a ready-to-query summary of total waste by city and year for dashboards or reports.

✅ Outcome of Step 3
- At this stage, the warehouse now supports:
- Efficient multi-level aggregation
- Flexible OLAP-style exploration
- High-performance reporting via precomputed summaries

