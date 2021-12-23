	/*===================================================
        JOINS
====================================================*/
    
--     Join islemleri farkli tablolardan secilen sutunlar ile yeni bir tablo 
--     olusturmak icin kullanilabilir.
--     
--     JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
--    	Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
--     icin JOIN islemleri kullanilabilir.

--     Standart SQL'de en çok kullanılan Join islemleri:
--   	1) FULL JOIN:  Tablodaki tum sonuclari gosterir
--     2) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir 						!!! 
--     3) LEFT JOIN:  Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir 			!!!
--     4) RIGHT JOIN: Sadece Ikinci tabloda olan tum sonuclari gosterir.

--		NOT: SQLite Sadece INNER, LEFT VE CROSS JOIN İşlemlerini desteklemektedir.
 
 /*===================================================*/   
 
 SELECT t1.x, t2.y, ....
	FROM TABLO1 t1
	FULL JOIN TABLO2 t2
	ON t1.FK = t2.PK;

  /* araclar.db adındaki veritabanını kullanarak Markalar ve Siparisler tablolarındaki 
 marka_id'si ayni olan kayıtların marka_id, marka_adi, siparis_adedi ve siparis_tarihi   
 bilgilerini  listeleyen bir sorgu yaziniz.*/
 
	SELECT markalar.marka_adi,markalar.marka_id,siparisler.siparis_adedi,siparisler.siparis_tarihi
	FROM markalar
	INNER JOIN siparisler on markalar.marka_id = siparisler.marka_id;

	SELECT markalar.marka_id,markalar.marka_adi,siparisler.siparis_adedi,siparisler.siparis_tarihi
	FROM markalar
	INNER JOIN siparisler on markalar.marka_id = siparisler.marka_id;
 
 
 
 	/* ödevvv invoices tablosunda 2009 ile 2013 tarihileri arasındaki faturaların toplam değerini listeyiniz */
	SELECT sum(total) as top_fatura
	FROM invoices
	WHERE total BETWEEN '2009-01-01' AND '2013-12-31';
	
	
	/* invoices tablosunda kaç adet farklı yıl olduğunu hesaplayan sorguyu yazınız ÖDEVVVVV */ 
	SELECT DISTINCT count(InvoiceDate)
	FROM invoices
	WHERE InvoiceDate like '20__-%%-%%';

	
