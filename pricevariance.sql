SELECT
p.VendorName,
p.PurchasePrice AS ActualUnitPrice,
pp.Price AS StandardUnitPrice,
p.PurchasePrice - pp.Price AS PriceVariance
FROM purchases AS p
JOIN purchase_prices AS pp
ON p.Brand = pp.Brand
WHERE p.PurchasePrice > pp.Price;
