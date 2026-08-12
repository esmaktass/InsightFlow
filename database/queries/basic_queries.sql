-- =====================================================
-- InsightFlow
-- Basic SQL Queries
-- =====================================================

--Q1: "Müşterilerin isim, soyisim ve e-posta adreslerini göster."
SELECT first_name, last_name, email
FROM customers;

--Q2: "Ürün kataloğunu incelemek istiyorum. Ürün adı, satış fiyatı ve stok miktarını göster."
SELECT product_name, list_price, stock_quantity
FROM products;

--Q3: "Satış fiyatı 100'den yüksek olan ürünleri göster."
SELECT product_name, list_price
FROM products
WHERE list_price > 100;

--Q4: "Stok miktarı 100 veya daha fazla olan ürünleri göster."
SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity >= 100;

--Q5: "İtalya'da yaşayan ve 1 Mart 2025'ten sonra kayıt olmuş müşterileri göster."
SELECT first_name, last_name, country, signup_date
FROM customers
WHERE country = 'Italy'
    AND signup_date > '2025-03-01';

--Q6: "Fransa veya Almanya'daki müşterilerin isimlerini ve ülkelerini göster."
SELECT first_name, country
FROM customers
WHERE country = 'France'
   OR country = 'Germany';

--Q7: "Ürünleri stok miktarı en yüksek olandan en düşük olana sırala."
SELECT product_name, stock_quantity
FROM products
ORDER BY stock_quantity DESC;

--Q8: "En pahalı 3 ürünü bul."
SELECT product_name, list_price
FROM products
ORDER BY list_price DESC
LIMIT 3;

--Q9:"Müşterilerimiz hangi şehirlerde bulunuyor?"
SELECT DISTINCT city
FROM customers;

--Q10 Final Challenge: "Stokta en az 50 adet bulunan ürünlerden en pahalı 5 tanesini görmek istiyorum."
SELECT product_name, list_price, stock_quantity
FROM products
WHERE stock_quantity >= 50
ORDER BY list_price DESC
LIMIT 5;

--Q11: Adı L harfiyle başlayan müşterileri göster.
SELECT first_name, last_name
FROM customers
WHERE first_name LIKE 'L%';

--Q12: İtalya, Fransa veya Almanya'da yaşayan müşterileri göster.
SELECT first_name, last_name, country
FROM customers
WHERE country IN ('Italy', 'France', 'Germany');

--Q13: Stok miktarı 50 ile 100 arasında olan ürünleri göster.
SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity BETWEEN 50 AND 100;

--Q14: 1 Şubat 2025 ile 30 Nisan 2025 arasında kayıt olan müşterileri göster.
SELECT first_name, last_name, signup_date
FROM customers
WHERE signup_date BETWEEN '2025-02-01' AND '2025-04-30';

--Q15: Şehir bilgisi eksik olan müşterileri bul.
SELECT first_name, last_name, city
FROM customers
WHERE city IS NULL;

--Q16: Şehir bilgisi bulunan müşterilerin isimlerini ve şehirlerini göster.
SELECT first_name, city
FROM customers
WHERE city IS NOT NULL;

--Q17:
SELECT
    product_name AS product,
    list_price AS price,
    stock_quantity AS stock 
FROM products;

--Q18:
SELECT
    product_name,
    list_price,
    cost,
    list_price - cost AS unit_profit
FROM products;

--Q19:Birim kârı 40'tan yüksek ürünleri bul.
SELECT 
    product_name,
    list_price - cost AS unit_profit
FROM products
WHERE list_price - cost > 40;

--Q20: Almanya, Fransa veya İtalya'da yaşayan, 1 Mart 2025 ile 31 Mayıs 2025 arasında kayıt olmuş müşterileri en yeni kayıttan en eskiye doğru göster.
SELECT first_name, last_name, country, signup_date
FROM customers
WHERE country IN ('Germany', 'France', 'Italy')
    AND signup_date BETWEEN '2025-03-01' AND '2025-05-31'
ORDER BY signup_date DESC;