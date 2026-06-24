--- KPIs

SELECT
    ROUND(SUM(sale_price),2) AS revenue,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT user_id) AS customers
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status IN ('Complete','Shipped');


--- Creating average order value
WITH sales AS (
    SELECT *
    FROM `bigquery-public-data.thelook_ecommerce.order_items`
    WHERE status IN ('Complete','Shipped')
)

SELECT
    ROUND(SUM(sale_price),2) AS revenue,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT user_id) AS customers,
    ROUND(
        SUM(sale_price) /
        COUNT(DISTINCT order_id),
        2
    ) AS avg_order_value
FROM sales;


--- Monthly revenue trend
SELECT
    DATE_TRUNC(DATE(created_at), MONTH) AS month,
    ROUND(SUM(sale_price),2) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status IN ('Complete','Shipped')
GROUP BY month
ORDER BY month;


SELECT
    EXTRACT(YEAR FROM created_at) AS year,
    ROUND(SUM(sale_price),2) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status IN ('Complete','Shipped')
GROUP BY year
ORDER BY year;


--- Revenue by category
SELECT
    p.category,
    ROUND(SUM(oi.sale_price),2) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id
WHERE oi.status IN ('Complete','Shipped')
GROUP BY p.category
ORDER BY revenue DESC;


--- Customer aquisition analysis
SELECT
    u.traffic_source,
    COUNT(DISTINCT oi.user_id) AS customers,
    ROUND(SUM(oi.sale_price),2) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.users` u
    ON oi.user_id = u.id
WHERE oi.status IN ('Complete','Shipped')
GROUP BY u.traffic_source
ORDER BY revenue DESC;


--- Calculating repeat customers
WITH customer_orders AS (
    SELECT
        user_id,
        COUNT(DISTINCT order_id) AS orders
    FROM `bigquery-public-data.thelook_ecommerce.order_items`
    WHERE status IN ('Complete','Shipped')
    GROUP BY user_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNTIF(orders > 1) AS repeat_customers,
    ROUND(
        COUNTIF(orders > 1) * 100.0 /
        COUNT(*),
        2
    ) AS repeat_customer_rate
FROM customer_orders;


--- Yearly Revenue + Orders + Customers + AOV
SELECT
    EXTRACT(YEAR FROM created_at) AS year,
    ROUND(SUM(sale_price),2) AS revenue,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT user_id) AS customers,
    ROUND(
        SUM(sale_price) /
        COUNT(DISTINCT order_id),
        2
    ) AS aov
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status IN ('Complete','Shipped')
GROUP BY year
ORDER BY year;


--- Customer Lifetime Value (CLV)
WITH customer_revenue AS (
    SELECT
        user_id,
        SUM(sale_price) AS lifetime_revenue
    FROM `bigquery-public-data.thelook_ecommerce.order_items`
    WHERE status IN ('Complete','Shipped')
    GROUP BY user_id
)
SELECT
    ROUND(AVG(lifetime_revenue),2) AS avg_clv,
    ROUND(MIN(lifetime_revenue),2) AS min_clv,
    ROUND(MAX(lifetime_revenue),2) AS max_clv
FROM customer_revenue;


--- Highest-value customers
WITH customer_revenue AS (
    SELECT
        user_id,
        SUM(sale_price) AS lifetime_revenue
    FROM `bigquery-public-data.thelook_ecommerce.order_items`
    WHERE status IN ('Complete','Shipped')
    GROUP BY user_id
)
SELECT *
FROM customer_revenue
ORDER BY lifetime_revenue DESC
LIMIT 10;


--- Profit 
SELECT
    ROUND(SUM(oi.sale_price),2) AS revenue,
    ROUND(SUM(p.cost),2) AS cost,
    ROUND(SUM(oi.sale_price)-SUM(p.cost),2) AS profit,
    ROUND(
        (SUM(oi.sale_price)-SUM(p.cost))
        / SUM(oi.sale_price) * 100,
        2
    ) AS profit_margin_pct
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id
WHERE oi.status IN ('Complete','Shipped');



SELECT
    p.category,
    ROUND(SUM(oi.sale_price),2) AS revenue,
    ROUND(SUM(p.cost),2) AS cost,
    ROUND(SUM(oi.sale_price)-SUM(p.cost),2) AS profit
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id
WHERE oi.status IN ('Complete','Shipped')
GROUP BY p.category
ORDER BY profit DESC;

