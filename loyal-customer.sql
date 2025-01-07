SELECT 
    c.customer_id,
    c.name,
    COUNT(b.booking_id) AS total_bookings,
    MAX(b.booking_date) AS last_booking_date
FROM 
    customers c
JOIN 
    bookings b ON c.customer_id = b.customer_id
WHERE 
    b.booking_date >= NOW() - INTERVAL 6 MONTH -- Look at the last 6 months
GROUP BY 
    c.customer_id, c.name
HAVING 
    total_bookings >= 3; -- Define "regular" as at least 3 bookings
