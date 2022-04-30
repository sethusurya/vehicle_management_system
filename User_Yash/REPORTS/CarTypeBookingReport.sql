select cc.car_category_name, 'Category Name VS Total', count(*) from vms_employee.BOOKING b
LEFT JOIN vms_employee.car_listing Cl
on cl.listing_id = b.listing_id
LEFT JOIN vms_employee.CAR_REGISTRATION CR
ON cr.car_register_id = cl.car_register_id
LEFT JOIN vms_employee.car_category cc
on cr.car_category_id = cc.car_category_id
GROUP BY cc.car_category_name