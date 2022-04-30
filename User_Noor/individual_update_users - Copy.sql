SET SERVEROUTPUT ON;

CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_USERS_UPDATE  AS 
         
        PROCEDURE UPDATE_USERS_PHONE_NO(
        vEMAIL IN USERS.EMAIL%type,
        vPHONE_NO IN USERS.PHONE_NO%type
        );

     PROCEDURE UPDATE_USERS_PASSWORD(
        vEMAIL IN USERS.EMAIL%type,
        vPASSWORD IN USERS.PASSWORD%type
        );

     PROCEDURE UPDATE_USERS_BLACKLISTED(
        vEMAIL IN USERS.EMAIL%type,
        vBLACKLISTED IN USERS.BLACKLISTED%type
        );
        
     PROCEDURE UPDATE_USERS_FIRST_NAME(
        vEMAIL IN USERS.EMAIL%type,
        vFIRST_NAME IN USERS.FIRST_NAME%type
        );

         PROCEDURE UPDATE_USERS_LAST_NAME(
        vEMAIL IN USERS.EMAIL%type,
        vLAST_NAME IN USERS.LAST_NAME%type
        );
      
      PROCEDURE UPDATE_USERS_DRIVER_LICENSE(
        vEMAIL IN USERS.EMAIL%type,
        vDRIVER_LICENSE IN USERS.DRIVER_LICENSE%type
        );
        
       PROCEDURE UPDATE_USERS_PASSPORT(
        vEMAIL IN USERS.EMAIL%type,
        vPASSPORT IN USERS.PASSPORT%type
        );
        
        PROCEDURE UPDATE_USERS_USER_NAME(
        vEMAIL IN USERS.EMAIL%type,
        vUSER_NAME IN USERS.USER_NAME%type
        );
END PCKG_USERS_UPDATE;
/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_USERS_UPDATE  AS 
    
     PROCEDURE UPDATE_USERS_PHONE_NO(
     vEMAIL IN USERS.EMAIL%type, 
     vPHONE_NO IN USERS.PHONE_NO%type)
 
     is
    ex_INVALID_PHONE_NO  EXCEPTION;
    
    BEGIN
     if vPHONE_NO is NULL or LENGTH(trim(vPHONE_NO)) != 10 then 
            raise ex_INVALID_PHONE_NO;
        end if;

   UPDATE USERS SET PHONE_NO=vPHONE_NO WHERE EMAIL= vEMAIL;
        dbms_output.put_line(' Phone number UPDATED!!!');

      EXCEPTION
            when ex_INVALID_PHONE_NO then
                dbms_output.put_line('Phone number is invalid !!!');

    END UPDATE_USERS_PHONE_NO;

     PROCEDURE UPDATE_USERS_PASSWORD(
        vEMAIL IN USERS.EMAIL%type,
        vPASSWORD IN USERS.PASSWORD%type
        )
        IS
        ex_INVALID_PASSWORD EXCEPTION;
    BEGIN

        if vPASSWORD is NULL or LENGTH(TRIM(vPASSWORD)) < 5 then
            raise ex_INVALID_PASSWORD;
        end if;

        UPDATE USERS SET PASSWORD=vPASSWORD WHERE EMAIL= vEMAIL;
        dbms_output.put_line('PASSWORD UPDATED !!!');

      EXCEPTION
            when ex_INVALID_PASSWORD then
                dbms_output.put_line('Password is invalid !!!');

    END UPDATE_USERS_PASSWORD;

     PROCEDURE UPDATE_USERS_BLACKLISTED(
        vEMAIL IN USERS.EMAIL%type,
        vBLACKLISTED IN USERS.BLACKLISTED%type
        )
        IS
        
        INVALID_BLACKLISTED EXCEPTION;
    BEGIN
        IF vBLACKLISTED NOT IN ('TRUE','FALSE') OR LENGTH(TRIM(vBLACKLISTED)) is NULL THEN
        RAISE INVALID_BLACKLISTED;
         end if;
        
        UPDATE USERS SET BLACKLISTED=vBLACKLISTED WHERE EMAIL= vEMAIL;
        dbms_output.put_line('BLACKLISTED UPDATED!!!');
        
        COMMIT;
        EXCEPTION
              when INVALID_BLACKLISTED then
                dbms_output.put_line('invalid Entry!!!');

    END UPDATE_USERS_BLACKLISTED;
    
        
     PROCEDURE UPDATE_USERS_FIRST_NAME(
        vEMAIL IN USERS.EMAIL%type,
        vFIRST_NAME IN USERS.FIRST_NAME%type
        )
        IS
       ex_INVALID_FIRST_NAME EXCEPTION;
        
    BEGIN 
    
    if vFIRST_NAME is NULL or trim(vFIRST_NAME) is NULL then
            raise ex_INVALID_FIRST_NAME;
        end if;
    
      UPDATE USERS SET FIRST_NAME=UPPER(vFIRST_NAME) WHERE EMAIL= vEMAIL;
        dbms_output.put_line('FIRST NAME UPDATED!!');
        COMMIT;
    
    
      EXCEPTION
            when ex_INVALID_FIRST_NAME then
                dbms_output.put_line('FIRST NAME is invalid !!!');
                
    END UPDATE_USERS_FIRST_NAME;
    
         PROCEDURE UPDATE_USERS_LAST_NAME(
        vEMAIL IN USERS.EMAIL%type,
        vLAST_NAME IN USERS.LAST_NAME%type
        )
        IS
        ex_INVALID_LAST_NAME EXCEPTION;
        
    BEGIN
          
        if vLAST_NAME is NULL or trim(vLAST_NAME) is NULL then
            raise ex_INVALID_LAST_NAME;
        end if;
         
        
        UPDATE USERS SET LAST_NAME=UPPER(vLAST_NAME) WHERE EMAIL= vEMAIL;
        dbms_output.put_line('LAST NAME UPDATED !!!');
        COMMIT;

      EXCEPTION
            when ex_INVALID_LAST_NAME then
                dbms_output.put_line('Last Name is invalid !!!');
                
    END UPDATE_USERS_LAST_NAME;

     PROCEDURE UPDATE_USERS_PASSPORT(
        vEMAIL IN USERS.EMAIL%type,
        vPASSPORT IN USERS.PASSPORT%type
        )
        IS
        
        CHECK_PASSPORT_COUNT NUMBER(38);
        
        ex_INVALID_PASSPORT EXCEPTION;
        INVALID_PASSPORT EXCEPTION;
        
    BEGIN
          
        if vPASSPORT is NULL or LENGTH(trim(vPASSPORT)) < 6 then 
            raise ex_INVALID_PASSPORT;
        end if;
        
        SELECT COUNT(PASSPORT) INTO CHECK_PASSPORT_COUNT FROM USERS  WHERE PASSPORT = vPASSPORT;
          IF CHECK_PASSPORT_COUNT != 0 THEN 
          raise INVALID_PASSPORT;
               
            END IF; 
            
        UPDATE USERS SET PASSPORT=vPASSPORT WHERE EMAIL= vEMAIL;
        dbms_output.put_line('PASSPORT number UPDATED !!!');
        COMMIT;

      EXCEPTION
            when ex_INVALID_PASSPORT then
                dbms_output.put_line('PASSPORT NO invalid !!!');
            when INVALID_PASSPORT then
                dbms_output.put_line('PASSPORT NO already exist!!!');

    END UPDATE_USERS_PASSPORT;

     PROCEDURE UPDATE_USERS_DRIVER_LICENSE(
        vEMAIL IN USERS.EMAIL%type,
        vDRIVER_LICENSE IN USERS.DRIVER_LICENSE%type
        )
        IS
           CHECK_DRIVER_LICENSE_COUNT NUMBER(38);
           ex_INVALID_DRIVER_LICENSE EXCEPTION;
             INVALID_DRIVER_LICENSE EXCEPTION;
    BEGIN
          
       if vDRIVER_LICENSE is NULL or trim(vDRIVER_LICENSE) is NULL or LENGTH(TRIM(vDRIVER_LICENSE)) != 10 then
            raise ex_INVALID_DRIVER_LICENSE;
        end if;
         
          SELECT COUNT(DRIVER_LICENSE) INTO CHECK_DRIVER_LICENSE_COUNT FROM USERS  WHERE DRIVER_LICENSE = vDRIVER_LICENSE;
          IF CHECK_DRIVER_LICENSE_COUNT != 0 THEN 
           raise INVALID_DRIVER_LICENSE;
               
            END IF; 
         
        UPDATE USERS SET DRIVER_LICENSE=vDRIVER_LICENSE WHERE EMAIL= vEMAIL;
        dbms_output.put_line('DRIVER_LICENSE UPDATED !!!');
        COMMIT;

      EXCEPTION
            when ex_INVALID_DRIVER_LICENSE then
                dbms_output.put_line('DRIVER_LICENSE is invalid !!!');
                 when INVALID_DRIVER_LICENSE then
                  dbms_output.put_line('DRIVER LICENSE already exist!!!');
                
    END UPDATE_USERS_DRIVER_LICENSE;

    PROCEDURE UPDATE_USERS_USER_NAME(
        vEMAIL IN USERS.EMAIL%type,
        vUSER_NAME IN USERS.USER_NAME%type
        )
          IS
        ex_INVALID_USER_NAME EXCEPTION;
    BEGIN
        if vUSER_NAME is NULL or trim(vUSER_NAME) is NULL then
            raise ex_INVALID_USER_NAME;
        end if;

        UPDATE USERS SET USER_NAME=UPPER(vUSER_NAME) WHERE EMAIL= vEMAIL;
        dbms_output.put_line('USER_NAME UPDATED !!!');
        COMMIT;
      EXCEPTION
            when ex_INVALID_USER_NAME then
                dbms_output.put_line('USER_NAME is invalid !!!');
    END UPDATE_USERS_USER_NAME;
END PCKG_USERS_UPDATE;
/