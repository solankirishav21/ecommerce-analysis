-- Overall Average Order Value
SELECT
    ROUND(SUM(amount) / COUNT(DISTINCT order_id), 2) AS overall_aov
FROM
    order_details;

/* Output:
"overall_aov"
"863.00"
*/

-- AOV for each month to track trends
SELECT
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    ROUND(SUM(od.amount) / COUNT(DISTINCT o.order_id), 2) AS monthly_aov
FROM
    orders AS o
JOIN
    order_details AS od ON o.order_id = od.order_id
GROUP BY
    month
ORDER BY
    month;
/* Output:
"month","monthly_aov"
"2018-04","743.77"
"2018-05","920.81"
"2018-06","788.60"
"2018-07","418.26"
"2018-08","996.74"
"2018-09","887.60"
"2018-10","735.23"
"2018-11","1045.35"
"2018-12","916.56"
"2019-01","1007.20"
"2019-02","711.56"
"2019-03","1016.16"
*/