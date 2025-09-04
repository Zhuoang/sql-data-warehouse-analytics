/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/

-- Category Sales Percentage Analysis
WITH cat_sales AS (
    SELECT
        p.category,
        SUM(f.sales_amount) AS total_cat_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    GROUP BY p.category
    )
SELECT
    category,
    total_cat_sales,
    SUM(total_cat_sales) OVER () AS total_sales,
    CONCAT(ROUND(CAST(total_cat_sales AS FLOAT)/ (SUM(total_cat_sales) OVER ())*100, 2), '%') AS ratio_to_total
FROM cat_sales
ORDER BY total_cat_sales DESC;

-- Category Orders Percentage Analysis
WITH cat_orders AS (
    SELECT
        p.category,
        COUNT(f.order_number) AS total_cat_orders
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    GROUP BY p.category
    )
SELECT
    category,
    total_cat_orders,
    SUM(total_cat_orders) OVER () AS total_orders,
    CONCAT(ROUND(CAST(total_cat_orders AS FLOAT)/ (SUM(total_cat_orders) OVER ())*100, 2), '%') AS ratio_to_total
FROM cat_orders
ORDER BY total_cat_orders DESC;
