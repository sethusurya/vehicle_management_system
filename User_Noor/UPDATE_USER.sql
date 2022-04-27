/* IF NO THEN INSERT */
CREATE OR REPLACE FUNCTION CHECK_DRIVER_LICENSE
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
    
        RETURN 'YES';
        END CHECK_DRIVER_LICENSE; 
        
--SELECT * FROM USERS;
--SELECT CHECK_DRIVER_LICENSE(9876543) FROM DUAL; 

CREATE OR REPLACE PROCEDURE UPDATE_USER(
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
        ex_INVALID_DRIVER_LICENSE EXCEPTION;
        ex_INVALID_ADDRESS_ID EXCEPTION;
        
        BEGIN 
        
        if vFIRST_NAME is NULL then
            raise ex_INVALID_FIRST_NAME;
        end if;

        if vUSER_NAME is NULL then
            raise ex_INVALID_USER_NAME;
        end if;

        if vLAST_NAME is NULL then
            raise ex_INVALID_LAST_NAME;
        end if;

        if vPASSWORD is NULL or LENGTH(TRIM(vPASSWORD)) < 5 then
            raise ex_INVALID_PASSWORD;
        end if;

        if vDRIVER_LICENSE is NULL then
            raise ex_INVALID_DRIVER_LICENSE;
        end if;
        
        UPDATE USERS 
        SET PHONE_NO = vPHONE_NO, FIRST_NAME = vFIRST_NAME, LAST_NAME = vLAST_NAME, PASSWORD = vPASSWORD, DRIVER_LICENSE = vDRIVER_LICENSE, PASSPORT = vPASSPORT, BLACKLISTED = vBLACKLISTED
        WHERE EMAIL = vEMAIL;
        
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
END UPDATE_USER; 
/ 

EXECUTE UPDATE_USER('YASH', 'yash@gmail.com', '8574151111', 'YASH', 'JAIN', 'XYZF31', '7412589', 'INJG21', 'FALSE');