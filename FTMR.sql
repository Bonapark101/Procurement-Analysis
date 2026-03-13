---aggregated PONumber and checked 
---if the total quantity per PONumber matches 
---between purchases and vendori_invoice tables
WITH invoice_totals AS (
    SELECT VendorNumber, PONumber, SUM(Quantity) AS InvoiceQty
    FROM vendor_invoice
    GROUP BY VendorNumber, PONumber
),
po_totals AS (
    SELECT VendorNumber, PONumber, SUM(Quantity) AS POTotalQty
    FROM purchases
    GROUP BY VendorNumber, PONumber
)
SELECT
    COUNT(*) AS TotalPOs,
    COUNT(*) FILTER (WHERE InvoiceQty = POTotalQty) AS MatchingInvoices,
    ROUND(
        (COUNT(*) FILTER (WHERE InvoiceQty = POTotalQty)::NUMERIC / COUNT(*)) * 100, 2
    ) AS FTMR_Percent
FROM invoice_totals i
JOIN po_totals p
ON i.VendorNumber = p.VendorNumber
AND i.PONumber = p.PONumber;