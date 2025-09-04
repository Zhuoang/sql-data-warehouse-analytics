/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

-- Product Price Categorization
SELECT
    product_name,
    cost,
    CASE NTILE(3) OVER (ORDER BY cost DESC)
        WHEN 1 THEN 'High'
        WHEN 2 THEN 'Medium'
        ELSE 'Low'
    END AS price_category
FROM gold.dim_products
GROUP BY 
    product_name, 
    cost;

-- Find how many products fall into each price category
WITH price_ranges AS (
    SELECT
        product_name,
        cost,
        CASE
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost BETWEEN 100 AND 500 THEN '100-500'
            WHEN cost BETWEEN 501 AND 1000 THEN '501-1000'
            WHEN cost BETWEEN 1001 AND 2000 THEN '1001-2000'
            ELSE 'Above 2000'
        END AS cost_range
        FROM gold.dim_products
        GROUP BY 
            product_name, 
            cost
    )
SELECT
    cost_range,
    COUNT(*) AS total_products
FROM price_ranges
GROUP BY cost_range
ORDER BY total_products DESC;

-- ========================================================================
-- Group customers into three segments based on their spending behavior:
--  • VIP: at least 12 months of history and spending more than €5,000.
--  • Regular: at least 12 months of history but spending €5,000 or less.
--  • New: lifespan less than 12 months.
-- And find the total number of customers by each group.
-- ========================================================================
WITH spending_tenure AS (
    SELECT
        c.customer_key,
        DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS tenure_mon,
        SUM(sales_amount) AS total_spending
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON f.customer_key = c.customer_key
    GROUP BY
        c.customer_key
    ),
customer_group AS (
    SELECT
        customer_key,
        CASE 
            WHEN tenure_mon >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN tenure_mon >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
        FROM spending_tenure
    )
SELECT
    customer_segment,
    COUNT (*) AS customer_num
FROM customer_group
GROUP BY customer_segment
ORDER BY customer_num DESC
