CREATE DATABASE OnlineStore
GO
USE OnlineStore

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY NOT NULL,
	CustomerID INT NOT NULL
)

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY NOT NULL,
	Name varchar(50) NOT NULL,
	Birthday DATE,
	CityID INT
)

CREATE TABLE Cities(
	CityID INT PRIMARY KEY NOT NULL,
	Name varchar(50) NOT NULL
)

CREATE TABLE Items(
	ItemID INT PRIMARY KEY Not NULL,
	Name varchar(50) NOT NULL,
	ItemTypeID int
)

CREATE TABLE ItemTypes(
	ItemTypeID int PRIMARY KEY Not NULL,
	Name varchar(50)
)

CREATE TABLE OrderItems(
	OrderID INT NOT NULL,
	ItemID INT Not NULL,
	CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID),
	CONSTRAINT FK_OrderItems_Items FOREIGN KEY (ItemID)
	REFERENCES Items(ItemID),
)

ALTER TABLE OrderItems
ADD CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, ItemID)

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)

ALTER TABLE Customers
ADD CONSTRAINT FK_Customers_Cities FOREIGN KEY (CityID)
REFERENCES Cities(CityID)

ALTER TABLE Items
ADD CONSTRAINT FK_Items_ItemTypes FOREIGN KEY (ItemTypeID)
REFERENCES ItemTypes(ItemTypeID)