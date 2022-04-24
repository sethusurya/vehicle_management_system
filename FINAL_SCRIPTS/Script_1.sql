

set serveroutput on;

DECLARE 
    user_name_to_create VARCHAR2(100);
BEGIN
        dbms_output.put_line('>>> Creating user using Procedure');
         user_name_to_create:='vms_test';
        EXECUTE IMMEDIATE 'create user ' || user_name_to_create || ' identified by VMStest001';
        dbms_output.put_line('>>> Allowing user to login');
        EXECUTE IMMEDIATE 'grant connect to ' || user_name_to_create ;
        dbms_output.put_line('>>> Allowing user to create a session and do ad-hoc');
        EXECUTE IMMEDIATE 'grant create session to ' || user_name_to_create;
        dbms_output.put_line('>>> Allowing user to create procedures');
        EXECUTE IMMEDIATE 'grant create procedure to ' || user_name_to_create;
        dbms_output.put_line('>>> Allowing user to create views');
        EXECUTE IMMEDIATE 'grant create view to ' || user_name_to_create ;
        dbms_output.put_line('>>> Allowing user to access resources');
        EXECUTE IMMEDIATE 'grant resource to ' || user_name_to_create;
        dbms_output.put_line('>>> Allowing user to do select');
        EXECUTE IMMEDIATE 'grant select any table to ' || user_name_to_create;
        dbms_output.put_line('>>> Allowing user to create directory');
        EXECUTE IMMEDIATE 'grant create any directory, drop any directory to ' || user_name_to_create;
        dbms_output.put_line('>>> Granting access to crypto package');
--        EXECUTE IMMEDIATE 'grant execute on sys.dbms_crypto to ' || user_name_to_create;
--        dbms_output.put_line('>>> Granting access to Random package');
--        EXECUTE IMMEDIATE 'grant execute on sys.dbms_random to ' || user_name_to_create;
--        dbms_output.put_line('>>> Granting tablespace to USER');
        EXECUTE IMMEDIATE 'GRANT UNLIMITED TABLESPACE to ' || user_name_to_create;
        dbms_output.put_line('>>> Allowing user to insert and update account table');
--        EXECUTE IMMEDIATE 'GRANT INSERT ON "ADMIN"."ACCOUNT" TO ' || user_name_to_create || ' WITH GRANT OPTION' ;
--        EXECUTE IMMEDIATE 'GRANT UPDATE ON "ADMIN"."ACCOUNT" TO ' || user_name_to_create || ' WITH GRANT OPTION' ;
--        EXECUTE IMMEDIATE 'GRANT REFERENCES ON "ADMIN"."ACCOUNT" TO ' || user_name_to_create || ' WITH GRANT OPTION' ;
--        EXECUTE IMMEDIATE 'GRANT SELECT ON "ADMIN"."ACCOUNT" TO ' || user_name_to_create || ' WITH GRANT OPTION' ;
        
EXCEPTION
        WHEN OTHERS THEN
                dbms_output.put_line(SQLERRM);
            IF SQLCODE = -1920 THEN --"table not found" exception
                dbms_output.put_line('*** User already exists. Please create a new user');
            END IF;
    dbms_output.put_line('>>> Executuion of procedure is Done to create a new user');
END;
/

--grant execute on sys.dbms_crypto to TEST_USER_1;
--grant execute on sys.dbms_random to TEST_USER_1;


--select user from dual;
