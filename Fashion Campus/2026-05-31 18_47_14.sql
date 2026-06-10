SELECT
  -- Keys
  COUNTIF(booking_id    IS NULL) AS null_booking_id,
  COUNTIF(customer_id   IS NULL) AS null_customer_id,
  COUNTIF(product_id    IS NULL) AS null_product_id,
  COUNTIF(session_id    IS NULL) AS null_session_id,

  -- Payment
  COUNTIF(payment_method IS NULL) AS null_payment_method,
  COUNTIF(payment_status IS NULL) AS null_payment_status,
  COUNTIF(total_amount   IS NULL) AS null_total_amount,
  COUNTIF(item_price     IS NULL) AS null_item_price,
  COUNTIF(quantity       IS NULL) AS null_quantity,

  -- Promo
  COUNTIF(promo_code   IS NULL) AS null_promo_code,
  COUNTIF(promo_amount IS NULL) AS null_promo_amount,

  -- Shipment
  COUNTIF(shipment_fee           IS NULL) AS null_shipment_fee,
  COUNTIF(shipment_date_limit    IS NULL) AS null_shipment_date,
  COUNTIF(shipment_location_lat  IS NULL) AS null_shipment_lat,
  COUNTIF(shipment_location_long IS NULL) AS null_shipment_long,

  -- Date
  COUNTIF(created_at IS NULL) AS null_created_at,

  COUNT(*) AS total_rows

FROM `DB_FMA.master_transaction_new`;
