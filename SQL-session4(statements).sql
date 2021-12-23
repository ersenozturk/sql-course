/*
SQL STATEMENT
DDL=Data Definition Language> Tablo oluşturma.(Dış taraf)
	CREATE,ALTER,DROP tablo oluştur,değiştir,sil
	
DDL=Data Manipulation Language> Tablolardaki verilerle uğraşır. Tablodaki veriyi güncelleme silme vs (İç aksam)
	INSERT,UPDATE,DELETE  veri girer,günceller,siler,   SELECT*Data Query Language
	
DCL=Data Control Language>Veritabanına izin verme. Yeni kullanıcı tanımlama ya da kaldırma işlemi. Daha çok DB Adminler (Priviliges..Grant/Revoke)

TCL=Transaction Control Language>
	COMMIT,ROLLBACK,SAVEPOINT
*/
/*DATA TYPES*/


/*------------------------------------------------------------------------------------------
	/*  CREATE TABLE
	/*------------------------------------------------------------------------------------------
	
	/*personel adinda bir tablo oluşturunuz.  Tabloda first_name, last_name 
	age(INT) ve hire_date (Date) sutunuları bulunmalıdır.*/


CREATE TABLE table_name
	(column_name1 data_type,
	column_name1 data_type);
	
	CREATE TABLE personel (
		first_name VARCHAR(20),
		last_name TEXT,
		age INT,
		hire_date DATE
	);
	
	
	/* Aynı isimle yeniden bir veritabanı oluşturulmak istenirse hata verir. Bu hatayı
	almamak için IF NOT EXISTS keywordu kullanılabilir */
	CREATE TABLE IF NOT EXISTS personel (
		first_name VARCHAR(20),
		last_name VARCHAR(20),
		age INT,
		hire_date DATE
	);

	/*Veritabanında vacation_plan adında yeni bir tablo oluşturunuz.  Sutun isimleri
	place_id, country, hotel_name, employee_id, vacation_length,budget 	*/
	CREATE table vacation_plan (
		place_id INTEGER,
		country TEXT,
		hotel_name TEXT,
		employee_id INTEGER,
		vacation_lenght INT,
		budget REAL
	);
	
	/*------------------------------------------------------------------------------------------
	/*  DROP TABLE
	/*------------------------------------------------------------------------------------------
	/* personel tablosunu siliniz */
	
	DROP TABLE personel;
	
	/* Bir tabloyu silerken tablo bulunamazsa hata verir. BU hatayı görememek için
	IF EXISTS keywordu kullanılabilir.*/
	DROP TABLE IF EXISTS personel;
		
	-- NOT: SQL'de TRUNCATE TABLE komutu bulunmasına karşın SQLite bu komutu 	!!!!
	-- desteklememektedir. Truncate komutu  bir tabloyu değil içindeki tüm verileri 
	-- silmek için kullanılır.
	
	/*------------------------------------------------------------------------------------------
	/*  INSERT INTO  tabloya veri girme
	/*----------------------------------------------------------------------------------------*/

	/* vacation_plan tablosuna 2 kayıt gerçekletiriniz.*/
	--- INSERT INTO TABLE_NAME VALUES (TABLE INFORMATIONS ); 
	INSERT INTO vacation_plan VALUES(48,'TR','HAPPY HOTEL', 1, 7, 4500);
	INSERT INTO vacation_plan VALUES(34, 'TR', 'Beach Hotel',2, 10, 5000);
	INSERT INTO vacation_plan VALUES(12, 'NL', 'COMFORT Hotel',3, 4, 3000);	
	INSERT INTO vacation_plan VALUES(NULL, NULL, NULL,4, 5, NULL);	
	
	
	-- NOT: Aynı komut tekrar çalıştırılırsa herhangi bir kısıt yoksa ise aynı veriler
	-- tekrar tabloya girilmiş olur. 
	
	/*vacation_plan tablosuna vacation_lenght ve budget sutunlarını eksik olarak veri girişi 
	yapınız*/
	INSERT INTO vacation_plan (place_id,country,hotel_name,employee_id) VALUES(35, 'TR', 'İZMİR HOTEL', 6);
		
	
	/*------------------------------------------------------------------------------------------
	/*  CONSTRAINTS - KISITLAMALAR 
	/*-----------------------------------------------------------------------------------------

	NOT NULL - Bir Sütunun NULL içermemesini garanti eder. 

    UNIQUE - Bir sütundaki tüm değerlerin BENZERSİZ olmasını garanti eder.  

    PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
                  BENZERSİZ olmasını garanti eder.(NOT NULL ve UNIQUE birleşimi gibi)

    FOREIGN KEY - Başka bir tablodaki Primary Key’i referans göstermek için kullanılır. 
                  Böylelikle, tablolar arasında ilişki kurulmuş olur. 

    DEFAULT - Herhangi bir değer atanmadığında Başlangıç değerinin atanmasını sağlar.
	/*----------------------------------------------------------------------------------------*/	
	
	CREATE TABLE workers (
		id INT PRIMARY KEY,
		id_number VARCHAR(11) UNIQUE NOT NULL,
		name TEXT DEFAULT 'NONAME',
		salary INT NOT NULL
	);
	
	INSERT INTO workers VALUES(1, '12345678910','AHMET CAN', 7000 );
	INSERT INTO workers VALUES( 2, '12345678910', 'MUSTAFA ALİ', 12000);  -- HATA (UNIQUE)
	INSERT INTO workers  (id,	id_number, salary) VALUES(3, '12345223465', 5000);
	INSERT INTO workers VALUES(4, '44343323465' , 'AYHAN BAK',NULL); -- HATA (NOT NULL)
	
	/*vacation_plan tablosunu place_id sutunu PK ve employee_id sutununu ise FK olarak  değiştirirek
	vacation_plan2 adinda yeni bir tablo oluşturunuz. Bu tablo, employees tablosu ile ilişkili olmalıdır*/ 
	
	CREATE table vacation_plan2 (
		id INT,
		place_id INTEGER,
		country TEXT,
		hotel_name TEXT,
		employee_id INTEGER,
		vacation_lenght INT,
		budget REAL,
		PRIMARY KEY(id),
		FOREIGN KEY(employee_id) REFERENCES employees(EmployeeId)
	);
	
	/* Employees tablosundaki EmployeeId'si 1 olan kişi için bir tatil planı giriniz.*/
	INSERT INTO vacation_plan2 VALUES(1, 34,'TR',	'HAPPY HOTEL',1,5,5660);
	
	/* Employees tablosunda bulunmayan bir kişi için (EmployeeId=9) olan kişi için bir tatil planı giriniz.*/
	INSERT INTO vacation_plan2 VALUES(2, 48,'TR',	'COMFORT HOTEL',9,10,7000);  --HATA
	INSERT INTO vacation_plan2 VALUES(3, 48,'TR',	'COMFORT HOTEL',8,5,5000); 
	INSERT INTO vacation_plan2 VALUES(4, 42,'TR',	'MEVLANA HOTEL',1,6, 4000);
	
	/*JOIN işlemi ile 2 tablodan veri çekme   koşulsz-koşullu*/
	SELECT e.FirstName,e.LastName,v.hotel_name, v.vacation_lenght
	FROM employees e
	JOIN vacation_plan2 v
	ON e.EmployeeId=v.employee_id;


	SELECT e.FirstName,e.LastName,v.hotel_name, v.vacation_lenght
	FROM employees e
	JOIN vacation_plan2 v
	ON e.EmployeeId=v.employee_id AND v.employee_id=1;
	
	
	/*------------------------------------------------------------------------------------------
	/*  ALTER TABLE (ADD, RENAME TO, DROP)
	/*  SQLITE MODIFY VE DELETE KOMUTLARINI DOĞRUDAN DESTEKLENMEZ
	/*------------------------------------------------------------------------------------------
	
	/*vacation_plan2 tablosuna name adında ve DEFAULT değeri noname olan 
	yeni bir sutun ekleyelim */
	
	ALTER TABLE vacation_plan2
	ADD name TEXT DEFAULT 'isimsiz';
	
	/*vacation_plan2 tablosundaki name sutununu siliniz */
	ALTER TABLE vacation_plan2
	DROP COLUMN name ;	
	
	/* workers tablosunun adını people olarak değiştiriniz */
	ALTER TABLE workers
	RENAME TO people;
	
	
	
	/*------------------------------------------------------------------------------------------
	/*  UPDATE,DELETE
		-- SYNTAX
		----------
		-- UPDATE tablo_adı
		-- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...  
		-- WHERE koşul;
		
		--DELETE tablo_adı
		--WHERE koşul;
   /*-----------------------------------------------------------------------------------------*/
   
   /*vacation_plan2 tablosundaki employee_id=1 olan kaydin  hotel_name'ini Komagene Hotel olarak
   güncelleyiniz.*/
   
   UPDATE vacation_plan2
   SET hotel_name = 'Komagene hotel'
   WHERE employee_id = 1;
   
   /* people tablosunda salary sutunu 5000 'den FAZLA olanların salary(maaşına)
   %10 zam yapacak sorguyu yazınız*/ 
   
   UPDATE people
   SET salary = salary * 1.1
   WHERE salary > 5000 ;