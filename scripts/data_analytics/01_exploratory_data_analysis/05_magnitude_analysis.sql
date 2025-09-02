/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/

-- Count of customers by country
SELECT
    country,
    COUNT(*) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC

-- Count of customers by gender
SELECT
    gender,
    COUNT(*) AS total_customers
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC

-- Count of products by category
SELECT
    category,
    COUNT(*) AS total_products
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC

-- Average cost of products by category
SELECT
    category,
    AVG(cost) AS average_cost
FROM gold.dim_products
GROUP BY category
ORDER BY average_cost DESC

-- Total revenue by product category
SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC

-- Total profit by product category
SELECT
    p.category,
    SUM(f.price * f.quantity - p.cost * f.quantity) AS total_profit
FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_profit DESC

-- Total revenue by customer
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY
        c.customer_key,
        c.first_name,
        c.last_name
ORDER BY total_revenue DESC

-- Total number of orders by country
SELECT
    c.country,
    COUNT(f.quantity) AS total_items_sold
FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_items_sold DESC

-- Total profit by country
SELECT
    c.country,
    SUM(f.price * f.quantity - p.cost * f.quantity) AS total_profit
FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
    LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY c.country
ORDER BY total_profit DESC

-- Total profit by country (Better Performance)
WITH
    f
    AS
    (
        SELECT
            customer_key,
            product_key,
            SUM(sales_amount) AS sales_amt,
            SUM(quantity)     AS qty
        FROM gold.fact_sales
        GROUP BY customer_key, product_key
    )
SELECT
    c.country,
    SUM(f.sales_amt - f.qty * p.cost) AS total_profit
FROM f
    JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
    JOIN gold.dim_products p
    ON p.product_key  = f.product_key
GROUP BY c.country
ORDER BY total_profit DESC;