------------------------------------------ADDRESS---------------------------------------------------------------------
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('15 SHEPHERD AVE', 'APT 2', '02115', 'BOSTON', 'MA', 'EMPLOYEE', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('16 SHEPHERD AVE', 'APT 2', '02115', 'BOSTON', 'MA', 'PARKING', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('17 SHEPHERD AVE', 'APT 2', '02115', 'BOSTON', 'MA', 'USER', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('15 SHEPHERD AVE', 'APT 1', '02115', 'BOSTON', 'MA', 'EMPLOYEE', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('16 SHEPHERD AVE', 'APT 2', '02115', 'CAMBRIGE', 'MA', 'EMPLOYEE', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('17 SHEPHERD AVE', 'APT 3', '02115', 'NEW WORK', 'NY', 'EMPLOYEE', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('18 SHEPHERD AVE', 'APT 4', '02115', 'Los Angeles', 'CA', 'EMPLOYEE', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('19 SHEPHERD AVE', 'APT 5', '02115', 'CHICAGO', 'IL', 'EMPLOYEE', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('20 SHEPHERD AVE', 'APT 6', '02115', 'CAMBRIGE', 'MA', 'USER', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('21 SHEPHERD AVE', 'APT 7', '02115', 'NEW WORK', 'NY', 'USER', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('22 SHEPHERD AVE', 'APT 8', '02115', 'Los Angeles', 'CA', 'USER', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('23 SHEPHERD AVE', 'APT 9', '02115', 'CHICAGO', 'IL', 'USER', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('24 SHEPHERD AVE', 'APT 10', '02115', 'CAMBRIGE', 'MA', 'USER', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('25 SHEPHERD AVE', 'APT 11', '02115', 'NEW WORK', 'NY', 'PARKING', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('26 SHEPHERD AVE', 'APT 12', '02115', 'CHICAGO', 'IL', 'PARKING', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('27 SHEPHERD AVE', 'APT 13', '02115', 'CAMBRIGE', 'MA', 'PARKING', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('30 SHEPHERD AVE', 'APT 14', '02115', 'Los Angeles', 'CA', 'PARKING', 'US');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('31 SHEPHERD AVE', 'APT 15', '02115', 'BOSTON', 'MA', 'PARKING', 'US');

--------------------------------------------------ROLES-----------------------------------------------------------------
EXECUTE PCKG_ROLE.INSERT_ROLE('OWNER');
EXECUTE PCKG_ROLE.INSERT_ROLE('DEVELOPER');
EXECUTE PCKG_ROLE.INSERT_ROLE('ANALYST');
EXECUTE PCKG_ROLE.INSERT_ROLE('TESTER');

----------------------------------------------------USERS---------------------------------------------------------------
EXECUTE PCKG_USERS.INSERT_USER('Sethu', 'sethu@gmail.com', '8573337398', 'Sethu', 'Pao', '12345', '3333333','CCV777', 'TRUE', 'ADDR_1');
EXECUTE PCKG_USERS.INSERT_USER('Noordeep', 'noordeep@gmail.com', '8574151025', 'Noor', 'Gill', '54321', '9876543','ABFG21', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Yash', 'yash@gmail.com', '8574151111', 'Yash', 'Jain', '85247', '7412589','INJG21', 'TRUE', 'ADDR_3');
EXECUTE PCKG_USERS.INSERT_USER('Raj', 'raj@gmail.com', '4156182598', 'Raj', 'Rampal', '56425', '4443333','FRC777', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Rohan', 'rohan@gmail.com', '8575551025', 'Rohan', 'Jain', '85412', '9898443','INFX21', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Yohesh', 'yohesh@gmail.com', '8574152211', 'Yogesh', 'Mahato', '254DC', '7412559','AFJG21', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Sneha', 'sneha@gmail.com', '2572220011', 'Sneha', 'Vaidya', '91024', '8521475','IN2221', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Suzan', 'suzan@gmail.com', '6983330441', 'Suzan', 'Kumar', '87432', '986933','IN3131', 'TRUE', 'ADDR_2');

------------------------------------------------------EMPLOYEE-----------------------------------------------------------
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('SETHU', 'P', 'pagolu.s@northeastern.edu', 'sethu', 'ADDR_3', '2');
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('SETHU', 'P', 'pagolu.s@northeastern.edu', 'sethu', 'ADDR_2', '2'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('SETHU', 'P', 'pagolu.s@northeastern.edu', 'sethu', 'ADDR_1', '2'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('gill', 'P', 'gill.s@northeastern.edu', 'sethu', 'ADDR_3', '1');
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('gill', 'P', 'gill.s@northeastern.edu', 'sethu', 'ADDR_2', '1'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('gill', 'P', 'gill.s@northeastern.edu', 'sethu', 'ADDR_1', '1');
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('deep', 'P', 'deep.s@northeastern.edu', 'sethu', 'ADDR_3', '1');
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('deep', 'P', 'deep.s@northeastern.edu', 'sethu', 'ADDR_2', '1'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('deep', 'P', 'deep.s@northeastern.edu', 'sethu', 'ADDR_1', '1'); 

---------------------------------------------------CAR CATEGORY-------------------------------------------------------------
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('WAGON');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('SEDAN');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('MINIVAN');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('SPORTS CAR');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('HATCHBACK');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('CONVERTIBLE');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('WAGON');

---------------------------------------------------PARKING ------------------------------------------------------------------
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_1');
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_2');
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_3');
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_4');
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_5');
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_6');
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_7');
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_8');
EXECUTE PCKG_PARKING.INSERT_PARKING('ADDR_9');
---------------------------------------------------CAR registration----------------------------------------------------------

EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER('Artyhbnju123fthyg1', 'zica', 'red', 'tata', 2018, '1-JAN-2018', 'gasoline','manual',4,'CAR_CATEGORY_1','EMPLOYEE_1', 'ADDR_1');
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER('Artyhbnju123fthyg1', 'zica', 'red', 'tata', 2018, '1-JAN-2018', 'gasoline','manual',4,'CAR_CATEGORY_1','EMPLOYEE_1', 'ADDR_2');
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER('Artyhbnju123fthyg1', 'zica', 'red', 'tata', 2018, '1-JAN-2018', 'gasoline','manual',4,'CAR_CATEGORY_1','EMPLOYEE_1', 'ADDR_3');
--------------------------------------------------CAR LISTING----------------------------------------------------------------
EXECUTE PCKG_CAR_LISTING.INSERT_CAR_LISTING('TRUE',25.50,'Artyhbnju123fthyg1','PARKING_1');
EXECUTE PCKG_CAR_LISTING.INSERT_CAR_LISTING('TRUE',25.50,'Artyhbnju123fthyg1','PARKING_2');
