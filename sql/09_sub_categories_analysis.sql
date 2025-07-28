-- Query to anlyze to 15 performing sub-categories based on total profit and revenue

SELECT 
    sub_category,
    COUNT(order_id) AS total_orders,
    SUM(amount) AS total_revenue,
    SUM(profit) AS total_profit
FROM order_details
GROUP BY sub_category
ORDER BY total_profit DESC, total_revenue DESC
LIMIT 15;
/*OUTPUT:
"sub_category","total_orders","total_revenue","total_profit"
"Printers","74","58252.00","5964.00"
"Bookcases","79","56861.00","4888.00"
"Accessories","72","21728.00","3559.00"
"Trousers","39","30039.00","2847.00"
"Stole","192","18546.00","2559.00"
"Phones","83","46119.00","2207.00"
"Hankerchief","198","14608.00","2098.00"
"T-shirt","77","7382.00","1500.00"
"Shirt","69","7555.00","1131.00"
"Furnishings","73","13484.00","844.00"
"Chairs","74","34222.00","577.00"
"Saree","210","53511.00","352.00"
"Leggings","53","2106.00","260.00"
"Skirt","64","1946.00","235.00"
"Kurti","47","3361.00","181.00"
*/

-- Query to find sub-categories with negative profit
SELECT 
    sub_category,
    COUNT(order_id) AS total_orders,
    SUM(amount) AS total_revenue,
    SUM(profit) AS total_profit
FROM order_details
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit;
/*OUTPUT:
"sub_category","total_orders","total_revenue","total_profit"
"Tables","17","22614.00","-4011.00"
"Electronic Games","79","39168.00","-1236.00"
*/