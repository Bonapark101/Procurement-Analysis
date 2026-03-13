---To inspect prcie variances
--ALTER TABLE vendor_invoice
--ADD COLUMN ActualUnitPrice NUMERIC;

--UPDATE vendor_invoice
--SET ActualUnitPrice = Dollars / Quantity;

SELECT
p.VendorName,
p.PurchasePrice AS ActualUnitPrice,
pp.Price AS StandardUnitPrice,
p.PurchasePrice - pp.Price AS PriceVariance
FROM purchases AS p
JOIN purchase_prices AS pp
ON p.Brand = pp.Brand
WHERE p.PurchasePrice > pp.Price;