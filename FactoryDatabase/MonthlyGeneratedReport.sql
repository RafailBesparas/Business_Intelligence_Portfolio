/* Creating the Database for the factory */
Use factoryproject

DELIMITER $$

CREATE PROCEDURE GenerateMonthlyProductionReport(IN reportMonth DATE)
BEGIN
    SELECT ProductType, SUM(QuantityProduced) AS TotalProduced, ProductionDate
    FROM Production
    WHERE MONTH(ProductionDate) = MONTH(reportMonth) 
    AND YEAR(ProductionDate) = YEAR(reportMonth)
    GROUP BY ProductType, ProductionDate
    ORDER BY ProductionDate;
END $$

DELIMITER ;