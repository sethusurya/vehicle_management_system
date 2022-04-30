--------------------------------------------------------------------------

select ZIPCODE,'No.OF ADDRESS FOR PARKING', count(*) from vms_employee.address
where address_type='PARKING'
group by zipcode;


-----------------------------------------------------------------------

select cc.car_category_name,'REVENUE', sum(t.TOTAL_COST)from vms_employee.transaction t
LEFT join vms_employee.BOOKING b
ON t.transaction_id = b.transaction_id
lefT join vms_employee.car_listing Cl
on cl.listing_id = b.listing_id
LEFT JOIN vms_employee.CAR_REGISTRATION CR
ON cr.car_register_id = cl.car_register_id
left join vms_employee.car_category cc
on cr.car_category_id = cc.car_category_id
GROUP BY cc.car_category_name

--------------------------------------------------------------------------