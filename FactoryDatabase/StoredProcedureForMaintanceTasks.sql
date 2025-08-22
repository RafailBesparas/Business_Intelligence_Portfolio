
/* This stored procedure schedules 
maintenance tasks and assigns employees to machines
based on their skills and availability.
 */

DELIMITER $$

CREATE PROCEDURE AssignMaintenanceTasks()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE empID INT;
    DECLARE machID INT;
    
    -- Declare a cursor for employees who are available and skilled
    DECLARE emp_cursor CURSOR FOR 
    SELECT EmployeeID FROM Employees
    WHERE Role = 'Technician' AND Availability = 'Available';
    
    -- Declare a cursor for machines that need maintenance
    DECLARE mach_cursor CURSOR FOR 
    SELECT MachineID FROM Machines
    WHERE Status = 'Requires Maintenance';
    
    -- Declare exit handlers
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Open cursors
    OPEN emp_cursor;
    OPEN mach_cursor;
    
    -- Assign maintenance tasks while both employees and machines are available
    read_loop: LOOP
        FETCH emp_cursor INTO empID;
        FETCH mach_cursor INTO machID;
        
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        
        -- Assign maintenance task
        INSERT INTO Maintenance (MachineID, EmployeeID, TaskDate)
        VALUES (machID, empID, CURDATE());
        
        -- Update employee availability
        UPDATE Employees
        SET Availability = 'Busy'
        WHERE EmployeeID = empID;
        
        -- Update machine status
        UPDATE Machines
        SET Status = 'Under Maintenance'
        WHERE MachineID = machID;
    END LOOP;
    
    -- Close cursors
    CLOSE emp_cursor;
    CLOSE mach_cursor;
END $$

DELIMITER ;