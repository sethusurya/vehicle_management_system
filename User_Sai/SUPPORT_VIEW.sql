
--------------------------------------
-- support_view
--------------------------------------

create or replace view support_view as
select usr.FIRST_NAME, usr.LAST_NAME, usr.EMAIL
book.LISTING_ID, 
carlist.car_register_id, carlist.fee_rate, 
car.CAR_NAME, car.car_company, 
trans.TOTAL_COST from users usr
join booking book on (usr.USER_ID = book.USER_ID)
join car_listing carlist on (carlist.listing_id = book.listing_id)
join car_registration car on (car.car_register_id = carlist.car_register_id)
join transaction trans on book.transaction_id = trans.transaction_id;
