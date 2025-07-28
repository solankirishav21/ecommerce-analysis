-- Analysis of regional sales performance in India
-- This SQL query aggregates sales data by state, calculating total orders, revenue, and profit.
SELECT
    state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.amount) AS total_revenue,
    SUM(od.profit) AS total_profit
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY state
ORDER BY total_profit DESC, total_revenue DESC, total_orders DESC;
/*
[
  {
    "state": "Maharashtra",
    "total_orders": "90",
    "total_revenue": "95348.00",
    "total_profit": "6176.00"
  },
  {
    "state": "Madhya Pradesh",
    "total_orders": "101",
    "total_revenue": "105140.00",
    "total_profit": "5551.00"
  },
  {
    "state": "Uttar Pradesh",
    "total_orders": "22",
    "total_revenue": "22359.00",
    "total_profit": "3237.00"
  },
  {
    "state": "Delhi",
    "total_orders": "22",
    "total_revenue": "22531.00",
    "total_profit": "2987.00"
  },
  {
    "state": "West Bengal",
    "total_orders": "22",
    "total_revenue": "14086.00",
    "total_profit": "2500.00"
  },
  {
    "state": "Kerala ",
    "total_orders": "16",
    "total_revenue": "13459.00",
    "total_profit": "1871.00"
  },
  {
    "state": "Haryana",
    "total_orders": "14",
    "total_revenue": "8863.00",
    "total_profit": "1325.00"
  },
  {
    "state": "Rajasthan",
    "total_orders": "32",
    "total_revenue": "21149.00",
    "total_profit": "1257.00"
  },
  {
    "state": "Himachal Pradesh",
    "total_orders": "14",
    "total_revenue": "8666.00",
    "total_profit": "656.00"
  },
  {
    "state": "Karnataka",
    "total_orders": "21",
    "total_revenue": "15058.00",
    "total_profit": "645.00"
  },
  {
    "state": "Gujarat",
    "total_orders": "27",
    "total_revenue": "21058.00",
    "total_profit": "465.00"
  },
  {
    "state": "Sikkim",
    "total_orders": "12",
    "total_revenue": "5276.00",
    "total_profit": "401.00"
  },
  {
    "state": "Goa",
    "total_orders": "14",
    "total_revenue": "6705.00",
    "total_profit": "370.00"
  },
  {
    "state": "Nagaland",
    "total_orders": "15",
    "total_revenue": "11903.00",
    "total_profit": "148.00"
  },
  {
    "state": "Jammu and Kashmir",
    "total_orders": "14",
    "total_revenue": "10829.00",
    "total_profit": "8.00"
  },
  {
    "state": "Bihar",
    "total_orders": "16",
    "total_revenue": "12943.00",
    "total_profit": "-321.00"
  },
  {
    "state": "Andhra Pradesh",
    "total_orders": "15",
    "total_revenue": "13256.00",
    "total_profit": "-496.00"
  },
  {
    "state": "Punjab",
    "total_orders": "25",
    "total_revenue": "16786.00",
    "total_profit": "-609.00"
  },
  {
    "state": "Tamil Nadu",
    "total_orders": "8",
    "total_revenue": "6087.00",
    "total_profit": "-2216.00"
  }
]
*/