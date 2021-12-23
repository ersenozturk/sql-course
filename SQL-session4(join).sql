 /* ÖDEV: Chinook veritabanındaki tracks tablosunda bulunan her bir şarkının türü (genre)
listeleyiniz.*/
SELECT * FROM tracks;
SELECT * FROM genres;

SELECT t.name as song_name, g.name as song_genre
FROM tracks t
JOIN genres g
ON t.GenreId = g.GenreId;

	 
 /* ÖDEV: invoice tablosundaki faturaların her birinin müşteri adını (FirstName),
 soyadını (lastName), fatura tarihi (InvoiceDate) ve fatura meblağını (total) 
 listeleyen sorguyu yazınız */
 
 SELECT * from invoices;
 SELECT * FROM customers;
 
 SELECT c.FirstName, c.LastName, i.InvoiceDate, i.total 
 FROM invoices i
 JOIN customers c
 on i.CustomerId = c.CustomerId;
 
	
	/* ÖDEV: artists tablosunda bulunan her bir kişinin albums tablosunda 
bulunan tüm albümlerinin listeleyen sorguyu yazınız. 
Sorguda ArtistId, Name, Title ve AlbumId olmalıdır */
 SELECT * from artists;
 SELECT * FROM albums;
 
SELECT artists.ArtistId,artists.name,albums.Title,albums.AlbumId
FROM artists
LEFT JOIN albums
ON albums.ArtistId = artists.ArtistId;