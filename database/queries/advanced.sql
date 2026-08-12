-- =====================================================
-- InsightFlow
-- Advanced SQL Analysis
-- CASE WHEN, Subqueries and CTEs
-- =====================================================

--Q1:
SELECT
    product_name,
    list_price,
    CASE
        WHEN list_price >= 100 THEN 'High Price'
        WHEN list_price >= 50 THEN 'Medium Price'
        ELSE 'Low Price'
    END AS price_segment
FROM products;

--Q2:
SELECT
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'Out of Stock'
        WHEN stock_quantity < 50 THEN 'Low Stock'
        WHEN stock_quantity <= 100 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS stock_status
FROM products;

--Q3:
SELECT
    oi.order_id,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)), 2) AS order_total,
    CASE
        WHEN SUM(oi.quantity * oi.unit_price * (1 - oi.discount)) >= 150 THEN 'High Value'
        WHEN SUM(oi.quantity * oi.unit_price * (1 - oi.discount)) >= 75 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_value_segment
FROM order_items AS oi
GROUP BY oi.order_id;

-- Q4: Segment customers based on spending
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)),2) AS total_spending,
    CASE
        WHEN SUM(oi.quantity * oi.unit_price * (1 - oi.discount)) >= 250
            THEN 'High Value'
        WHEN SUM(oi.quantity * oi.unit_price * (1 - oi.discount)) >= 100
            THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spending DESC;

--Q5: Find products that are more expensive than the average selling price.
SELECT
    product_name,
    list_price
FROM products
WHERE list_price > (
    SELECT AVG(list_price)
    FROM products   
);

--Q6: Show products with stock levels above the average.
SELECT
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity > (
    SELECT AVG(stock_quantity)
    FROM products
);

--Q7: Find the product or products with the highest cost.
SELECT
    product_name,
    cost
FROM products
WHERE cost = (
    SELECT MAX(cost)
    FROM products
);

--Q8: Average Order Value
WITH order_totals AS (
    SELECT
        o.order_id,
        ROUND(
            SUM(oi.quantity * oi.unit_price * (1 - oi.discount)),
            2
        ) AS order_total
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY o.order_id
)
SELECT
    ROUND(AVG(order_total), 2) AS average_order_value
FROM order_totals;

--Q9: 
-- Q9: Customer spending using a CTE
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)),2) AS total_spending
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)
SELECT
    customer_id,
    customer_name,
    total_spending
FROM customer_spending
ORDER BY total_spending DESC;

--Q10:
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)), 2) AS total_spending
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT
    customer_id,
    customer_name,
    total_spending,
    CASE 
        WHEN total_spending >= 250 THEN 'High Value'
        WHEN total_spending >= 100 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_spending;

--Q11: Find customers who spend more than the average customer.
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)), 2) AS total_spending
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY 
        c.customer_id,
        c.first_name, 
        c.last_name
)
SELECT
    customer_id,
    customer_name,
    total_spending
FROM customer_spending
WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM customer_spending
)   
ORDER BY total_spending DESC;

--Q12:
WITH category_revenue AS (
    SELECT
        c.category_id,
        c.category_name,
        SUM(oi.quantity*oi.unit_price*(1-oi.discount)) AS total_revenue
    FROM categories AS c
    JOIN products AS p
        ON c.category_id = p.category_id
    JOIN order_items AS oi
        ON p.product_id = oi.product_id 
    JOIN orders AS o
        ON oi.order_id = o.order_id
    WHERE o.status = 'Completed'    
    GROUP BY 
        c.category_id, 
        c.category_name
)
SELECT
    category_name,
    total_revenue
FROM category_revenue
ORDER BY total_revenue DESC;

--Q13: Which category generates the most revenue?
WITH category_revenue AS (
    SELECT
        c.category_id,
        c.category_name,
        SUM(oi.quantity*oi.unit_price*(1-oi.discount)) AS total_revenue
    FROM categories AS c
    JOIN products AS p
        ON c.category_id = p.category_id
    JOIN order_items AS oi
        ON p.product_id = oi.product_id 
    JOIN orders AS o
        ON oi.order_id = o.order_id
    WHERE o.status = 'Completed'    
    GROUP BY 
        c.category_id, 
        c.category_name
)
SELECT
    category_name,
    total_revenue
FROM category_revenue
WHERE total_revenue = (
    SELECT MAX(total_revenue)
    FROM category_revenue
)
ORDER BY total_revenue DESC;

--Q14: Which products are in the highest revenue-generating category?
WITH category_revenue AS (
    SELECT
        c.category_id,
        c.category_name,
        SUM(oi.quantity*oi.unit_price*(1-oi.discount)) AS total_revenue
    FROM categories AS c
    JOIN products AS p
        ON c.category_id = p.category_id
    JOIN order_items AS oi
        ON p.product_id = oi.product_id 
    JOIN orders AS o
        ON oi.order_id = o.order_id
    WHERE o.status = 'Completed'    
    GROUP BY 
        c.category_id, 
        c.category_name
),
highest_revenue_category AS (
    SELECT
        category_id,
        category_name,
        total_revenue
    FROM category_revenue
    WHERE total_revenue = (
        SELECT MAX(total_revenue)
        FROM category_revenue
    )
)
SELECT
    p.product_name,
    p.category_id,
    hrc.category_name,
    SUM(oi.quantity*oi.unit_price*(1-oi.discount)) AS product_revenue   
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id 
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN highest_revenue_category AS hrc
    ON p.category_id = hrc.category_id
WHERE o.status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name,
    p.category_id,
    hrc.category_name
ORDER BY product_revenue DESC;