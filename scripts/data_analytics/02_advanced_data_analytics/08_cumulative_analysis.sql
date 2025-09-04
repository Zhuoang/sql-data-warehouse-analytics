/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate running total sales by month
SELECT
    *,
    SUM(total_sales) OVER (PARTITION BY YEAR(order_month) ORDER BY order_month) AS running_total_sales
FROM (
    SELECT
        DATETRUNC(MONTH, order_date) AS order_month,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(MONTH, order_date)
) sub

-- Calculate running total sales by year
-- and moving average sales over time
SELECT
    order_month,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_month) AS running_total_sales,
    AVG(avg_sales) OVER (ORDER BY order_month) AS moving_avg_sales
FROM (
    SELECT
        DATETRUNC(YEAR, order_date) AS order_month,
        SUM(sales_amount) AS total_sales,
        AVG(sales_amount) AS avg_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(YEAR, order_date)
) sub