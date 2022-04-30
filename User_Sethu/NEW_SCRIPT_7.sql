--------------------------------------
-- support_view
--------------------------------------

create or replace view support_view as
select usr.FIRST_NAME, usr.LAST_NAME, usr.EMAIL,
book.LISTING_ID, 
carlist.car_register_id, carlist.fee_rate, 
car.CAR_NAME, car.car_company, 
trans.TOTAL_COST from users usr
join booking book on (usr.USER_ID = book.USER_ID)
join car_listing carlist on (carlist.listing_id = book.listing_id)
join car_registration car on (car.car_register_id = carlist.car_register_id)
join transaction trans on book.transaction_id = trans.transaction_id;




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



------------------------------------
--  audit_view
------------------------------------

create or replace view audit_view as
select 
au_usr.USERNAME, au_usr.TABLE_NAME as AUDIT_USER_TABLE, au_usr.AUDIT_DATE as USER_AUDIT_DATE, au_usr.ACTION as USER_ACTION,
au_trans.TABLE_NAME as AUDIT_TRANSACTION_TABLE, au_trans.AUDIT_DATE as TRANSACTION_AUDIT,au_trans.ACTION as TRANSACTION_TABLE_ACTION
from AUDIT_DATA_TRANSACTION au_trans
join AUDIT_DATA_USER au_usr on au_usr.AUDIT_ID = au_trans.AUDIT_ID;


------------------------------------
-- Analyst View
------------------------------------

create or replace view analyst_view
as
select usr.USER_ID, usr.FIRST_NAME, usr.LAST_NAME, usr.EMAIL,usr.PHONE_NO,
adr.ADDRESS_LINE_1,adr.ADDRESS_LINE_2,adr.ZIPCODE,
city.CITY_NAME,
state.STATE_NAME,
carlist.AVAILABILITY, carlist.DATE_POSTED, 
car.CAR_NAME, car.car_company, car.NO_OF_SEATS,car.FUEL_TYPE, car.TRANSMISSION_TYPE,
carlist.fee_rate, 
trans.TOTAL_COST,trans.STATUS as TRANSACTION_STATUS,
book.BOOKING_STATUS
from users usr
join address adr on (usr.ADDRESS_ID = adr.ADDRESS_ID)
join CITY city on adr.CITY_ID = city.CITY_ID
join STATE state on city.STATE_ID = state.STATE_ID
join booking book on (usr.USER_ID = book.USER_ID)
join car_listing carlist on (carlist.listing_id = book.listing_id)
join car_registration car on (car.car_register_id = carlist.car_register_id)
join transaction trans on book.transaction_id = trans.transaction_id;


--select * from support_view;
--select * from analyst_view;
--select * from audit_view;
--select * from payment_view;