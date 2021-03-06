------------------------------------------ADDRESS---------------------------------------------------------------------
-- 1st in insert
-- 17 inserts
-- ADDR_1 to ADDR_6 EMP
--addr_7 to addr_11 user
--addr_12 to addr_17 parking
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('15 SHEPHERD AVE', 'APT 2', '02115', 'BOSTON', 'MA', 'EMPLOYEE', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('15 SHEPHERD AVE', 'APT 1', '02115', 'BOSTON', 'MA', 'EMPLOYEE', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('16 SHEPHERD AVE', 'APT 2', '02141', 'CAMBRIGE', 'MA', 'EMPLOYEE', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('17 SHEPHERD AVE', 'APT 3', '10001', 'NEW WORK', 'NY', 'EMPLOYEE', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('18 SHEPHERD AVE', 'APT 4', '90001', 'Los Angeles', 'CA', 'EMPLOYEE', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('19 SHEPHERD AVE', 'APT 5', '60007', 'CHICAGO', 'IL', 'EMPLOYEE', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('79 HIGHLANDSTREET', 'APT 2', '02119', 'ROXBURY', 'MA', 'EMPLOYEE', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('20 SHEPHERD AVE', 'APT 6', '02141', 'CAMBRIGE', 'MA', 'USER', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('17 SHEPHERD AVE', 'APT 2', '02115', 'BOSTON', 'MA', 'USER', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('21 SHEPHERD AVE', 'APT 7', '10001', 'NEW WORK', 'NY', 'USER', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('22 SHEPHERD AVE', 'APT 8', '90001', 'Los Angeles', 'CA', 'USER', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('23 SHEPHERD AVE', 'APT 9', '60007', 'CHICAGO', 'IL', 'USER', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('24 SHEPHERD AVE', 'APT 10', '02141', 'CAMBRIGE', 'MA', 'USER', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('56 HIGHLANDSTREET', 'APT 1', '02119', 'ROXBURY', 'MA', 'USER', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('25 SHEPHERD AVE', 'APT 11', '10001', 'NEW WORK', 'NY', 'PARKING', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('26 SHEPHERD AVE', 'APT 12', '60007', 'CHICAGO', 'IL', 'PARKING', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('27 SHEPHERD AVE', 'APT 13', '02141', 'CAMBRIGE', 'MA', 'PARKING', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('30 SHEPHERD AVE', 'APT 14', '90001', 'Los Angeles', 'CA', 'PARKING', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('31 SHEPHERD AVE', 'APT 15', '02115', 'BOSTON', 'MA', 'PARKING', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('16 HIGHLANDPARK AVE', 'APT 2', '02119', 'ROXBURY', 'MA', 'PARKING', 'USA');
EXECUTE PKG_ADDRESS.INSERT_ADDRESS('57 HIGHLANDSTREET', 'APT 1', '02119', 'ROXBURY', 'MA', 'PARKING', 'USA');

--------------------------------------------------ROLES-----------------------------------------------------------------
-- 2nd in insert
-- ROLE_1
-- ROLE_2
-- ROLE_3
-- ROLE_4
EXECUTE PCKG_ROLE.INSERT_ROLE('OWNER');
EXECUTE PCKG_ROLE.INSERT_ROLE('DEVELOPER');
EXECUTE PCKG_ROLE.INSERT_ROLE('ANALYST');
EXECUTE PCKG_ROLE.INSERT_ROLE('TESTER');

----------------------------------------------------USERS---------------------------------------------------------------

--- 3rd in insert
-- USER_1
-- USER_2
-- ...
-- USER_16
EXECUTE PCKG_USERS.INSERT_USER('Sethu', 'sethu@gmail.com', '8573337398', 'Sethu', 'Pag', '123456', '6987451254','CXCV7743', 'FALSE', 'ADDR_1');
EXECUTE PCKG_USERS.INSERT_USER('Noordeep', 'noordeep@gmail.com', '8574151025', 'Noor', 'Gill', '54A3C21', '2587412589','ABFG2170', 'FALSE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Yash', 'yash@gmail.com', '8574151111', 'Yash', 'Jain', '8C52F47', '7412589124','INJ34G21', 'FALSE', 'ADDR_3');
EXECUTE PCKG_USERS.INSERT_USER('Raj', 'raj@gmail.com', '8576182598', 'Raj', 'Rampal', 'ZQ56425', '4425133458','FRA79701', 'FALSE', 'ADDR_4');
EXECUTE PCKG_USERS.INSERT_USER('Rohan', 'rohan@gmail.com', '8575551025', 'Rohan', 'Jain', '8Z54W12', '9898443612','INFX2143', 'FALSE', 'ADDR_5');
EXECUTE PCKG_USERS.INSERT_USER('Yohesh', 'yohesh@gmail.com', '8574152211', 'Yogesh', 'Mahato', '254DCF2', '7412559739','AFJG2176', 'FALSE', 'ADDR_6');
EXECUTE PCKG_USERS.INSERT_USER('Sneha', 'sneha@gmail.com', '9882220011', 'Sneha', 'Vaidya', 'AV91024', '8521475348','INXA2221', 'FALSE', 'ADDR_7');
EXECUTE PCKG_USERS.INSERT_USER('Suzan', 'suzan@gmail.com', '9983330441', 'Suzan', 'Kumar', 'VC87432', '9869335461','INL31315', 'FALSE', 'ADDR_8');
EXECUTE PCKG_USERS.INSERT_USER('Sajag', 'sajag@yahoo.com', '8573337398', 'Sajag', 'Jain', 'AXRT431', '5894435434','ACCVX797', 'FALSE', 'ADDR_9');
EXECUTE PCKG_USERS.INSERT_USER('Rowen', 'rowen@yahoo.com', '8555751025', 'Rowen', 'Ram', 'AHJ5432', '9878543541','AGG21X40', 'FALSE', 'ADDR_10');
EXECUTE PCKG_USERS.INSERT_USER('Rohit', 'rohit@yahoo.com', '8961351111', 'Rohit', 'Kumar', 'XXC85247', '7413589661','AFINZG21', 'FALSE', 'ADDR_11');
EXECUTE PCKG_USERS.INSERT_USER('Rajnesh', 'rajnesh@yahoo.com', '4157772598', 'Rajnesh', 'Jain', 'AFK56425', '8894443433','FRHYT777', 'FALSE', 'ADDR_12');
EXECUTE PCKG_USERS.INSERT_USER('Ritika', 'ritika@yahoo.com', '8544451035', 'Ritika', 'Rampuri', 'DAZ85412', '9899443885','GNAFJX21', 'FALSE', 'ADDR_13');
EXECUTE PCKG_USERS.INSERT_USER('Somesh', 'somesh@yahoo.com', '8575512211', 'Somesh', 'Mahato', '254DCX1', '7414559554','CFJG2121', 'FALSE', 'ADDR_14');
EXECUTE PCKG_USERS.INSERT_USER('Rama', 'rama@yahoo.com', '5572220011', 'Rama', 'Krishna', 'JJZ9102', '8521485663','UN222132', 'FALSE', 'ADDR_15');
EXECUTE PCKG_USERS.INSERT_USER('Akshay', 'akshay@yahoo.com', '6987630441', 'Akshay', 'Patil', 'AJK87432', '9899869631','IGAX3131', 'FALSE', 'ADDR_16');
EXECUTE PCKG_USERS.INSERT_USER('John', 'johncena@gmail.com', '9875415879', 'John', 'Cena', 'AKKL7432', '8745874695','LKLX3131', 'FALSE', 'ADDR_17');
EXECUTE PCKG_USERS.INSERT_USER('Ramesh', 'ramesh@gmail.com', '9857584258', 'Ramesh', 'Ahuja', 'ERT43178', '8747734695','OOPX3131', 'FALSE', 'ADDR_18');
EXECUTE PCKG_USERS.INSERT_USER('Shahrukh', 'shahrukh@gmail.com', '9896522547', 'Shahrukh', 'Khan', 'AHHG7432', '8796541258','JFKX3131', 'FALSE', 'ADDR_19');
------------------------------------------------------EMPLOYEE-----------------------------------------------------------
-- 4th in insert
-- EMPLOYEE_1
-- ..
-- EMPLOYEE_16
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('sethu', 'pagolu', 'sethu@gmail.com', 'pass1', 'ADDR_1', 'ROLE_2');
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('Noordeep', 'gill', 'noordeep@gmail.com', 'pass2', 'ADDR_2', 'ROLE_2'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('yash', 'hello', 'yash@gmail.com', 'pass3', 'ADDR_3', 'ROLE_2'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('raj', 'josh', 'raj@gmail.com', 'pass4', 'ADDR_3', 'ROLE_2');
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('rohan', 'khan', 'rohan@gmail.com', 'pass5', 'ADDR_4', 'ROLE_2'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('yohesh', 'sohesh', 'yohesh@gmail.com', 'pass6', 'ADDR_5', 'ROLE_3');
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('deep', 'anadh', 'sneha@gmail.com', 'pass7', 'ADDR_6', 'ROLE_3');
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('suzan', 'kumar', 'suzan@gmail.com', 'pass8', 'ADDR_6', 'ROLE_2'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('sneha', 'sharma', 'sneha@yahoo.com', 'pass9', 'ADDR_5', 'ROLE_3'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('suzan', 'khan', 'suzan@yahoo.com', 'pass10', 'ADDR_4', 'ROLE_3'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('yohesh', 'sohesh', 'yohesh@yahoo.com', 'pass11', 'ADDR_4', 'ROLE_2'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('raj', 'kumar', 'raj@yahoo.com', 'pass12', 'ADDR_3', 'ROLE_4'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('noor', 'deep', 'noordeep@yahoo.com', 'pass13', 'ADDR_2', 'ROLE_4'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('sethu', 'pagolu', 'sethu@yahoo.com', 'pass14', 'ADDR_2', 'ROLE_4'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('sethu', 'surya', 'pagolu.s@northeastern.edu', 'pass15', 'ADDR_1', 'ROLE_1'); 
EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('gill', 'noor', 'gill.no@northeastern.edu', 'pass16', 'ADDR_1', 'ROLE_1'); 
---------------------------------------------------CAR CATEGORY-------------------------------------------------------------
-- 5th in insert
-- CAR_CATEGORY_1
-- ..
-- CAR_CATEGORY_9
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('SEDAN');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('SUV');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('COUPE');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('SPORTS CAR');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('HATCHBACK');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('CONVERTIBLE');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('WAGON');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('MINIVAN');
EXECUTE PCKG_CAR_CATEGORY.INSERT_CAR_CATEGORY('PICKUP TRUCK');

---------------------------------------------------PARKING ------------------------------------------------------------------
-- 6th in insert
-- PARKING_1
-- ..
-- PARKING_14 (14 parking spots created)
-- ADDR_18 to
-- ADDR_25 inserted as parking
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('15 SHEPHERD AVE', 'APT 2', '02115', 'BOSTON', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('15 SHEPHERD AVE', 'APT 1', '02115', 'BOSTON', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('16 SHEPHERD AVE', 'APT 2', '02141', 'CAMBRIGE', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('17 SHEPHERD AVE', 'APT 3', '10001', 'NEW WORK', 'NY', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('18 SHEPHERD AVE', 'APT 4', '90001', 'Los Angeles', 'CA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('19 SHEPHERD AVE', 'APT 5', '60007', 'CHICAGO', 'IL','USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('79 HIGHLANDSTREET', 'APT 2', '02119', 'ROXBURY', 'MA','USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('20 SHEPHERD AVE', 'APT 6', '02141', 'CAMBRIGE', 'MA',  'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('17 SHEPHERD AVE', 'APT 2', '02115', 'BOSTON', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('21 SHEPHERD AVE', 'APT 7', '10001', 'NEW WORK', 'NY', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('22 SHEPHERD AVE', 'APT 8', '90001', 'Los Angeles', 'CA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('23 SHEPHERD AVE', 'APT 9', '60007', 'CHICAGO', 'IL', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('24 SHEPHERD AVE', 'APT 10', '02141', 'CAMBRIGE', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('56 HIGHLANDSTREET', 'APT 1', '02119', 'ROXBURY', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('25 SHEPHERD AVE', 'APT 11', '10001', 'NEW WORK', 'NY', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('26 SHEPHERD AVE', 'APT 12', '60007', 'CHICAGO', 'IL', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('27 SHEPHERD AVE', 'APT 13', '02141', 'CAMBRIGE', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('30 SHEPHERD AVE', 'APT 14', '90001', 'Los Angeles', 'CA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('31 SHEPHERD AVE', 'APT 15', '02115', 'BOSTON', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('16 HIGHLANDPARK AVE', 'APT 2', '02119', 'ROXBURY', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('57 HIGHLANDSTREET', 'APT 1', '02119', 'ROXBURY', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('25 HIGHLANDSTREET', 'APT 11', '10001', 'NEW WORK', 'NY', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('46 SHEPHERD AVE', 'APT 12', '60007', 'CHICAGO', 'IL', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('47 SHEPHERD AVE', 'APT 13', '02141', 'CAMBRIGE', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('90 SHEPHERD AVE', 'APT 14', '90001', 'Los Angeles', 'CA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('91 SHEPHERD AVE', 'APT 15', '02115', 'BOSTON', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('166 HIGHLANDPARK AVE', 'APT 2', '02119', 'ROXBURY', 'MA', 'USA');
EXECUTE PCKG_PARKING_EXT.INSERT_PARKING_EXT('57 HIGHLANDSTREET', 'APT 1', '02119', 'ROXBURY', 'MA', 'USA');
---------------------------------------------------CAR registration----------------------------------------------------------
-- 7th in INSERT
-- 28 CARS REGISTERED with their registered numbers
-- 13 Cars LISTED
-- 15 CARS not listed (parking spot taken)

-- select * from CAR_REGISTRATION
-- where 
--     UPPER(CAR_REGISTER_ID) NOT IN(
--     select UPPER(CAR_REGISTER_ID) FROM CAR_LISTING);

EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthyg7', 'city', 'RED', 'honda ', 2018, '1-JAN-2018', 'gasoline','manual',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','51 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 10);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthyg8', 'civic', 'white', 'honda ', 2019, '1-JAN-2019', 'gasoline','manual',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','52 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 12.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthyg9', 'accord', 'black', 'honda ', 2020, '1-FEB-2020', 'gasoline','manual',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','53 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 14.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthyg0', 'A7', 'RED', 'audi ', 2019, '1-MAR-2019', 'gasoline','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','54 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 20.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya0', 'A8', 'white', 'audi ', 2020, '1-JAN-2020', 'gasoline','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','55 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 22);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya1', 'Q7', 'black', 'audi ', 2017, '1-JUN-2017', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','56 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 25.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya2', 'Q5', 'RED', 'audi ', 2018, '1-JAN-2018', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','57 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 22);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya3', 'X7', 'white', 'bmw ', 2021, '1-FEB-2021', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','58 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 25.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya4', 'X5', 'black', 'bmw ', 2021, '1-JAN-2021', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','59 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 22);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya5', '330', 'RED', 'bmw ', 2017, '1-JAN-2017', 'gasoline','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','60 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 20.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya6', 'ecosport', 'white', 'ford ', 2018, '1-FEB-2018', 'diesel','automatic',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','51 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 12.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya7', 'focus', 'black', 'ford ', 2020, '1-JAN-2020', 'gasoline','manual',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','61 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 10);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya8', 'model 3', 'RED', 'tesla ', 2019, '1-FEB-2019', 'electric','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','62 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 17.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya9', 'wrangler', 'white', 'jeep ', 2020, '1-APR-2020', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','63 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 20.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123ftjyg7', 'city', 'RED', 'honda ', 2018, '1-JAN-2018', 'gasoline','manual',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','51 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 10);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju133fthyg8', 'civic', 'white', 'honda ', 2019, '1-JAN-2019', 'gasoline','manual',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','52 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 12.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju153fthyg9', 'accord', 'black', 'honda ', 2020, '1-FEB-2020', 'gasoline','manual',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','53 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 14.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju163fthyg0', 'A7', 'RED', 'audi ', 2019, '1-MAR-2019', 'gasoline','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','54 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 20.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju173fthya0', 'A8', 'white', 'audi ', 2020, '1-JAN-2020', 'gasoline','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','55 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 22);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju183fthya1', 'Q7', 'black', 'audi ', 2017, '1-JUN-2017', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','56 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 25.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju193fthya2', 'Q5', 'RED', 'audi ', 2018, '1-JAN-2018', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','57 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 22);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju223fthya3', 'X7', 'white', 'bmw ', 2021, '1-FEB-2021', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','58 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 25.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju223fthya4', 'X5', 'black', 'bmw ', 2021, '1-JAN-2021', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','59 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 22);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju223fthya5', '330', 'RED', 'bmw ', 2017, '1-JAN-2017', 'gasoline','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','60 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 20.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju223fthya6', 'ecosport', 'white', 'ford ', 2018, '1-FEB-2018', 'diesel','automatic',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','51 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 12.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju223fthya7', 'focus', 'black', 'ford ', 2020, '1-JAN-2020', 'gasoline','manual',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','61 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 10);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju223fthya8', 'model 3', 'RED', 'tesla ', 2019, '1-FEB-2019', 'electric','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','62 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 17.5);
EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju223fthya9', 'wrangler', 'white', 'jeep ', 2020, '1-APR-2020', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','63 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 20.5);

-----------------------------------------------------------------BOOKING----------------------------------------------------------------------------------------
-- 8th in insert
-- 14 bookings inserted
-- BOOK_1
-- ..
-- BOOK_14
-- BOOKING INSERTION
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_1','CAR_LISTING_1');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_2','CAR_LISTING_2');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_3','CAR_LISTING_3');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_4','CAR_LISTING_4');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_5','CAR_LISTING_5');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_6','CAR_LISTING_6');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_7','CAR_LISTING_7');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_8','CAR_LISTING_8');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_9','CAR_LISTING_9');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_10','CAR_LISTING_10');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_11','CAR_LISTING_11');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_12','CAR_LISTING_12');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_13','CAR_LISTING_13');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP),TO_TIMESTAMP(LOCALTIMESTAMP) + 1,'USER_14','CAR_LISTING_14');
EXECUTE PKG_BOOKING.INSERT_NEW_BOOKING(TO_TIMESTAMP(LOCALTIMESTAMP)+1,TO_TIMESTAMP(LOCALTIMESTAMP) + 2,'USER_15','CAR_LISTING_15');

-- BOOKING IN PROGRESS
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_1','USER_1');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_2','USER_2');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_3','USER_3');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_4','USER_4');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_5','USER_5');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_6','USER_6');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_7','USER_7');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_8','USER_8');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_9','USER_9');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_10','USER_10');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_11','USER_11');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_12','USER_12');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_13','USER_13');
EXECUTE PKG_BOOKING.BOOKING_IN_PROGRESS('BOOK_14','USER_14');

-- BOOKING COMPLETED
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_5','CAR_LISTING_5','COMMENT-1'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_6','CAR_LISTING_6','COMMENT-2'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_7','CAR_LISTING_7','COMMENT-3'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_8','CAR_LISTING_8','COMMENT-4'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_9','CAR_LISTING_9','COMMENT-5'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_10','CAR_LISTING_10','COMMENT-6'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_11','CAR_LISTING_11','COMMENT-7'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_12','CAR_LISTING_12','COMMENT-8');
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_13','CAR_LISTING_13','COMMENT-9'); 
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_14','CAR_LISTING_14','COMMENT-10');  
EXECUTE PKG_BOOKING.BOOKING_COMPLETED('BOOK_15','CAR_LISTING_15','COMMENT-11'); 

-- PAYMENT SUCCESS
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_SUCCESS('BOOK_10'); 
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_SUCCESS('BOOK_11'); 
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_SUCCESS('BOOK_12'); 
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_SUCCESS('BOOK_13');

-- PAYMENT FAILED
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_FAIL('BOOK_14'); 
EXECUTE PKG_BOOKING.BOOKING_PAYMENT_FAIL('BOOK_15');

-- BOOKING CANCELLED
EXECUTE PKG_BOOKING.BOOKING_CANCELLED('BOOK_12'); 
EXECUTE PKG_BOOKING.BOOKING_CANCELLED('BOOK_15');

-----------------------------------------------------------END---------------------------------------------------------------------------------------------------

-- need to end bookings and update transactions

-- insert new bookings for the same users

-- try to see reports

-- EXECUTE PCKG_CAR_LISTING_EXT.FILTER_LISTING('USER_16','13454',2,'SEDAN','1-JUN-2022 11:17:19.256000000 PM','2-JUN-22 8:17:19.256000000 PM');