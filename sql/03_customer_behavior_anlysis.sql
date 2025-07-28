-- Customer spending, profit, and order analysis
-- This SQL script analyzes customer behavior by calculating total orders, total spent, total profit generated,

SELECT  
    customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.amount) AS total_spent,
    ROUND(AVG(od.amount), 2) AS average_spent,
    SUM(od.profit) AS total_profit_generated,
    MAX(o.order_date) AS last_order_date,
    ROUND(SUM(od.amount) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY customer_name
ORDER BY total_profit_generated DESC, total_spent DESC, total_orders DESC
LIMIT 15;

/* OUTPUT (TOP 15 customers by profit generated):
"customer_name","total_orders","total_spent","average_spent","total_profit_generated","last_order_date","average_order_value"
"Seema","1","5228.00","1045.60","1970.00","2019-01-24","5228.00"
"Abhijeet","2","5691.00","406.50","1562.00","2018-11-10","2845.50"
"Priyanka","4","5762.00","274.38","1340.00","2019-03-16","1440.50"
"Abhishek","5","8135.00","325.40","1314.00","2018-12-07","1627.00"
"Sarita","3","5449.00","389.21","1265.00","2019-03-27","1816.33"
"Swapnil","3","4929.00","379.15","1215.00","2018-12-10","1643.00"
"Pournamasi","2","2286.00","381.00","1027.00","2019-03-21","1143.00"
"Gaurav","2","3349.00","334.90","1011.00","2019-02-03","1674.50"
"Pearl","3","3944.00","563.43","995.00","2019-03-21","1314.67"
"Vishakha","1","4836.00","1209.00","966.00","2018-12-27","4836.00"
"Rohan","4","4901.00","350.07","917.00","2018-12-06","1225.25"
"Parishi","2","4741.00","431.00","900.00","2019-03-07","2370.50"
"Soumya","3","6869.00","624.45","894.00","2019-01-21","2289.67"
"Aastha","1","3276.00","546.00","873.00","2018-10-26","3276.00"
"Harshal","1","6026.00","860.86","864.00","2019-02-03","6026.00"
*/
