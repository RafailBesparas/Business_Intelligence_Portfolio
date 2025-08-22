CREATE MATERIALIZED VIEW max_waste_stats AS
SELECT 
    s.City,
    f.Stationid,
    t.TruckType,
    MAX(f.Wastecollected) AS max_waste_collected
FROM 
    FactTrips f
JOIN 
    DimStation s ON f.Stationid = s.Stationid
JOIN 
    DimTruck t ON f.Truckid = t.Truckid
GROUP BY 
    s.City, f.Stationid, t.TruckType;

Select * from max_waste_stats limit 5;
