/*
===============================================================================
Measures Exploration (Key Metrics Report)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- =====================================================================
-- Calculate Key Metrics
-- =====================================================================

-- Calculate total sales
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-- Calculate total items sold
SELECT SUM(quantity) AS total_items_sold
FROM gold.fact_sales;

-- Calculate average sales
SELECT AVG(sales_amount) AS avg_sales
FROM gold.fact_sales;

-- Calculate total number of orders
SELECT COUNT(order_number) AS total_orders
FROM gold.fact_sales;

SELECT COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;

-- Calculate total number of products
SELECT COUNT(product_key) AS total_products
FROM gold.dim_products;

SELECT COUNT(DISTINCT product_key) AS total_products
FROM gold.dim_products;

-- Calculate total number of customers
SELECT COUNT(customer_key) AS total_customers
FROM gold.dim_customers;

SELECT COUNT(DISTINCT customer_key) AS total_customers
FROM gold.dim_customers;

-- Calculate customers who have placed orders
SELECT COUNT(DISTINCT customer_key) AS customers_with_orders
FROM gold.fact_sales
WHERE order_number IS NOT NULL;

-- =====================================================================
-- Generate a Report that shows all the key metrics of the business
-- =====================================================================
    SELECT
        'Total Sales' AS measure_name,
        SUM(sales_amount) AS measure_value
    FROM gold.fact_sales
UNION ALL
    SELECT
        'Total Items Sold' AS measure_name,
        SUM(quantity) AS measure_value
    FROM gold.fact_sales
UNION ALL
    SELECT
        'Average Sales' AS measure_name,
        AVG(sales_amount) AS measure_value
    FROM gold.fact_sales
UNION ALL
    SELECT
        'Total Orders' AS measure_name,
        COUNT(DISTINCT order_number) AS measure_value
    FROM gold.fact_sales
UNION ALL
    SELECT
        'Total Products' AS measure_name,
        COUNT(DISTINCT product_key) AS measure_value
    FROM gold.dim_products
UNION ALL
    SELECT
        'Total Customers' AS measure_name,
        COUNT(DISTINCT customer_key) AS measure_value
    FROM gold.dim_customers
UNION ALL
    SELECT
        'Customers With Orders' AS measure_name,
        COUNT(DISTINCT customer_key) AS measure_value
    FROM gold.fact_sales
    WHERE order_number IS NOT NULL;