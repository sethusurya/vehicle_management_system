select BOOKING_STATUS, 'BOOKING STATUS VS TOTAL COUNT',count(*) from vms_employee.Booking
group by BOOKING_STATUS;