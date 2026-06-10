-- MART: Traffic & Conversion dari Clickstream
CREATE OR REPLACE TABLE DB_FMA.mart_marketing_funnel AS

WITH session_events AS (
  SELECT
    session_id,
    traffic_source,
    promo_code,
    COUNT(DISTINCT event_id)                              AS total_events,
    COUNTIF(event_name = 'product_detail')               AS product_views,
    COUNTIF(event_name = 'add_to_cart')                  AS add_to_cart,
    COUNTIF(event_name = 'checkout')                     AS checkout,
    COUNTIF(payment_status = 'paid')                     AS paid_sessions,
    SUM(CASE WHEN payment_status='paid' THEN item_price * quantity ELSE 0 END) AS session_revenue
  FROM `DB_FMA.click_stream`
  GROUP BY 1,2,3
)

SELECT
  traffic_source,
  COUNT(DISTINCT session_id)                            AS total_sessions,
  SUM(product_views)                                    AS total_product_views,
  SUM(add_to_cart)                                      AS total_add_to_cart,
  SUM(checkout)                                         AS total_checkout,
  SUM(paid_sessions)                                    AS total_conversions,

  -- Conversion Rates
  ROUND(SUM(add_to_cart)   / NULLIF(SUM(product_views), 0) * 100, 2) AS view_to_cart_rate,
  ROUND(SUM(paid_sessions) / NULLIF(COUNT(DISTINCT session_id), 0) * 100, 2) AS conversion_rate,

  -- Revenue
  SUM(session_revenue)                                  AS total_revenue,
  ROUND(AVG(session_revenue), 2)                        AS avg_revenue_per_session

FROM session_events
GROUP BY 1
ORDER BY total_conversions DESC;