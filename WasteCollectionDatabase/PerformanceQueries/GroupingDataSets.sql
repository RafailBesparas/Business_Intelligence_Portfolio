-- Grouping Data
SELECT 
    stationid,
    trucktype,
    SUM(Wastecollected) AS total_waste_collected
FROM 
    FactTrips
JOIN 
    DimTruck ON FactTrips.Truckid = DimTruck.Truckid
GROUP BY 
    GROUPING SETS (
        (stationid, trucktype),        -- Group by stationid and trucktype
        (stationid),                   -- Group by stationid only
        (trucktype),                   -- Group by trucktype only
        ()                             -- Overall total without any grouping
    );