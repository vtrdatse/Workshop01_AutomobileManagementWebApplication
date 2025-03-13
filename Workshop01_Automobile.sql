CREATE DATABASE MyStock
GO

USE MyStock
GO

CREATE TABLE Cars (
	CarID INT PRIMARY KEY,
	CarName VARCHAR(50),
	Manufacturer VARCHAR(50),
	Price MONEY,
	ReleasedYear INT
)
GO

INSERT INTO Cars (CarID, CarName, Manufacturer, Price, ReleasedYear)
VALUES
(1, 'Accord', 'Honda Motor Company', 24970, 2021),
(2, 'Clarity', 'Honda Motor Company', 33400, 2021),
(3, 'BMW 8 Series', 'BMW', 85000, 2021),
(4, 'Audi A6', 'Audi', 14000, 2020)
GO
