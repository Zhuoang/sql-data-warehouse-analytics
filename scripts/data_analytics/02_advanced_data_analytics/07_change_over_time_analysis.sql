/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions

-- Yearly Sales Performance Summary
SELECT
    YEAR(order_date) AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    COUNT(order_number) AS total_orders
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY order_year DESC

-- DATETRUNC(); 2013 Monthly Sales Performance Summary
SELECT
    DATETRUNC(month, order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    COUNT(order_number) AS total_orders
FROM gold.fact_sales
WHERE YEAR(order_date) = 2013
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date);

-- FORMAT(); 2012 Monthly Sales Performance Summary (different formatting)
SELECT
    FORMAT(order_date,'MMM yyyy') AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    COUNT(order_number) AS total_orders
FROM gold.fact_sales
WHERE YEAR(order_date) = 2012
GROUP BY FORMAT(order_date,'MMM yyyy'), DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date);