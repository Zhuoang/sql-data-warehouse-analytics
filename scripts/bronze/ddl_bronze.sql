/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose: 
    This script creates tables in the 'bronze' schema, dropping existing tables if they already exist.
===============================================================================
*/
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info(
    cst_id             INT,
    cst_key            VARCHAR(50),
    cst_firstname      VARCHAR(50),
    cst_lastname       VARCHAR(50),
    cst_marital_status VARCHAR(20),
    cst_gndr           VARCHAR(10),
    cst_create_date    DATE
);
GO

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info(
    prd_id         INT,
    prd_key        VARCHAR(50),
    prd_nm         VARCHAR(100),
    prd_cost       DECIMAL(10, 2),
    prd_line       VARCHAR(50),
    prd_start_dt   DATE,
    prd_end_dt     DATE
);
GO

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details(
    sls_ord_num     VARCHAR(50),
    sls_prd_key     VARCHAR(50),
    sls_cust_id     INT,
    sls_order_dt    DATE,
    sls_ship_dt     DATE,
    sls_due_dt      DATE,
    sls_sales       DECIMAL(10, 2),
    sls_quantity    INT,
    sls_price       DECIMAL(10, 2)
);
GO

IF OBJECT_ID('bronze.erp_loc_z101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_z101;

CREATE TABLE bronze.erp_loc_z101(
    CID     VARCHAR(50),
    CNTRY   VARCHAR(100)
);
GO

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12(
    CID      VARCHAR(50),
    BDATE    DATE,
    GENDER   VARCHAR(10)
);
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2(
    ID            VARCHAR(10),
    CAT           VARCHAR(50),
    SUBCAT        VARCHAR(50),
    MAINTENANCE   VARCHAR(10)
);
GO
