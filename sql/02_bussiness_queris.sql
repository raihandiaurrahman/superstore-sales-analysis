-- berapa total penjualan dan keuntungan?
SELECT SUM(Sales),SUM(Profit) 
FROM `super_store`;

-- berapa jumlah Order,jumlah customer dan jumlah rata” sales per order?
SELECT COUNT(DISTINCT Order_id)
FROM super_store;

SELECT COUNT(DISTINCT customer_id)
FROM super_store;

SELECT SUM(Sales) / COUNT(DISTINCT Order_id) as avg_order
FROM super_store

-- Bagaimana tren penjualan setiap bulan?
SELECT
	YEAR(`Order_date`) AS tahun,
	MONTH(`Order_date`) AS bulan,
	SUM(Sales) AS total_penjualan
FROM super_store
GROUP BY YEAR(`Order_date`), MONTH(`Order_date`);
ORDER BY tahun ASC, bulan ASC; 

-- Kategori dengan keuntungan terbesar
SELECT Category,SUM(profit) AS total_keuntungan 
FROM `super_store` 
GROUP BY Category 
ORDER BY total_keuntungan DESC;

-- Wilayah mana yang memiliki penjualan tinggi tetapi keuntungan rendah?

WITH penjualan_wilayah AS (
    SELECT
        State,
        SUM(Sales) AS total_penjualan,
        SUM(Profit) AS total_untung
    FROM super_store
    GROUP BY State
),
rata_rata AS (
    SELECT
        AVG(total_penjualan) AS rata_penjualan,
        AVG(total_untung) AS rata_untung
    FROM penjualan_wilayah
)
SELECT
    p.State,
    p.total_penjualan,
    p.total_untung
FROM penjualan_wilayah p
CROSS JOIN rata_rata r
WHERE p.total_penjualan > r.rata_penjualan
AND p.total_untung < r.rata_untung
ORDER BY p.total_penjualan DESC;

-- Bagaimana hubungan diskon dengan keuntungan? -> USING PYTHON
-- Bagaimana hubungan total penjualan dan profit per kategori? -> USING PYTHON

-- Top 5 Product dari category apa dan berdasarkan Sales
SELECT Product_Name,
	    Category,
    SUM(Sales) as total_sales,
    SUM(Profit) as total_profit,
    SUM(Profit) / SUM(Sales) as percent_profit
FROM super_store
GROUP BY Product_Name,Category
ORDER BY total_sales DESC
LIMIT 5

