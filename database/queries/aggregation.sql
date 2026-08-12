-- =====================================================
-- InsightFlow
-- Aggregation & Business Metrics
-- =====================================================

-- Q1: Calculate the total number of products
SELECT COUNT(*) AS total_products
FROM products;

--Q2: How many customars has city information?
SELECT COUNT(city) AS customers_with_city
FROM customers;

--Q3: Calculate the total stock quantity.
SELECT
    SUM(stock_quantity) AS total_stock
FROM products;

--Q4: Calculate the average selling price of the products.
SELECT
    ROUND(AVG(list_price), 2) AS average_price
FROM products;

--Q5: Find minimum cost, maximum cost and average cost of the products in a single query.
SELECT
    MIN(cost) AS min_cost,
    MAX(cost) AS max_cost,
    ROUND(AVG(cost), 2) AS average_cost
FROM products;

--Q6: Write a query for finding Product Summary.
SELECT
    COUNT(*) AS total_products,
    ROUND(AVG(cost), 2) AS average_cost,
    ROUND(AVG(list_price), 2) AS average_price,
    SUM(stock_quantity) AS total_stock,
    MAX(list_price) AS max_price
FROM products;

--Q7: Find out how many customers there are in each city.
SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;

--Q8:
SELECT 
    category_id,
    COUNT(*) AS product_count,
    ROUND(AVG(list_price), 2) AS average_price,
    SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category_id;

--Q9: Group the customers and calculate how many customers are in each combination.
SELECT
    country,
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY country, city
ORDER BY country ASC, customer_count DESC;

--Q10:Find cities that have at least 2 customers.
SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city
HAVING COUNT(*) >= 2;

--Q11: Find category IDs with a total stock greater than 150. Sort by stock from highest to lowest.
SELECT
    category_id,
    SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category_id
HAVING SUM(stock_quantity) > 150
ORDER BY total_stock DESC;

--Q12:
SELECT 
    category_id,
    ROUND(AVG(cost), 2) AS average_cost,
    ROUND(AVG(list_price), 2) AS average_price,
    ROUND(AVG(list_price - cost), 2) AS average_unit_profit
FROM products
GROUP BY category_id;

--Q13: Analyze missing city information
SELECT
    COUNT(*) AS total_customers,
    COUNT(city) AS customers_with_city,
    COUNT(*) - COUNT(city) AS missing_city_count
FROM customers;

--Q14: Among categories with at least 2 products, find those with an average selling price higher than 50 and sort them from most expensive to least expensive based on their average selling price.
SELECT 
    category_id,
    COUNT(*) AS product_count,
    ROUND(AVG(list_price), 2) AS average_price
FROM products
GROUP BY category_id    
HAVING COUNT(*) >= 2 
    AND AVG(list_price) > 50
ORDER BY average_price DESC;    

-- =====================================================
-- Order & Revenue Metrics
-- =====================================================

--Q15: Total orders
SELECT COUNT(*) AS total_orders
FROM orders;

--Q16: Completed orders
SELECT COUNT(*) AS completed_orders
FROM orders
WHERE status = 'Completed';

--Q17: Cancelled orders
SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE status = 'Cancelled';

--Q18: Pending orders
SELECT COUNT(*) AS pending_orders
FROM orders
WHERE status = 'Pending';

--Q19: Total quantity sold
SELECT SUM(quantity) AS total_quantity_sold
FROM order_items;   

--Q20: Find the total payment volume.
SELECT SUM(payment_amount) AS total_payment_volume
FROM payments;

--Q21: Find the average payment amount.
SELECT 
    ROUND(AVG(payment_amount), 2) AS average_payment_amount
FROM payments;

--Q22: Payment count by method
SELECT 
    payment_method,
    COUNT(*) AS payment_count   
FROM payments
GROUP BY payment_method;

--Q23: Total payment amount by method
SELECT 
    payment_method,
    SUM(payment_amount) AS total_payment_amount         
FROM payments
GROUP BY payment_method
ORDER BY total_payment_amount DESC;

--Q24: Average payment amount by method
SELECT 
    payment_method,
    ROUND(AVG(payment_amount), 2) AS average_payment_amount     
FROM payments
GROUP BY payment_method;

--Q25: Find payment methods with a total payment volume greater than 150.
SELECT 
    payment_method,
    SUM(payment_amount) AS total_payment_amount
FROM payments
GROUP BY payment_method
HAVING SUM(payment_amount) > 150
ORDER BY total_payment_amount DESC;

--Q26:Show the number of orders for each order status in a single query.
SELECT 
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status;

--Q27: Payment method performance summary
SELECT 
    payment_method,
    COUNT(*) AS payment_count,
    SUM(payment_amount) AS total_payment_amount,
    ROUND(AVG(payment_amount), 2) AS average_payment_amount,
    MIN(payment_amount) AS min_payment,
    MAX(payment_amount) AS max_payment
FROM payments
GROUP BY payment_method
ORDER BY total_payment_amount DESC;

--Q28: Find payment methods that have been used at least 3 times.
SELECT 
    payment_method,
    COUNT(*) AS payment_count
FROM payments
GROUP BY payment_method
HAVING COUNT(*) >= 3;

--Q29: Order status performance
SELECT 
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;