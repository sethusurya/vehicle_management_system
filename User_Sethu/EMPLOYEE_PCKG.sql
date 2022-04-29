set serveroutput on;
CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_EMPLOYEE AS
     PROCEDURE INSERT_EMPLOYEE(
        vEMP_FIRST_NAME IN EMPLOYEE.EMP_FIRST_NAME%type,
        vEMP_LAST_NAME IN EMPLOYEE.EMP_LAST_NAME%type,
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type,
        vEMP_PASSWORD IN EMPLOYEE.EMP_PASSWORD%type,
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type,
        vROLE_ID IN ROLE.ROLE_ID%type
    );

    PROCEDURE REMOVE_EMPLOYEE(
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type
    );
END PCKG_EMPLOYEE;
/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_EMPLOYEE AS

    PROCEDURE INSERT_EMPLOYEE(
        vEMP_FIRST_NAME IN EMPLOYEE.EMP_FIRST_NAME%type,
        vEMP_LAST_NAME IN EMPLOYEE.EMP_LAST_NAME%type,
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type,
        vEMP_PASSWORD IN EMPLOYEE.EMP_PASSWORD%type,
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type,
        vROLE_ID IN ROLE.ROLE_ID%type) AS
        vCount NUMBER(5);
        vCount2 NUMBER(5);
        vCount3 NUMBER(5);
        ex_INVALID_FIRST_NAME EXCEPTION;
        ex_INVALID_LAST_NAME EXCEPTION;
        INVALID_EMAIL EXCEPTION;
        ex_INVALID_PASSWORD EXCEPTION;
        ex_INVALID_ADDRESS EXCEPTION;
        ex_INVALID_ROLE EXCEPTION;
        ex_EXISTS_ALREADY EXCEPTION;
        BEGIN

            if vEMP_FIRST_NAME is NULL or REGEXP_LIKE(TRIM(vEMP_FIRST_NAME) , '^[0-9]*$') is NULL then
                raise ex_INVALID_FIRST_NAME;
            end if;
            
            if vEMP_LAST_NAME is NULL or REGEXP_LIKE(TRIM(vEMP_LAST_NAME) , '^[0-9]*$') is NULL then
                raise ex_INVALID_LAST_NAME;
            end if;
            
            if vEMP_EMAIL is NULL or LENGTH(TRIM(vEMP_EMAIL)) is NULL or NOT (TRIM(vEMP_EMAIL)) LIKE '%@_%._%' then
                raise INVALID_EMAIL;
            end if;
            
            if vEMP_PASSWORD is NULL or LENGTH(TRIM(vEMP_PASSWORD)) is NULL then
                raise ex_INVALID_PASSWORD;
            end if;
            BEGIN
                SELECT count(*) INTO vCount FROM ADDRESS WHERE ADDRESS_TYPE='EMPLOYEE' and ADDRESS_ID= UPPER(TRIM(vADDRESS_ID));
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        vCount := 0;
            END;
            IF vCount < 1 THEN
                RAISE ex_INVALID_ADDRESS;
            END IF;
            BEGIN
                SELECT count(*) INTO vCount2 FROM ROLE WHERE ROLE_ID = UPPER(TRIM(vROLE_ID));
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        vCount2 := 0;
            END;
            IF vCount2 < 1 THEN
                RAISE ex_INVALID_ROLE;
            END IF;
            BEGIN
                SELECT count(*) INTO vCount3 FROM EMPLOYEE WHERE EMP_EMAIL = UPPER(TRIM(vEMP_EMAIL));
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        vCount3 := 0;
            END;
            IF vCount3 > 0 THEN
                RAISE ex_EXISTS_ALREADY;
            END IF;
            INSERT INTO EMPLOYEE(EMPLOYEE_ID, EMP_FIRST_NAME, EMP_LAST_NAME, EMP_EMAIL, EMP_PASSWORD, DATE_OF_JOINING, ADDRESS_ID, ROLE_ID)
            VALUES
            ('EMPLOYEE_'||EMPLOYEE_ID_SEQ.NEXTVAL, UPPER(TRIM(vEMP_FIRST_NAME)),UPPER(TRIM(vEMP_LAST_NAME)), UPPER(TRIM(vEMP_EMAIL)), vEMP_PASSWORD, SYSDATE, UPPER(TRIM(vADDRESS_ID)), UPPER(TRIM(vROLE_ID)));

        EXCEPTION
            when ex_INVALID_FIRST_NAME then
                dbms_output.put_line('First name is invalid !!!');
            when ex_INVALID_LAST_NAME then
                dbms_output.put_line('Last name is invalid !!!');
            when INVALID_EMAIL then
                dbms_output.put_line('Email is invalid !!!');
            when ex_INVALID_PASSWORD then
                dbms_output.put_line('password is invalid !!!');
            when ex_INVALID_ADDRESS then
                dbms_output.put_line('ADDRESS DOES NOT EXIST !!!');
            when ex_INVALID_ROLE THEN
                dbms_output.put_line('INVALID ROLE!!');
            when ex_EXISTS_ALREADY THEN
                dbms_output.put_line('EMPLOYEE WITH SAME EMAIL ALREADY EXISTS!!');
    END INSERT_EMPLOYEE;

    PROCEDURE REMOVE_EMPLOYEE(
            vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type
        ) AS
        vUSER_COUNT NUMBER(5);
        vREGISTRATIONS_COUNT NUMBER(5);
        vEMP_ID EMPLOYEE.EMPLOYEE_ID%type;
        ex_EMPLOYEE_DONT_EXIST EXCEPTION;
        ex_REGISTRATIONS_EXIST EXCEPTION;
        BEGIN
        -- check if there are any car_registrations, if car_registrations are zero then remove
        select count(*) INTO vUSER_COUNT from EMPLOYEE where EMP_EMAIL = UPPER(TRIM(vEMP_EMAIL));
        IF vUSER_COUNT = 0 THEN
            RAISE ex_EMPLOYEE_DONT_EXIST;
        END IF;
        SELECT EMPLOYEE_ID INTO vEMP_ID FROM EMPLOYEE WHERE EMP_EMAIL = UPPER(TRIM(vEMP_EMAIL));
        SELECT COUNT(*) INTO vREGISTRATIONS_COUNT FROM CAR_REGISTRATION WHERE EMPLOYEE_ID = vEMP_ID;
        IF vREGISTRATIONS_COUNT > 0 THEN
            RAISE ex_REGISTRATIONS_EXIST;
        END IF;
        -- DELETE ROW DATA FROM THE EMPLOYEE TABLE
        -- DROP USER vEMP_ID CASCADE;
        DELETE FROM EMPLOYEE WHERE UPPER(EMP_EMAIL) = UPPER(TRIM(vEMP_EMAIL));
    EXCEPTION
        WHEN ex_EMPLOYEE_DONT_EXIST THEN
            dbms_output.put_line('EMPLOYEE WITH EMAIL: '|| vEMP_EMAIL || ' DOES NOT EXIST!!!');
        WHEN ex_REGISTRATIONS_EXIST THEN
            dbms_output.put_line('CAR REGISTRATIONS EXIST FOR THE EMPLOYEE, PLEASE REMOVE THEM TO REMOVE EMPLOYEE!!!!');
    END REMOVE_EMPLOYEE;

END PCKG_EMPLOYEE;
/

-- EXECUTE PCKG_EMPLOYEE.INSERT_EMPLOYEE('SETHU', 'P', 'pagolu.s@northeastern.edu', 'sethu', 'ADDR_3', '1');
--EXECUTE PCKG_EMPLOYEE.REMOVE_EMPLOYEE('GILL.S@NORTHEASTERN.EDU');