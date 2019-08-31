-- CategoryID'si 2 olan kategorileri getirin.
SELECT*FROM Categories
WHERE CategoryID = 2

-- Londrada ikamet eden çalýþanlarýn ad ve soyadlarý nedir.
SELECT FirstName+' '+LastName AS ÝkametLondra FROM Employees
WHERE City = 'london'

-- Birim fiyatý 50 ile 80 arasý olan ürünler nelerdir.
SELECT * FROM Products
WHERE UnitPrice BETWEEN 50 AND 80

-- Ülkesi A harfi ile bitmeyen müþterileri listeleyin.
SELECT * FROM Customers
WHERE Country NOT LIKE '%a'

-- 04.07.1996 ile 31.12.1996 tarihleri arasýnda verilen sipariþler hangileridir.
SELECT * FROM Orders
WHERE OrderDate BETWEEN '1996-07-04' AND '1996-12-31'

-- Ürün adlarýný ve fiyatlarýný, her birine %18 olarak uygulanmak üzere KDV bilgisiyle beraber listeleyin. KDV bilgisi ayrý bir sütun olarak gelmeli.
SELECT ProductName,UnitPrice,CAST(UnitPrice*0.18 as DECIMAL(5,2)) AS KdvTutarý
FROM Products

-- Dairy Products kategorisine ait ürünleri listeleyin.
SELECT * FROM Categories WHERE CategoryName = 'Dairy Products'

-- Üçüncü harfi N olan çalýþanlarýn ad ve soyadlarýný listeleyin.
SELECT FirstName + ' ' + LastName AS AdSoyad
FROM Employees WHERE FirstName LIKE '__N%'

-- Çalýþanlarýn açýk adreslerini ve telefonlarýný raporlayýn.
SELECT FirstName,LastName,Address,HomePhone FROM Employees

-- Her bir kategorinin açýklamasýnýn ne olduðunu raporlayýn.
SELECT CategoryName,Description FROM Categories

-- Sipariþlerimin sipariþ tarihlerini ve nereye gönderileceklerini raporlayýn.
SELECT OrderID,OrderDate,ShipCountry,ShipCity FROM Orders

-- Ürünlerin adýný, kategori IDsini, birim fiyatýný ve stok miktarýný raporlayýn.
SELECT ProductName,CategoryID,UnitPrice,UnitsInStock FROM Products

-- Her bir tedarikçinin þirket adý ve açýk adreslerini raporlayýn.
SELECT CompanyName,Address FROM Suppliers

-- Her bir müþterinin þirket adý ve açýk adreslerini arasýnda '/' olacak þekilde tek bir kolonda ve yetkili kiþiyle birlikte raporlayýn.
SELECT CompanyName+'/ '+Address+'/ '+ContactName AS Þirket FROM Customers

-- Çalýþanlarýn adýný ve soyadýný baþýnda unvanlarý ile birlikte tek bir kolonda listeleyin ve kolonun adýnýn 'Kiþi Bilgisi' olmasýný saðlayýn.
SELECT Title+'  '+FirstName+' '+LastName AS [Kiþi Bilgisi] FROM Employees

-- Birebir firma sahibi ile temas kurulan tedarikçileri listeleyin
SELECT * FROM Suppliers WHERE ContactTitle = 'owner'

-- Hangi çalýþanlarým Almanca biliyor
SELECT * FROM Employees WHERE Notes LIKE '%GERMAN%'

-- Stokta 40 tan fazla olan ürünlerimin adlarý ve kategori Idleri
SELECT ProductName,CategoryID,UnitsInStock FROM Products WHERE UnitsInStock > 40

-- Ýsmi 'chai' olanlarýn ya da kategorisi 3 olan ve 29 dan fazla stoðu olan ürünleri listeleyin
SELECT ProductName,CategoryID,UnitsInStock
FROM Products
WHERE ProductName = 'chai' OR CategoryID = 3 AND UnitsInStock > 29

-- Stoðu 42 ile 100 arasýnda olan ürünleri listeleyin
SELECT * FROM Products WHERE UnitsInStock BETWEEN 42 AND 100

-- Doðum tarihleri 1961-01-01 ve 2010-10-10 tarihleri arasýnda ve kadýn çalýþanlarýmý listeleyin
SELECT * FROM Employees WHERE BirthDate BETWEEN '1961-01-01' AND '2010-10-10' AND TitleOfCourtesy IN('MS.','MRS.')

-- Yaþadýðý þehir London ve Seattle olmayan çalýþanlarýmýz kimlerdir?
SELECT * FROM Employees WHERE City NOT IN('LONDON','SEATTLE')

-- Adýnda ve soyadýnda 'e' harfi geçmeyen çalýþanlarýmýz kimlerdir?
SELECT * FROM Employees WHERE FirstName NOT LIKE '%E%' AND LastName NOT LIKE '%E%' 

-- Stok miktarý kritik seviyeye veya altýna düþmesine raðmen hala sipariþini vermediðim ürünler hangileridir?
SELECT * FROM Products WHERE UnitsInStock < ReorderLevel AND UnitsOnOrder = 0

-- Þiþede sattýðým ürünler nelerdir?
SELECT * FROM Products WHERE QuantityPerUnit LIKE '%BOTTLE%'

-- Londra'da yasayan personellerimin adini soyadini gosteriniz...
SELECT FirstName+' '+LastName AS LivingLondon FROM Employees WHERE City = 'LONDON'

-- CategoryID'si 5 olmayan urunleri listeleyiniz..
SELECT * FROM Products WHERE CategoryID NOT LIKE 5

-- 01.01.1993'ten sonra ise giren personelleri listeleyiniz...
SELECT * FROM Employees WHERE HireDate > '1993-01-01'

-- Fiyatý küsüratlý ürünleri bulun.
SELECT * FROM Products WHERE UnitPrice NOT LIKE '%00'

-- Elimde bulunan aktif ürünlerin hepsini sattýðýmda, her birinden ne kadar kazanacaðýmý raporlayýn. Ürün adý ve kazancý þeklinde iki kolon ile gösterin.
SELECT ProductName,UnitPrice*UnitsInStock AS [TOPLAM KAZANÇ] FROM Products

-- Stoðu olmasýna raðmen artýk satýþýný yapmadýðým ürünler hangisidir?
SELECT * FROM Products WHERE UnitsInStock > 0 AND Discontinued = 1

-- Bolge bilgisi olmayan müþterilerin listesini raporlayiniz...
SELECT * FROM Customers WHERE Region IS NULL

-- Bölge bilgisi olan personellerimi gosteriniz...
SELECT * FROM Employees WHERE Region IS NOT NULL

-- CategoryID'si 5 olan, urun bedeli 20'den buyuk 300'den kucuk olan, stok durumu null olmayan urunlerimin adlarini ve id'lerini gosteriniz...
SELECT * FROM Products 
WHERE CategoryID = 5 AND UnitPrice BETWEEN 20 AND 300 AND UnitsInStock NOT LIKE 0

-- 'Dumon' ya da 'Alfki' idlerine sahip olan musterilerden alinmis, 1 nolu personelin onayladigi, 3 nolu kargo firmasi tarafindan gonderilmis ve ShipRegion'u null olan siparisleri gosteriniz...
SELECT * FROM Orders WHERE CustomerID IN('DUMON','ALFKÝ') AND EmployeeID = 1 AND ShipVia = 3 AND ShipRegion IS NULL

-- Teslimatý Amerika'ya geç kalan sipariþler hangileridir?
SELECT * FROM Orders WHERE ShippedDate > RequiredDate AND ShipCountry = 'USA'

-- Patron dýþýnda hangi çalýþanlar Fransýzca biliyor?
SELECT * FROM Employees WHERE EmployeeID NOT LIKE 2 AND Notes LIKE '%FRENCH%'

-- Henüz teslimatý gerçekleþmemiþ sipariþler hangileridir?
SELECT * FROM Orders WHERE ShippedDate IS NULL

-- 1 dolarýn altýnda kargo ücreti olan sipariþler hangileridir?
SELECT * FROM Orders WHERE Freight < 1

-- Son gününde teslim edilen sipariþler hangileridir?
SELECT * FROM Orders WHERE RequiredDate = ShippedDate

-- 01.11.1997 - 06.06.1998 tarihleri arasindaki siparisleri gosteriniz...
SELECT * FROM Orders WHERE OrderDate BETWEEN '1997-11-01' AND '1998-06-06'

-- Stoðumda hiç bulunmayýp tedarikçilerime sipariþ verdiðim ürünler hangileridir?
SELECT * FROM Products WHERE UnitsInStock = 0 AND UnitsOnOrder > 0

-- Yüksek lisans yapan çalýþanlarým hangileridir?
SELECT * FROM Employees WHERE Notes LIKE '%MA%' AND Notes LIKE '%MBA%' -- BUNDA SIKINTI VAR

------------------------------------------------------------------------------------------------

-- Tüm çalýþanlarýmýn ad ve soyadýný tek kolonda getirin ancak soyadýn tamamý büyük harf ile olsun
SELECT FirstName+' '+UPPER(LastName) AS AdSoyad FROM Employees

-- Müþterilerimin þirket isimlerinin ilk 3 harfini getirin.
SELECT LEFT(CompanyName,3) AS Sirket3Harf FROM Customers

-- Sistemde kayýtlý her ürün için bir barkod numarasý oluþturulacaktýr. Barkod numarasý ID'sinin 3 kere tekrarlanýp ardýna da isminin ilk 3 harfinin eklendiði þekildedir. Örneðin Chai ürünü için 111Cha þeklindedir. Ürünleri ve her biri için oluþan barkod numarasýný listeleyin.
SELECT REPLICATE(ProductID,3)+LEFT(ProductName,3) AS BarcodeNumber,* FROM Products

-- Tüm ürünlerin fiyatlarýný virgülden sonra 2 basamak gelecek þekilde getirin.
SELECT ROUND(UnitPrice,2) FROM Products 

-- Sipariþlerin gönderildiði ülkelerin ilk iki harfini küçük, gerisini büyük harf olacak þekilde listeleyin.
SELECT  LOWER(LEFT(ShipCountry,2))+UPPER(SUBSTRING(ShipCountry,3,10)) FROM Orders 

-- Tüm sipariþ kalemlerinin tutarýný hesaplayýn, hesapladýðýnýz deðerler tamsayý olarak görünsün
SELECT ROUND((UnitPrice-(UnitPrice*Discount))*Quantity,0) AS [Kalem Tutarý] FROM [Order Details]

-- Her yýl ve her ay için ayýn 15'inden önce sevk edilmiþ sipariþleri listeleyin.
SELECT * FROM Orders WHERE DATEPART(DAY,ShippedDate) < 15

-- Birim fiyatý 20 ile 75 arasýnda olan ve gelecek sipariþi olan ürünlerimin, yeni gelen ürünler geldiði zaman oluþacak stok miktarýný ve güncel stok miktarýný aþaðýdaki gibi bir kolonda yazdýrýn. 
--Kolon adý Stok Bilgisi olsun ve ürün adý ile birlikte listelensin. 'Mevcut Stok : 20, Gelecek Olan Sipariþ : 30, Toplam Stok : 50'
SELECT ProductName,UnitsInStock AS [Mevcut Stok],UnitsOnOrder AS [Gelecek Olan Sipariþ],UnitsInStock+UnitsOnOrder AS [Toplam Stok]
FROM Products WHERE UnitPrice BETWEEN 20 AND 75 AND UnitsOnOrder > 0

-- Ürünlerime Birim Fiyatý 20 den az ise ayný fiyat, 20 ve 50 arasýndaysa %10 indirim, 50 ve 100 arasýndaysa %20 indirim, 100 den fazlaysa %25 indirim yapýn. Birim fiyata göre sýralayýn
SELECT ProductName,UnitPrice,
[Ýndirimli Fiyat] = CASE
		 WHEN UnitPrice < 20 THEN UnitPrice
		 WHEN 20<UnitPrice AND UnitPrice<50  THEN UnitPrice-(UnitPrice*0.10)
		 WHEN 50<UnitPrice AND UnitPrice<100  THEN UnitPrice-(UnitPrice*0.20)
		 ELSE UnitPrice-(UnitPrice*0.25)
		END
FROM Products 
ORDER BY [Ýndirimli Fiyat]

-- Çalýþanlarýmýn bu yýlki doðum günleri hangi güne denk gelmektedir?
SELECT FirstName+' '+LastName AS [Ýsim Soyisim],
DATENAME(WEEKDAY,DATEADD(YEAR,DATEDIFF(YEAR,BirthDate,GETDATE()),BirthDate)) AS DoðumGünü 
FROM Employees 

-------------------------------------------------------------------------------------------------

-- Employees tablosuna kendi bilgilerinizle bir kayýt ekleyin.
INSERT INTO Employees(LastName,FirstName,Title,TitleOfCourtesy,Address,City,Country)
VALUES('Karacif','Hüseyin','Patronun Patronu','Prof.Doç.Dr.','1392/1 Gazi Mah','Miami','ÇORUM')

-- Eklediðiniz kayýttaki ünvan bilgisini developer olarak güncelleyin
UPDATE Employees
	SET TitleOfCourtesy = 'Developer'
WHERE EmployeeID = 10

-- Kahve isminde bir kategori oluþturun ve açýklamasýna 'Sýcak içiniz' bilgisini ekleyin.
INSERT INTO Categories(CategoryName,Description)
VALUES('Kahve','Sýcah Sýcah Ýçiniz Gana Gana Ýçin')

-- Espresso isimli ürünü kahve kategorisine ekleyin. Fiyatý 10, stok miktarý ise 50 olarak güncelleyin.
INSERT INTO Products(ProductName,CategoryID,Discontinued)
VALUES ('Espresso',9,0)

UPDATE Products
	SET UnitPrice = 10,
		UnitsInStock = 50
WHERE ProductName = 'espresso'


-- BLGDM kodu ile Bilge Adam isimli müþteriyi ekleyin.
INSERT INTO Customers(CustomerID,CompanyName)
VALUES('BLGDM','Bilge Adam')

-- Bilge Adam müþterisi 30 adet espresso sipariþi versin ve bu sipariþler Speedy Express firmasý ile gönderilsin. Kargo ücreti 80 dolardýr ancak Bilge Adam anlaþmalý olduðundan %15 indirimi vardýr. Bu sipariþle developer ünvanýna sahip çalýþaným ilgileniyor. Sipariþ verildikten sonra 5 gün içerisinde kargolanmalý.
INSERT INTO Orders(CustomerID,EmployeeID,OrderDate,RequiredDate,ShipVia,Freight)
VALUES ('BLGDM',10,GETDATE(),DATEADD(DAY,5,GETDATE()),1,80-(80*0.15))

INSERT INTO [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
VALUES('11078','78','10','30',0)

-- Bir önceki maddede belirtilen sipariþ 2 gün sonra teslim ediliyor. Gerekli güncellemeyi sisteme yansýtýn.
UPDATE Orders
	SET ShippedDate = DATEADD(DAY,2,GETDATE())
WHERE OrderID = 11078

-- Yukarýdaki tüm maddelerde yapýlan iþlemleri geri alacak sorguyu yazýn.
DELETE FROM Employees WHERE EmployeeID = 10
GO
DELETE FROM Categories WHERE CategoryID = 9
GO
DELETE FROM Products WHERE ProductID = 78
GO
DELETE FROM Customers WHERE CustomerID = 'BLGDM'
GO
DELETE FROM Orders WHERE OrderID = 11078
GO
DELETE FROM [Order Details] WHERE OrderID = 11078
GO
-----------------------------------------------------------------------------------------------
-- Beverages kategorisine ait ürünleri listeleyin
SELECT * FROM Products p
	JOIN Categories c
		ON c.CategoryID = p.CategoryID
WHERE c.CategoryName = 'Beverages'

-- Ýndirimli gönderdiðim sipariþlerdeki ürün adlarýný, birim fiyatýný ve indirim tutarýný gösterin
SELECT p.ProductName,P.UnitPrice,CONVERT(decimal(6,2),od.UnitPrice*Discount) AS [Ýndirim Tutarý] FROM [Order Details] od
	JOIN Products p 
		ON od.ProductID = p.ProductID
WHERE od.Discount > 0

-- Federal Shipping ile taþýnmýþ ve Nancy'nin almýþ olduðu sipariþleri gösterin
SELECT * FROM Orders WHERE ShipVia = 3 AND EmployeeID = 1

-- Doðu konumundaki bölgeleri listeleyin
SELECT TerritoryDescription,r.RegionDescription FROM Territories t
 JOIN Region r
	ON r.RegionID = t.RegionID
 WHERE r.RegionID = 3 

-- Þehri Londra olan tedarikçilerimden temin ettiðim ve stoðumda yeterli sayýda bulunan, birim fiyatý 30 ile 60 arasýnda olan ürünlerim nelerdir
SELECT * FROM Products p
	JOIN Suppliers s
		ON S.SupplierID = p.SupplierID
WHERE S.City = 'london' AND p.UnitsInStock > p.ReorderLevel AND p.UnitPrice BETWEEN 30 AND 60

-- Chai ürünümü hangi müþterilerime satmýþým?
SELECT c.* FROM Orders o
	JOIN Customers c
		ON o.CustomerID = c.CustomerID
	JOIN [Order Details] od
		ON od.OrderID = o.OrderID
	JOIN Products p
		ON p.ProductID = od.ProductID
WHERE p.ProductName = 'chai'

-- Aðustos ayýnda teslim ettiðim sipariþlerimdeki ürünlerden, kategorisi içecek olanlarýn, isimlerini, teslim tarihlerini ve hangi þehre teslim edildiðini, kargo ücretine göre ters sýralý þekilde listeleyin.
SELECT P.ProductName,o.ShippedDate,o.ShipCity,Freight FROM Orders o
	JOIN [Order Details] od
		ON od.OrderID = o.OrderID
	JOIN Products p
		ON p.ProductID = od.ProductID
WHERE DATEPART(MONTH,ShippedDate) = 08 AND p.CategoryID = 1 
ORDER BY Freight DESC

-- Þirket þahibi ile iletiþime geçtiðim Meksikalý müþterilerimin verdiði sipariþlerden kargo ücreti 30 dolarýn altýnda olanlarla hangi çalýþanlarým ilgilenmþtir?
SELECT o.*,e.FirstName+' '+LastName AS [Ýlgili Çalýþan] FROM Customers c
	JOIN Orders o
		ON c.CustomerID = o.CustomerID
	JOIN Employees e
		ON o.EmployeeID = e.EmployeeID
WHERE c.ContactTitle = 'owner' AND c.Country = 'mexico' AND o.Freight < 30

-- Seafood ürünlerimden sipariþ gönderdiðim müþterilerimi listeleyin.
SELECT DISTINCT c.* FROM Orders o 
	JOIN Customers c
		ON c.CustomerID = o.CustomerID
	JOIN [Order Details] od
		ON od.OrderID = o.OrderID
	JOIN Products p
		ON p.ProductID = od.ProductID
WHERE p.CategoryID = 8

-- Hangi sipariþim hangi müþterime, ne zaman, hangi çalýþaným tarafýndan gerçekleþtirilmiþ?
SELECT p.ProductName AS [Sipariþ Edilen Ürün],cus.CompanyName AS Müþteri,
o.OrderDate AS [Sipariþ Tarihi],e.FirstName+' '+e.LastName AS [Ýlgili Çalýþan]
FROM Products p
	JOIN [Order Details] c
		ON c.ProductID = p.ProductID
	JOIN Orders o
		ON c.OrderID = o.OrderID
	JOIN Customers cus
		ON  cus.CustomerID = o.CustomerID
	JOIN Employees e
		ON e.EmployeeID = o.EmployeeID

-- Bölge bilgisi Northern olan çalýþanlarýmýn onayladýðý sipariþlerimdeki kritik stok seviyesinde olan ürünleri listeleyin. Ürün adi ve çalýþan adý listelensin ve tekrar eden kayýtlar olmasýn
SELECT DISTINCT P.ProductName AS ÜrünAd, e.FirstName+' '+e.LastName AS [Çalýþan AdSoyad] 
FROM Employees e
 JOIN EmployeeTerritories et
	ON et.EmployeeID = e.EmployeeID
 JOIN Orders o
	ON o.EmployeeID = e.EmployeeID
 JOIN [Order Details] od
	ON o.OrderID = od.OrderID
 JOIN Products p
	ON p.ProductID = od.ProductID
 JOIN Territories te
	ON te.TerritoryID = et.TerritoryID
 JOIN Region re
	ON re.RegionID = te.RegionID

WHERE re.RegionDescription='Northern' AND p.UnitsInStock<p.ReorderLevel

--HADÝ SELAMETLE :)