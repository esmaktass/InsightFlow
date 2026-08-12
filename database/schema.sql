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