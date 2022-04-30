select us.email,'USER vs BOOKING',count(b.user_id) from vms_employee.users us
left JOIN  vms_employee.BOOKING b
on b.USER_ID = us.USER_ID
GROUP BY us.email;