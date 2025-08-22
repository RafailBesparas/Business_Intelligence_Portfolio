-- Create a Dimension Table DimTruck based on the csv
CREATE TABLE DimTruck (
    Truckid INT PRIMARY KEY,
    TruckType VARCHAR(50)
);


-- Copy and paste this to psql tool
\copy DimTruck (Truckid, TruckType) 
FROM 'C:\Users\user\Desktop\DataEngineeringUpload\PortfolioProject\DimTruck.csv' 
DELIMITER ',' CSV HEADER;

-- Find the first 5 rows
SELECT * FROM DimTruck LIMIT 5;
