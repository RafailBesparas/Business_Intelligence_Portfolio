/* Creating the Database for the factory */

Create database FactoryProject;

Use FactoryProject;

Create Table Employees (
	EmployeeID Int Primary Key,
    FirstName Varchar(50),
    LastName varchar(50),
    InsutryRole varchar(50),
    Department varchar(50),
    Salary Decimal(10,2)
);

Create Table Machine (
	MachineId Int Primary Key,
    MachineType Varchar(50),
    MachineStatus Varchar(50),
    MaintenanceSchedule date 
);

Create Table Production (
	ProductionId int Primary Key,
    ProductionType varchar(50),
    MachineID int,
    Foreign Key (MachineId) References Machine(MachineId)
);

Create Table Inventory (
	InventoryId int primary key,
    ItemName varchar(50),
    Quantity int,
    Supplier varchar(50)
);

Create Table Maintenance (
	MaintenanceId int primary key,
    MachineId int,
    EmployeeId int, 
    IssueDescription varchar(255),
    RepairDate Date,
    Foreign Key (MachineId) references Machine(MachineId),
    Foreign Key (EmployeeId) references Employees(EmployeeId)
);

