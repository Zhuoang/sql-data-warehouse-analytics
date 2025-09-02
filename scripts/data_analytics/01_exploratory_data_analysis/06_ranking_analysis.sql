/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: TOP, ROW_NUMBER(), RANK(), DENSE_RANK()
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Top 5 products by sales
SELECT
    TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_sales DESC

-- Bottom 5 products by sales
SELECT
    TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_sales ASC

-- Top 5 subcategories by sales
SELECT
    TOP 5
    p.subcategory,
    SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.subcategory
ORDER BY total_sales DESC

-- Bottom 5 subcategories by sales
SELECT
    TOP 5
    p.subcategory,
    SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.subcategory
ORDER BY total_sales ASC

-- Top 5 products by sales with ranking
SELECT
    TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_sales,
    ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS sales_rank
FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY sales_rank

-- Top 10 customers by sales (including gaps)
SELECT *
FROM (
    SELECT
        c.first_name,
        c.last_name,
        SUM(f.sales_amount) AS total_sales,
        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS sales_rank
    FROM gold.fact_sales f
        LEFT JOIN gold.dim_customers c
        ON c.customer_key = f.customer_key
    GROUP BY 
        c.customer_key, 
        c.first_name, 
        c.last_name
) t
WHERE sales_rank <= 10
ORDER BY sales_rank;

-- Bottom 3 customers by sales (including ties)
SELECT *
FROM (
    SELECT
        c.first_name,
        c.last_name,
        SUM(f.sales_amount) AS total_sales,
        DENSE_RANK() OVER (ORDER BY SUM(f.sales_amount) ASC) AS sales_rank
    FROM gold.fact_sales f
        LEFT JOIN gold.dim_customers c
        ON c.customer_key = f.customer_key
    GROUP BY 
        c.customer_key, 
        c.first_name, 
        c.last_name
) t
WHERE sales_rank <= 3
ORDER BY sales_rank;