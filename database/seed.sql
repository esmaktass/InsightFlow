-- =====================================================
-- InsightFlow Seed Data
-- Sample data for development and SQL analysis
-- =====================================================

INSERT INTO categories (category_name)
VALUES
    ('Electronics'),
    ('Home & Kitchen'),
    ('Books'),
    ('Sports'),
    ('Clothing');

INSERT INTO customers (
    first_name,
    last_name,
    email,
    city,
    country,
    signup_date
)
VALUES
    ('Emma', 'Johnson', 'emma.johnson@example.com', 'London', 'United Kingdom', '2025-01-15'),
    ('Liam', 'Smith', 'liam.smith@example.com', 'Manchester', 'United Kingdom', '2025-02-03'),
    ('Sofia', 'Rossi', 'sofia.rossi@example.com', 'Milan', 'Italy', '2025-02-21'),
    ('Lucas', 'Martin', 'lucas.martin@example.com', 'Paris', 'France', '2025-03-10'),
    ('Anna', 'Schmidt', 'anna.schmidt@example.com', 'Berlin', 'Germany', '2025-03-27'),
    ('Daniel', 'Garcia', 'daniel.garcia@example.com', 'Madrid', 'Spain', '2025-04-08'),
    ('Olivia', 'Brown', 'olivia.brown@example.com', 'London', 'United Kingdom', '2025-04-19'),
    ('Marco', 'Bianchi', 'marco.bianchi@example.com', 'Rome', 'Italy', '2025-05-02'),
    ('Laura', 'Muller', 'laura.muller@example.com', 'Munich', 'Germany', '2025-05-18'),
    ('Hugo', 'Dubois', 'hugo.dubois@example.com', 'Lyon', 'France', '2025-06-01'),
    ('Noah', 'Wilson', 'noah.wilson@example.com', NULL, 'United Kingdom', '2025-06-12');

INSERT INTO products (
    product_name,
    category_id,
    cost,
    list_price,
    stock_quantity
)
VALUES
    ('Wireless Headphones', 1, 45.00, 89.99, 120),
    ('Mechanical Keyboard', 1, 55.00, 109.99, 75),
    ('Smart Watch', 1, 80.00, 159.99, 60),

    ('Coffee Machine', 2, 70.00, 139.99, 40),
    ('Air Fryer', 2, 60.00, 119.99, 55),

    ('Data Science Handbook', 3, 20.00, 39.99, 100),
    ('SQL Fundamentals', 3, 15.00, 29.99, 150),

    ('Yoga Mat', 4, 12.00, 29.99, 90),
    ('Running Shoes', 4, 40.00, 89.99, 65),

    ('Basic T-Shirt', 5, 8.00, 24.99, 200);

INSERT INTO orders (
    customer_id,
    order_date,
    status
)
VALUES
    (1, '2025-06-02', 'Completed'),
    (2, '2025-06-03', 'Completed'),
    (3, '2025-06-04', 'Completed'),
    (4, '2025-06-05', 'Cancelled'),
    (5, '2025-06-06', 'Completed'),
    (1, '2025-06-10', 'Completed'),
    (6, '2025-06-11', 'Pending'),
    (7, '2025-06-12', 'Completed'),
    (8, '2025-06-13', 'Completed'),
    (9, '2025-06-14', 'Completed'),
    (10, '2025-06-15', 'Completed'),
    (3, '2025-06-18', 'Completed');

INSERT INTO order_items (
    order_id,
    product_id,
    quantity,
    unit_price,
    discount
)
VALUES
    (1, 1, 1, 89.99, 0.00),
    (1, 6, 1, 39.99, 0.10),

    (2, 2, 1, 109.99, 0.00),

    (3, 4, 1, 139.99, 0.15),
    (3, 8, 2, 29.99, 0.00),

    (4, 3, 1, 159.99, 0.00),

    (5, 5, 1, 119.99, 0.05),
    (5, 10, 2, 24.99, 0.00),

    (6, 7, 1, 29.99, 0.00),
    (6, 9, 1, 89.99, 0.10),

    (7, 1, 2, 89.99, 0.00),

    (8, 4, 1, 139.99, 0.00),
    (8, 6, 2, 39.99, 0.00),

    (9, 8, 1, 29.99, 0.00),

    (10, 3, 1, 159.99, 0.20),

    (11, 2, 1, 109.99, 0.00),
    (11, 7, 2, 29.99, 0.00),

    (12, 5, 1, 119.99, 0.00),
    (12, 10, 3, 24.99, 0.05);

INSERT INTO payments (
    order_id,
    payment_method,
    payment_amount,
    payment_date
)
VALUES
    (1, 'Credit Card', 125.98, '2025-06-02'),
    (2, 'PayPal', 109.99, '2025-06-03'),
    (3, 'Credit Card', 178.98, '2025-06-04'),
    (5, 'Debit Card', 163.97, '2025-06-06'),
    (6, 'Credit Card', 110.98, '2025-06-10'),
    (8, 'PayPal', 219.97, '2025-06-12'),
    (9, 'Credit Card', 29.99, '2025-06-13'),
    (10, 'Debit Card', 127.99, '2025-06-14'),
    (11, 'Credit Card', 169.97, '2025-06-15'),
    (12, 'PayPal', 191.21, '2025-06-18');