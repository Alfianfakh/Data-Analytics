-- MART: Daily Sales Summary
CREATE OR REPLACE TABLE DB_FMA.mart_daily_sales AS

SELECT
  transaction_date,
  year_month,
  year,
  month,
  day_of_week,

  -- Volume
  COUNT(DISTINCT booking_id)                            AS total_orders,
  COUNT(DISTINCT customer_id)                           AS unique_customers,
  SUM(quantity)                                         AS total_items_sold,

  -- Revenue
  SUM(total_amount)                                     AS gross_revenue,
  SUM(promo_amount)                                     AS total_discount,
  SUM(total_amount) - SUM(promo_amount)                 AS net_revenue,
  SUM(shipment_fee)                                     AS total_shipment_fee,

  -- Averages
  ROUND(AVG(total_amount), 2)                           AS avg_order_value,
  ROUND(AVG(quantity), 2)                               AS avg_items_per_order,

  -- Payment
  COUNTIF(payment_status = 'paid') / COUNT(*) * 100    AS payment_success_rate

FROM `DB_FMA.master_transaction_new`
GROUP BY 1,2,3,4,5
ORDER BY 1;