select EMPLOYEE_ID, 'CAR_REGISTRATION_STATUS', COUNT(CAR_REGISTER_ID)
from CAR_REGISTRATION group by EMPLOYEE_ID;


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
GROUP BY cc.car_category_name

--------------------------------------------------------------------------