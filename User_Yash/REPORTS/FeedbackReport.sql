Select us.email, cr.CAR_REGISTER_ID, cr.CAR_NAME, cr.CAR_COLOR, cr.CAR_COMPANY, cg.CAR_CATEGORY_NAME, b.ACTUAL_START_DATE, b.ACTUAL_END_DATE,b.COMMENTS as FEEDBACKS 
from vms_employee.users us, vms_employee.booking b, vms_employee.CAR_LISTING c, vms_employee.CAR_REGISTRATION cr, vms_employee.car_category cg  
where us.USER_ID = b.USER_ID and b.COMMENTS is not NULL 
and c.LISTING_ID = b.LISTING_ID and cr.CAR_CATEGORY_ID = cg.CAR_CATEGORY_ID and cr.CAR_REGISTER_ID = c.CAR_REGISTER_ID;