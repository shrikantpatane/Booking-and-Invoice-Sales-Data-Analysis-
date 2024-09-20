use project_intern;
select * from booking;
select * from invoice;

 SELECT 
b.Ticket_PNR as Ticket_PNR_b,
i.Ticket_PNR as Ticket_PNR_i,
b.Vendor as Vendor_b,
i.Vendor as Vendor_i,
 b.Transaction_Type as  Transaction_Type_b,
  LEFT(b.Location, 3) as Location_b,
  i.Origin as Origin_i
FROM 
    Booking b
INNER JOIN 
    Invoice i 
ON 
    b.Ticket_PNR = i.Ticket_PNR
    AND b.Vendor = i.Vendor
    AND b.Transaction_Type = i.Transaction_Type
    AND LEFT(b.Location, 3) = i.Origin;
  
  
-- Total bookings
  
SELECT COUNT(Ticket_PNR) AS Total_Bookings
FROM Booking;

-- Matched invoices

SELECT
    COUNT(*) AS Matched_Invoices
FROM
    Booking b
INNER JOIN
    Invoice i
ON
    b.Ticket_PNR = i.Ticket_PNR
    AND b.Ticket_Number = i.Ticket_Number;
    
    
--  GST claimed

SELECT
    round(sum(b.Transaction_Amount_INR * b.GST_rate/100),1) AS Total_GST_Claimed
FROM
    Booking b
    where b.GST_rate >0;
    
    
-- exempted amounts

SELECT
    sum(b.Transaction_Amount_INR) AS Total_GST_Claimed
FROM
    Booking b
        where b.GST_rate <=0;
    


--  Relationships between booking and invoice data

-- 1. Missing Records in Invoice
SELECT
    b.Ticket_PNR,
    b.Vendor,
    b.Transaction_Type
FROM
    Booking b
LEFT JOIN
    Invoice i
ON
    b.Ticket_PNR = i.Ticket_Number
    AND b.Vendor = i.Vendor
    AND b.Transaction_Type = i.Transaction_Type
WHERE
    i.Ticket_Number IS NULL;
    
    

-- 2. Missing Records in Booking
    
SELECT
    i.Invoice_Number,
    i.Ticket_Number,
    i.Vendor,
    i.Transaction_Type
FROM
    Invoice i
LEFT JOIN
    Booking b
ON
    i.Ticket_Number = b.Ticket_PNR
    AND i.Vendor = b.Vendor
    AND i.Transaction_Type = b.Transaction_Type
WHERE
    b.Ticket_PNR IS NULL;
    
    
-- 3. Discrepancies in Amounts

SELECT
    b.Ticket_PNR,
    b.Vendor,
    b.Transaction_Type,
    b.Transaction_Amount_INR,
    i.Invoice_Total_Amount
FROM
    Booking b
INNER JOIN
    Invoice i
ON
    b.Ticket_PNR = i.Ticket_Number
    AND b.Vendor = i.Vendor
    AND b.Transaction_Type = i.Transaction_Type
WHERE
    b.Transaction_Amount_INR <> i.Invoice_Total_Amount;


    


    
    





