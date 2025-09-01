/*
============================================================
Quality Checks
============================================================

Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' schemas. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after loading data into the Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
============================================================
*/

-- =============================================================
-- Checking 'silver.crm_cust_info'
-- =============================================================
SELECT * 
FROM silver.crm_cust_info

-- Check for Duplicates & NULLs in Primary Key
-- Expectation: No result
SELECT 
cst_id,
COUNT(*) AS customer_count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1
    OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No result
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;

-- =============================================================
-- Checking 'silver.crm_prd_info'
-- =============================================================
SELECT * 
FROM silver.crm_prd_info

-- Check for Duplicates & NULL in Primary Key
-- Expectation: No result
SELECT
    prd_key,
    COUNT(*) AS product_count
FROM silver.crm_prd_info
GROUP BY prd_key
HAVING COUNT(*) > 1;


-- Check for Unwanted Spaces
-- Expectation: No result
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check for NULLs & Negative Numbers
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- Check for Invalid Date Orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_start_dt > prd_end_dt

-- =============================================================
-- Checking 'silver.crm_sales_details'
-- =============================================================
SELECT * 
FROM silver.crm_sales_details;

-- Check for Invalid Dates
SELECT 
    NULLIF(sls_order_dt, 0)
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0
    OR LEN(sls_order_dt) != 8
    OR sls_order_dt > 20250101
    OR sls_order_dt < 20000101;

-- Check for Order Dates and Shipping Dates after Due Dates
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
    OR sls_ship_dt > sls_due_dt;

-- Check for NULLs, Negative or Zero Values in Numeric Fields
SELECT *
FROM silver.crm_sales_details
WHERE sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
    OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
    OR sls_price * sls_quantity != sls_sales;

-- =============================================================
-- Checking 'silver.erp_cust_az12'
-- =============================================================
SELECT * 
FROM silver.erp_cust_az12;

-- Check for duplicates in PK
SELECT
    COUNT(*)
FROM silver.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1;

-- Check for Unwanted Spaces
SELECT *
FROM silver.erp_cust_az12
WHERE cid != TRIM(cid)
    OR gen != TRIM(gen);

-- Check for Data Normalization & Standardization
SELECT DISTINCT gen
FROM silver.erp_cust_az12;

-- Check for Primary Key Length
SELECT
    LEN(cid) AS cid_length,
    COUNT(*) 
FROM silver.erp_cust_az12
GROUP BY LEN(cid);

-- Check for Invalid Birthdates
SELECT bdate
FROM silver.erp_cust_az12
WHERE bdate IS NULL
    OR bdate < '1925-01-01'
    OR bdate > GETDATE()

-- =============================================================
-- Checking 'silver.erp_loc_a101'
-- =============================================================
SELECT * 
FROM silver.erp_loc_a101;

-- Check for duplicates in PK
SELECT
    COUNT(*)
FROM silver.erp_loc_a101
GROUP BY cid
HAVING COUNT(*) > 1;

-- Check for Unwanted Spaces
SELECT *
FROM silver.erp_loc_a101
WHERE cid != TRIM(cid)

-- Check for Primary Key Length
SELECT
    LEN(cid) AS cid_length,
    COUNT(*) 
FROM silver.erp_loc_a101
GROUP BY LEN(cid);

-- Check for Country
SELECT DISTINCT cntry
FROM silver.erp_loc_a101;

-- =============================================================
-- Checking 'silver.erp_px_cat_g1v2'
-- =============================================================
SELECT * 
FROM silver.erp_px_cat_g1v2;

-- Check for duplicates in PK
SELECT
    COUNT(*)
FROM silver.erp_px_cat_g1v2
GROUP BY id
HAVING COUNT(*) > 1;

-- Check for Unwanted Spaces
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE id != TRIM(id)
    OR cat != TRIM(cat)
    OR subcat != TRIM(subcat)
    OR maintenance != TRIM(maintenance);

-- Check for Primary Key Length
SELECT
    LEN(id) AS id_length,
    COUNT(*) 
FROM silver.erp_px_cat_g1v2
GROUP BY LEN(id);

-- Check for cat Column
SELECT 
    DISTINCT cat
FROM silver.erp_px_cat_g1v2;

-- Check for subcat Column
SELECT 
    DISTINCT subcat
FROM silver.erp_px_cat_g1v2;

-- Check for maintenance Column
SELECT 
    DISTINCT maintenance
FROM silver.erp_px_cat_g1v2;
