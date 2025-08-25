/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose: This script creates tables in the 'bronze' schema.
===============================================================================
*/

CREATE TABLE bronze.crm_cust_info(
    cst_id INT PRIMARY KEY,
    cst_key VARCHAR(50) NOT NULL,
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(20),
    cst_gndr VARCHAR(10),
    cst_create_date DATE
);
GO

CREATE TABLE bronze.crm_prd_info(
    prd_id INT PRIMARY KEY,
    prd_key VARCHAR(50) NOT NULL,
    prd_nm VARCHAR(100),
    prd_cost DECIMAL(10, 2),
    prd_line VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);
GO

CREATE TABLE bronze.crm_sales_details(
    sls_ord_num VARCHAR(50) PRIMARY KEY,
    sls_prd_key VARCHAR(50) NOT NULL,
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales DECIMAL(10, 2),
    sls_quantity INT,
    sls_price DECIMAL(10, 2)
);
GO

CREATE TABLE bronze.erp_LOC_A101(
    CID VARCHAR(50) PRIMARY KEY,
    CNTRY VARCHAR(100)
);
GO

CREATE TABLE bronze.erp_CUST_AZ12(
    CID VARCHAR(50) PRIMARY KEY,
    BDATE DATE,
    GENDER VARCHAR(10)
);
GO

CREATE TABLE bronze.erp_PX_CAT_G1V2(
    ID VARCHAR(10) PRIMARY KEY,
    CAT VARCHAR(50),
    SUBCAT VARCHAR(50),
    MAINTENANCE VARCHAR(10)
);
GO
