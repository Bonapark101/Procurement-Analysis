SELECT
    VendorNumber,
    VendorName,
    SUM(Dollars) AS TotalSpend,
    COUNT(DISTINCT PONumber) AS NumPOs,
    COUNT(*) AS NumInvoices
FROM vendor_invoice
GROUP BY VendorNumber, VendorName
ORDER BY TotalSpend DESC;