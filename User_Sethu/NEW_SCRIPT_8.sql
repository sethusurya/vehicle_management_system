----------------------------------------------
-------------------BOOKING STATUS REPORT------------------------

select BOOKING_STATUS, count(*) from Booking
group by BOOKING_STATUS;

---------------------------------------------------

----------------------BOOKING WITH RESPECT TO STATUS-----------------------

select cc.car_category_name, 'Category Name VS Total', count(*) from BOOKING b
LEFT JOIN car_listing Cl
on cl.listing_id = b.listing_id
LEFT JOIN CAR_REGISTRATION CR
ON cr.car_register_id = cl.car_register_id
LEFT JOIN car_category cc
on cr.car_category_id = cc.car_category_id
GROUP BY cc.car_category_name

-------------------------------------------

Select us.email, cr.CAR_REGISTER_ID, cr.CAR_NAME, cr.CAR_COLOR, cr.CAR_COMPANY, cg.CAR_CATEGORY_NAME, b.ACTUAL_START_DATE, b.ACTUAL_END_DATE,b.COMMENTS as FEEDBACKS 
from users us, booking b, CAR_LISTING c, CAR_REGISTRATION cr, car_category cg  
where us.USER_ID = b.USER_ID and b.COMMENTS is not NULL 
and c.LISTING_ID = b.LISTING_ID and cr.CAR_CATEGORY_ID = cg.CAR_CATEGORY_ID and cr.CAR_REGISTER_ID = c.CAR_REGISTER_ID;

------------------------------------------

select STATUS, 'TRANSACTION STATUS VS TOTAL', count(*) from TRANSACTION
group by STATUS;

-----------------------------------------

select us.email,'USER vs BOOKING',count(b.user_id) from users us
left JOIN  BOOKING b
on b.USER_ID = us.USER_ID
GROUP BY us.email;

--------------------------------------------------------------------------

select ZIPCODE,'No.OF ADDRESS FOR PARKING', count(*) from address
where address_type='PARKING'
group by zipcode;


-----------------------------------------------------------------------

select cc.car_category_name,'REVENUE', sum(t.TOTAL_COST)from transaction t
LEFT join BOOKING b
ON t.transaction_id = b.transaction_id
lefT join car_listing Cl
on cl.listing_id = b.listing_id
LEFT JOIN CAR_REGISTRATION CR
ON cr.car_register_id = cl.car_register_id
left join car_category cc
on cr.car_category_id = cc.car_category_id
GROUP BY cc.car_category_name;