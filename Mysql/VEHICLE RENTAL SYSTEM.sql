CREATE DATABASE VehicleRental;
use VehicleRental;

/* VEHICLES TABLE */

CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY AUTO_INCREMENT,
    RegistrationNumber VARCHAR(20) UNIQUE,
    Model VARCHAR(50),
    Manufacturer VARCHAR(50),
    Year INT,
    Color VARCHAR(30),
    RentalRate DECIMAL(10,2),
    AvailabilityStatus VARCHAR(20)
);
alter table Vehicles add Mileage int;
INSERT INTO Vehicles (RegistrationNumber, Model, Manufacturer, Year, Color, RentalRate, AvailabilityStatus,Mileage) VALUES
('KA11AB1234', 'Innova Crysta', 'Toyota', 2020, 'White', 3000.00, 'Available',25000),
('KA05XY6789', 'Swift Dzire', 'Maruti', 2019, 'Silver', 1500.00, 'Available',20000),
('KA08MN4321', 'Harley Davidson', 'Harley', 2021, 'Black', 5000.00, 'Rented',15000),
('KA11GH5678', 'Honda City', 'Honda', 2018, 'Red', 2500.00, 'Available',25000),
('KA12EF8899', 'Creta', 'Hyundai', 2022, 'Blue', 3500.00, 'Rented',10000);

/*CUSTOMERS TABLE*/
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(250),
    DrivingLicenseNumber VARCHAR(30)
);

INSERT INTO Customers (Name, Phone, Email, Address, DrivingLicenseNumber) VALUES
('Rajesh Kumar', '9876543210', 'rajesh@example.com', '12 MG Road, Bangalore', 'DL1234567890'),
('Anita Sharma', '9876501234', 'anita@example.com', '5th Cross, Bangalore', 'DL0987654321'),
('Surya M', '9845123456', 'surya@example.com', '8th Main, Mysore', 'DL5554443332'),
('Riya Sen', '9924456789', 'riya@example.com', 'BTM Layout, Bangalore', 'DL2468135790'),
('Karthik N', '9887654321', 'karthik@example.com', 'MG Road, Mangalore', 'DL1357924680');

/*RENTALS TABLE*/
CREATE TABLE Rentals (
    RentalID INT PRIMARY KEY AUTO_INCREMENT,
    VehicleID INT,
    CustomerID INT,
    RentalDate DATE,
    ReturnDate DATE,
    TotalCost DECIMAL(10,2),
    Status VARCHAR(20),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

INSERT INTO Rentals (VehicleID, CustomerID, RentalDate, ReturnDate, TotalCost, Status) VALUES
(1, 1, '2025-08-10', '2025-08-15', 15000.00, 'Completed'),
(3, 2, '2025-08-14', NULL, 10000.00, 'Ongoing'),
(2, 3, '2025-08-05', '2025-08-10', 7500.00, 'Completed'),
(4, 4, '2025-08-12', '2025-08-16', 10000.00, 'Completed'),
(5, 5, '2025-08-15', NULL, 14000.00, 'Ongoing');

/*PAYMENTS TABLE*/
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    RentalID INT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    PaymentMethod VARCHAR(20),
    FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

INSERT INTO Payments (RentalID, PaymentDate, Amount, PaymentMethod) VALUES
(1, '2025-08-10', 15000.00, 'Credit Card'),
(2, '2025-08-14', 10000.00, 'Cash'),
(3, '2025-08-05', 7500.00, 'UPI'),
(4, '2025-08-12', 10000.00, 'Debit Card'),
(5, '2025-08-15', 14000.00, 'Credit Card');

/*MAINTENANCE TABLE*/
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY AUTO_INCREMENT,
    VehicleID INT,
    ServiceDate DATE,
    Description VARCHAR(200),
    Cost DECIMAL(10,2),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

INSERT INTO Maintenance (VehicleID, ServiceDate, Description, Cost) VALUES
(1, '2025-07-01', 'Engine servicing', 5000.00),
(2, '2025-06-20', 'Oil change', 1500.00),
(3, '2025-07-15', 'Tyre replacement', 3500.00),
(4, '2025-07-20', 'Battery check', 1200.00),
(5, '2025-07-25', 'AC repair', 2800.00);

/*RENTAL LOG TABLE*/
CREATE TABLE RentalLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    RentalID INT,
    LogDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

#TRIGGERS
DELIMITER //

/*Trigger to log rental creation*/
CREATE TRIGGER AfterRentalInsert
AFTER INSERT ON Rentals
FOR EACH ROW
BEGIN
    INSERT INTO RentalLog (RentalID) VALUES (NEW.RentalID);
END;
//

/*Trigger to set vehicle availability status to 'Rented' when a rental is made*/
CREATE TRIGGER SetVehicleRented
AFTER INSERT ON Rentals
FOR EACH ROW
BEGIN
    UPDATE Vehicles
    SET AvailabilityStatus = 'Rented'
    WHERE VehicleID = NEW.VehicleID;
END;
//

/*Trigger to set vehicle availability status to 'Available' when rental status is updated to 'Completed'*/
CREATE TRIGGER SetVehicleAvailable
AFTER UPDATE ON Rentals
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Completed' THEN
        UPDATE Vehicles
        SET AvailabilityStatus = 'Available'
        WHERE VehicleID = NEW.VehicleID;
    END IF;
END;
//

DELIMITER ;
/*  Queries */
/*  update */
/* Change status to Rented */
update Vehicles set AvailabilityStatus='Rented' where RegistrationNumber='KA01AB1234';

/*  delete  */
/* Remove a Vehicle */
delete from Vehicles where Model='Swift Dzire';

/*  Where  */
/* Available Vehicles Only */
select *from Vehicles where AvailabilityStatus='Available';

/* Aggregate functions */
/* count vehicles */
select count(*) from Vehicles;
/* total Rental rate */
select sum(RentalRate) from Vehicles;

/*GROUP BY */
/*  Vehicles by manufacturer*/
select Manufacturer,count(*) as vehiclecount from Vehicles group by Manufacturer;

/* having */
/* manufacturers with more than one vehicle*/
select Manufacturer,count(*) as VehiclesCount from Vehicles group by Manufacturer having count(*)>1;

/* Like */
/* Find vehicles by color pattern */
select *from Vehicles where Color like '%whi%';

/* sub queries */
/* find the highest-paid rental */
select *from Rentals where TotalCost=(select max(TotalCost) from Rentals);
/*Triggers */
select r.RentalID,v.RegistrationNumber,v.AvailabilityStatus,r.Status from Rentals r join Vehicles v on r.vehicleID=v.VehicleID;