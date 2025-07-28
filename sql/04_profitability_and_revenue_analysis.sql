-- Profitability and Revenue analysis for different product-categories

SELECT
    category,
    SUM(amount) AS total_revenue,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / SUM(amount)) * 100, 2) AS profit_margin_percentage,
    SUM(quantity) as total_items_sold
FROM order_details
GROUP BY category
ORDER BY total_profit DESC;

/* Output:
"category","total_revenue","total_profit","profit_margin_percentage","total_items_sold"
"Clothing","139054.00","11163.00","8.03","3516"
"Electronics","165267.00","10494.00","6.35","1154"
"Furniture","127181.00","2298.00","1.81","945"
*/