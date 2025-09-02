/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

-- Explore All Objects in the Database
SELECT *
FROM information_schema.tables

-- Explore All Columns in the Dimension Tables
SELECT *
FROM information_schema.columns
WHERE table_name LIKE 'dim_%'