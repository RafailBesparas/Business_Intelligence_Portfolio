Use FactoryProject;

Insert Into employees (EmployeeId, FirstName, LastName, InsutryRole, Department, Salary)
Values
(1, 'John', 'Doe', 'Technician', 'Maintenance',45000.00),
(2, 'Jane', 'Smith', 'Supervisor', 'Production',60000.00),
(3, 'Emily', 'Clark', 'Manager', 'Inventory',70000.00),
(4, 'Mike', 'Johnson', 'Operator', 'Production',40000.00);

Insert into Machine (MachineId, MachineType, MachineStatus, MaintenanceSchedule)
value
(1, 'Conveyor Belt', 'Operational', '2024-12-01'),
(2, 'CNC Machine', 'Operational', '2024-10-15'),
(3, 'Packaging Robot', 'Under Maintenance', '2024-11-05'),
(4, '3D Printer', 'Operational', '2024-10-20');

Insert Into Production (ProductionId, ProductionType, ProductionDate,  MachineID)
values
(1, 'Widget A', '2024-09-15', 1),
(2, 'Widget B', '2024-09-20', 2),
(3, 'Widget C', '2024-09-25', 4),
(4, 'Widget D', '2024-09-30', 1);

Insert Into Inventory (InventoryId, ItemName, Quantity, Supplier, QuantityUsed)
values
(1, 'Raw Material A', 500, 'Supplier X',10),
(2, 'Raw Material B', 300, 'Supplier Y',20),
(3, 'Finished Widget A', 150, 'Supplier X',30),
(4, 'Finished Widget B', 200, 'Supplier Z',40);

Insert Into Maintenance (MaintenanceId, MachineId, EmployeeId, IssueDescription, RepairDate)
Values
(1, 2, 1, 'Calibration needed', '2024-10-10'),
(2, 3, 1, 'Motor replacement', '2024-11-01'),
(3, 1, 2, 'Belt realignment', '2024-12-02'),
(4, 4, 4, 'Nozzle cleaning', '2024-10-25');

