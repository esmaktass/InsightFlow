-- =====================================================
-- InsightFlow Database Schema
-- PostgreSQL
-- Author: Esma Aktaş
-- =====================================================

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100),
    signup_date DATE NOT NULL
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INTEGER NOT NULL
        REFERENCES categories(category_id),
    cost NUMERIC(10,2) NOT NULL
        CHECK (cost >= 0),
    list_price NUMERIC(10,2) NOT NULL
        CHECK (list_price >= 0),
    stock_quantity INTEGER NOT NULL
        CHECK (stock_quantity >= 0),
    CHECK (list_price >= cost)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL
        REFERENCES customers(customer_id),
    order_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL
        REFERENCES orders(order_id),
    product_id INTEGER NOT NULL
        REFERENCES products(product_id),
    quantity INTEGER NOT NULL
        CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL
        CHECK (unit_price >= 0),
    discount NUMERIC(5,2) NOT NULL DEFAULT 0
        CHECK (discount >= 0 AND discount <= 1)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL
        REFERENCES orders(order_id),
    payment_method VARCHAR(50) NOT NULL,
    payment_amount NUMERIC(10,2) NOT NULL
        CHECK (payment_amount >= 0),
    payment_date DATE NOT NULL
);