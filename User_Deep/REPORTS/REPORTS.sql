
select u.USER_NAME,b.booking_status, COUNT(b.USER_ID) from USERS u join Booking b ON u.USER_ID = b.USER_ID
GROUP BY USER_NAME, BOOKING_STATUS;
