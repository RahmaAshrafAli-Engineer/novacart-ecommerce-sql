/*==========================================================
NovaCart Database Assignment - Solutions (MySQL 8.0+)
Student Name : Rahma Ashraf Ali Faragallah
Section      : ___________________________
ID           : ___________________________
==========================================================*/

USE NovaCart;

/*==========================================================
                    Part 1 - Basic Queries
==========================================================*/

-- Q1. Display all customers.
SELECT * FROM Customer;

------------------------------------------------------------

-- Q2. Display the names, categories, and prices of all products.
SELECT p.Product_Name, c.Category_Name, p.Selling_Price
FROM Product p
JOIN Category c ON c.Category_ID = p.Category_ID;

------------------------------------------------------------

-- Q3. Display all products whose price is greater than 5000.
SELECT * FROM Product
WHERE Selling_Price > 5000;

------------------------------------------------------------

-- Q4. Display all delivered orders.
SELECT * FROM Orders
WHERE Order_Status = 'Delivered';

------------------------------------------------------------

-- Q5. Display all customers ordered by their join date (newest first).
SELECT * FROM Customer
ORDER BY Join_Date DESC;

/*==========================================================
            Part 2 - Aggregate Functions
==========================================================*/

-- Q6. Display the total number of customers.
SELECT COUNT(*) AS Total_Customers FROM Customer;

------------------------------------------------------------

-- Q7. Display the average product price.
SELECT AVG(Selling_Price) AS Avg_Price FROM Product;

------------------------------------------------------------

-- Q8. Display the highest and lowest product prices.
SELECT MAX(Selling_Price) AS Highest_Price,
       MIN(Selling_Price) AS Lowest_Price
FROM Product;

------------------------------------------------------------

-- Q9. Display the total stock quantity available.
SELECT SUM(Stock_Quantity) AS Total_Stock FROM Product;

------------------------------------------------------------

-- Q10. Display the total amount received from all payments.
SELECT SUM(Payment_Amount) AS Total_Payments FROM Payment;

/*==========================================================
                Part 3 - GROUP BY & HAVING
==========================================================*/

-- Q11. Display the number of orders for each order status.
SELECT Order_Status, COUNT(*) AS Number_Of_Orders
FROM Orders
GROUP BY Order_Status;

------------------------------------------------------------

-- Q12. Display the total payment amount for each payment method.
SELECT Payment_Method, SUM(Payment_Amount) AS Total_Amount
FROM Payment
GROUP BY Payment_Method;

------------------------------------------------------------

-- Q13. Display the total sales amount for each order.
SELECT Order_ID, SUM(Quantity * Unit_Price) AS Total_Sales
FROM Order_Details
GROUP BY Order_ID;

------------------------------------------------------------

-- Q14. Display orders whose total sales exceed 5000.
SELECT Order_ID, SUM(Quantity * Unit_Price) AS Total_Sales
FROM Order_Details
GROUP BY Order_ID
HAVING SUM(Quantity * Unit_Price) > 5000;

------------------------------------------------------------

-- Q15. Display the number of reviews for each product.
SELECT p.Product_ID, p.Product_Name, COUNT(r.Review_ID) AS Number_Of_Reviews
FROM Product p
LEFT JOIN Review r ON r.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Product_Name;

/*==========================================================
                        Part 4 - Joins
==========================================================*/

-- Q16. Display each customer's name with their orders.
SELECT c.Full_Name, o.Order_ID, o.Order_Date, o.Order_Status
FROM Customer c
LEFT JOIN Orders o ON o.Customer_ID = c.Customer_ID;

------------------------------------------------------------

-- Q17. Display each order with the customer's name.
SELECT o.Order_ID, o.Order_Date, o.Order_Status, c.Full_Name
FROM Orders o
JOIN Customer c ON c.Customer_ID = o.Customer_ID;

------------------------------------------------------------

-- Q18. Display each order with its products and purchased quantities.
SELECT od.Order_ID, p.Product_Name, od.Quantity
FROM Order_Details od
JOIN Product p ON p.Product_ID = od.Product_ID
ORDER BY od.Order_ID;

------------------------------------------------------------

-- Q19. Display all reviews with the customer name and product name.
SELECT r.Review_ID, c.Full_Name, p.Product_Name, r.Rating, r.Comment, r.Review_Date
FROM Review r
JOIN Customer c ON c.Customer_ID = r.Customer_ID
JOIN Product p  ON p.Product_ID  = r.Product_ID;

------------------------------------------------------------

-- Q20. Display the total amount spent by each customer.
SELECT c.Customer_ID, c.Full_Name,
       COALESCE(SUM(pay.Payment_Amount), 0) AS Total_Spent
FROM Customer c
LEFT JOIN Orders o   ON o.Customer_ID = c.Customer_ID
LEFT JOIN Payment pay ON pay.Order_ID = o.Order_ID
GROUP BY c.Customer_ID, c.Full_Name;

/*==========================================================
                    Part 5 - Subqueries
==========================================================*/

-- Q21. Display customers who have placed at least one order.
SELECT * FROM Customer
WHERE Customer_ID IN (SELECT Customer_ID FROM Orders);

------------------------------------------------------------

-- Q22. Display products that have never been ordered.
SELECT * FROM Product
WHERE Product_ID NOT IN (SELECT Product_ID FROM Order_Details);

------------------------------------------------------------

-- Q23. Display products that have never received a review.
SELECT * FROM Product
WHERE Product_ID NOT IN (SELECT Product_ID FROM Review);

------------------------------------------------------------

-- Q24. Display customers who placed more orders than the average number of orders per customer.
SELECT c.Customer_ID, c.Full_Name, COUNT(o.Order_ID) AS Number_Of_Orders
FROM Customer c
JOIN Orders o ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Full_Name
HAVING COUNT(o.Order_ID) > (
    SELECT AVG(order_count)
    FROM (SELECT COUNT(*) AS order_count
          FROM Orders
          GROUP BY Customer_ID) AS t
);

------------------------------------------------------------

-- Q25. Display products whose price is above the average product price.
SELECT * FROM Product
WHERE Selling_Price > (SELECT AVG(Selling_Price) FROM Product);

/*==========================================================
                Part 6 - Common Table Expressions
==========================================================*/

-- Q26. Using a CTE, calculate the monthly revenue.
WITH Monthly_Revenue AS (
    SELECT DATE_FORMAT(Payment_Date, '%Y-%m') AS Revenue_Month,
           SUM(Payment_Amount) AS Revenue
    FROM Payment
    GROUP BY DATE_FORMAT(Payment_Date, '%Y-%m')
)
SELECT Revenue_Month, Revenue
FROM Monthly_Revenue
ORDER BY Revenue_Month;

------------------------------------------------------------

-- Q27. Using a CTE, display the total amount spent by each customer.
-- Return only customers whose total spending exceeds 10000.
WITH Customer_Spending AS (
    SELECT c.Customer_ID, c.Full_Name,
           SUM(pay.Payment_Amount) AS Total_Spent
    FROM Customer c
    JOIN Orders o    ON o.Customer_ID = c.Customer_ID
    JOIN Payment pay ON pay.Order_ID  = o.Order_ID
    GROUP BY c.Customer_ID, c.Full_Name
)
SELECT *
FROM Customer_Spending
WHERE Total_Spent > 10000;

/*==========================================================
                Part 7 - Window Functions
==========================================================*/

-- Q28. Rank customers based on their total spending using RANK().
WITH Customer_Spending AS (
    SELECT c.Customer_ID, c.Full_Name,
           COALESCE(SUM(pay.Payment_Amount), 0) AS Total_Spent
    FROM Customer c
    LEFT JOIN Orders o    ON o.Customer_ID = c.Customer_ID
    LEFT JOIN Payment pay ON pay.Order_ID  = o.Order_ID
    GROUP BY c.Customer_ID, c.Full_Name
)
SELECT Customer_ID, Full_Name, Total_Spent,
       RANK() OVER (ORDER BY Total_Spent DESC) AS Spending_Rank
FROM Customer_Spending;

------------------------------------------------------------

-- Q29. Rank products based on the total quantity sold using DENSE_RANK().
SELECT p.Product_ID, p.Product_Name,
       SUM(od.Quantity) AS Total_Quantity_Sold,
       DENSE_RANK() OVER (ORDER BY SUM(od.Quantity) DESC) AS Sales_Rank
FROM Product p
JOIN Order_Details od ON od.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Product_Name;

------------------------------------------------------------

-- Q30. Display the previous payment amount using LAG() ordered by payment_date.
SELECT Payment_ID, Payment_Date, Payment_Amount,
       LAG(Payment_Amount) OVER (ORDER BY Payment_Date, Payment_ID) AS Previous_Payment_Amount
FROM Payment;

------------------------------------------------------------

-- Q31. Display a running total of revenue ordered by payment_date.
SELECT Payment_ID, Payment_Date, Payment_Amount,
       SUM(Payment_Amount) OVER (
           ORDER BY Payment_Date, Payment_ID
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS Running_Total
FROM Payment;

/*==========================================================
                        Part 8 - Views
==========================================================*/

-- Q32. Create a view named vw_revenue_by_month that displays the monthly revenue.
CREATE OR REPLACE VIEW vw_revenue_by_month AS
SELECT DATE_FORMAT(Payment_Date, '%Y-%m') AS Revenue_Month,
       SUM(Payment_Amount) AS Monthly_Revenue
FROM Payment
GROUP BY DATE_FORMAT(Payment_Date, '%Y-%m');

SELECT * FROM vw_revenue_by_month ORDER BY Revenue_Month;

------------------------------------------------------------

-- Q33. Create a view named vw_best_selling_products
CREATE OR REPLACE VIEW vw_best_selling_products AS
SELECT p.Product_Name,
       SUM(od.Quantity) AS Total_Quantity_Sold,
       SUM(od.Quantity * od.Unit_Price) AS Total_Revenue
FROM Product p
JOIN Order_Details od ON od.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Product_Name;

SELECT * FROM vw_best_selling_products ORDER BY Total_Quantity_Sold DESC;

------------------------------------------------------------

-- Q34. Create a view named vw_customer_summary
CREATE OR REPLACE VIEW vw_customer_summary AS
SELECT c.Full_Name AS Customer_Name,
       COUNT(DISTINCT o.Order_ID) AS Number_Of_Orders,
       COALESCE(SUM(pay.Payment_Amount), 0) AS Total_Amount_Spent
FROM Customer c
LEFT JOIN Orders o    ON o.Customer_ID = c.Customer_ID
LEFT JOIN Payment pay ON pay.Order_ID  = o.Order_ID
GROUP BY c.Customer_ID, c.Full_Name;

SELECT * FROM vw_customer_summary;

/*======================= End =============================*/
