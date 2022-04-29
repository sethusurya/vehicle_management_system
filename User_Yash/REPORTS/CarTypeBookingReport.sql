select cc.car_category_name, 'Category Name VS Total', count(*) from BOOKING b
LEFT JOIN car_listing Cl
on cl.listing_id = b.listing_id
LEFT JOIN CAR_REGISTRATION CR
ON cr.car_register_id = cl.car_register_id
LEFT JOIN car_category cc
on cr.car_category_id = cc.car_category_id
GROUP BY cc.car_category_name