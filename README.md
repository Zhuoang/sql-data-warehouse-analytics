# **Data Warehouse Project**

This project demonstrates a comprehensive data warehousing and analytics solution, showcasing the entire process from building a data warehouse to delivering actionable insights.

---

## **Data Architecture**

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:

!docs/data_ architecture.png

1. **Bronze Layer**: Stores raw source data in its original form, ingested from CSV files into the SQL Server database.
2. **Silver Layer**: Applies data cleansing, standardization, and normalization to prepare consistent datasets for analysis.
3. **Gold Layer**: Delivers business-ready data organized into a star schema optimized for reporting and analytics.

---

## **Project Overview**

This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Design and implement extraction, transformation, and loading processes to move data from source systems into the warehouse.
3. **Data Modelling**: Build fact and dimension tables structured for efficient analytical queries.
4. **Analytics & Reporting**: Develop SQL-based reports and dashboards that deliver actionable business insights.

**This repository serves as a strong portfolio piece, highlighting expertise in:**

- SQL Development
- Data Architect
- Data Engineering
- ETL Pipeline Development
- Data Modeling
- Data Analytics

---

## **Project Requirements**

### **Building the Data Warehouse**

### **Objective**

Build a modern data warehouse in SQL Server to consolidate sales data, providing a reliable source that supports analytical reporting and data-driven decision-making.

### **Specifications**

- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**:  Clean and resolve quality issues to ensure accuracy and consistency before analysis.
- **Integration**: Consolidate both sources into a unified, user-friendly data model optimized for analytical queries.
- **Scope**: Limit to the latest dataset; historical data is excluded from this project’s scope.
- **Documentation**: Provide clear, well-structured documentation of the data model for both business stakeholders and analytics teams.
