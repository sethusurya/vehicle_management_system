-- ADDRESS INSERTION
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('15 SHEPHERD AVE', 'APT 1', '02115', 'BOSTON', 'MA', 'EMPLOYEE', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('16 SHEPHERD AVE', 'APT 2', '02115', 'CAMBRIGE', 'MA', 'EMPLOYEE', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('17 SHEPHERD AVE', 'APT 3', '02115', 'NEW WORK', 'NY', 'EMPLOYEE', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('18 SHEPHERD AVE', 'APT 4', '02115', 'Los Angeles', 'CA', 'EMPLOYEE', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('19 SHEPHERD AVE', 'APT 5', '02115', 'CHICAGO', 'IL', 'EMPLOYEE', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('20 SHEPHERD AVE', 'APT 6', '02115', 'CAMBRIGE', 'MA', 'USER', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('21 SHEPHERD AVE', 'APT 7', '02115', 'NEW WORK', 'NY', 'USER', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('22 SHEPHERD AVE', 'APT 8', '02115', 'Los Angeles', 'CA', 'USER', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('23 SHEPHERD AVE', 'APT 9', '02115', 'CHICAGO', 'IL', 'USER', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('24 SHEPHERD AVE', 'APT 10', '02115', 'CAMBRIGE', 'MA', 'USER', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('25 SHEPHERD AVE', 'APT 11', '02115', 'NEW WORK', 'NY', 'PARKING', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('26 SHEPHERD AVE', 'APT 12', '02115', 'CHICAGO', 'IL', 'PARKING', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('27 SHEPHERD AVE', 'APT 13', '02115', 'CAMBRIGE', 'MA', 'PARKING', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('30 SHEPHERD AVE', 'APT 14', '02115', 'Los Angeles', 'CA', 'PARKING', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('31 SHEPHERD AVE', 'APT 15', '02115', 'BOSTON', 'MA', 'PARKING', 'US');


-- BOOKING INSERTION
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_1','CAR_LISTING_1');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_2','CAR_LISTING_2');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_3','CAR_LISTING_3');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_4','CAR_LISTING_4');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_5','CAR_LISTING_5');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_6','CAR_LISTING_6');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_7','CAR_LISTING_7');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_8','CAR_LISTING_8');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_9','CAR_LISTING_9');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_10','CAR_LISTING_10');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_11','CAR_LISTING_11');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_12','CAR_LISTING_12');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_13','CAR_LISTING_13');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_14','CAR_LISTING_14');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_14','CAR_LISTING_15');

-- BOOKING IN PROGRESS
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_1','USER_1');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_2','USER_2');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_3','USER_3');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_4','USER_4');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_5','USER_5');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_6','USER_6');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_7','USER_7');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_8','USER_8');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_9','USER_9');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_10','USER_10');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_11','USER_11');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_12','USER_12');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_13','USER_13');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_14','USER_14');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_15','USER_15');

-- BOOKING COMPLETED
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_5','CAR_LISTING_5'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_6','CAR_LISTING_6'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_7','CAR_LISTING_7'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_8','CAR_LISTING_8'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_9','CAR_LISTING_9'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_10','CAR_LISTING_10'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_11','CAR_LISTING_11'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_12','CAR_LISTING_12');
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_13','CAR_LISTING_13'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_14','CAR_LISTING_14');  
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_15','CAR_LISTING_15'); 

-- PAYMENT SUCCESS
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_SUCCESS('BOOK_10'); 
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_SUCCESS('BOOK_11'); 
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_SUCCESS('BOOK_12'); 
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_SUCCESS('BOOK_13');

-- PAYMENT FAILED
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_FAIL('BOOK_14'); 
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_FAIL('BOOK_15');

-- BOOKING CANCELLED
EXECUTE PKG_BOOKING.BOOKING_CANCELLED('BOOK_12'); 
EXECUTE PKG_BOOKING.BOOKING_CANCELLED('BOOK_13');