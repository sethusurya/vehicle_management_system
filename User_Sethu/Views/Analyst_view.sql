create or replace view analyst_view
as
select u.First_name, u.last_name, u.email, b.booking_status, b.created_start_date, cr.car_register_id, cc.car_category_name,t.total_cost,t.status from transaction t
LEFT join BOOKING b
ON t.transaction_id = b.transaction_id
lefT join car_listing Cl
on cl.listing_id = b.listing_id
LEFT JOIN CAR_REGISTRATION CR
ON cr.car_register_id = cl.car_register_id
left join car_category cc
on cr.car_category_id = cc.car_category_id
left join users u
ON b.user_id = u.user_id;


-- select * from analyst_view;

create or replace view service_support_view
as
select u.First_name, u.last_name, u.email, u.phone_no, u.passport, u.driver_license, u.blacklisted, b.booking_status, b.created_start_date,b.created_end_date, b.actual_start_date, b.actual_end_date, cr.car_register_id, cc.car_category_name from BOOKING b
lefT join car_listing Cl
on cl.listing_id = b.listing_id
LEFT JOIN CAR_REGISTRATION CR
ON cr.car_register_id = cl.car_register_id
left join car_category cc
on cr.car_category_id = cc.car_category_id
left join users u
ON b.user_id = u.user_id;

-- select * from service_support_view;