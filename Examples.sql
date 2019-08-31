-- Hangi tedarikçiden hangi ürünü kaç adet  temin etmişim? Tedarikci | UrunAdedi
SELECT s.CompanyName AS Tedarikçi,ProductName AS ÜrünAdı,SUM(p.UnitsInStock + p.UnitsOnOrder + od.Quantity) AS [Toplam Ürün Adedi]
FROM Products p
	JOIN Suppliers s
		ON p.SupplierID = s.SupplierID
	JOIN [Order Details] od
		ON p.ProductID = od.ProductID
GROUP BY s.CompanyName,p.ProductName 

-- Nancy adındaki personelim hangi firmaya toplam kaç adet ürün satmıştır? FirmaAdi | UrunAdet
SELECT c.CompanyName AS FirmaAdi,SUM(od.Quantity)AS UrunAdet
FROM Employees e
	JOIN Orders o
		ON e.EmployeeID = o.EmployeeID
	JOIN [Order Details] od
		ON o.OrderID = od.OrderID
	JOIN Customers c
		ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName

-- Batı bölgesinden sorumlu çalışanlara ait müşteri sayısı bilgisini getirin. Calisan | MusteriSayisi
SELECT e.FirstName+' '+e.LastName AS İsimSoyisim,COUNT(DISTINCT o.CustomerID) AS MüşteriSayisi
FROM Employees e
	JOIN EmployeeTerritories et
		ON et.EmployeeID = e.EmployeeID
	JOIN Territories t
		ON t.TerritoryID = et.TerritoryID
	JOIN Orders o 
		ON o.EmployeeID = et.EmployeeID
		
WHERE t.RegionID = 2
GROUP BY e.FirstName+' '+e.LastName

-- Kategori adı Confections olan ürünleri hangi ülkelere fiyat olarak toplam ne kadar gönderdik ? Ulke | ToplamFiyat
SELECT ShipCountry AS ÜLKE,SUM(p.UnitPrice) AS ToplamFiyat
FROM Products p
	JOIN Categories c
		ON p.CategoryID = c.CategoryID
	JOIN [Order Details] od
		ON p.ProductID = od.ProductID
	JOIN Orders o
		ON o.OrderID = od.OrderID
WHERE CategoryName = 'confections'
GROUP BY  o.ShipCountry

-- Her bir ürün için ortalama talep sayısı(ortalama sipariş adeti) bilgisini ürün adıyla beraber listeleyin. UrunAdi | OrtalamaTalepSayısı
SELECT P.ProductName AS UrunAD,AVG(od.Quantity) AS OrtalamaTalepSayısı
FROM Products p
	JOIN [Order Details] od
		ON p.ProductID = od.ProductID
GROUP BY p.ProductName

-- 250'den fazla sipariş taşımış olan kargo firmalarının adlarını, telefon numaralarını ve taşıdıkları sipariş sayılarını getiren sorguyu yazın. FirmaAdi | Telefon | SiparisSayisi
SELECT s.CompanyName,s.Phone,COUNT(*) AS TaşınanKargo
FROM Orders o
	JOIN Shippers s
		ON s.ShipperID = o.ShipVia
GROUP BY s.CompanyName,s.Phone
HAVING COUNT(*) > 250

-- Müşterilerimin toplam sipariş adetlerini Müşteri adı ile birlikte raporlayın	CustomerName | TotalOrdersCount
SELECT c.CompanyName,COUNT(*) AS TotalOrdersCount
FROM Orders o
	RIGHT JOIN Customers c
		ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName

-- Kargo şirketlerine göre taşınan sipariş sayıları nedir? ShipperName | TotalOrdersCount
SELECT s.CompanyName,COUNT(*) AS TaşınanKargo
FROM Orders o
	JOIN Shippers s
		ON s.ShipperID = o.ShipVia
GROUP BY s.CompanyName

-- Ürün Id ve isimlerini, bugünkü fiyatı ile birlikte bugüne kadar yer aldığı siparişlerdeki en ucuz fiyat ve bu fiyat ile arasındaki farkı da hesaplayarak listeleyin. ProductID | ProductName | UnitPrice | LowestPrice | Difference
SELECT DISTINCT p.ProductID,p.ProductName,p.UnitPrice,MIN(od.UnitPrice) AS LowestPrice ,p.UnitPrice-MIN(od.UnitPrice) AS Difference
FROM Products p
	JOIN [Order Details] od
		ON p.ProductID = od.ProductID
GROUP BY p.ProductID,p.ProductName,p.UnitPrice

-- Sevilla şehri hariç ıspanyaya gönderilen kargoların toplam adedi, toplam tutarı ve ortalama tutarını şehirlere göre raporlayın. City | TotalCount | TotalPrice | Average
SELECT o.ShipCity AS City,SUM(od.UnitPrice*od.Quantity*(1-Discount)) TotalPrice,AVG(od.UnitPrice*od.Quantity*(1-Discount)) AS Average
FROM Orders o
	JOIN [Order Details] od
		ON od.OrderID = o.OrderID
WHERE o.ShipCity NOT LIKE 'Sevilla' AND o.ShipCountry LIKE 'Spain'
GROUP BY o.ShipCity

-- Her yıl hangi ülkeye kaç adet sipariş göndermişim? Year | Country | TotalOrdersCount
SELECT YEAR(o.OrderDate) AS Yil,
	   o.ShipCountry AS Country,
	   COUNT(o.OrderID) AS SiparisAdedi
FROM [Order Details] od
	JOIN Orders o
		ON od.OrderID = o.OrderID
GROUP BY YEAR(o.OrderDate),o.ShipCountry

-- En değerli müşterim kim? (Bana en çok para kazandıran)
SELECT TOP 1 c.CompanyName AS Musterim,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Ciro
FROM [Order Details] od
	JOIN Orders o
		ON od.OrderID = o.OrderID
	JOIN Customers c
		ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
ORDER BY Ciro DESC

-- şehir bazında sipariş adetlerim nelerdir? City | Count
SELECT o.ShipCity AS City,COUNT(*) AS SiparişAdet
FROM Orders O
GROUP BY o.ShipCity