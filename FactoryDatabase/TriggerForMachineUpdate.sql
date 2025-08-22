use factoryproject;

/* Trigger to Update Machine Status when a 
maintenance task is logged in the Maintenance table. */

DELIMITER $$

Create Trigger UpdateMachineStatus
After Insert on Maintenance
for each row
begin
	Update Machine
    Set MachineStatus = 'Under Maintenance'
    where MachineId = (NEW.MachineId) ;
END $$

Delimiter ;

