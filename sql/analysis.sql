-- SQL Business Analysis (Chinook)

-- 1 Revenue by month
SELECT
  strftime('%Y-%m', InvoiceDate) AS month,
  ROUND(SUM(Total), 2) AS revenue
FROM Invoice
GROUP BY 1
ORDER BY 1;

-- 2 Top customers by lifetime spend
SELECT
  c.CustomerId,
  c.FirstName || ' ' || c.LastName AS customer_name,
  c.Country,
  ROUND(SUM(i.Total), 2) AS lifetime_spend
FROM Customer c
JOIN Invoice i ON i.CustomerId = c.CustomerId
GROUP BY 1,2,3
ORDER BY lifetime_spend DESC
LIMIT 10;

-- 3 Revenue by country
SELECT
  BillingCountry,
  ROUND(SUM(Total), 2) AS revenue
FROM Invoice
GROUP BY 1
ORDER BY revenue DESC;

-- 4 Top tracks by revenue
SELECT
  t.Name,
  ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS revenue
FROM InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId
GROUP BY 1
ORDER BY revenue DESC
LIMIT 10;

-- 5 Average order value + total revenue
SELECT
  COUNT(*) AS total_orders,
  ROUND(AVG(Total),2) AS avg_order_value,
  ROUND(SUM(Total),2) AS total_revenue
FROM Invoice;
