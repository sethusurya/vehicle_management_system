------------------------------------------ADDRESS---------------------------------------------------------------------
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('15 SHEPHERD AVE', 'APT 2', '02115', 'BOSTON', 'MA', 'EMPLOYEE', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('16 SHEPHERD AVE', 'APT 2', '02115', 'BOSTON', 'MA', 'PARKING', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('17 SHEPHERD AVE', 'APT 2', '02115', 'BOSTON', 'MA', 'USER', 'USA');


--------------------------------------------------ROLES-----------------------------------------------------------------
EXECUTE PCKG_ROLE.INSERT_ROLE('OWNER');
EXECUTE PCKG_ROLE.INSERT_ROLE('DEVELOPER');
EXECUTE PCKG_ROLE.INSERT_ROLE('ANALYST');
EXECUTE PCKG_ROLE.INSERT_ROLE('TESTER');

----------------------------------------------------USERS---------------------------------------------------------------
EXECUTE PCKG_USERS.INSERT_USER('Sethu', 'sethu@gmail.com', '8573337398', 'Sethu', 'Pao', '12345', '3333333','CCV777', 'TRUE', 'ADDR_1');
EXECUTE PCKG_USERS.INSERT_USER('Noordeep', 'noordeep@gmail.com', '8574151025', 'Noor', 'Gill', '54321', '9876543','ABFG21', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Yash', 'yash@gmail.com', '8574151111', 'Yash', 'Jain', '85247', '7412589','INJG21', 'TRUE', 'ADDR_3');

------------------------------------------------------EMPLOYEE-----------------------------------------------------------
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('SETHU', 'P', 'pagolu.s@northeastern.edu', 'sethu', 'ADDR_3', '2');
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('SETHU', 'P', 'pagolu.s@northeastern.edu', 'sethu', 'ADDR_2', '2'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('SETHU', 'P', 'pagolu.s@northeastern.edu', 'sethu', 'ADDR_1', '2'); 

---------------------------------------------------CAR CATEGORY-------------------------------------------------------------
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('WAGON');

---------------------------------------------------PARKING ------------------------------------------------------------------
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_1');
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_2');
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_3');

---------------------------------------------------CAR registration----------------------------------------------------------

EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER('Artyhbnju123fthyg1', 'zica', 'red', 'tata', 2018, '1-JAN-2018', 'gasoline','manual',4,'CAR_CATEGORY_1','EMPLOYEE_1', 'ADDR_1');
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER('Artyhbnju123fthyg1', 'zica', 'red', 'tata', 2018, '1-JAN-2018', 'gasoline','manual',4,'CAR_CATEGORY_1','EMPLOYEE_1', 'ADDR_2');
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER('Artyhbnju123fthyg1', 'zica', 'red', 'tata', 2018, '1-JAN-2018', 'gasoline','manual',4,'CAR_CATEGORY_1','EMPLOYEE_1', 'ADDR_3');
--------------------------------------------------CAR LISTING----------------------------------------------------------------
EXECUTE PCKG_CAR_LISTING.INSERT_CAR_LISTING('TRUE',25.50,'Artyhbnju123fthyg1','1');
EXECUTE PCKG_CAR_LISTING.INSERT_CAR_LISTING('TRUE',25.50,'Artyhbnju123fthyg1','1');

-----------------------------------------------------BOOKING----------------------------------------------------------------
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING('24-04-22 8:17:19.256000000 PM','25-04-22 8:17:19.256000000 PM','USER_1','CAR_LISTING_6');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING('24-04-22 8:17:19.256000000 PM','25-04-22 8:17:19.256000000 PM','USER_2','CAR_LISTING_6');
---------------------------------------------------TRANSACTION----------------------------------------------------------------