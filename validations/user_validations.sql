CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_USERS  AS 
    PROCEDURE INSERT_USER(
        vUSER_NAME IN USERS.USER_NAME%type,
        vEMAIL IN USERS.EMAIL%type, 
        vPHONE_NO IN USERS.PHONE_NO%type, 
        vFIRST_NAME IN USERS.FIRST_NAME%type, 
        vLAST_NAME IN USERS.LAST_NAME%type, 
        vPASSWORD IN USERS.PASSWORD%type,
        vDRIVER_LICENSE IN USERS.DRIVER_LICENSE%type,
        vPASSPORT IN USERS.PASSPORT%type,
        vBLACKLISTED IN USERS.BLACKLISTED%type,
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type
        ); 
        PROCEDURE DELETE_USER(
        vEMAIL IN USERS.EMAIL%type
        );
END PCKG_USERS;
/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_USERS  AS 
    PROCEDURE INSERT_USER(
        vUSER_NAME IN USERS.USER_NAME%type,
        vEMAIL IN USERS.EMAIL%type, 
        vPHONE_NO IN USERS.PHONE_NO%type, 
        vFIRST_NAME IN USERS.FIRST_NAME%type, 
        vLAST_NAME IN USERS.LAST_NAME%type, 
        vPASSWORD IN USERS.PASSWORD%type,
        vDRIVER_LICENSE IN USERS.DRIVER_LICENSE%type,
        vPASSPORT IN USERS.PASSPORT%type,
        vBLACKLISTED IN USERS.BLACKLISTED%type,
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type
        ) AS     
        
        ex_INVALID_FIRST_NAME EXCEPTION; 
        ex_INVALID_USER_NAME EXCEPTION;
        ex_INVALID_LAST_NAME EXCEPTION;
        ex_INVALID_PASSWORD EXCEPTION;
        ex_INVALID_DRIVER_LICENSE EXCEPTION;

        CHECK_ADDRESS_COUNT NUMBER(38);
        CHECK_EMAIL_COUNT NUMBER(38);
        CHECK_USER_NAME_COUNT NUMBER(38);
        CHECK_DL_COUNT NUMBER(38);
        CHECK_PASSPORT_COUNT NUMBER(38);
    BEGIN

        BEGIN
        SELECT COUNT(EMAIL) INTO CHECK_EMAIL_COUNT FROM USERS WHERE EMAIL = vEMAIL; 
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CHECK_EMAIL_COUNT := 0;
        END;

        BEGIN
        SELECT COUNT(USER_NAME) INTO CHECK_USER_NAME_COUNT FROM USERS WHERE USER_NAME = vUSER_NAME; 
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CHECK_USER_NAME_COUNT := 0;
        END;

        BEGIN
        SELECT COUNT(DRIVER_LICENSE) INTO CHECK_DL_COUNT FROM USERS WHERE DRIVER_LICENSE = vDRIVER_LICENSE; 
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CHECK_DL_COUNT := 0;
        END;

        BEGIN
        SELECT COUNT(PASSPORT) INTO CHECK_PASSPORT_COUNT FROM USERS WHERE PASSPORT = vPASSPORT; 
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CHECK_PASSPORT_COUNT := 0;
        END;

        if vFIRST_NAME is NULL or REGEXP_LIKE(TRIM(vFIRST_NAME) , '^[0-9]*$') is NULL then
            raise ex_INVALID_FIRST_NAME;
        end if;

        if vUSER_NAME is NULL or REGEXP_LIKE(TRIM(vUSER_NAME) , '^[0-9]*$') is NULL then
            raise ex_INVALID_USER_NAME;
        end if;

        if vLAST_NAME is NULL or REGEXP_LIKE(TRIM(vLAST_NAME) , '^[0-9]*$') is NULL then
            raise ex_INVALID_LAST_NAME;
        end if;

        if vPASSWORD is NULL or REGEXP_LIKE(TRIM(vPASSWORD) , '^[0-9]*$') is NULL  or LENGTH(TRIM(vPASSWORD)) > 5 then
            raise ex_INVALID_PASSWORD;
        end if;

        if vDRIVER_LICENSE is NULL then
            raise ex_INVALID_DRIVER_LICENSE;
        end if;

        IF CHECK_EMAIL_COUNT = 0 AND CHECK_USER_NAME_COUNT = 0 AND CHECK_DL_COUNT = 0 AND CHECK_PASSPORT_COUNT = 0 THEN 
        INSERT INTO USERS(USER_ID, PASSWORD, USER_NAME, EMAIL, PHONE_NO, FIRST_NAME, LAST_NAME, DATE_OF_JOINING, DRIVER_LICENSE, PASSPORT, BLACKLISTED, ADDRESS_ID)
        VALUES
        ('USER_' || USERS_ID_SEQ.NEXTVAL, vPASSWORD, vUSER_NAME, vEMAIL, vPHONE_NO, vFIRST_NAME, vLAST_NAME, SYSDATE, vDRIVER_LICENSE, UPPER(vPASSPORT), vBLACKLISTED, vADDRESS_ID);
        END IF;

        EXCEPTION
            when ex_INVALID_FIRST_NAME then
                dbms_output.put_line('First name is invalid !!!');
            when ex_INVALID_LAST_NAME then
                dbms_output.put_line('LAST name is invalid !!!');
            when ex_INVALID_USER_NAME then
                dbms_output.put_line('USER name is invalid !!!');
            when ex_INVALID_PASSWORD then
                dbms_output.put_line('Password should be greater than 5 and should not be null !!!');
            when ex_INVALID_DRIVER_LICENSE then
                dbms_output.put_line('INVALID DRIVER LICENSE NUMBER!!!');
    END INSERT_USER;
    
    PROCEDURE DELETE_USER(
        vEMAIL IN USERS.EMAIL%type
        ) AS     
        
        ex_DELETE_USER EXCEPTION; 
        CHECK_EMAIL_COUNT NUMBER(38);
    BEGIN
        
        BEGIN
        SELECT COUNT(EMAIL) INTO CHECK_EMAIL_COUNT FROM USERS WHERE EMAIL = vEMAIL; 
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CHECK_EMAIL_COUNT := 0;
        END;
        
        IF CHECK_EMAIL_COUNT != 0 THEN 
        DELETE FROM USERS WHERE EMAIL = vEMAIL;
        END IF; 
        
        IF CHECK_EMAIL_COUNT = 0 THEN 
            raise ex_DELETE_USER; 
        END IF; 
        EXCEPTION
            when ex_DELETE_USER then
                dbms_output.put_line('Sorry, USER does not exist !!!');
    END DELETE_USER;
END PCKG_USERS;
/

--EXECUTE PCKG_USERS.INSERT_USER('Sethu', 'sethu@GMAIL.COM', '8573337398', 'Sethu', 'pa', '12345', '3333333','CCV777', 'TRUE', 'ADDR_2');
--EXECUTE PCKG_USERS.DELETE_USER('yash001@gmail.com');
--SELECT * FROM USERS;
--SELECT * FROM ADDRESS;