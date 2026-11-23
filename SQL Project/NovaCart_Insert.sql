-- NovaCart Database Design Assignment
-- MySQL INSERT Script (sample data)
-- Run AFTER 2_NovaCart_DDL.sql

USE NovaCart;

-- 1. Customer (10 rows)
INSERT INTO Customer (Customer_ID, Full_Name, Email, Phone, Home_Address, Join_Date) VALUES
(1,  'Ahmed Hassan',     'ahmed.hassan@example.com',   '01012345678', '12 Tahrir St, Dokki, Giza',            '2025-11-01'),
(2,  'Sara Mahmoud',     'sara.mahmoud@example.com',   '01123456789', '45 Nasr City Rd, Cairo',               '2025-11-15'),
(3,  'Omar Khaled',      'omar.khaled@example.com',    '01234567890', '8 Corniche El Nile, Maadi, Cairo',     '2025-12-03'),
(4,  'Mona Ibrahim',     'mona.ibrahim@example.com',   '01098765432', '23 Gamal Abdel Nasser St, Alexandria', '2025-12-20'),
(5,  'Youssef Adel',     'youssef.adel@example.com',   '01187654321', '77 Hurghada Main Rd, Red Sea',         '2026-01-08'),
(6,  'Nour El-Din',      'nour.eldin@example.com',     '01276543210', '5 El Mansoura St, Mansoura',           '2026-01-22'),
(7,  'Laila Samir',      'laila.samir@example.com',    '01055556666', '19 Sheikh Zayed Ave, Giza',            '2026-02-05'),
(8,  'Karim Fathy',      'karim.fathy@example.com',    '01166667777', '31 Zamalek St, Cairo',                 '2026-02-18'),
(9,  'Hana Mostafa',     'hana.mostafa@example.com',   '01277778888', '14 Tanta Ring Rd, Tanta',              '2026-03-02'),
(10, 'Mahmoud Reda',     'mahmoud.reda@example.com',   '01088889999', '60 Badr City, Cairo',                  '2026-03-14');

-- 2. Category (10 rows)
INSERT INTO Category (Category_ID, Category_Name) VALUES
(1,  'Electronics'),
(2,  'Clothing'),
(3,  'Home & Kitchen'),
(4,  'Books'),
(5,  'Sports & Outdoors'),
(6,  'Beauty & Personal Care'),
(7,  'Toys & Games'),
(8,  'Groceries'),
(9,  'Office Supplies'),
(10, 'Automotive');

-- 3. Product (15 rows)
INSERT INTO Product (Product_ID, Product_Name, Category_ID, Selling_Price, Stock_Quantity) VALUES
(1,  'Wireless Bluetooth Headphones', 1,  59.99,  120),
(2,  'Smartphone 128GB',              1,  399.00, 60),
(3,  'Mens Cotton T-Shirt',           2,  14.99,  300),
(4,  'Womens Running Jacket',         2,  49.50,  85),
(5,  'Non-Stick Frying Pan',          3,  24.99,  150),
(6,  'Electric Kettle 1.7L',          3,  32.00,  90),
(7,  'SQL for Beginners (Book)',      4,  29.95,  200),
(8,  'Yoga Mat',                      5,  19.99,  180),
(9,  'Dumbbell Set 20kg',             5,  64.00,  40),
(10, 'Moisturizing Face Cream',       6,  17.50,  220),
(11, 'Building Blocks Set',           7,  27.99,  110),
(12, 'Organic Olive Oil 1L',          8,  12.75,  250),
(13, 'A4 Printer Paper 500 Sheets',   9,  6.99,   500),
(14, 'Car Phone Holder',              10, 9.99,   175),
(15, 'Laptop 15.6 inch',              1,  749.00, 25);

-- 4. Orders (10 rows)
INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Order_Status) VALUES
(1,  1,  '2026-01-05', 'Delivered'),
(2,  2,  '2026-01-12', 'Delivered'),
(3,  3,  '2026-02-03', 'Delivered'),
(4,  4,  '2026-02-18', 'Shipped'),
(5,  5,  '2026-03-07', 'Delivered'),
(6,  6,  '2026-03-21', 'Pending'),
(7,  7,  '2026-04-02', 'Cancelled'),
(8,  8,  '2026-04-15', 'Delivered'),
(9,  9,  '2026-05-01', 'Shipped'),
(10, 10, '2026-05-10', 'Pending');

-- 5. Order_Details (20 rows, 2 per order)
INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Unit_Price) VALUES
(1,  1,  1, 59.99),
(1,  7,  2, 29.95),
(2,  2,  1, 399.00),
(2,  14, 1, 9.99),
(3,  3,  3, 14.99),
(3,  4,  1, 49.50),
(4,  5,  1, 24.99),
(4,  6,  1, 32.00),
(5,  8,  2, 19.99),
(5,  9,  1, 64.00),
(6,  10, 2, 17.50),
(6,  12, 3, 12.75),
(7,  11, 1, 27.99),
(7,  13, 4, 6.99),
(8,  15, 1, 749.00),
(8,  1,  1, 59.99),
(9,  7,  1, 29.95),
(9,  13, 2, 6.99),
(10, 3,  2, 14.99),
(10, 8,  1, 19.99);

-- 6. Payment (10 rows, one per order; amount = sum of Quantity * Unit_Price)
INSERT INTO Payment (Payment_ID, Order_ID, Payment_Date, Payment_Amount, Payment_Method) VALUES
(1,  1,  '2026-01-05', 119.89, 'Credit Card'),
(2,  2,  '2026-01-12', 408.99, 'PayPal'),
(3,  3,  '2026-02-03', 94.47,  'Credit Card'),
(4,  4,  '2026-02-18', 56.99,  'PayPal'),
(5,  5,  '2026-03-08', 103.98, 'COD'),
(6,  6,  '2026-03-21', 73.25,  'Credit Card'),
(7,  7,  '2026-04-02', 55.95,  'PayPal'),
(8,  8,  '2026-04-15', 808.99, 'Credit Card'),
(9,  9,  '2026-05-01', 43.93,  'PayPal'),
(10, 10, '2026-05-10', 49.97,  'COD');

-- 7. Review (10 rows; customers review products from their delivered orders)
INSERT INTO Review (Review_ID, Customer_ID, Product_ID, Rating, Comment, Review_Date) VALUES
(1,  1, 1,  5, 'Excellent sound quality and very comfortable.',        '2026-01-15'),
(2,  1, 7,  4, 'Clear explanations, great for beginners.',             '2026-01-16'),
(3,  2, 2,  4, 'Fast phone with a great camera, battery is average.',  '2026-01-22'),
(4,  2, 14, 3, 'Works fine but the grip could be stronger.',           '2026-01-23'),
(5,  3, 3,  5, 'Soft fabric and true to size.',                        '2026-02-12'),
(6,  3, 4,  4, 'Lightweight and good for running in cool weather.',    '2026-02-13'),
(7,  5, 8,  5, 'Non-slip and the perfect thickness.',                  '2026-03-16'),
(8,  5, 9,  3, 'Good weights but the case feels cheap.',               '2026-03-17'),
(9,  8, 15, 5, 'Powerful laptop, handles everything I need.',          '2026-04-25'),
(10, 8, 1,  4, 'Great headphones for the price.',                      '2026-04-26');

-- Quick verification of row counts
SELECT 'Customer' AS Table_Name, COUNT(*) AS Total_Rows FROM Customer
UNION ALL SELECT 'Category',      COUNT(*) FROM Category
UNION ALL SELECT 'Product',       COUNT(*) FROM Product
UNION ALL SELECT 'Orders',        COUNT(*) FROM Orders
UNION ALL SELECT 'Order_Details', COUNT(*) FROM Order_Details
UNION ALL SELECT 'Payment',       COUNT(*) FROM Payment
UNION ALL SELECT 'Review',        COUNT(*) FROM Review;
