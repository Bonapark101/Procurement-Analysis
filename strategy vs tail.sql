WITH vendor_summary AS (
    SELECT
        vi.VendorNumber,
        vi.VendorName,
        SUM(vi.Dollars) AS TotalSpend,
        COUNT(*) AS NumInvoices,
        AVG(GREATEST(p.ReceivingDate - p.PODate, 0)) AS AvgLeadTimeDays
    FROM vendor_invoice vi
    LEFT JOIN purchases p
        ON vi.VendorNumber = p.VendorNumber
        AND vi.PONumber = p.PONumber
    GROUP BY vi.VendorNumber, vi.VendorName
)
SELECT
    CASE
        WHEN TotalSpend > 50000 AND NumInvoices > 10 THEN 'Strategic Vendor'
        ELSE 'Tail Vendor'
    END AS VendorCategory,
    COUNT(*) AS NumVendors
FROM vendor_summary
GROUP BY VendorCategory;