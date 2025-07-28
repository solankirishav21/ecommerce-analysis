-- Yearly sales trend and performance analysis
SELECT
	EXTRACT(YEAR FROM order_date) AS order_year,
	COUNT(DISTINCT o.order_id) AS total_orders,
	SUM(od.amount) AS total_revenue,
	SUM(od.profit) AS total_profit
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY order_year
ORDER BY order_year;

/* Output
[
  {
    "order_year": "2018",
    "total_orders": "327",
    "total_revenue": "272702.00",
    "total_profit": "-1799.00"
  },
  {
    "order_year": "2019",
    "total_orders": "173",
    "total_revenue": "158800.00",
    "total_profit": "25754.00"
  }
]
*/

--Monthly sales trend and performance analysis
SELECT 
	TO_CHAR(order_date, 'YYYY-MM') AS order_month,
	COUNT(DISTINCT o.order_id) AS total_orders,
	SUM(od.amount) AS total_revenue,
	SUM(od.profit) AS total_profit
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY order_month
ORDER BY order_month;

/* Output 
[
  {
    "order_month": "2018-04",
    "total_orders": "44",
    "total_revenue": "32726.00",
    "total_profit": "-3960.00"
  },
  {
    "order_month": "2018-05",
    "total_orders": "31",
    "total_revenue": "28545.00",
    "total_profit": "-3584.00"
  },
  {
    "order_month": "2018-06",
    "total_orders": "30",
    "total_revenue": "23658.00",
    "total_profit": "-4970.00"
  },
  {
    "order_month": "2018-07",
    "total_orders": "31",
    "total_revenue": "12966.00",
    "total_profit": "-2138.00"
  },
  {
    "order_month": "2018-08",
    "total_orders": "31",
    "total_revenue": "30899.00",
    "total_profit": "-2180.00"
  },
  {
    "order_month": "2018-09",
    "total_orders": "30",
    "total_revenue": "26628.00",
    "total_profit": "-4963.00"
  },
  {
    "order_month": "2018-10",
    "total_orders": "43",
    "total_revenue": "31615.00",
    "total_profit": "3093.00"
  },
  {
    "order_month": "2018-11",
    "total_orders": "46",
    "total_revenue": "48086.00",
    "total_profit": "11619.00"
  },
  {
    "order_month": "2018-12",
    "total_orders": "41",
    "total_revenue": "37579.00",
    "total_profit": "5284.00"
  },
  {
    "order_month": "2019-01",
    "total_orders": "61",
    "total_revenue": "61439.00",
    "total_profit": "9760.00"
  },
  {
    "order_month": "2019-02",
    "total_orders": "54",
    "total_revenue": "38424.00",
    "total_profit": "5917.00"
  },
  {
    "order_month": "2019-03",
    "total_orders": "58",
    "total_revenue": "58937.00",
    "total_profit": "10077.00"
  }
]

*/
