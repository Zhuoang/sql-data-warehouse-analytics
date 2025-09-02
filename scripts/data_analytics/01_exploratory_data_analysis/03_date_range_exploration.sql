/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Find the first and last order dates
-- and the number of years between them
SELECT
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order,
    DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS years_between
FROM gold.fact_sales

-- Find the oldest and youngest customer birth dates
SELECT
    MIN(birth_date) AS oldest_customer,
    DATEDIFF(YEAR, MIN(birth_date), GETDATE()) AS oldest_customer_age,
    MAX(birth_date) AS youngest_customer,
    DATEDIFF(YEAR, MAX(birth_date), GETDATE()) AS youngest_customer_age
FROM gold.dim_customers
