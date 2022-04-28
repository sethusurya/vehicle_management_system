
--------------------------------------
-- support_view
--------------------------------------

create or replace view support_view as
select 
usr.USER_ID, usr.FIRST_NAME , usr.LAST_NAME, usr.EMAIL, usr.PHONE_NO,
car.CAR_REGISTER_ID,
cat.CAR_CATEGORY_NAME,
carlist.FEE_RATE, carlist.AVAILABILITY,
book.BOOKING_STATUS,
trans.TOTAL_COST,trans.STATUS
from TRANSACTION trans, USERS usr, CAR_REGISTRATION car, CAR_LISTING carlist,CAR_CATEGORY cat, BOOKING book
WHERE
usr.USER_ID = BOOK.USER_ID
AND
trans.TRANSACTION_ID = book.TRANSACTION_ID
AND
car.CAR_CATEGORY_ID = cat.CAR_CATEGORY_ID
AND
carlist.CAR_REGISTER_ID = car.CAR_REGISTER_ID;

