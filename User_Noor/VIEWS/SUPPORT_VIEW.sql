-- SUPPORT VIEW
select u.USER_ID, u.FIRST_NAME, u.LAST_NAME, b.LISTING_ID, r.car_register_id, t.CAR_NAME, t.car_company, r.fee_rate from users u 
join booking b on (u.USER_ID = b.USER_ID)
join car_listing r on (r.listing_id = b.listing_id)
join car_registration t on (t.car_register_id = r.car_register_id);