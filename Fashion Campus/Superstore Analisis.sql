
-- 1. Analisis Total Penjualan dan Keuntungan
# Menghitung total penjualan dan total keuntungan dari seluruh dataset.
/* SELECT
  SUM(Sales) as total_sales,
  SUM(Profit) as total_profit
FROM `datascience-414913.percobaan.sales`; */

# Menghitung total penjualan dan total keuntungan berdasarkan wilayah (region).
/* SELECT
  Region,
  SUM(Sales) as total_sales,
  SUM(Profit) as total_profit
FROM `datascience-414913.percobaan.sales`
GROUP BY Region
ORDER BY total_sales DESC; */
--------------------------------------------------------


-- 2. Analisis Pelanggan
# Menghitung jumlah unik order dalam dataset.
/* SELECT Count(DISTINCT order_ID) as total_orders
FROM `datascience-414913.percobaan.sales`; */

# Mengidentifikasi pelanggan dengan jumlah pembelian terbesar berdasarkan total penjualan.
/* SELECT 
  Customer_ID,
  Customer_Name,
  SUM(Sales) as total_spent
FROM `datascience-414913.percobaan.sales`
GROUP BY Customer_Name, Customer_ID
ORDER BY total_spent DESC
LIMIT 15; */
--------------------------------------------------------


-- 3. Analisis Produk dan Kategori
# Menentukan kategori produk dengan total penjualan tertinggi.
/* SELECT
  Category,
  SUM(Sales) as total_sales
FROM `datascience-414913.percobaan.sales`
GROUP BY Category
ORDER BY total_sales DESC; */

# Menghitung margin keuntungan terbesar per kategori produk.
/* SELECT 
  Category, 
  SUM(Sales) AS total_sales,
  SUM(Profit) AS total_profit,
  (SUM(Profit) / SUM(Sales)) * 100 AS profit_margin_percentage
FROM `datascience-414913.percobaan.sales`
GROUP BY Category
ORDER BY profit_margin_percentage DESC; */

# Mengidentifikasi produk yang paling sering dibeli oleh pelanggan berdasarkan jumlah total kuantitas yang terjual.
/* SELECT 
  Product_Name,
  SUM(Quantity) as total_quantity
FROM `datascience-414913.percobaan.sales`
GROUP BY Product_Name
ORDER BY total_quantity DESC; */

# Menganalisis produk yang sering dibeli dalam jumlah besar, yang dapat menunjukkan tingginya permintaan pasar.
/* SELECT
  Product_Name,
  AVG(Quantity) as produk_tertinggi
FROM `datascience-414913.percobaan.sales`
GROUP BY Product_Name
ORDER BY produk_tertinggi DESC
LIMIT 10; */
--------------------------------------------------------


-- 4. Analisis Diskon
# Menganalisis pengaruh diskon terhadap rata-rata keuntungan.
/* SELECT 
  Discount,
  AVG(Profit) as avg_profit
FROM `datascience-414913.percobaan.sales`
GROUP BY Discount
ORDER BY Discount; */

# Menganalisis apakah semakin tinggi diskon, semakin banyak barang yang dibeli oleh pelanggan.
/* SELECT 
  Discount, 
  AVG(Quantity) AS avg_quantity_sold
FROM `datascience-414913.percobaan.sales`
GROUP BY Discount
ORDER BY Discount DESC; */

# Mengidentifikasi produk yang mengalami kerugian jika diberikan diskon tinggi.
/* SELECT
  Product_Name,
  AVG(Discount) as Discount,
  SUM(Profit) as Profit
FROM `datascience-414913.percobaan.sales`  
GROUP BY Product_Name
HAVING Profit < 0
ORDER BY Discount DESC; */
--------------------------------------------------------


-- 5. Analisis Tren dan Waktu
# Menganalisis tren penjualan berdasarkan tahun untuk melihat pola kenaikan atau penurunan penjualan setiap tahunnya.
/* SELECT 
  EXTRACT(YEAR FROM Order_Date) as year,
  SUM(Sales) as Total_sales_peryear
FROM `datascience-414913.percobaan.sales`
GROUP BY year
ORDER BY year; */

# Menganalisis bulan dengan total penjualan tertinggi dalam satu tahun.
/* SELECT 
  EXTRACT(YEAR FROM order_date) as year,
  EXTRACT(MONTH FROM order_date) as month,
  SUM(Sales) as total_sales
FROM `datascience-414913.percobaan.sales`
GROUP BY year, month
ORDER BY total_sales DESC
LIMIT 12; */
--------------------------------------------------------


-- 6. Analisis Geografis
# Mengidentifikasi kota dengan total penjualan tertinggi.
/* SELECT 
  City,
  SUM(Sales) as total_sales
FROM `datascience-414913.percobaan.sales`
GROUP BY City
ORDER BY total_sales DESC
LIMIT 15; */
