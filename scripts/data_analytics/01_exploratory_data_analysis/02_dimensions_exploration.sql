/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
===============================================================================
*/

-- Explore All Countries of our customers
SELECT DISTINCT country
FROM gold.dim_customers;

-- Explore All Categories, Sub-categories, Product Names
SELECT DISTINCT category, subcategory, product_name
FROM gold.dim_products
ORDER BY 1, 2, 3;