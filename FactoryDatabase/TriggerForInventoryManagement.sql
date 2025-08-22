Use factoryproject;

/* Trigger to Update Machine Status when a 
maintenance task is logged in the Maintenance table. */

DELIMITER $$

CREATE TRIGGER UpdateInventoryLevels
AFTER INSERT ON Production
FOR EACH ROW
BEGIN
    -- Decrease the stock of raw materials in the Inventory table based on the quantity used in the production
    UPDATE Inventory
    SET Quantity = Quantity - QuantityUsed
    WHERE InventoryId = NEW.InventoryId;
END $$

DELIMITER ;

