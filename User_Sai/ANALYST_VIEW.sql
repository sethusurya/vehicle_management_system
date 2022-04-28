
------------------------------------
-- Analyst View
------------------------------------

create or replace view analyst_view
as
select usr.USER_ID,
usr.FIRST_NAME, usr.LAST_NAME, usr.EMAIL, usr.PHONE_NO,
adr.ADDRESS_LINE_1,adr.ADDRESS_LINE_2,adr.ZIPCODE,
city.CITY_NAME,
state.STATE_NAME,
cnt.COUNTRY_NAME,
cat.CAR_CATEGORY_NAME,
car.CAR_NAME,car.CAR_COMPANY, car.NO_OF_SEATS,car.FUEL_TYPE, car.TRANSMISSION_TYPE,
carlist.FEE_RATE, carlist.AVAILABILITY, carlist.DATE_POSTED,
book.BOOKING_STATUS,
trans.STATUS, 
trans.TOTAL_COST,
park.PARKING_ID
from Users usr,
ADDRESS adr,
CITY city,
STATE state,
COUNTRY cnt,
CAR_CATEGORY cat,
CAR_REGISTRATION car,
CAR_LISTING carlist,
BOOKING book,
TRANSACTION trans,
PARKING park
WHERE
usr.USER_ID = BOOK.USER_ID 
and 
usr.ADDRESS_ID = adr.ADDRESS_ID
and
book.TRANSACTION_ID = trans.TRANSACTION_ID 
and
car.CAR_REGISTER_ID = carlist.CAR_REGISTER_ID
and
car.CAR_CATEGORY_ID = cat.CAR_CATEGORY_ID
and 
adr.ADDRESS_ID = park.ADDRESS_ID;


