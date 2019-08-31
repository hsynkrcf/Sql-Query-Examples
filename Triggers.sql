-- 10 siparişten sonra müşteriye aldığı ürünlerde %10 indirim uygulasın.
GO

CREATE TRIGGER trg_IndirimUygula
ON Orders
AFTER INSERT
AS
BEGIN
	DECLARE @musteriIDSayisi int
	DECLARE @musteriID int
	DECLARE @siparisID int

	SELECT @musteriID=CustomerID,
		   @siparisID=OrderID,
		   @productID=ProductID
	 from inserted

	SELECT @musteriIDSayisi=COUNT(*) from Orders	
	WHERE CustomerID = @musteriID
GROUP BY CustomerID

	IF @musteriIDSayisi>10
	BEGIN

		INSERT INTO Orders(OrderID,CustomerID,OrderDate)
		VALUES(@siparisID,@musteriID,GETDATE())


		INSERT INTO [Order Details](OrderID,Discount)
		VALUES(@siparisID,'0,10')

	END
	ELSE
	BEGIN
		INSERT INTO Orders(OrderID,CustomerID,OrderDate)
		VALUES(@siparisID,@musteriID,GETDATE())
	END
END

GO
-- Sipariş verilirken, siparişte yer alan ürünlerden herhangi biri kritik seviyenin altına düşüyorsa siparişi kaydetmeyip uyarı versin.

CREATE TRIGGER trg_KritikSeviyeUyarı
ON Orders
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @KritikSeviye int
	DECLARE @Urun NVARCHAR(50)

	SELECT  @KritikSeviye=(SELECT ReorderLevel FROM Products)

	

END



-- Verilen siparişteki bir ürünün adet bilgisi yanlış girilmiş ve düzeltilmek istendiğinde o ürünün stok bilgisini de düzeltsin.
GO

CREATE TRIGGER trg_StokDuzeltme
ON [Order Details]
AFTER INSERT
AS
BEGIN
	DECLARE @UrunAdet int
	DECLARE @UrunStok int
	DECLARE @UrunAdi nvarchar(50)
	DECLARE @SiparisID int

	SELECT @SiparisID=OrderID FROM inserted
	SELECT

END


-- Bir kategoriye 15 ten fazla ürün eklenemesin.
CREATE TRIGGER trg_UrunEklemeKısıt
ON Products
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @kategoriID int
	DECLARE @UrunAdi nvarchar(max)
	DECLARE @kategoriAdet int
	DECLARE @discontinued AS BIT

	
	SELECT @kategoriID=CategoryID,
		   @UrunAdi=ProductName
	From inserted

	SELECT @kategoriAdet=COUNT(*) from Products	
	WHERE CategoryID = @kategoriID
GROUP BY CategoryID

	IF @kategoriAdet>=15
	BEGIN
	PRINT '15 adet üründen fazla ürün girilemez'
	END
	ELSE
	BEGIN
		INSERT INTO Products(ProductName,CategoryID,Discontinued)
		VALUES(@UrunAdi,@kategoriID,@discontinued)
	END
END