
SELECT USER FROM DUAL;

--------------------------------------
--          ROLES
--------------------------------------
    CREATE ROLE DEVELOPER;
    CREATE ROLE TESTER;
    CREATE ROLE ANALYST;
    CREATE ROLE SERVICE;
    CREATE ROLE SECURITY;

---------------------------------------
---         DEVELOPER
---------------------------------------
    GRANT CONNECT, CREATE SESSION TO DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.ADDRESS to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.BOOKING to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.CAR_CATEGORY to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.CAR_LISTING to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.CAR_REGISTRATION to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.CITY to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.COUNTRY to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.EMPLOYEE to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.PARKING to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.STATE to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.TRANSACTION to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.USERS to DEVELOPER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.ROLE to DEVELOPER;

    GRANT ALL ON vms_employee.PCKG_CAR_CATEGORY TO DEVELOPER;
    GRANT ALL ON vms_employee.PCKG_CAR_LISTING TO DEVELOPER;
    GRANT ALL ON vms_employee.PCKG_CITY TO DEVELOPER;
    GRANT ALL ON vms_employee.PCKG_COUNTRY TO DEVELOPER;
    GRANT ALL ON vms_employee.PCKG_EMPLOYEE TO DEVELOPER; 
    GRANT ALL ON vms_employee.PCKG_PARKING TO DEVELOPER;
    GRANT ALL ON vms_employee.PCKG_PARKING_EXT TO DEVELOPER;
    GRANT ALL ON vms_employee.PCKG_STATE TO DEVELOPER;
    GRANT ALL ON vms_employee.PCKG_USERS TO DEVELOPER;
    GRANT ALL ON vms_employee.PKG_ADDRESS TO DEVELOPER;
    GRANT ALL ON vms_employee.PKG_BOOKING TO DEVELOPER;
    GRANT ALL ON vms_employee.PKG_CAR_REGISTER TO DEVELOPER;
    GRANT ALL ON vms_employee.PKG_TRANSACTION TO DEVELOPER;
    GRANT ALL ON vms_employee.PCKG_ROLE TO DEVELOPER;

    GRANT ALL ON vms_employee.Analyst_View TO DEVELOPER;
    GRANT ALL ON vms_employee.Audit_View TO DEVELOPER;
    GRANT ALL ON vms_employee.Payment_View TO DEVELOPER;
    GRANT ALL ON vms_employee.Support_View TO DEVELOPER;

---------------------------------------
---         TESTER
---------------------------------------
    GRANT CONNECT, CREATE SESSION TO TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.ADDRESS to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.BOOKING to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.CAR_CATEGORY to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.CAR_LISTING to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.CAR_REGISTRATION to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.CITY to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.COUNTRY to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.EMPLOYEE to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.PARKING to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.STATE to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.TRANSACTION to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.USERS to TESTER;
    GRANT INSERT, UPDATE, DELETE, SELECT ON vms_employee.ROLE to TESTER;

    GRANT ALL ON vms_employee.PCKG_CAR_CATEGORY TO TESTER;
    GRANT ALL ON vms_employee.PCKG_CAR_LISTING TO TESTER;
    GRANT ALL ON vms_employee.PCKG_CITY TO TESTER;
    GRANT ALL ON vms_employee.PCKG_COUNTRY TO TESTER;
    GRANT ALL ON vms_employee.PCKG_EMPLOYEE TO TESTER; 
    GRANT ALL ON vms_employee.PCKG_PARKING TO TESTER;
    GRANT ALL ON vms_employee.PCKG_PARKING_EXT TO TESTER;
    GRANT ALL ON vms_employee.PCKG_STATE TO TESTER;
    GRANT ALL ON vms_employee.PCKG_USERS TO TESTER;
    GRANT ALL ON vms_employee.PKG_ADDRESS TO TESTER;
    GRANT ALL ON vms_employee.PKG_BOOKING TO TESTER;
    GRANT ALL ON vms_employee.PKG_CAR_REGISTER TO TESTER;
    GRANT ALL ON vms_employee.PKG_TRANSACTION TO TESTER;
    GRANT ALL ON vms_employee.PCKG_ROLE TO TESTER;


    GRANT ALL ON vms_employee.Analyst_View TO TESTER;
    GRANT ALL ON vms_employee.Audit_View TO TESTER;
    GRANT ALL ON vms_employee.Payment_View TO TESTER;
    GRANT ALL ON vms_employee.Support_View TO TESTER;
---------------------------------------
---  ANALYST 
---------------------------------------
    GRANT  CONNECT, CREATE SESSION to ANALYST;
    GRANT ALL ON vms_employee.Analyst_View TO TESTER;

---------------------------------------
---         SERVICE
---------------------------------------
    GRANT CONNECT, CREATE SESSION to SERVICE;
    GRANT ALL ON vms_employee.PCKG_CAR_CATEGORY TO SERVICE;
    GRANT ALL ON vms_employee.PCKG_CAR_LISTING TO SERVICE;
    GRANT ALL ON vms_employee.PCKG_CITY TO SERVICE;
    GRANT ALL ON vms_employee.PCKG_COUNTRY TO SERVICE;
    GRANT ALL ON vms_employee.PCKG_EMPLOYEE TO SERVICE; 
    GRANT ALL ON vms_employee.PCKG_PARKING TO SERVICE;
    GRANT ALL ON vms_employee.PCKG_PARKING_EXT TO SERVICE;
    GRANT ALL ON vms_employee.PCKG_STATE TO SERVICE;
    GRANT ALL ON vms_employee.PCKG_USERS TO SERVICE;
    GRANT ALL ON vms_employee.PKG_ADDRESS TO SERVICE;
    GRANT ALL ON vms_employee.PKG_BOOKING TO SERVICE;
    GRANT ALL ON vms_employee.PKG_CAR_REGISTER TO SERVICE;
    GRANT ALL ON vms_employee.PKG_TRANSACTION TO SERVICE;

---------------------------------------
---  SECURITY
---------------------------------------
    GRANT CONNECT, CREATE SESSION to SECURITY;
    GRANT ALL ON vms_employee.Audit_View TO SECURITY;
    
----------------------------------------
--              USERS
----------------------------------------
  
    --DEVELOPER
    CREATE USER DEEP IDENTIFIED BY Root1234567890;
    --TESTER
    CREATE USER SETHU IDENTIFIED BY Root1234567890;
    --ANALYST
    CREATE USER NOOR IDENTIFIED BY Root1234567890;
    --SERVICE
    CREATE USER SAI IDENTIFIED BY Root1234567890;
    --AUDIT
    CREATE USER YASH IDENTIFIED BY Root1234567890;



-----------------------------------------
-- ######################################
-----------------------------------------

-----------------------------------------
-- ROLES - USERS
-----------------------------------------

    GRANT DEVELOPER TO DEEP;
    GRANT TESTER TO SETHU;
    GRANT ANALYST TO NOOR;
    GRANT SERVICE TO SAI;
    GRANT SECURITY TO YASH;

-----------------------------------------

    -- SELECT * FROM session_roles;
    
    -- SELECT * FROM user_role_privs;
    -- SELECT * FROM role_sys_privs where ROLE IN ('APP_OWNER','DEVELOPER','TESTER','ANALYST','SERVICE','SECURITY');
    -- SELECT * FROM role_tab_privs where ROLE IN ('APP_OWNER','DEVELOPER','TESTER','ANALYST','SERVICE','SECURITY');
    
    -- select * from ALL_TABLES where OWNER = 'ADMIN';
    -- select * from DBA_ROLE_PRIVS where grantee = 'ADMIN';
    
    -- SELECT * FROM dba_role_privs where GRANTED_ROLE IN ('ADMIN', 'APP_OWNER', 'DEVELOPER', 'TESTER', 'ANALYST', 'SERVICE', 'SECURITY');
