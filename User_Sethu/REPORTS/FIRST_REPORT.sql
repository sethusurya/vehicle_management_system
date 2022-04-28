select EMPLOYEE_ID, 'CAR_REGISTRATION_STATUS', COUNT(CAR_REGISTER_ID)
from CAR_REGISTRATION group by EMPLOYEE_ID;


--------------------------------------------------------------------------

select ZIPCODE,'No.OF ADDRESS FOR PARKING', count(*) from address
where address_type='PARKING'
group by zipcode;


-----------------------------------------------------------------------

