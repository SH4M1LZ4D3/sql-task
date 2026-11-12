#PART 1
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INT
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Product VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    BirthDate DATE,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(30),
    ShipAddress VARCHAR(150),
    BillAddress VARCHAR(150),
    Quantity INT,
    Sales DECIMAL(10,2),
    CreationTime DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SalesPersonID) REFERENCES Employees(EmployeeID)
);
INSERT INTO Customers (CustomerID, FirstName, LastName, Country, Score) VALUES
(1, 'Ayla', 'Karimova', 'Azerbaijan', 720),
(2, 'John', 'Miller', 'USA', 450),
(3, 'Emma', 'Schmidt', 'Germany', 860),
(4, 'Sara', 'Martin', 'France', 280),
(5, 'Lukas', 'Weber', 'Germany', 550);
INSERT INTO Products (ProductID, Product, Category, Price) VALUES
(101, 'Wireless Mouse', 'Electronics', 55),
(102, 'Office Chair', 'Furniture', 230),
(103, 'Laptop', 'Electronics', 850),
(104, 'Notebook', 'Stationery', 12),
(105, 'Smart Phone', 'Electronics', 420);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID) VALUES
(11, 'David', 'Lee', 'Sales', '1990-05-15', 'Male', 2200, NULL),
(12, 'Maya', 'Brown', 'Sales', '1992-08-20', 'Female', 2400, NULL),
(13, 'Alex', 'Green', 'Support', '1995-11-10', 'Male', 1900, NULL);
INSERT INTO Orders (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime) VALUES
(201, 101, 1, 11, '2026-10-04', '2026-10-06', 'Delivered', 'Baku, Nizami str.', 'Baku, Nizami str.', 2, 110, '2026-10-04 10:30:00'),
(202, 103, 3, 12, '2026-10-08', '2026-10-10', 'Shipped', 'Berlin, Hauptstr.', 'Berlin, Hauptstr.', 1, 850, '2026-10-08 14:15:00'),
(203, 102, 2, 11, '2026-10-12', NULL, 'Pending', 'NY, 5th Ave', 'NY, 5th Ave', 1, 230, '2026-10-12 09:00:00'),
(204, 105, 5, 12, '2026-10-15', '2026-10-17', 'Delivered', 'Munich, Marienplatz', 'Munich, Marienplatz', 1, 420, '2026-10-15 16:45:00');

SELECT * FROM Customers;

SELECT FirstName, LastName, Country FROM Customers;

SELECT CustomerID, FirstName, LastName, Country 
FROM Customers 
WHERE Country = 'Germany';

SELECT * 
FROM Customers 
WHERE Score >= 300 AND Country IN ('Germany', 'France');

SELECT ProductID, Product, Category, Price 
FROM Products 
ORDER BY Price DESC;

SELECT Product, Price 
FROM Products 
WHERE Price BETWEEN 50 AND 300;

SELECT Product, Category 
FROM Products 
WHERE Product LIKE '%Phone%';

SELECT DISTINCT Category 
FROM Products 
ORDER BY Category ASC;

SELECT Orders.OrderID, Customers.FirstName, Customers.LastName 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT OrderStatus, COUNT(OrderID) AS NumberOfOrders, SUM(Sales) AS TotalSales 
FROM Orders 
GROUP BY OrderStatus 
ORDER BY TotalSales DESC;

INSERT INTO Products (ProductID, Product, Category, Price) 
VALUES (999, 'Smart Watch', 'Electronics', 150);

UPDATE Products 
SET Price = 180 
WHERE ProductID = 999;

SELECT * FROM Products WHERE ProductID = 999;

DELETE FROM Products 
WHERE ProductID = 999;

SELECT FirstName, LastName, Country, Score 
FROM Customers 
WHERE Score > 500 
ORDER BY Score DESC;

SELECT FirstName, LastName, Country, Score 
FROM Customers 
WHERE Country IN ('Germany', 'France', 'USA') AND Score >= 300;

SELECT CONCAT(Customers.FirstName, ' ', Customers.LastName) AS FullName, 
       Orders.OrderID, 
       Orders.OrderDate, 
       Orders.Sales 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Country 
FROM Customers 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
WHERE Orders.OrderID IS NULL;

SELECT Customers.FirstName, Customers.LastName, SUM(Orders.Sales) AS TotalSales 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName 
ORDER BY TotalSales DESC;

SELECT Customers.FirstName, Customers.LastName, SUM(Orders.Sales) AS TotalSales 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName 
HAVING SUM(Orders.Sales) > 1000;

SELECT CONCAT(Customers.FirstName, ' ', Customers.LastName) AS FullName, 
       Customers.Country, 
       SUM(Orders.Sales) AS TotalSales 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Country 
ORDER BY TotalSales DESC 
LIMIT 5;

SELECT OrderID, CustomerID, OrderDate, ShipDate, OrderStatus 
FROM Orders 
WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31';

SELECT * 
FROM Orders 
WHERE OrderStatus = 'Pending' 
ORDER BY OrderDate ASC;

SELECT Orders.OrderID, CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, Orders.OrderDate, Orders.ShipDate 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE DATEDIFF(Orders.ShipDate, Orders.OrderDate) > 7;

SELECT CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, Customers.Country 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE DATEDIFF(Orders.ShipDate, Orders.OrderDate) > 7;

UPDATE Orders 
SET OrderStatus = 'Shipped', ShipDate = '2026-11-05' 
WHERE OrderID = 105;

UPDATE Orders 
SET ShipAddress = '45 Main Street, Baku' 
WHERE OrderID = 110;

DELETE FROM Orders 
WHERE OrderID = 999;

SELECT OrderStatus, COUNT(OrderID) AS OrderCount 
FROM Orders 
GROUP BY OrderStatus;

SELECT CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, Orders.OrderDate, Orders.OrderStatus 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE Orders.ShipDate IS NULL;

SELECT Product, Category, Price 
FROM Products 
WHERE Price BETWEEN 50 AND 300 
ORDER BY Price ASC;

SELECT * 
FROM Products 
WHERE Category = 'Electronics' AND Price > 500;

SELECT Products.Product, Products.Category, Orders.Quantity, Orders.Sales 
FROM Products 
INNER JOIN Orders ON Products.ProductID = Orders.ProductID;

SELECT Products.Product, SUM(Orders.Quantity) AS TotalQuantity 
FROM Products 
INNER JOIN Orders ON Products.ProductID = Orders.ProductID 
GROUP BY Products.ProductID, Products.Product 
ORDER BY TotalQuantity DESC 
LIMIT 5;

SELECT Products.ProductID, Products.Product, Products.Category 
FROM Products 
LEFT JOIN Orders ON Products.ProductID = Orders.ProductID 
WHERE Orders.OrderID IS NULL;

SELECT CONCAT(Employees.FirstName, ' ', Employees.LastName) AS FullName, Employees.Department, SUM(Orders.Sales) AS TotalSales 
FROM Employees 
INNER JOIN Orders ON Employees.EmployeeID = Orders.SalesPersonID 
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Department;

SELECT CONCAT(Employees.FirstName, ' ', Employees.LastName) AS FullName, SUM(Orders.Sales) AS TotalSales 
FROM Employees 
INNER JOIN Orders ON Employees.EmployeeID = Orders.SalesPersonID 
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName 
HAVING SUM(Orders.Sales) > 5000 
ORDER BY TotalSales DESC;

INSERT INTO Products (ProductID, Product, Category, Price) 
VALUES (501, 'Wireless Keyboard', 'Electronics', 75);

UPDATE Products 
SET Price = 90 
WHERE ProductID = 501;

ALTER TABLE Products 
ADD StockQuantity INT;

SELECT FirstName, LastName FROM Customers 
UNION 
SELECT FirstName, LastName FROM Employees;

SELECT Products.Category, SUM(Orders.Quantity) AS TotalQuantity, SUM(Orders.Sales) AS TotalSales 
FROM Products 
INNER JOIN Orders ON Products.ProductID = Orders.ProductID 
GROUP BY Products.Category 
HAVING SUM(Orders.Sales) > 2000 
ORDER BY TotalSales DESC;



#PART 2
CREATE DATABASE CourseRegistrationDB;
USE CourseRegistrationDB;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    BirthDate DATE,
    Faculty VARCHAR(100),
    EnrollmentYear INT
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(100),
    Email VARCHAR(100),
    Salary DECIMAL(10,2)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT,
    Semester VARCHAR(20),
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    Grade DECIMAL(5,2),
    Status VARCHAR(20),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    UNIQUE (StudentID, CourseID)
);