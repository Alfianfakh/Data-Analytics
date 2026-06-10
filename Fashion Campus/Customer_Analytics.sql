-- MART: Customer Segmentation (RFM)
CREATE OR REPLACE TABLE DB_FMA.mart_customer_rfm AS

WITH rfm_base AS (
  SELECT
    customer_id,
    customer_name,
    customer_gender,
    age_group,
    home_country,
    device_type,
    first_join_date,

    -- RFM Metrics
    DATE_DIFF(CURRENT_DATE(), MAX(transaction_date), DAY)   AS recency_days,
    COUNT(DISTINCT booking_id)                               AS frequency,
    SUM(total_amount)                                        AS monetary

  FROM `DB_FMA.master_transaction_new`
  WHERE payment_status = 'paid'
  GROUP BY 1,2,3,4,5,6,7
),

rfm_scored AS (
  SELECT *,
    NTILE(5) OVER (ORDER BY recency_days DESC)  AS r_score,  -- lebih kecil = lebih baik
    NTILE(5) OVER (ORDER BY frequency ASC)      AS f_score,
    NTILE(5) OVER (ORDER BY monetary ASC)       AS m_score
  FROM rfm_base
)

SELECT *,
  ROUND((r_score + f_score + m_score) / 3, 2)  AS rfm_avg,
  CASE
    WHEN r_score >= 4 AND f_score >= 4          THEN 'Champions'
    WHEN r_score >= 3 AND f_score >= 3          THEN 'Loyal Customers'
    WHEN r_score >= 4 AND f_score <= 2          THEN 'New Customers'
    WHEN r_score >= 3 AND f_score <= 3          THEN 'Potential Loyalist'
    WHEN r_score <= 2 AND f_score >= 3          THEN 'At Risk'
    WHEN r_score <= 2 AND f_score <= 2          THEN 'Lost Customers'
    ELSE 'Need Attention'
  END AS customer_segment

FROM rfm_scored;