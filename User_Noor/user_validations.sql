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
        PROCEDURE UPDATE_USER(
        vUSER_NAME IN USERS.USER_NAME%type,
        vEMAIL IN USERS.EMAIL%type, 
        vPHONE_NO IN USERS.PHONE_NO%type, 
        vFIRST_NAME IN USERS.FIRST_NAME%type, 
        vLAST_NAME IN USERS.LAST_NAME%type, 
        vPASSWORD IN USERS.PASSWORD%type,
        vDRIVER_LICENSE IN USERS.DRIVER_LICENSE%type,
        vPASSPORT IN USERS.PASSPORT%type,
        vBLACKLISTED IN USERS.BLACKLISTED%type
        );
        FUNCTION CHECK_DRIVER_LICENSE
        (vDRIVER_LICENSE IN USERS.DRIVER_LICENSE%type) 
        RETURN VARCHAR2; 
        
        FUNCTION CHECK_PASSPORT
        (vPASSPORT IN USERS.PASSPORT%type) 
        RETURN VARCHAR2;
        
        FUNCTION CHECK_ADDRESS_ID
        (vADDRESS_ID IN ADDRESS.ADDRESS_ID%type) 
        RETURN VARCHAR2;
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
        ex_INVALID_ADDRESS_ID EXCEPTION;

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

        if vPASSWORD is NULL or LENGTH(TRIM(vPASSWORD)) > 5 then
            raise ex_INVALID_PASSWORD;
        end if;

        if vDRIVER_LICENSE is NULL then
            raise ex_INVALID_DRIVER_LICENSE;
        end if;
        
        if vADDRESS_ID is NULL or vADDRESS_ID = '' or CHECK_ADDRESS_ID(vADDRESS_ID) = 'NO' then
            raise ex_INVALID_ADDRESS_ID;
        end if;

        IF CHECK_EMAIL_COUNT = 0 AND CHECK_USER_NAME_COUNT = 0 AND CHECK_DL_COUNT = 0 AND CHECK_PASSPORT_COUNT = 0 THEN 
        INSERT INTO USERS(USER_ID, PASSWORD, USER_NAME, EMAIL, PHONE_NO, FIRST_NAME, LAST_NAME, DATE_OF_JOINING, DRIVER_LICENSE, PASSPORT, BLACKLISTED, ADDRESS_ID)
        VALUES
        ('USER_' || USERS_ID_SEQ.NEXTVAL, vPASSWORD, UPPER(vUSER_NAME), LOWER(vEMAIL), vPHONE_NO, UPPER(vFIRST_NAME), UPPER(vLAST_NAME), SYSDATE, vDRIVER_LICENSE, UPPER(vPASSPORT), vBLACKLISTED, vADDRESS_ID);
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
            when ex_INVALID_ADDRESS_ID then
                dbms_output.put_line('INVALID ADDRESS ID NUMBER OR IT DOES NOT EXIST!!!');
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
    
    PROCEDURE UPDATE_USER(
        vUSER_NAME IN USERS.USER_NAME%type,
        vEMAIL IN USERS.EMAIL%type, 
        vPHONE_NO IN USERS.PHONE_NO%type, 
        vFIRST_NAME IN USERS.FIRST_NAME%type, 
        vLAST_NAME IN USERS.LAST_NAME%type, 
        vPASSWORD IN USERS.PASSWORD%type,
        vDRIVER_LICENSE IN USERS.DRIVER_LICENSE%type,
        vPASSPORT IN USERS.PASSPORT%type,
        vBLACKLISTED IN USERS.BLACKLISTED%type
        ) AS 
        
        ex_INVALID_FIRST_NAME EXCEPTION; 
        ex_INVALID_USER_NAME EXCEPTION;
        ex_INVALID_LAST_NAME EXCEPTION;
        ex_INVALID_PASSWORD EXCEPTION;
        ex_INVALID_DL EXCEPTION;
        ex_INVALID_ADDRESS_ID EXCEPTION;
        
        BEGIN 
        
        if vFIRST_NAME is NULL or trim(vFIRST_NAME) is NULL then
            raise ex_INVALID_FIRST_NAME;
        end if;

        if vUSER_NAME is NULL or trim(vUSER_NAME) is NULL then
            raise ex_INVALID_USER_NAME;
        end if;

        if vLAST_NAME is NULL or trim(vLAST_NAME) is NULL then
            raise ex_INVALID_LAST_NAME;
        end if;

        if vPASSWORD is NULL or LENGTH(TRIM(vPASSWORD)) < 5  or trim(vPASSWORD) is NULL then
            raise ex_INVALID_PASSWORD;
        end if;

        if vDRIVER_LICENSE is NULL or trim(vDRIVER_LICENSE) is NULL then
            raise ex_INVALID_DL;
        end if;
        
        if CHECK_PASSPORT(vPASSPORT) = 'NO' AND  CHECK_DRIVER_LICENSE(vDRIVER_LICENSE) = 'NO' then 
        UPDATE USERS 
        SET PHONE_NO = vPHONE_NO, FIRST_NAME = vFIRST_NAME, LAST_NAME = vLAST_NAME, PASSWORD = vPASSWORD, DRIVER_LICENSE = vDRIVER_LICENSE, PASSPORT = vPASSPORT, BLACKLISTED = vBLACKLISTED
        WHERE EMAIL = vEMAIL;
        end if;
        
        EXCEPTION
            when ex_INVALID_FIRST_NAME then
                dbms_output.put_line('First name is invalid !!!');
            when ex_INVALID_LAST_NAME then
                dbms_output.put_line('LAST name is invalid !!!');
            when ex_INVALID_USER_NAME then
                dbms_output.put_line('USER name is invalid !!!');
            when ex_INVALID_PASSWORD then
                dbms_output.put_line('Password should be greater than 5 and should not be null !!!');
            when ex_INVALID_DL then
                dbms_output.put_line('DRIVER LICENSE number already exist !!!');
        END UPDATE_USER;
        
        FUNCTION CHECK_DRIVER_LICENSE
        (vDRIVER_LICENSE IN USERS.DRIVER_LICENSE%type) 
        RETURN VARCHAR2 AS 
        
        CHECK_DRIVER_LICENSE_COUNT NUMBER(38);
        BEGIN
        
            BEGIN
            SELECT COUNT(DRIVER_LICENSE) INTO CHECK_DRIVER_LICENSE_COUNT FROM USERS  WHERE DRIVER_LICENSE = vDRIVER_LICENSE;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CHECK_DRIVER_LICENSE_COUNT := 0;
            END;
            
            IF CHECK_DRIVER_LICENSE_COUNT = 0 THEN 
                RETURN 'NO';
            END IF; 
            
            IF CHECK_DRIVER_LICENSE_COUNT != 0 THEN 
                dbms_output.put_line('DRIVER LICENSE already exist!!!');
            END IF; 
        
        RETURN 'YES';
        END CHECK_DRIVER_LICENSE; 
        
        FUNCTION CHECK_PASSPORT
        (vPASSPORT IN USERS.PASSPORT%type) 
        RETURN VARCHAR2 AS 
        
        CHECK_PASSPORT_COUNT NUMBER(38);
        BEGIN
            BEGIN
            SELECT COUNT(PASSPORT) INTO CHECK_PASSPORT_COUNT FROM USERS  WHERE PASSPORT = vPASSPORT;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CHECK_PASSPORT_COUNT := 0;
            END;
            
            IF CHECK_PASSPORT_COUNT = 0 THEN 
                RETURN 'NO';
            END IF; 
            
            IF CHECK_PASSPORT_COUNT != 0 THEN 
                dbms_output.put_line('PASSPORT already exist!!!');
            END IF; 
        
        RETURN 'YES';
        END CHECK_PASSPORT; 
        
        FUNCTION CHECK_ADDRESS_ID
        (vADDRESS_ID IN ADDRESS.ADDRESS_ID%type) 
        RETURN VARCHAR2 AS 
        
        CHECK_ADDRESS_ID NUMBER(38);
        BEGIN
        
            BEGIN
            SELECT COUNT(ADDRESS_ID) INTO CHECK_ADDRESS_ID FROM ADDRESS  WHERE ADDRESS_ID = vADDRESS_ID;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CHECK_ADDRESS_ID := 0;
            END;
            
            IF CHECK_ADDRESS_ID = 0 THEN 
                RETURN 'NO';
            END IF;    
            
            IF CHECK_ADDRESS_ID != 0 THEN 
                dbms_output.put_line('ADDRESS ID does not exist !!!');
            END IF; 
        
        RETURN 'YES';
        END CHECK_ADDRESS_ID; 
END PCKG_USERS;
/



EXECUTE PCKG_USERS.INSERT_USER('Sethu', 'sethu@gmail.com', '8573337398', 'Sethu', 'Pao', '12345', '3333333','CCV777', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Noordeep', 'noordeep@gmail.com', '8574151025', 'Noor', 'Gill', '54321', '9876543','ABFG21', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Yash', 'yash@gmail.com', '8574151111', 'Yash', 'Jain', '85247', '7412589','INJG21', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Deep', 'deep@gmail.com', '8572220011', 'Deep', 'Vaidya', '96324', '8521475','IN2221', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Sai', 'sai@gmail.com', '8573330441', 'Sai', 'Kumar', '85412', '987523','IN3030', 'TRUE', 'ADDR_2');

EXECUTE PCKG_USERS.INSERT_USER('Sethu', 'sethu@gmail.com', '8573337398', 'Sethu', 'Pao', '12345', '3333333','CCV777', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Noordeep', 'noordeep@gmail.com', '8574151025', 'Noor', 'Gill', '54321', '9876543','ABFG21', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Yash', 'yash@gmail.com', '8574151111', 'Yash', 'Jain', '85247', '7412589','INJG21', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Deep', 'deep@gmail.com', '8572220011', 'Deep', 'Vaidya', '96324', '8521475','IN2221', 'TRUE', 'ADDR_2');
EXECUTE PCKG_USERS.INSERT_USER('Sai', 'sai@gmail.com', '8573330441', 'Sai', 'Kumar', '85412', '987523','IN3030', 'TRUE', 'ADDR_2');

--EXECUTE PCKG_USERS.DELETE_USER('sai@gmail.COM');
EXECUTE PCKG_USERS.DELETE_USER('sethu@GMAIL.COM');
EXECUTE PCKG_USERS.DELETE_USER('noordeep@gmail.COM');
EXECUTE PCKG_USERS.DELETE_USER('yash@gmail.COM');
EXECUTE PCKG_USERS.DELETE_USER('deep@gmail.COM');
EXECUTE PCKG_USERS.DELETE_USER('sai@gmail.COM');
SELECT * FROM USERS;

--SELECT * FROM ADDRESS;
EXECUTE PCKG_USERS.UPDATE_USER('Deepu', 'yash@gmail.com', '2587412569', 'Yash kumar', 'Shah', 'TTT223', '7344489', 'ILGXX1', 'TRUE');
EXECUTE PCKG_USERS.UPDATE_USER('Vivek', 'yohesh@gmail.com', '2587412569', 'Vivek kumar', 'lala', 'TT8823', '2124489', 'IGGXX1', 'TRUE');