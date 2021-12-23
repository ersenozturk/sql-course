/*===================================================
	AGGREGATE(Biriktiren) FUNCTION COUNT,MIN,MAX,AVG,SUM )
	Büyük miktardan veriyi alıp bundan tek bir değer döndürür.
====================================================*/
	
	-- COUNT Bir rowdaki elemansayısı örnek 
	/*  SELECT count(first_name) AS 'outputa nasıl çıktı vermesini istersek'                AS kullanmadan yazılanlar çoğnlkla tablo isimleri
	    FROM student_info; */ 
	-------------------------------------------------------------------------------------------------	
	/* last name de kaç null var öğrenelim mesela ; 
	SELECT count(*) FROM students WHERE LastName Is	NULL;
	-------------------------------------------------------------------------------------------------	
	
	/* invoices tablosunda kaç adet NULL(boş) BillingState döndüren sorgu                                 FARKLI BAK is falan var*/
	SELECT count(*) FROM invoices WHERE BillingState Is	NULL;
	
	/* invoices tablosunda kaç adet fatura bulunduğunu döndüren sorgu */
	SELECT count(*) FROM invoices;
	
	
	/* tracks tablosunda kaç adet farklı Composer bulunduğunu döndüren sorguyu yazınız*/
	SELECT DISTINCT count(Composer)
	FROM tracks;
	
	SELECT count(DISTINCT Composer) AS besteci_sayisi
	FROM tracks;
	
	
	/* invoices tablosunda kaç adet farklı yıl olduğunu hesaplayan sorguyu yazınız ÖDEVVVVV */ 
	
	
-- MIN,MAX
	-------------------------------------------------------------------------------------------------	
	/* tracks tablosundaki şarkı süresi en kısa olan şarkının adını ve süresi listeleyen
	sorguyu yaziniz */
	SELECT name as şarkı_ismi, min(Milliseconds) as Şarkı_süremiz_loo
	FROM tracks;
	
	/* students tablosundaki en düşük ve en yüksek notu listeleyen sorguyu yaziniz */
	
	SELECT MIN(Grade) as min_grade, max(grade) max_grade
	FROM students;
	

	-- SUM,AVG
	-------------------------------------------------------------------------------------------------	
	/* invoices  tablosundaki faturaların toplam değerini listeyiniz */
	SELECT SUM(total) AS Toplam_Gelir
	FROM invoices;
	
	/* invoices  tablosundaki faturaların ortalama değerini listeyiniz */
	SELECT avg(total) AS ortalama_Gelir
	FROM invoices;
	
	SELECT round(avg(total)) AS ortalama_Gelir_yuvarlanmış
	FROM invoices;
	
	SELECT round(avg(total),2) AS ortalama_Gelir_ikibasamaklı_yuvarlanmış
	FROM invoices;
	
	/* ödevvv invoices  tablosunda 2009 ile 2013 tarihileri arasındaki faturaların toplam değerini listeyiniz */
	
	-------
	
	/* tracks tablosundaki şarkıların ortalama süresinden daha uzun olan 			iptal!!gereksiz!!
	şarkıların adlarını listeleyiniz */
	SELECT ROUND(AVG(Milliseconds))
	FROM tracks;
	
	SELECT Name, Milliseconds
	FROM tracks
	WHERE Milliseconds > 393599;
	
	/*Bu yöntem hard-coded olduğu için çok mantıklı bir çözüm değil. 
	alt-sorgu(sub-query) ile daha doğru bir yaklaşım olacaktır sonraki 
	bölümlerde alt-sorguyu ayrıntılı bir şekilde inceleyeceğiz.*/
	/* tracks tablosundaki şarkıların ortalama süresinden daha uzun olan şarkıların adlarını listeleyiniz */
	
	SELECT Name, Milliseconds
	FROM tracks
	WHERE Milliseconds > ( 	SELECT AVG(Milliseconds)
							FROM tracks);
	/* sayısı */
	SELECT count(Milliseconds)
	FROM tracks
	WHERE Milliseconds > ( 	SELECT AVG(Milliseconds)
							FROM tracks);
	/* sayısı */						
	SELECT count(Milliseconds)
	FROM tracks;
	/*===================================================
 GROUP BY
====================================================*/
	/* Group by clause 
	- Where in altında order by   ın üstünde olur (where..group by..order by)
	- yalnızca bir sonuc verir 
	usually AGGREGATE func ile kullanılır 
	istatistik veriler için çok kullanışlı*/
	

	/* tracks tablosundaki her bir Bestecisinin (Composer) toplam şarkı sayısını 
	Besteci adına göre gruplandırarak listeleyen sorguyu yazınız. */
	SELECT Composer,count(name) as şarkı_sayısı
	FROM tracks
	GROUP BY Composer; /* burda heeeepsini seçti.null olanlar 978 adet. */
	
	SELECT Composer,count(name) as şarkı_sayısı
	FROM tracks
	WHERE Composer IS NOT NULL /* null olmayanları çalıştır */
	GROUP BY Composer;
	
	SELECT Composer, COUNT(name) AS Song_Count
	FROM tracks
	WHERE Composer IS NOT NULL
	GROUP BY Composer;  /*hocanın yaptığı*/
	
	/* customers tablosundaki müşterilerin sayılarını Ülkelerine (Country) göre gruplandırarak 
	ve müşteri sayısına göre AZALAN şekilde sıralayarak listeleyen sorguyu yazınız*/
	SELECT country, COUNT(FirstName) as nu_of_cust
	FROM customers
	GROUP BY country
	ORDER BY nu_of_cust DESC;
	
	SELECT country, COUNT(FirstName) as nu_of_cust
	FROM customers
	GROUP BY country
	ORDER BY COUNT(FirstName) DESC;
	
	/* customers tablosundaki müşterilerin sayılarını Ülkelerine (Country) ve Şehirlerine (City) 
	göre gruplandırarak listeleyen sorguyu yazınız   23 15  */
	SELECT country,City, count(FirstName) as müşyeri_sayısı
	FROM customers
	GROUP BY country, City;
	
	/* invoices tablosundaki her bir ülkenin (BillingCountry) fatura ortalamalarını 
	hesaplayan ve ülke bilgileri ile listeleyen sorguyu yazınız.*/
	SELECT BillingCountry as fatura_ülkesi, round(avg(total),2) as ort_fatura
	FROM invoices
	GROUP BY BillingCountry;
	
	SELECT BillingCountry round(avg(total),2) as ort_fatura
	FROM invoices
	WHERE InvoiceDate BETWEEN '2009-01-01' AND '2011-12-31 23:59:59'
	GROUP BY BillingCountry;
	
