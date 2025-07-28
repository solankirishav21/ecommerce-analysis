-- Monthly target achievement analysis for different product-categories
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
WHERE
    mar.actual_revenue >= st.target
ORDER BY
    mar.month;

/* Output:
"month","category","actual_revenue","target"
"2018-04","Clothing","13478.00","12000.00"
"2018-04","Electronics","11127.00","9000.00"
"2018-05","Electronics","12807.00","9000.00"
"2018-06","Electronics","9344.00","9000.00"
"2018-08","Electronics","9539.00","9000.00"
"2018-10","Electronics","13361.00","9000.00"
"2018-11","Clothing","16270.00","16000.00"
"2018-11","Furniture","15165.00","11300.00"
"2018-11","Electronics","16651.00","9000.00"
"2018-12","Electronics","18560.00","9000.00"
"2019-01","Electronics","26716.00","16000.00"
"2019-01","Furniture","21257.00","11500.00"
"2019-02","Furniture","16262.00","11600.00"
"2019-03","Clothing","21418.00","16000.00"
"2019-03","Electronics","20860.00","16000.00"
"2019-03","Furniture","16659.00","11800.00"
*/