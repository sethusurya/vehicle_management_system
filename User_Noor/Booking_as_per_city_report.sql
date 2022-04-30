-- Booking as per city 
SELECT  CITY_NAME,'CITY vs BOOKING' ,COUNT(CITY_NAME) FROM booking b 
join users u on b.USER_ID = u.USER_ID
join address a on a.ADDRESS_ID = u.ADDRESS_ID
JOIN CITY c on c.CITY_ID = a.CITY_ID
GROUP BY c.CITY_NAME;