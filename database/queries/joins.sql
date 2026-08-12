-- =====================================================
-- InsightFlow
-- JOIN Analysis
-- =====================================================

--Q1: Display all orders with customer name, surname, order date, and order status.
SELECT 
    o.order_id,
    c.first_name,
    c.last_name,
    o.order_date,
    o.status
FROM orders AS o
INNER JOIN customers AS c 
    ON o.customer_id = c.customer_id;

--Q2:
SELECT 
    o.order_id,
    oi.product_id,
    oi.quantity,
    oi.unit_price,
    oi.discount
FROM order_items AS oi
INNER JOIN orders AS o
    ON oi.order_id = o.order_id;

--Q3: Show which products are in which order.
SELECT 
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM order_items AS oi
INNER JOIN orders AS o
    ON oi.order_id = o.order_id 
INNER JOIN products AS p
    ON oi.product_id = p.product_id;

--Q4:
SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_id,
    p.product_name,
    oi.quantity
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id;

--Q5:
SELECT
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.discount,
    ROUND(oi.quantity * oi.unit_price * (1 - oi.discount),2) AS line_revenue
FROM order_items AS oi
INNER JOIN orders AS o
    ON oi.order_id = o.order_id 
INNER JOIN products AS p
    ON oi.product_id = p.product_id;

--Q6: Show only order items from completed orders.
SELECT
    o.order_id,
    p.product_name,
    ROUND(oi.quantity * oi.unit_price * (1 - oi.discount),2) AS line_revenue
FROM order_items AS oi
INNER JOIN orders AS o
    ON oi.order_id = o.order_id 
INNER JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status = 'Completed';

--Q7: Calculate the total revenue from completed orders.
SELECT
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)),2) AS total_revenue
FROM order_items AS oi
INNER JOIN orders AS o
    ON oi.order_id = o.order_id 
WHERE o.status = 'Completed';

--Q8: Who are our most valuable customers?
SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    c.customer_id,
    SUM(oi.quantity * oi.unit_price * (1 - oi.discount)) AS total_spending
FROM customers AS c
INNER JOIN orders AS o  
    ON c.customer_id = o.customer_id    
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spending DESC;

--Q9: Calculate the total number of units sold and the total revenue for each product in completed orders.
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price * (1 - oi.discount)) AS total_revenue
FROM products AS p
INNER JOIN order_items AS oi    
    ON p.product_id = oi.product_id 
INNER JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY 
    p.product_id, 
    p.product_name
ORDER BY total_revenue DESC;

--Q10: Calculate the total sales volume and revenue for each category in completed orders.
SELECT
    c.category_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price * (1 - oi.discount)) AS total_revenue
FROM categories AS c
INNER JOIN products AS p
    ON c.category_id = p.category_id
INNER JOIN order_items AS oi
    ON p.product_id = oi.product_id
INNER JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY 
    c.category_id, 
    c.category_name
ORDER BY total_revenue DESC;

--Q11: Show all customers and order information, if any.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_id,
    o.order_date
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;  
    
--Q12: Customers who have never placed an order.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

--Q13: Completed orders show each customer's total order count, total number of items purchased, and total expenditure.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.quantity) AS total_units,
    SUM(oi.quantity * oi.unit_price * (1 - oi.discount)) AS total_spending
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id    
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name 
ORDER BY total_spending DESC;