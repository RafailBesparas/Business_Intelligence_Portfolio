-- Create the Dimension Data Table
CREATE TABLE DimDate (
    dateid INT PRIMARY KEY,
    date DATE,
    Year INT,
    Quarter INT,
    QuarterName VARCHAR(2),
    Month INT,
    Monthname VARCHAR(20),
    Day INT,
    Weekday INT,
    WeekdayName VARCHAR(10)
);

--Paste this to PSQL Tool
\copy DimDate (dateid, date, Year, Quarter, QuarterName, Month, Monthname, Day, Weekday, WeekdayName) FRO
M 'C:\Users\user\Desktop\DataEngineeringUpload\PortfolioProject\DimDate.csv' DELIMITER ',' CSV HEADER;
COPY 350

-- Take the first 5 rows
select * from DimDate;