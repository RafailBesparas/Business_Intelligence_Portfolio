# 🛠️ Step 1: Creating the Star Schema

The first step in building the waste management data warehouse is the creation of a **star schema**, which is a common data modeling technique in dimensional analytics. This schema allows efficient querying for multidimensional analysis.

The schema consists of several **dimension tables** that describe various business aspects (date, truck, station), and one central **fact table** that stores the quantitative data (waste collection trips).

---

## 🧱 Star Schema Components

### 📊 Fact Table: `FactTrips`
Captures measurable event data about each waste collection trip.
```sql
- trip_id (Primary Key)
- date_id (Foreign Key → DimDate)
- truck_id (Foreign Key → DimTruck)
- station_id (Foreign Key → DimStation)
- waste_collected_tons
- trip_number
- distance_travelled_km

## 📂 Script: CreateStarSchema.sql
This script includes the CREATE TABLE statements to initialize the schema structure for all fact and dimension tables. Foreign key constraints ensure referential integrity between the central fact table and the surrounding dimensions.

##💡 Best Practice: All primary keys are surrogate keys (typically integers) to enhance join performance and simplify dimension table management.
