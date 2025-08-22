--- Create the FactTrips Table
CREATE TABLE FactTrips (
    Tripid INT PRIMARY KEY,
    Dateid INT,
    Stationid INT,
    Truckid INT,
    Wastecollected DECIMAL(10, 2)
);

-- Use this in the PSQL tool
\copy FactTrips (Tripid, Dateid, Stationid, Truckid, Wastecollected) 
FROM 'C:\Users\user\Desktop\DataEngineeringUpload\PortfolioProject\FactTrips.csv' 
DELIMITER ',' CSV HEADER;

--- Check the five rows from the table
SELECT * FROM FactTrips LIMIT 5;
