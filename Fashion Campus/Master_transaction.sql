-- MASTER TABLE: Transaction + Product + Customer
CREATE OR REPLACE TABLE DB_FMA.master_transaction_new AS

SELECT
  -- Transaction Info
  t.booking_id,
  t.created_at,
  DATE(t.created_at)                                    AS transaction_date,
  FORMAT_DATE('%Y-%m', DATE(t.created_at))              AS year_month,
  EXTRACT(YEAR  FROM t.created_at)                      AS year,
  EXTRACT(MONTH FROM t.created_at)                      AS month,
  EXTRACT(DAYOFWEEK FROM t.created_at)                  AS day_of_week,

  -- Customer Info
  t.customer_id,
  CONCAT(c.first_name, ' ', c.last_name)                AS customer_name,
  c.gender                                              AS customer_gender,
  DATE_DIFF(CURRENT_DATE(), DATE(c.birthdate), YEAR)    AS customer_age,
  CASE
    WHEN DATE_DIFF(CURRENT_DATE(), DATE(c.birthdate), YEAR) < 25 THEN 'Gen Z'
    WHEN DATE_DIFF(CURRENT_DATE(), DATE(c.birthdate), YEAR) < 40 THEN 'Millennial'
    WHEN DATE_DIFF(CURRENT_DATE(), DATE(c.birthdate), YEAR) < 55 THEN 'Gen X'
    ELSE 'Boomer'
  END                                                   AS age_group,
  c.home_country,
  c.home_location,
  c.device_type,
  DATE(c.first_join_date)                               AS first_join_date,

  -- Product Info
  t.product_id,
  p.productDisplayName                                  AS product_name,
  p.masterCategory                                      AS category,
  p.subCategory                                         AS sub_category,
  p.articleType                                         AS article_type,
  p.baseColour                                          AS colour,
  p.season,
  p.gender                                              AS product_gender,
  p.usage                                               AS product_usage,

  -- Transaction Metrics
  t.quantity,
  t.item_price,
  t.total_amount,
  t.promo_code,
  t.promo_amount,
  t.shipment_fee,
  t.payment_method,
  t.payment_status,
  t.session_id

FROM `DB_FMA.transaction_new` t
LEFT JOIN `DB_FMA.customer`    c ON t.customer_id = c.customer_id
LEFT JOIN `DB_FMA.product`     p ON t.product_id  = p.id;