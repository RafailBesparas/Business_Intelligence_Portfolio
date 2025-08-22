SELECT 
    DATE_PART('year', d.date) AS year,
    s.City,
    f.Stationid,
    AVG(f.Wastecollected) AS average_waste_collected
FROM 
    FactTrips f
JOIN 
    DimStation s ON f.Stationid = s.Stationid
JOIN 
    DimDate d ON f.Dateid = d.dateid
GROUP BY 
    CUBE (
        DATE_PART('year', d.date),  -- Year level
        s.City,                    -- City level
        f.Stationid                -- Station ID level
    )
ORDER BY 
    year, city, stationid;
