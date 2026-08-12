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