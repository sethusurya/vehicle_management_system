

--------------------------------
--PAYMENT VIEW 
--------------------------------

create or replace view payment_view as
select usr.USER_ID, usr.FIRST_NAME, usr.LAST_NAME, usr.EMAIL,usr.PHONE_NO,
car.CAR_NAME, car.car_company, car.NO_OF_SEATS,
carlist.AVAILABILITY, carlist.DATE_POSTED,
book.actual_start_date,book.actual_end_date,book.BOOKING_STATUS,
carlist.fee_rate,
trans.TOTAL_COST,trans.STATUS as TRANSACTION_STATUS
from users usr
join booking book on (usr.USER_ID = book.USER_ID)
join car_listing carlist on (carlist.listing_id = book.listing_id)
join car_registration car on (car.car_register_id = carlist.car_register_id)
join transaction trans on book.transaction_id = trans.transaction_id;