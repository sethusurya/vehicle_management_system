select STATUS, 'TRANSACTION STATUS VS TOTAL', count(*) from vms_employee.TRANSACTION
group by STATUS;