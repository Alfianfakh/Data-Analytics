CREATE OR REPLACE TABLE `datascience-414913.DB_FMA.scorecard` AS

SELECT
  SUM(total_amount)             AS total_revenue,
  COUNT(DISTINCT booking_id)    AS total_orders,
  COUNT(DISTINCT customer_id)   AS unique_customers,
  ROUND(AVG(total_amount), 2)   AS avg_order_value,
  SUM(quantity)                 AS total_items_sold,
  SUM(promo_amount)             AS total_discount

FROM `datascience-414913.DB_FMA.master_transaction_new`
WHERE payment_status = 'Success'
  AND year BETWEEN 2019 AND 2022;