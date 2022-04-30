
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
from vms_employee.users usr
join vms_employee.address adr on (usr.ADDRESS_ID = adr.ADDRESS_ID)
join vms_employee.CITY city on adr.CITY_ID = city.CITY_ID
join vms_employee.STATE state on city.STATE_ID = state.STATE_ID
join vms_employee.booking book on (usr.USER_ID = book.USER_ID)
join vms_employee.car_listing carlist on (carlist.listing_id = book.listing_id)
join vms_employee.car_registration car on (car.car_register_id = carlist.car_register_id)
join vms_employee.transaction trans on book.transaction_id = trans.transaction_id;
