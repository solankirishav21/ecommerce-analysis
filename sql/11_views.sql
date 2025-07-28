-- View to calculate key performance indicators (KPIs) for the e-commerce platform
-- This view aggregates total revenue, profit, profit margin percentage, total orders, and total customers
CREATE OR REPLACE VIEW kpi_overview AS
    SELECT 
        SUM(od.amount) AS total_revenue,
        SUM(od.profit) AS total_profit,
        ROUND((SUM(od.profit) / SUM(od.amount)) * 100, 2) AS profit_margin_percentage,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(DISTINCT o.customer_name) AS total_customers
    FROM 
        orders o
    JOIN order_details od ON o.order_id = od.order_id;

SELECT * FROM kpi_overview;

-- View to calculate monthly performance metrics
-- This view aggregates monthly revenue, profit, profit margin percentage, total orders, and average order value (AOV)
CREATE OR REPLACE VIEW monthly_performance AS
    SELECT
        TO_CHAR(o.order_date, 'YYYY-MM') AS month,
        SUM(od.amount) AS total_revenue,
        SUM(od.profit) AS total_profit,
        COUNT(DISTINCT o.order_id) AS total_orders,
         ROUND((SUM(od.profit) / SUM(od.amount)) * 100, 2) AS profit_margin_percentage,
    ROUND(SUM(od.amount) / COUNT(DISTINCT o.order_id), 2) AS monthly_aov
    FROM order_details od
    JOIN orders o ON od.order_id = o.order_id
    GROUP BY month;

SELECT * FROM monthly_performance;

-- View to calculate regional performance metrics
-- This view aggregates total revenue, profit, profit margin percentage, total orders, and average order value by state
CREATE OR REPLACE VIEW regional_performance AS
    SELECT
        o.state,
        SUM(od.amount) AS total_revenue,
        SUM(od.profit) AS total_profit,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND((SUM(od.profit) / SUM(od.amount)) * 100, 2) AS profit_margin_percentage,
        ROUND(SUM(od.amount) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
    FROM order_details od
    JOIN orders o ON od.order_id = o.order_id
    GROUP BY o.state;

SELECT * FROM regional_performance;

-- View to calculate customer performance metrics
-- This view aggregates total spending, profit, total orders, and average order value by customer
CREATE OR REPLACE VIEW customer_performance AS
    SELECT
        o.customer_name,
        SUM(od.amount) AS total_spent,
        SUM(od.profit) AS total_profit,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(od.amount) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
    FROM order_details od
    JOIN orders o ON od.order_id = o.order_id
    GROUP BY o.customer_name;

SELECT * FROM customer_performance;

--View to create RFM (Recency, Frequency, Monetary) metrics for customer segmentation
-- This view calculates RFM scores for customers based on their purchase history
-- Recency is calculated as the number of days since the last purchase, Frequency is the number of unique orders, and Monetary is the total amount spent by the customer
-- The scores are then used to segment customers into different categories such as 'Champions', 'Loyal Customers', 'Potential Loyalists', 'Recent Customers', 'At Risk', 'Hibernating', and 'Others'
-- The RFM scores are calculated using NTILE to divide the customers into quartiles based on their RFM values
CREATE OR REPLACE VIEW rfm_analysis AS
    WITH rfm_base AS (
        SELECT
            o.customer_name,
            (SELECT MAX(order_date) FROM orders) - MAX(o.order_date) AS recency,
            COUNT(DISTINCT o.order_id) AS frequency,
            SUM(od.amount) AS monetary
        FROM
            orders AS o
        JOIN
            order_details AS od ON o.order_id = od.order_id
        GROUP BY
            o.customer_name
    ),
    rfm_scores AS (
        SELECT
            customer_name,
            recency,
            frequency,
            monetary,
            NTILE(4) OVER (ORDER BY recency DESC) AS r_score,  
            NTILE(4) OVER (ORDER BY frequency ASC)  AS f_score, 
            NTILE(4) OVER (ORDER BY monetary ASC)  AS m_score
        FROM
            rfm_base
    )
    SELECT
        customer_name,
        recency,
        frequency,
        monetary,
        r_score,
        f_score,
        m_score,
        CASE
            WHEN r_score = 4 AND f_score = 4 AND m_score = 4 THEN 'Champions'
            WHEN r_score = 4 AND f_score >= 3 THEN 'Loyal Customers'
            WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Potential Loyalists'
            WHEN r_score = 4 THEN 'Recent Customers'
            WHEN r_score <= 2 AND f_score <= 2 THEN 'At Risk'
            WHEN r_score = 1 AND f_score = 1 THEN 'Hibernating'
            ELSE 'Others'
        END AS customer_segment
    FROM
        rfm_scores;

SELECT * FROM rfm_analysis;

-- View to calculate product(subcategory) performance metrics
-- This view aggregates total revenue, profit, profit margin percentage, total orders, and average order value by product sub-category
CREATE OR REPLACE VIEW product_performance AS
    SELECT
        sub_category AS product,
        SUM(amount) AS total_revenue,
        SUM(profit) AS total_profit,
        COUNT(DISTINCT order_id) AS total_orders,
        ROUND((SUM(profit) / SUM(amount)) * 100, 2) AS profit_margin_percentage,
        ROUND(SUM(amount) / COUNT(DISTINCT order_id), 2) AS average_order_value
    FROM order_details 
    GROUP BY sub_category;

SELECT * FROM product_performance;

-- View to calculate target anlysis metrics
-- This view aggregates actual revenue by month and category, and compares it with sales targets
CREATE OR REPLACE VIEW target_analysis AS
    WITH monthly_actual_revenue AS (
        SELECT
            TO_CHAR(o.order_date, 'YYYY-MM') AS month,
            od.category,
            SUM(od.amount) AS actual_revenue
        FROM
            orders AS o
        JOIN
            order_details AS od ON o.order_id = od.order_id
        GROUP BY
            month,
            od.category
        )

        -- SELECT * FROM monthly_actual_revenue
        SELECT
            mar.month,
            mar.category,
            mar.actual_revenue,
            st.target
        FROM
            monthly_actual_revenue AS mar
        JOIN
            sales_target AS st ON mar.category = st.category AND mar.month = TO_CHAR(st.order_date, 'YYYY-MM')
        ORDER BY
            mar.month;

SELECT * FROM target_analysis;

--  PSQL command to save the views created as CSV files
/*
\copy (SELECT * FROM product_performance) TO 'C:/Users/Rishav Singh Solanki/Desktop/data-analysis/e-commerce/data/sql_views/product_performance.csv' WITH (FORMAT CSV, HEADER);
\copy (SELECT * FROM rfm_analysis) TO 'C:/Users/Rishav Singh Solanki/Desktop/data-analysis/e-commerce/data/sql_views/rfm_analysis.csv' WITH (FORMAT CSV, HEADER);
\copy (SELECT * FROM target_analysis) TO 'C:/Users/Rishav Singh Solanki/Desktop/data-analysis/e-commerce/data/sql_views/target_analysis.csv' WITH (FORMAT CSV, HEADER);
\copy (SELECT * FROM kpi_overview) TO 'C:/Users/Rishav Singh Solanki/Desktop/data-analysis/e-commerce/data/sql_views/kpi_overview.csv' WITH (FORMAT CSV, HEADER);
\copy (SELECT * FROM monthly_performance) TO 'C:/Users/Rishav Singh Solanki/Desktop/data-analysis/e-commerce/data/sql_views/monthly_performance.csv' WITH (FORMAT CSV, HEADER);
\copy (SELECT * FROM regional_performance) TO 'C:/Users/Rishav Singh Solanki/Desktop/data-analysis/e-commerce/data/sql_views/regional_performance.csv' WITH (FORMAT CSV, HEADER);
\copy (SELECT * FROM customer_performance) TO 'C:/Users/Rishav Singh Solanki/Desktop/data-analysis/e-commerce/data/sql_views/customer_performance.csv' WITH (FORMAT CSV, HEADER);
*/