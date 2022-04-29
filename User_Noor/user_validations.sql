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
        
        FUNCTION CHECK_EMAIL
        (vEMAIL IN USERS.EMAIL%type) 
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
        ex_INVALID_PHONE_NUMBER EXCEPTION;
        ex_INVALID_PASSPORT_NUM EXCEPTION;
        ex_INVALID_EMAIL EXCEPTION;
        ex_INVALID_PASSPORT_NUMBER EXCEPTION;

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

        if vPASSWORD is NULL or LENGTH(TRIM(vPASSWORD)) < 5 then
            raise ex_INVALID_PASSWORD;
        end if;

        if vDRIVER_LICENSE is NULL  or LENGTH(TRIM(vDRIVER_LICENSE)) != 10 then
            raise ex_INVALID_DRIVER_LICENSE;
        end if;
        
        if vADDRESS_ID is NULL or vADDRESS_ID = '' or CHECK_ADDRESS_ID(vADDRESS_ID) = 'NO' then
            raise ex_INVALID_ADDRESS_ID;
        end if;
        
        if vPHONE_NO is NULL or LENGTH(trim(vPHONE_NO)) != 10 then 
            raise ex_INVALID_PHONE_NUMBER;
        end if;
        
        if vPASSPORT is NULL or LENGTH(trim(vPASSPORT)) < 6 then 
            raise ex_INVALID_PASSPORT_NUM;
        end if;
        
        if vEMAIL is NULL or LENGTH(trim(vEMAIL)) = 0 then 
            raise ex_INVALID_EMAIL;
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
            when ex_INVALID_PHONE_NUMBER then 
                dbms_output.put_line('INVALID phone number!!!');
            when ex_INVALID_PASSPORT_NUMBER then 
                dbms_output.put_line('Either passport number is invalid or its smaller tan 5 !!!');
            when ex_INVALID_EMAIL then 
                dbms_output.put_line('Email is NULL or invalid !!!');
            when ex_INVALID_PASSPORT_NUM then 
                dbms_output.put_line('Passport is NULL or invalid !!!');  
    END INSERT_USER;
    
    PROCEDURE DELETE_USER(
        vEMAIL IN USERS.EMAIL%type
        ) AS     
        
        ex_DELETE_USER EXCEPTION; 
        ex_USER_EXIST_IN_BOOKING EXCEPTION;
        ex_USER_ID_IN_BOOKING_COUNT EXCEPTION;
        
        CHECK_EMAIL_COUNT NUMBER(38);
        USER_USER_ID_IN_BOOKING_COUNT NUMBER(38);
        USER_ID_VAL_FROM_USER_TBL VARCHAR2(500);
        USER_EXIST_IN_BOOKING_COUNT NUMBER(38);
        
    BEGIN
        
        BEGIN
        SELECT USER_ID INTO USER_ID_VAL_FROM_USER_TBL FROM USERS WHERE EMAIL = vEMAIL; 
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            USER_ID_VAL_FROM_USER_TBL := 0;
        END;
        
        IF USER_ID_VAL_FROM_USER_TBL is NOT NULL or  USER_ID_VAL_FROM_USER_TBL != '' then
        BEGIN
        SELECT COUNT(USER_ID) INTO USER_USER_ID_IN_BOOKING_COUNT FROM BOOKING WHERE USER_ID = USER_ID_VAL_FROM_USER_TBL; 
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            USER_USER_ID_IN_BOOKING_COUNT := 0;
        END;
        END IF;
    
        IF USER_USER_ID_IN_BOOKING_COUNT != 0 THEN 
             raise ex_USER_ID_IN_BOOKING_COUNT;
        END IF;
        
        IF CHECK_EMAIL_COUNT != 0 THEN 
        DELETE FROM USERS WHERE UPPER(EMAIL) = UPPER(vEMAIL);
        END IF; 
        
        IF CHECK_EMAIL_COUNT = 0 THEN 
            raise ex_DELETE_USER; 
        END IF; 
        EXCEPTION
            when ex_DELETE_USER then
                dbms_output.put_line('Sorry, USER does not exist !!!');
            when ex_USER_ID_IN_BOOKING_COUNT then 
                dbms_output.put_line('User exist in Booking table, cant delete !!!');
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
        ex_INVALID_EMAIL EXCEPTION;
        ex_INVALID_EMAIL_FOR_UPDATE EXCEPTION;
        
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

        if vPASSWORD is NULL or LENGTH(TRIM(vPASSWORD)) < 5 then
            raise ex_INVALID_PASSWORD;
        end if;

        if vDRIVER_LICENSE is NULL or trim(vDRIVER_LICENSE) is NULL then
            raise ex_INVALID_DL;
        end if;
        
        if vEMAIL is NULL or LENGTH(trim(vEMAIL)) = 0 then 
            raise ex_INVALID_EMAIL_FOR_UPDATE;
        end if;
        
        if CHECK_PASSPORT(vPASSPORT) = 'NO' AND  CHECK_DRIVER_LICENSE(vDRIVER_LICENSE) = 'NO' AND CHECK_EMAIL(vEMAIL) = 'NO' then 
        UPDATE USERS 
        SET PHONE_NO = vPHONE_NO, FIRST_NAME = vFIRST_NAME, LAST_NAME = vLAST_NAME, PASSWORD = vPASSWORD, DRIVER_LICENSE = vDRIVER_LICENSE, PASSPORT = vPASSPORT, BLACKLISTED = vBLACKLISTED
        WHERE UPPER(EMAIL) = UPPER(vEMAIL);
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
            when ex_INVALID_EMAIL_FOR_UPDATE then
                dbms_output.put_line('Email is null or invalid !!!');
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
                dbms_output.put_line('ADDRESS ID does not exist !!!');
                RETURN 'NO';
            END IF;    
        
        RETURN 'YES';
        END CHECK_ADDRESS_ID; 
        
        FUNCTION CHECK_EMAIL
        (vEMAIL IN USERS.EMAIL%type) 
        RETURN VARCHAR2 AS 
        
        CHECK_EMAIL_COUNT NUMBER(38);
        BEGIN
        
            BEGIN
            SELECT COUNT(EMAIL) INTO CHECK_EMAIL_COUNT FROM USERS WHERE EMAIL = vEMAIL;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CHECK_EMAIL_COUNT := 0;
            END;
            
            IF CHECK_EMAIL_COUNT = 0 THEN 
                RETURN 'NO';
           END IF;    
            
            IF CHECK_EMAIL_COUNT != 0 THEN 
                dbms_output.put_line('EMAIL ID ALREADY EXIST !!!');
            END IF; 
        
        RETURN 'YES';
        END CHECK_EMAIL; 
END PCKG_USERS;
/

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