SELECT
    p.VendorName,
    SUM(ABS(pp.Price - p.PurchasePrice)) AS TotalSavings,   -- always positive
    COUNT(*) AS NumPurchases,
    ROUND(
        (COUNT(CASE WHEN (p.PurchasePrice - pp.Price) < 0 THEN 1 END)::NUMERIC / COUNT(*)) * 100,
        2
    ) AS PercentValid
FROM purchases AS p
JOIN purchase_prices AS pp
    ON p.Brand = pp.Brand
WHERE p.PurchasePrice < pp.Price
GROUP BY p.VendorName
ORDER BY TotalSavings DESC;