-- Hangi siparişim hangi müşterime, ne zaman, hangi çalışanım tarafından verilmiştir.
SELECT o.OrderID AS Siparis,
       (SELECT CompanyName
	    FROM Customers
		WHERE CustomerID = o.CustomerID) AS Musteri,
		OrderDate AS SiparişTarihi,
	    (SELECT FirstName + ' ' + LastName
	               FROM Employees
				   WHERE EmployeeID = o.EmployeeID
	              ) AS Çalisan
FROM Orders o

-- Son 10 siparişte satılan ürünleri, kategorileri ile birlikte getirin                                 
SELECT od.OrderID,(SELECT p.ProductName FROM Products p WHERE od.ProductID = p.ProductID) AS SatılanÜrün,
			(SELECT c.CategoryName FROM Categories c WHERE c.CategoryID = (SELECT p.CategoryID FROM Products p 
			 WHERE od.ProductID = p.ProductID)) AS Kategori
FROM [Order Details] od
WHERE od.OrderID IN (SELECT TOP 10 o.OrderID FROM Orders o ORDER BY OrderID DESC)

-- İlk 15 siparişimi hangi firmalardan almışım?
SELECT TOP 15 OrderID,(SELECT CompanyName FROM Customers WHERE o.CustomerID = CustomerID) AS Firmaİsmi
FROM Orders o
ORDER BY OrderID

-- Kuzey (Northern) bölgesinden çalışan(lar)ım kim?
SELECT FirstName+' '+LastName AS KuzeydenSorumlu
FROM Employees e
WHERE EmployeeID IN(SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID IN(SELECT TerritoryID FROM Territories WHERE RegionID = (SELECT RegionID FROM Region WHERE RegionDescription = 'Northern')))

-- New York şehrinden sorumlu çalışan(lar)ım kim?
SELECT FirstName+' '+LastName AS NYSorumlusu
FROM Employees e
WHERE EmployeeID IN(SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID IN(SELECT TerritoryID FROM Territories WHERE TerritoryDescription = 'new york'))

-- Amerikada yaşayan çalışanlarımın almış olduğu siparişlerin listesi
SELECT *
FROM Orders o
WHERE o.EmployeeID IN(SELECT EmployeeID FROM Employees WHERE Country = 'USA')

-- İndirim Uygulanan Siparişlerde hangi ürüne ne kadar indirim uygulanmış (ürün adı ve SiparişID'si ile beraber getiriniz)
SELECT (SELECT ProductName FROM Products WHERE od.ProductID = ProductID) AS ÜrünADI,od.OrderID AS SiparişID,UnitPrice*(1-Discount) AS Uygulananİndirim
FROM [Order Details] od
WHERE Discount > 0

-- Üreticilerin çalışabileceği tüm olası gemi şirketleri.               ---YAPAMADIM


-- Federal Shipping ile taşınmış ve Nancy'nin almış olduğu siparişleri gösteriniz (OrderID, FirstName, lAStName, OrderDate, CompanyName)
SELECT o.OrderID,(SELECT FirstName+' '+LastName FROM Employees WHERE o.EmployeeID = EmployeeID) AS FullName,o.OrderDate,(SELECT CompanyName FROM Customers WHERE o.CustomerID = CustomerID) AS CompanyName
FROM Orders o
WHERE o.ShipVia = (SELECT ShipperID FROM Shippers s WHERE s.CompanyName = 'Federal Shipping') AND o.EmployeeID = (SELECT EmployeeID FROM Employees e WHERE e.FirstName = 'Nancy')


-- EmployeeId si 1 olan çalışanımın satmış olduğu ürünleri getiren sorguyu yazınız.
SELECT ProductName
FROM Products p
WHERE p.ProductID IN(SELECT ProductID FROM [Order Details] od WHERE od.OrderID IN (SELECT OrderID FROM Orders WHERE EmployeeID = 1))

-- Siparişler tablosunda 4 ten az kaydı olan firmalar
SELECT *
FROM Customers c
WHERE c.CustomerID IN(SELECT CustomerID FROM Orders GROUP BY CustomerID HAVING COUNT(CustomerID)<4)

-- Müşterilerin ilk gerçekleştirdiği sipariş tarihleri
SELECT CustomerID,MIN(OrderDate) AS İlkSiparisTarihi
FROM Orders o
GROUP BY CustomerID

-- Kargo ücreti, en pahalı üründen yüksek olan siparişler. Freight | OrderID | MostExpensiveProduct
SELECT o.Freight,o.OrderID,(SELECT MAX(UnitPrice) FROM [Order Details] od WHERE od.OrderID = o.OrderID) AS MostExpensiveProductPrice
FROM Orders o
WHERE o.OrderID IN(SELECT od.OrderID FROM [Order Details] od GROUP BY od.OrderID HAVING Freight > MAX(UnitPrice))

-- 50den fazla satış yapan elemanlar
SELECT e.FirstName+' '+e.LastName AS AdSoyad
FROM Employees e
WHERE e.EmployeeID IN(SELECT EmployeeID FROM Orders GROUP BY EmployeeID HAVING COUNT(*)>50)

-- Hangi ülkede hangi sipariş, en geç teslim edilmiştir?
SELECT ShipCountry,MAX(DATEDIFF(DAY,o.RequiredDate,o.ShippedDate))
FROM Orders o
GROUP BY ShipCountry
