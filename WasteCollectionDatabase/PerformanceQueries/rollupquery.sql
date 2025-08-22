SELECT 
    DATE_PART('year', d.date) AS year,
    s.City,
    f.Stationid,
    SUM(f.Wastecollected) AS total_waste_collected
FROM 
    FactTrips f
JOIN 
    DimStation s ON f.Stationid = s.Stationid
JOIN 
    DimDate d ON f.Dateid = d.dateid
GROUP BY 
    ROLLUP (
        DATE_PART('year', d.date),  -- Year level
        s.City,                    -- City level
        f.Stationid                -- Station ID level
    )
ORDER BY 
    year, city, stationid;
