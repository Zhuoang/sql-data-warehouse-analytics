/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/

-- =============================================================================
-- Create Report: gold.report_customers
-- =============================================================================
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS

WITH base_query AS (
    /*---------------------------------------------------------------------------
     1) Base Query: Retrieves core columns from tables
    ---------------------------------------------------------------------------*/
    SELECT
		s.order_number,
        s.product_key,
        s.order_date,
        s.sales_amount,
        s.quantity,
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        DATEDIFF(YEAR, c.birth_date, GETDATE()) AS age
    FROM gold.fact_sales s
        LEFT JOIN gold.dim_customers c
            ON s.customer_key = c.customer_key
    WHERE order_date IS NOT NULL
    ),
customer_aggregation AS (
    /*---------------------------------------------------------------------------
     2) Customer Aggregation: Summarizes key metrics at the customer level
    ---------------------------------------------------------------------------*/
    SELECT
        customer_key,
        customer_number,
        customer_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_sales,
        COUNT(quantity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(order_date) AS last_order,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
    FROM base_query
    GROUP BY
        customer_key,
        customer_number,
        customer_name,
        age
    )
/*---------------------------------------------------------------------------
 3) KPIs Calculations: Derives additional metrics and segments customers
---------------------------------------------------------------------------*/
SELECT
    customer_key,
    customer_number,
    customer_name,
    age,
    CASE 
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 35 THEN '20-35'
        WHEN age BETWEEN 36 AND 49 THEN '36-49'
        WHEN age BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65 and Above'
    END AS age_group,
    CASE 
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    total_sales,
    total_orders,
    total_quantity,
    total_products,
    last_order,
    DATEDIFF(MONTH, last_order, GETDATE()) AS recency,
    lifespan,
    CASE
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_value,
    CASE
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_sales
FROM customer_aggregation;
