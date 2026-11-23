/*==========================================================
            NovaCart Database Assignment
============================================================

Student Name : ___________________________

Section      : ___________________________

ID           : ___________________________

Instructions:
1. Read each question carefully.
2. Write your SQL query below each question.
3. Do NOT modify the database structure.
4. Your queries should execute without errors.

==========================================================*/

USE NovaCartDB;
GO

/*==========================================================
                    Part 1 - Basic Queries
==========================================================*/

-- Q1. Display all customers.

-- Write your query here.



------------------------------------------------------------

-- Q2. Display the names, categories, and prices of all products.

-- Write your query here.



------------------------------------------------------------

-- Q3. Display all products whose price is greater than 5000.

-- Write your query here.



------------------------------------------------------------

-- Q4. Display all delivered orders.

-- Write your query here.



------------------------------------------------------------

-- Q5. Display all customers ordered by their join date (newest first).

-- Write your query here.



/*==========================================================
            Part 2 - Aggregate Functions
==========================================================*/

-- Q6. Display the total number of customers.

-- Write your query here.



------------------------------------------------------------

-- Q7. Display the average product price.

-- Write your query here.



------------------------------------------------------------

-- Q8. Display the highest and lowest product prices.

-- Write your query here.



------------------------------------------------------------

-- Q9. Display the total stock quantity available.

-- Write your query here.



------------------------------------------------------------

-- Q10. Display the total amount received from all payments.

-- Write your query here.



/*==========================================================
                Part 3 - GROUP BY & HAVING
==========================================================*/

-- Q11. Display the number of orders for each order status.

-- Write your query here.



------------------------------------------------------------

-- Q12. Display the total payment amount for each payment method.

-- Write your query here.



------------------------------------------------------------

-- Q13. Display the total sales amount for each order.
-- (Hint: quantity * unit_price)

-- Write your query here.



------------------------------------------------------------

-- Q14. Display orders whose total sales exceed 5000.

-- Write your query here.



------------------------------------------------------------

-- Q15. Display the number of reviews for each product.

-- Write your query here.



/*==========================================================
                        Part 4 - Joins
==========================================================*/

-- Q16. Display each customer's name with their orders.

-- Write your query here.



------------------------------------------------------------

-- Q17. Display each order with the customer's name.

-- Write your query here.



------------------------------------------------------------

-- Q18. Display each order with its products and purchased quantities.

-- Write your query here.



------------------------------------------------------------

-- Q19. Display all reviews with the customer name and product name.

-- Write your query here.



------------------------------------------------------------

-- Q20. Display the total amount spent by each customer.

-- Write your query here.



/*==========================================================
                    Part 5 - Subqueries
==========================================================*/

-- Q21. Display customers who have placed at least one order.

-- Write your query here.



------------------------------------------------------------

-- Q22. Display products that have never been ordered.

-- Write your query here.



------------------------------------------------------------

-- Q23. Display products that have never received a review.

-- Write your query here.



------------------------------------------------------------

-- Q24. Display customers who placed more orders than the average number of orders per customer.

-- Write your query here.



------------------------------------------------------------

-- Q25. Display products whose price is above the average product price.

-- Write your query here.



/*==========================================================
                Part 6 - Common Table Expressions
==========================================================*/

-- Q26. Using a CTE, calculate the monthly revenue.

-- Write your query here.



------------------------------------------------------------

-- Q27. Using a CTE, display the total amount spent by each customer.
-- Return only customers whose total spending exceeds 10000.

-- Write your query here.



/*==========================================================
                Part 7 - Window Functions
==========================================================*/

-- Q28. Rank customers based on their total spending using RANK().

-- Write your query here.



------------------------------------------------------------

-- Q29. Rank products based on the total quantity sold using DENSE_RANK().

-- Write your query here.



------------------------------------------------------------

-- Q30. Display the previous payment amount using LAG() ordered by payment_date.

-- Write your query here.



------------------------------------------------------------

-- Q31. Display a running total of revenue ordered by payment_date.

-- Write your query here.



/*==========================================================
                        Part 8 - Views
==========================================================*/

-- Q32. Create a view named vw_revenue_by_month
-- that displays the monthly revenue.

-- Write your query here.



------------------------------------------------------------

-- Q33. Create a view named vw_best_selling_products
-- that displays:
-- Product Name
-- Total Quantity Sold
-- Total Revenue

-- Write your query here.



------------------------------------------------------------

-- Q34. Create a view named vw_customer_summary
-- that displays:
-- Customer Name
-- Number of Orders
-- Total Amount Spent

-- Write your query here.



/*======================= End =============================*/