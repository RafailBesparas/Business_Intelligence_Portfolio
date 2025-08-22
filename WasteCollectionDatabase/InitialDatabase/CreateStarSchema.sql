-- My Dim Date
CREATE TABLE MyDimDate (
    dateid INT PRIMARY KEY,  -- Unique ID for each date
    date DATE NOT NULL,         -- The actual date
    day INT NOT NULL,           -- Day of the month
    month INT NOT NULL,         -- Month of the year (1-12)
    year INT NOT NULL,          -- Year
    monthname VARCHAR(20),      -- Name of the month (e.g., January)
    dayofweek INT NOT NULL      -- Day of the week (0=Sunday, 6=Saturday)
);

-- Create the waste table
CREATE TABLE MyDimWaste (
    wasteid SERIAL PRIMARY KEY,       -- Unique ID for waste type
    wastetype VARCHAR(50) NOT NULL,   -- Type of waste (e.g., Dry, Wet)
    description TEXT,                 -- Description of waste type
    recyclable BOOLEAN,               -- Whether it's recyclable
    wastecategory VARCHAR(50)         -- Category of waste (optional)
);

--DimZoneTable
CREATE TABLE MyDimZone (
    zoneid SERIAL PRIMARY KEY,       -- Unique ID for the zone
    zonename VARCHAR(100) NOT NULL,  -- Name of the zone (e.g., South)
    city VARCHAR(100) NOT NULL,      -- City where the collection happens
    region VARCHAR(100)              -- Optional: Region (e.g., Southeast)
);

--FactTripsTable
CREATE TABLE MyFactTrips (
    tripid SERIAL PRIMARY KEY,               -- Unique ID for each trip
    dateid INT NOT NULL REFERENCES MyDimDate(dateid),  -- Foreign key to MyDimDate
    wasteid INT NOT NULL REFERENCES MyDimWaste(wasteid),  -- Foreign key to MyDimWaste
    zoneid INT NOT NULL REFERENCES MyDimZone(zoneid),    -- Foreign key to MyDimZone
    waste_collected_in_tons DECIMAL(10, 2) NOT NULL,    -- Amount of waste collected
    trip_number INT NOT NULL,                        -- Trip number identifier
    collection_zone VARCHAR(100) NOT NULL,            -- Collection zone (e.g., North)
    trip_date DATE NOT NULL                          -- Date of the trip
);

