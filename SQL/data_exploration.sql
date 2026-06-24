--- Checking the table data
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.users`
LIMIT 10;

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.orders`
LIMIT 10;

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.order_items`
LIMIT 10;

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.products`
LIMIT 10;


--- Checking the number of rows
SELECT COUNT(*)
FROM `bigquery-public-data.thelook_ecommerce.users`;

SELECT COUNT(*)
FROM `bigquery-public-data.thelook_ecommerce.orders`;

SELECT COUNT(*)
FROM `bigquery-public-data.thelook_ecommerce.products`;

SELECT COUNT(*)
FROM `bigquery-public-data.thelook_ecommerce.order_items`;


--- Checking for duplicates
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT id) AS unique_ids
FROM `bigquery-public-data.thelook_ecommerce.users`;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT id) AS unique_ids
FROM `bigquery-public-data.thelook_ecommerce.products`;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM `bigquery-public-data.thelook_ecommerce.orders`;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT id) AS unique_rows
FROM `bigquery-public-data.thelook_ecommerce.order_items`;

--- Check for null values
SELECT
    COUNTIF(age IS NULL) AS null_age,
    COUNTIF(gender IS NULL) AS null_gender,
    COUNTIF(country IS NULL) AS null_country,
    COUNTIF(traffic_source IS NULL) AS null_traffic_source
FROM `bigquery-public-data.thelook_ecommerce.users`;


SELECT
    COUNTIF(status IS NULL) AS null_status,
    COUNTIF(created_at IS NULL) AS null_created_at
FROM `bigquery-public-data.thelook_ecommerce.orders`;


SELECT
    COUNTIF(sale_price IS NULL) AS null_sale_price,
    COUNTIF(product_id IS NULL) AS null_product_id
FROM `bigquery-public-data.thelook_ecommerce.order_items`;


--- Check for orphan orders
SELECT COUNT(*) AS orphan_orders
FROM `bigquery-public-data.thelook_ecommerce.orders` o
LEFT JOIN `bigquery-public-data.thelook_ecommerce.users` u
ON o.user_id = u.id
WHERE u.id IS NULL;


SELECT COUNT(*) AS orphan_order_items
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
LEFT JOIN `bigquery-public-data.thelook_ecommerce.orders` o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


--- Check for date range
SELECT
    MIN(created_at) AS first_user,
    MAX(created_at) AS latest_user
FROM `bigquery-public-data.thelook_ecommerce.users`;


SELECT
    MIN(created_at) AS first_order,
    MAX(created_at) AS latest_order
FROM `bigquery-public-data.thelook_ecommerce.orders`;


SELECT
    MIN(created_at) AS first_sale,
    MAX(created_at) AS latest_sale
FROM `bigquery-public-data.thelook_ecommerce.order_items`;


--- Check for status distribution
SELECT
    status,
    COUNT(*) AS orders
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY status
ORDER BY orders DESC;


SELECT
    status,
    COUNT(*) AS transactions
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY status
ORDER BY transactions DESC;


--- Data exploration
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.order_items`
LIMIT 10;



---
SELECT COUNT(*)
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE user_id IS NULL;

SELECT COUNT(*)
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE product_id IS NULL;

SELECT COUNT(*)
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE order_id IS NULL;


