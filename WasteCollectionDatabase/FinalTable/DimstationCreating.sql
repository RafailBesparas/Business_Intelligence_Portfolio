-- Create dim Station
CREATE TABLE DimStation (
    Stationid INT PRIMARY KEY,
    City VARCHAR(100)
);

-- Copy this or write it in the PSQL tool
\copy DimStation (Stationid, City) 
FROM 'C:\Users\user\Desktop\DataEngineeringUpload\PortfolioProject\DimStation.csv' 
DELIMITER ',' CSV HEADER;

-- check the 5 lines for tables
SELECT * FROM DimStation LIMIT 5;
