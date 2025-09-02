/*
=============================================================
Quality Checks
=============================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency,
    and accuracy of the Gold Layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Run these checks after loading data to the Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
=============================================================
*/

-- =============================================================
-- Checking 'gold.dim_customers'
-- =============================================================

-- Check for duplicate customer records
-- Expectation: No results
SELECT COUNT(*)
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Check for inconsistent gender information
SELECT DISTINCT gender
FROM gold.dim_customers

-- =============================================================
-- Checking 'gold.dim_products'
-- =============================================================
  
-- Check for duplicate product keys
-- Expectation: No results
SELECT COUNT(*)
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1

-- =============================================================
-- Checking 'gold.fact_sales'
-- =============================================================
  
-- Foreign Key Integrity
-- Expectation: No results
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
LEFT JOIN gold.dim_customers c
    ON f.customer_key = c.customer_key
WHERE p.product_key IS NULL
    OR c.customer_key IS NULL
