-- NovaCart Database Design Assignment
-- MySQL DDL Script
-- WARNING: This script drops the existing NovaCart database and all its data.

DROP DATABASE IF EXISTS NovaCart;
CREATE DATABASE NovaCart
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE NovaCart;

-- 1. Customer
CREATE TABLE Customer (
    Customer_ID INT AUTO_INCREMENT,
    Full_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Home_Address VARCHAR(255) NOT NULL,
    Join_Date DATE NOT NULL,
    CONSTRAINT PK_Customer PRIMARY KEY (Customer_ID),
    CONSTRAINT UQ_Customer_Email UNIQUE (Email)
) ENGINE=InnoDB;

-- 2. Category
CREATE TABLE Category (
    Category_ID INT AUTO_INCREMENT,
    Category_Name VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Category PRIMARY KEY (Category_ID),
    CONSTRAINT UQ_Category_Name UNIQUE (Category_Name)
) ENGINE=InnoDB;

-- 3. Product
CREATE TABLE Product (
    Product_ID INT AUTO_INCREMENT,
    Product_Name VARCHAR(150) NOT NULL,
    Category_ID INT NOT NULL,
    Selling_Price DECIMAL(10,2) NOT NULL,
    Stock_Quantity INT NOT NULL DEFAULT 0,
    CONSTRAINT PK_Product PRIMARY KEY (Product_ID),
    CONSTRAINT CHK_Product_Price CHECK (Selling_Price >= 0),
    CONSTRAINT CHK_Product_Stock CHECK (Stock_Quantity >= 0),
    CONSTRAINT FK_Product_Category
        FOREIGN KEY (Category_ID)
        REFERENCES Category(Category_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 4. Orders
CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Order_Date DATE NOT NULL,
    Order_Status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL DEFAULT 'Pending',
    CONSTRAINT PK_Orders PRIMARY KEY (Order_ID),
    CONSTRAINT FK_Orders_Customer
        FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 5. Order_Details (resolves the many-to-many relationship)
CREATE TABLE Order_Details (
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Order_Details PRIMARY KEY (Order_ID, Product_ID),
    CONSTRAINT CHK_Order_Details_Quantity CHECK (Quantity > 0),
    CONSTRAINT CHK_Order_Details_Unit_Price CHECK (Unit_Price >= 0),
    CONSTRAINT FK_Order_Details_Order
        FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_Order_Details_Product
        FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 6. Payment (one payment per order)
CREATE TABLE Payment (
    Payment_ID INT AUTO_INCREMENT,
    Order_ID INT NOT NULL,
    Payment_Date DATE NOT NULL,
    Payment_Amount DECIMAL(10,2) NOT NULL,
    Payment_Method ENUM('Credit Card', 'PayPal', 'COD') NOT NULL,
    CONSTRAINT PK_Payment PRIMARY KEY (Payment_ID),
    CONSTRAINT UQ_Payment_Order UNIQUE (Order_ID),
    CONSTRAINT CHK_Payment_Amount CHECK (Payment_Amount >= 0),
    CONSTRAINT FK_Payment_Order
        FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 7. Review
CREATE TABLE Review (
    Review_ID INT AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Rating TINYINT NOT NULL,
    Comment VARCHAR(1000) NULL,
    Review_Date DATE NOT NULL,
    CONSTRAINT PK_Review PRIMARY KEY (Review_ID),
    CONSTRAINT UQ_Review_Customer_Product UNIQUE (Customer_ID, Product_ID),
    CONSTRAINT CHK_Review_Rating CHECK (Rating BETWEEN 1 AND 5),
    CONSTRAINT FK_Review_Customer
        FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_Review_Product
        FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- Verify that all seven tables were created
SHOW TABLES;
