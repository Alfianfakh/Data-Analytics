-- MART: Product Performance
CREATE OR REPLACE TABLE DB_FMA.mart_product_performance AS

SELECT
  product_id,
  product_name,
  category,
  sub_category,
  article_type,
  colour,
  season,
  product_gender,

  -- Sales Metrics
  COUNT(DISTINCT booking_id)    AS total_orders,
  SUM(quantity)                 AS total_qty_sold,
  SUM(total_amount)             AS total_revenue,
  ROUND(AVG(item_price), 2)     AS avg_selling_price,

  -- Promo
  COUNTIF(promo_code IS NOT NULL)               AS orders_with_promo,
  SUM(promo_amount)                             AS total_discount_given,

  -- Ranking
  RANK() OVER (ORDER BY SUM(total_amount) DESC) AS revenue_rank,
  RANK() OVER (ORDER BY SUM(quantity) DESC)     AS qty_rank

FROM `DB_FMA.master_transaction_new``
WHERE payment_status = 'paid'
GROUP BY 1,2,3,4,5,6,7,8;