------------------------------------------------------------DECLARATIONS------------------------------------------------------------------
-------------------country------------------------------
CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_COUNTRY   AS 
      FUNCTION CHECK_COUNTRY_EXISTS(
      vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type 
      ) RETURN VARCHAR2;
       
       PROCEDURE INSERT_COUNTRY(
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type
        );
END PCKG_COUNTRY;
/

---------------------state------------------------------
CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_STATE  AS 
      FUNCTION STATE_CHECK(
        vSTATE_NAME IN STATE.STATE_NAME%type
       ) RETURN VARCHAR2;
       
       PROCEDURE INSERT_STATE(
        vSTATE_NAME IN STATE.STATE_NAME%type, 
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type
        );
END PCKG_STATE;
/

------------------------city-----------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_CITY  AS 
      FUNCTION CITY_CHECK(
        vCITY_NAME IN CITY.CITY_NAME%type
       ) RETURN VARCHAR2;
       
       PROCEDURE INSERT_CITY(
        vCITY_NAME IN CITY.CITY_NAME%type, 
        vSTATE_NAME IN STATE.STATE_NAME%type
        );
END PCKG_CITY;
/

-----------------------address----------------------------

create or replace PACKAGE PKG_ADDRESS   AS 
    
    FUNCTION ADDRESS_VALIDATION(
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vADDRESS_TYPE IN ADDRESS.ADDRESS_TYPE%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_NAME IN CITY.CITY_NAME%TYPE,
        vSTATE_NAME IN STATE.STATE_NAME%TYPE,
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%TYPE
    ) RETURN VARCHAR2;

    PROCEDURE INSERT_ADDRESS(
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_NAME IN CITY.CITY_NAME%TYPE,
        vSTATE_NAME IN STATE.STATE_NAME%TYPE,
        vADDRESS_TYPE IN ADDRESS.ADDRESS_TYPE%type,
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%TYPE 
    );

    PROCEDURE UPDATE_ADDRESS(
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type,
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_NAME IN CITY.CITY_NAME%TYPE,
        vSTATE_NAME IN STATE.STATE_NAME%TYPE,
        vADDRESS_TYPE IN ADDRESS.ADDRESS_TYPE%type,
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%TYPE 
    );

END PKG_ADDRESS;
/

-----------------------role--------------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_ROLE  AS 
    PROCEDURE INSERT_ROLE(
        vROLE_NAME IN ROLE.ROLE_NAME%type
        );
END PCKG_ROLE;
/

---------------------employee--------------------------------

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

    PROCEDURE UPDATE_EMPLOYEE(
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type,
        vEMP_FIRST_NAME IN EMPLOYEE.EMP_FIRST_NAME%type,
        vEMP_LAST_NAME IN EMPLOYEE.EMP_LAST_NAME%type
    );
END PCKG_EMPLOYEE;
/

---------------------car_category-----------------------------
CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_CAR_CATEGORY   AS
    FUNCTION PROCESS_CAR_CATEGORY(
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type
    ) RETURN VARCHAR2;

    PROCEDURE INSERT_CAR_CATEGORY(
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type  
    );
    
    PROCEDURE UPDATE_CAR_CATEGORY(
        vCAR_CATEGORY_ID IN CAR_CATEGORY.CAR_CATEGORY_ID%type,
        newCATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type
    );
    
    PROCEDURE CHECK_AND_RETURN_ID(
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type,
        OUT_CATEGORY_ID OUT CAR_CATEGORY.CAR_CATEGORY_ID%type
    );

    PROCEDURE DELETE_CATEGORY_BY_NAME(
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type
    );
    
END PCKG_CAR_CATEGORY;
/

--------------------------parking-----------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_PARKING AS

    PROCEDURE INSERT_PARKING(
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type);

END PCKG_PARKING;
/


-------------------------parking-ext-----------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_PARKING_EXT AS

    PROCEDURE INSERT_PARKING_EXT(
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_NAME IN CITY.CITY_NAME%TYPE,
        vSTATE_NAME IN STATE.STATE_NAME%TYPE,
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%TYPE);

END PCKG_PARKING_EXT;
/
------------------------car_registration----------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE PKG_CAR_REGISTER   AS 
    PROCEDURE BODY_CAR_REGISTER_DATA(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type,
        vCAR_NAME IN CAR_REGISTRATION.CAR_NAME%type, 
        vCAR_COLOR IN CAR_REGISTRATION.CAR_COLOR%type,
        vCAR_COMPANY IN CAR_REGISTRATION.CAR_COMPANY%type,
        vYEAR_OF_MANUFACTURE IN NUMBER,
        vREGISTRATION_DATE IN CAR_REGISTRATION.REGISTRATION_DATE%type,
        vFUEL_TYPE IN CAR_REGISTRATION.FUEL_TYPE%type,
        vTRANSMISSION_TYPE IN CAR_REGISTRATION.TRANSMISSION_TYPE%type,
        vNO_OF_SEATS IN NUMBER,
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type,
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type,
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_NAME IN CITY.CITY_NAME%TYPE,
        vSTATE_NAME IN STATE.STATE_NAME%TYPE,
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%TYPE,
        vFEE_RATE IN CAR_LISTING.FEE_RATE%type
    ); 
    PROCEDURE BODY_CAR_REGISTER( 
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type,
        vCAR_NAME IN CAR_REGISTRATION.CAR_NAME%type, 
        vCAR_COLOR IN CAR_REGISTRATION.CAR_COLOR%type,
        vCAR_COMPANY IN CAR_REGISTRATION.CAR_COMPANY%type,
        vYEAR_OF_MANUFACTURE IN NUMBER,
        vREGISTRATION_DATE IN CAR_REGISTRATION.REGISTRATION_DATE%type,
        vFUEL_TYPE IN CAR_REGISTRATION.FUEL_TYPE%type,
        vTRANSMISSION_TYPE IN CAR_REGISTRATION.TRANSMISSION_TYPE%type,
        vNO_OF_SEATS IN NUMBER,
        vCAR_CATEGORY_ID IN CAR_REGISTRATION.CAR_CATEGORY_ID%type,
        vEMPLOYEE_ID IN CAR_REGISTRATION.EMPLOYEE_ID%type,
        vADDRESS_ID IN CAR_REGISTRATION.ADDRESS_ID%type
        );
    
    FUNCTION BODY_CAR_REGISTER_CHECK(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type,
        vCAR_NAME IN CAR_REGISTRATION.CAR_NAME%type, 
        vCAR_COLOR IN CAR_REGISTRATION.CAR_COLOR%type,
        vCAR_COMPANY IN CAR_REGISTRATION.CAR_COMPANY%type,
        vYEAR_OF_MANUFACTURE IN NUMBER,
        vREGISTRATION_DATE IN CAR_REGISTRATION.REGISTRATION_DATE%type,
        vFUEL_TYPE IN CAR_REGISTRATION.FUEL_TYPE%type,
        vTRANSMISSION_TYPE IN CAR_REGISTRATION.TRANSMISSION_TYPE%type,
        vNO_OF_SEATS IN NUMBER,
        vCAR_CATEGORY_ID IN CAR_REGISTRATION.CAR_CATEGORY_ID%type,
        vEMPLOYEE_ID IN CAR_REGISTRATION.EMPLOYEE_ID%type,
        vADDRESS_ID IN CAR_REGISTRATION.ADDRESS_ID%type
       ) 
    RETURN VARCHAR2;
    
    PROCEDURE BODY_CAR_REGISTER_INSERT_TABLE(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type,
        vCAR_NAME IN CAR_REGISTRATION.CAR_NAME%type, 
        vCAR_COLOR IN CAR_REGISTRATION.CAR_COLOR%type,
        vCAR_COMPANY IN CAR_REGISTRATION.CAR_COMPANY%type,
        vYEAR_OF_MANUFACTURE IN NUMBER,
        vREGISTRATION_DATE IN CAR_REGISTRATION.REGISTRATION_DATE%type,
        vFUEL_TYPE IN CAR_REGISTRATION.FUEL_TYPE%type,
        vTRANSMISSION_TYPE IN CAR_REGISTRATION.TRANSMISSION_TYPE%type,
        vNO_OF_SEATS IN NUMBER,
        vCAR_CATEGORY_ID IN CAR_REGISTRATION.CAR_CATEGORY_ID%type,
        vEMPLOYEE_ID IN CAR_REGISTRATION.EMPLOYEE_ID%type,
        vADDRESS_ID IN CAR_REGISTRATION.ADDRESS_ID%type
    );
    
    PROCEDURE BODY_CAR_REGISTER_UPDATE_TABLE(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type,
        uCAR_NAME IN CAR_REGISTRATION.CAR_NAME%type, 
        uCAR_COLOR IN CAR_REGISTRATION.CAR_COLOR%type,
        uCAR_COMPANY IN CAR_REGISTRATION.CAR_COMPANY%type,
        uYEAR_OF_MANUFACTURE IN NUMBER,
        uREGISTRATION_DATE IN CAR_REGISTRATION.REGISTRATION_DATE%type,
        uFUEL_TYPE IN CAR_REGISTRATION.FUEL_TYPE%type,
        uTRANSMISSION_TYPE IN CAR_REGISTRATION.TRANSMISSION_TYPE%type,
        uNO_OF_SEATS IN NUMBER,
        uCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type,
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type
    );
    
     PROCEDURE BODY_CAR_REGISTER_DELETE_DATA(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type
    );
    
    FUNCTION BODY_CAR_REGISTER_ID_CHECK( 
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type
       ) 
    RETURN NUMBER;
    
END PKG_CAR_REGISTER;
/

-------------------------car_listing--------------------------------
CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_CAR_LISTING AS

    FUNCTION PROCESS_CAR_LISTING(
        vAVAILABILITY IN CAR_LISTING.AVAILABILITY%type,
        vDATE_POSTED  IN CAR_LISTING.DATE_POSTED%type,
        vFEE_RATE IN CAR_LISTING.FEE_RATE%type,
        vCAR_REGISTER_ID IN CAR_LISTING.CAR_REGISTER_ID%type,
        vCAR_PARKING_ID IN CAR_LISTING.PARKING_ID%type
    ) RETURN VARCHAR2;

    PROCEDURE INSERT_CAR_LISTING(
       vAVAILABILITY IN CAR_LISTING.AVAILABILITY%type,
        vFEE_RATE IN CAR_LISTING.FEE_RATE%type,
        vCAR_REGISTER_ID IN CAR_LISTING.CAR_REGISTER_ID%type,
        vCAR_PARKING_ID IN CAR_LISTING.PARKING_ID%type 
    );
    
    PROCEDURE UPDATE_CAR_LISTING_PRICE(
        vCAR_LISTING_ID IN CAR_LISTING.LISTING_ID%type,
        vFEE_RATE IN CAR_LISTING.FEE_RATE%type
    );
END PCKG_CAR_LISTING;
/

-----------------------transaction-----------------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE PKG_TRANSACTION   AS 
    PROCEDURE BODY_TRANSACTION_INSERT(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT);
    PROCEDURE BODY_TRANSACTION_INSERT_TABLE(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT);
    PROCEDURE BODY_TRANSACTION_UPDATE_TABLE(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT);
    PROCEDURE BODY_TRANSACTION_UPDATE_TABLE_SUCCESS(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2);
    PROCEDURE BODY_TRANSACTION(vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT, vTRANSACTION_ID OUT VARCHAR2);
    
    FUNCTION BODY_TRANSACTION_CHECK( 
        vSTATUS IN TRANSACTION.STATUS%type, 
        vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2;
    
    FUNCTION BODY_TRANSACTION_CALL( 
        vSTATUS IN TRANSACTION.STATUS%type, 
        vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2;
    
    FUNCTION BODY_TRANSACTION_ID_CHECK( 
        vTRANSACTION_ID IN TRANSACTION.TRANSACTION_ID%type
       ) 
    RETURN NUMBER;
    
    FUNCTION BODY_TRANSACTION_ID_GENERATE( 
        vSTATUS IN TRANSACTION.STATUS%type, 
        vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2;
END PKG_TRANSACTION;
/

-----------------------booking---------------------------------------

create or replace PACKAGE PKG_BOOKING   AS 
    
    FUNCTION NEW_BOOKING_VALIDATION(
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vUSER_ID IN BOOKING.USER_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
    ) RETURN VARCHAR2;

    FUNCTION BOOKING_IN_PROGRESS_VALIDATION(
            vBOOKING_ID IN BOOKING.BOOKING_ID%type,
            vLISTING_ID IN BOOKING.LISTING_ID%type
    ) RETURN VARCHAR2;

    FUNCTION BOOKING_COMPLETED_VALIDATION(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
    ) RETURN VARCHAR2;

    FUNCTION BOOKING_PAYMENT_VALIDATION(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
    ) RETURN VARCHAR2;

    PROCEDURE INSERT_NEW_BOOKING(
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vUSER_ID IN BOOKING.USER_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
    );

    PROCEDURE BOOKING_IN_PROGRESS(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
    );

    PROCEDURE BOOKING_COMPLETED(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type,
        vCOMMENTS IN BOOKING.COMMENTS%type
    );

    PROCEDURE BOOKING_PAYMENT_SUCCESS(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
    );

    PROCEDURE BOOKING_PAYMENT_FAIL(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
    );

    PROCEDURE BOOKING_CANCELLED(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
    );

	 FUNCTION COMPARE_TIMESTAMP(
        VTIME_ONE IN TIMESTAMP,
        VTIMESTAMP_TWO IN TIMESTAMP
    ) RETURN VARCHAR2;

END PKG_BOOKING;
/

----------------------users-----------------------------------------


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

-------------------------------- filter listing----------------------------------------
CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_CAR_LISTING_EXT AS
    PROCEDURE FILTER_LISTING(
        vUSER_ID IN USERS.USER_ID%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vMIN_NO_OF_SEATS IN NUMBER DEFAULT 2,
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type,
        vBOOKING_START IN TIMESTAMP DEFAULT SYSDATE,
        vBOOKING_END IN TIMESTAMP DEFAULT SYSDATE+1
    );
END PCKG_CAR_LISTING_EXT;
/



-------------------------------------------------------------BODY---------------------------------------------------------------------------

/*
--------------------------------------------COUNTRY START-------------------------------------------------------------------------------
*/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_COUNTRY AS
    
    FUNCTION CHECK_COUNTRY_EXISTS 
    (
      vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type 
    ) RETURN VARCHAR2 AS
    
        DB_COUNTRY_NAME NUMBER(38);
        
        NO_STATE_FOUND EXCEPTION;
    BEGIN
    
        select count(COUNTRY_NAME) into DB_COUNTRY_NAME from COUNTRY where COUNTRY_NAME = vCOUNTRY_NAME;
        
        if DB_COUNTRY_NAME = 0 then
            return 'NO';
        end if;
        
        return 'YES';
    END CHECK_COUNTRY_EXISTS;
    
    PROCEDURE INSERT_COUNTRY(
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type
        ) AS     
        
        ex_INVALID EXCEPTION;
        ex_DUPLICATE_COUNTRY EXCEPTION;
        
    BEGIN
        
        if vCOUNTRY_NAME is NULL or LENGTH(TRIM(vCOUNTRY_NAME)) is NULL then
            raise ex_INVALID;
        end if;
        
        IF CHECK_COUNTRY_EXISTS(vCOUNTRY_NAME) = 'NO' then 
            INSERT INTO COUNTRY(COUNTRY_ID, COUNTRY_NAME) VALUES (COUNTRY_ID_SEQ.NEXTVAL, vCOUNTRY_NAME);
        END IF; 
        
        IF CHECK_COUNTRY_EXISTS(vCOUNTRY_NAME) = 'YES' then
            raise ex_DUPLICATE_COUNTRY;
        END IF; 
        
        EXCEPTION
            when ex_INVALID then
                dbms_output.put_line('INVALID COUNTRY NAME !!!');
            when ex_DUPLICATE_COUNTRY then
                dbms_output.put_line('COUNTRY NAME  ALREADY EXISTS!!!');
    END INSERT_COUNTRY;
END PCKG_COUNTRY; 
/

/*
--------------------------------------------COUNTRY END-------------------------------------------------------------------------------
*/


/*
--------------------------------------------STATE START-------------------------------------------------------------------------------
*/


CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_STATE AS
    
    FUNCTION STATE_CHECK(
        vSTATE_NAME IN STATE.STATE_NAME%type
       ) 
    RETURN VARCHAR2 AS
        DB_STATE_NAME NUMBER(38);
        
        INVALID_STATE_NAME EXCEPTION;
        DUPLICATE_STATE_NAME EXCEPTION;
        
    BEGIN
    
        select count(STATE_NAME) into DB_STATE_NAME from STATE where STATE_NAME = vSTATE_NAME;
        
        IF DB_STATE_NAME != 0 THEN
            raise DUPLICATE_STATE_NAME;
        END IF;
            
        if vSTATE_NAME is NULL or LENGTH(TRIM(vSTATE_NAME)) is NULL then
            raise INVALID_STATE_NAME;
        end if;
        
        RETURN 'YES';
    
    EXCEPTION
        when INVALID_STATE_NAME then
            dbms_output.put_line('Invalid state name !!!');
            RETURN 'NO';
        when DUPLICATE_STATE_NAME then
            dbms_output.put_line('STATE NAME ALREADY EXIST IN STATE TABLE !!!');
            RETURN 'NO';
    END;
    
    PROCEDURE INSERT_STATE(
        vSTATE_NAME IN STATE.STATE_NAME%type, 
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%type
        ) AS     
        
        ex_INVALID EXCEPTION;
        INVALID_COUNTRY_NAME EXCEPTION;
        ex_COUNTRY_NAME_DOES_NOT_EXIST EXCEPTION;
        ex_COUNTRY_ID_NOT_FOUND EXCEPTION;
        
        DB_COUNTRY_NAME_EXIST NUMBER(38);
        gCOUNTRY_ID VARCHAR(500); 
        
    BEGIN
    
        BEGIN
        select count(COUNTRY_NAME) into DB_COUNTRY_NAME_EXIST from COUNTRY where COUNTRY_NAME = vCOUNTRY_NAME;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DB_COUNTRY_NAME_EXIST := 0;
        END;
        
        IF DB_COUNTRY_NAME_EXIST != 0 THEN
        BEGIN
        select COUNTRY_ID into gCOUNTRY_ID from COUNTRY where COUNTRY_NAME = vCOUNTRY_NAME;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            raise ex_COUNTRY_ID_NOT_FOUND;
        END;
        END IF;

        if vSTATE_NAME is NULL or LENGTH(TRIM(vSTATE_NAME)) is NULL then
            raise ex_INVALID;
        end if;
        
        if vCOUNTRY_NAME is NULL or  LENGTH(vCOUNTRY_NAME) = 0 then
            raise INVALID_COUNTRY_NAME;
        end if;

        if DB_COUNTRY_NAME_EXIST != 0 AND STATE_CHECK(vSTATE_NAME) = 'YES' then
            INSERT INTO STATE(STATE_ID, STATE_NAME, COUNTRY_ID) VALUES (STATE_ID_SEQ.NEXTVAL, vSTATE_NAME, gCOUNTRY_ID);
        end if; 
        
        if DB_COUNTRY_NAME_EXIST = 0 then
            raise ex_COUNTRY_NAME_DOES_NOT_EXIST;
        end if; 
        
        EXCEPTION
            when ex_INVALID then
                dbms_output.put_line('INVALID STATE NAME !!!');
            when INVALID_COUNTRY_NAME then
                dbms_output.put_line('COUNTRY NAME  IS INVALID!!!');
            when ex_COUNTRY_NAME_DOES_NOT_EXIST then
                dbms_output.put_line('COUNTRY NAME DOES NOT EXIST!!!');
    END INSERT_STATE;

END PCKG_STATE;
/

/*
--------------------------------------------STATE END-------------------------------------------------------------------------------
*/

/*
--------------------------------------------CITY START-------------------------------------------------------------------------------
*/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_CITY AS
    
    FUNCTION CITY_CHECK(
        vCITY_NAME IN CITY.CITY_NAME%type
       ) 
    RETURN VARCHAR2 AS
        DB_CITY_NAME NUMBER(38);
        
        INVALID_CITY_NAME EXCEPTION;
        DUPLICATE_CITY_NAME EXCEPTION;
        
    BEGIN
    
        select count(CITY_NAME) into DB_CITY_NAME from CITY where CITY_NAME = vCITY_NAME;
        
        IF DB_CITY_NAME != 0 THEN
            raise DUPLICATE_CITY_NAME;
        END IF;
            
        if vCITY_NAME is NULL or LENGTH(TRIM(vCITY_NAME)) is NULL then
            raise INVALID_CITY_NAME;
        end if;
        
        RETURN 'YES';
    
    EXCEPTION
        when INVALID_CITY_NAME then
            dbms_output.put_line('Invalid CITY name !!!');
            RETURN 'NO';
        when DUPLICATE_CITY_NAME then
            dbms_output.put_line('CITY NAME ALREADY EXIST IN STATE TABLE !!!');
            RETURN 'NO';
    END;
    
    PROCEDURE INSERT_CITY(
        vCITY_NAME IN CITY.CITY_NAME%type, 
        vSTATE_NAME IN STATE.STATE_NAME%type
        ) AS     
        
        ex_INVALID EXCEPTION;
        INVALID_STATE_NAME EXCEPTION;
        ex_STATE_NAME_DOES_NOT_EXIST EXCEPTION;
        
        DB_STATE_NAME_EXIST NUMBER(38);
        gSTATE_ID VARCHAR(500); 
        
    BEGIN
        
        BEGIN
        select count(STATE_NAME) into DB_STATE_NAME_EXIST from STATE where STATE_NAME = vSTATE_NAME;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DB_STATE_NAME_EXIST := 0;
        END;
        
        BEGIN
        select STATE_ID into gSTATE_ID from STATE where STATE_NAME = vSTATE_NAME;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            gSTATE_ID := NULL;
        END;
        
        if vCITY_NAME is NULL or LENGTH(TRIM(vCITY_NAME)) is NULL then
            raise ex_INVALID;
        end if;
        
        if vSTATE_NAME is NULL or  LENGTH(vSTATE_NAME) = 0 then
            raise INVALID_STATE_NAME;
        end if;
        
        if DB_STATE_NAME_EXIST = 0 then
            raise ex_STATE_NAME_DOES_NOT_EXIST;
        end if; 

        if DB_STATE_NAME_EXIST != 0 AND CITY_CHECK(vCITY_NAME) = 'YES' AND gSTATE_ID IS NOT NULL then
            INSERT INTO CITY(CITY_ID, CITY_NAME, STATE_ID) VALUES (CITY_ID_SEQ.NEXTVAL, vCITY_NAME, gSTATE_ID);
        end if; 
        
        EXCEPTION
            when ex_INVALID then
                dbms_output.put_line('INVALID STATE NAME !!!');
            when INVALID_STATE_NAME then
                dbms_output.put_line('STATE NAME  IS INVALID!!!');
            when ex_STATE_NAME_DOES_NOT_EXIST then
                dbms_output.put_line('STATE NAME DOES NOT EXIST!!!');
    END INSERT_CITY;

END PCKG_CITY;
/
/*
---------------------------------------------CITY END--------------------------------------------------------------------------------
*/


/*
---------------------------------------------------------ADDRESS START-----------------------------------------------------------------
*/

create or replace PACKAGE BODY PKG_ADDRESS   AS

  FUNCTION ADDRESS_VALIDATION(
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vADDRESS_TYPE IN ADDRESS.ADDRESS_TYPE%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_NAME IN CITY.CITY_NAME%TYPE,
        vSTATE_NAME IN STATE.STATE_NAME%TYPE,
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%TYPE
    ) RETURN VARCHAR2 AS

			ZIPCODE_LENGTH NUMBER;
            ADDR1_LENGTH NUMBER;
            ADDR2_LENGTH NUMBER;
            EXISTING_ADDRESS NUMBER;
			INVALID_ADDR1_EX EXCEPTION;
			INVALID_ZIP_CODE_EX EXCEPTION;
			ZIP_CODE_NAN_EX EXCEPTION;
			ZIPCODE_LENGTH_EX EXCEPTION;
            ADDR1_LENGTH_EX EXCEPTION;
            ADDR2_LENGTH_EX EXCEPTION;
            ADDRESS_TYPE_EX EXCEPTION;
            ADDRESS_TYPE_VAL_EX EXCEPTION;
            INVALID_CITY_EX EXCEPTION;
            INVALID_STATE_EX EXCEPTION;
            INVALID_COUNTRY_EX EXCEPTION;

    BEGIN
		EXECUTE IMMEDIATE ('SELECT LENGTH(''' ||vZIP_CODE|| ''') FROM DUAL') INTO ZIPCODE_LENGTH;
        EXECUTE IMMEDIATE ('SELECT LENGTH(''' ||vADDRESS_LINE_1|| ''') FROM DUAL') INTO ADDR1_LENGTH;
    
        IF(NOT vADDRESS_LINE_1 is NULL or NOT LENGTH(trim(vADDRESS_LINE_1)) IS NULL) THEN
            EXECUTE IMMEDIATE ('SELECT LENGTH(''' ||vADDRESS_LINE_2|| ''') FROM DUAL') INTO ADDR2_LENGTH;
        END IF;

		-- CHECK IF BOOKING STATUS IS BLACK OR NULL
        if vADDRESS_LINE_1 is NULL or LENGTH(trim(vADDRESS_LINE_1)) IS NULL then
            raise INVALID_ADDR1_EX;
        end if;

        IF(NOT vADDRESS_LINE_2 = NULL AND NOT LENGTH(TRIM(vADDRESS_LINE_2)) IS NULL AND ADDR2_LENGTH > 50) THEN
			RAISE ADDR2_LENGTH_EX;
		END IF;

        if vADDRESS_TYPE is NULL or LENGTH(TRIM(vADDRESS_TYPE)) is NULL then
			RAISE ADDRESS_TYPE_EX;
		END IF;
        
        if vCITY_NAME is NULL or LENGTH(TRIM(vCITY_NAME)) is NULL then
			RAISE INVALID_CITY_EX;
		END IF;
        
        if vSTATE_NAME is NULL or LENGTH(TRIM(vSTATE_NAME)) is NULL then
			RAISE INVALID_STATE_EX;
		END IF;
        
        if vCOUNTRY_NAME is NULL or LENGTH(TRIM(vCOUNTRY_NAME)) is NULL then
			RAISE INVALID_COUNTRY_EX;
		END IF;

        if NOT UPPER(vADDRESS_TYPE) in ('USER','EMPLOYEE','PARKING') then
            raise ADDRESS_TYPE_VAL_EX;
        end if;

        IF(ADDR1_LENGTH > 50) THEN
			RAISE ADDR1_LENGTH_EX;
		END IF;

		-- CHECK IF BOOKING STATUS IS BLANK OR NULL
        if vZIP_CODE is NULL or LENGTH(trim(vZIP_CODE)) IS NULL then
            raise INVALID_ZIP_CODE_EX;
        end if;

		-- CHECK IF BOOKING STATUS IS BLANK OR NULL
        if vZIP_CODE = 0 then
            raise INVALID_ZIP_CODE_EX;
        end if;

		-- CHECK IF BOOKING STATUS IS BLANK OR NULL
        if ZIPCODE_LENGTH <> 5 then
            raise ZIPCODE_LENGTH_EX;
        end if;

		-- CHECK IF DEPT_NAME IS NOT A NUMBER 
		IF(NOT VALIDATE_CONVERSION(vZIP_CODE AS NUMBER) = 1) THEN 
			RAISE ZIP_CODE_NAN_EX;
		END IF;

        RETURN 'YES';
    EXCEPTION
        when INVALID_ADDR1_EX then
            dbms_output.put_line('[ERROR] Invalid Address, Address Line 1 is mandatory');
            RETURN 'NO';
        when INVALID_ZIP_CODE_EX then
            dbms_output.put_line('[ERROR] Invalid ZipCode, ZipCode is mandatory');
            RETURN 'NO';
        when ZIP_CODE_NAN_EX then
            dbms_output.put_line('[ERROR] ZipCode needs to be a valid number');
            RETURN 'NO';
        when ZIPCODE_LENGTH_EX then
            dbms_output.put_line('[ERROR] Invalid ZipCode, ZipCode should not contain more than 5 digits');
            RETURN 'NO';
        when ADDR1_LENGTH_EX then
            dbms_output.put_line('[ERROR] Invalid Address 1, maximum 50 characters are allowed');
            RETURN 'NO';
        when ADDR2_LENGTH_EX then
            dbms_output.put_line('[ERROR] Invalid Address 2, maximum 50 characters are allowed');
            RETURN 'NO';
        when ADDRESS_TYPE_EX then
            dbms_output.put_line('[ERROR] Invalid Address Type, AddressType cannot be NULL or blank');
            RETURN 'NO';
        when ADDRESS_TYPE_VAL_EX then
            dbms_output.put_line('[ERROR] Invalid Address Type, allowed values are PARKING, USER, EMPLOYEE');
            RETURN 'NO';
        when INVALID_CITY_EX then
            dbms_output.put_line('[ERROR] Invalid City, City cannot be NULL or blank');
            RETURN 'NO';
        when INVALID_STATE_EX then
            dbms_output.put_line('[ERROR] Invalid State, State cannot be NULL or blank');
            RETURN 'NO';
        when INVALID_COUNTRY_EX then
            dbms_output.put_line('[ERROR] Invalid Country, Country cannot be NULL or blank');
            RETURN 'NO';
        when others then
            RETURN 'NO';
  END ADDRESS_VALIDATION;

    PROCEDURE INSERT_ADDRESS(
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_NAME IN CITY.CITY_NAME%TYPE,
        vSTATE_NAME IN STATE.STATE_NAME%TYPE,
        vADDRESS_TYPE IN ADDRESS.ADDRESS_TYPE%type,
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%TYPE 
    ) AS

        INVALID_INPUT_EX EXCEPTION;
        FAILURE_EX EXCEPTION;
        FOREIGN_KEY_CITY_ID CITY.CITY_ID%TYPE;
        FOREIGN_KEY_STATE_ID STATE.STATE_ID%TYPE;
        FOREIGN_KEY_COUNTRY_ID COUNTRY.COUNTRY_ID%TYPE;
        EXITSTING_CITY_NAME NUMBER;
        EXISTING_STATE_NAME NUMBER;
        EXISTING_COUNTRY_NAME NUMBER;
        EXISTING_ADDRESS NUMBER;
        INVALID_CITY_EX EXCEPTION;
        INVALID_STATE_EX EXCEPTION;
        INVALID_COUNTRY_EX EXCEPTION;

    BEGIN

        SELECT COUNT(*) INTO EXITSTING_CITY_NAME FROM CITY WHERE CITY_NAME=vCITY_NAME;
        SELECT COUNT(*) INTO EXISTING_STATE_NAME FROM STATE WHERE STATE_NAME=vSTATE_NAME;
        SELECT COUNT(*) INTO EXISTING_COUNTRY_NAME FROM COUNTRY WHERE COUNTRY_NAME=vCOUNTRY_NAME;
        SELECT COUNT(*) INTO EXISTING_ADDRESS FROM ADDRESS WHERE ADDRESS_LINE_1=vADDRESS_LINE_1;
        -- validate address
        IF ADDRESS_VALIDATION(vADDRESS_LINE_1, vADDRESS_LINE_2, vADDRESS_TYPE, vZIP_CODE, vCITY_NAME, vSTATE_NAME, vCOUNTRY_NAME) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        -- check if country exists
        IF EXISTING_COUNTRY_NAME = 0 THEN
            FOREIGN_KEY_COUNTRY_ID := 'COUNTRY_'||COUNTRY_ID_SEQ.NEXTVAL;

            -- COUNTRY DATA VALIDATION
            IF PCKG_COUNTRY.CHECK_COUNTRY_EXISTS(UPPER(TRIM(vCOUNTRY_NAME))) = 'NO' THEN
            INSERT INTO COUNTRY VALUES (
                FOREIGN_KEY_COUNTRY_ID,
                upper(trim(vCOUNTRY_NAME))
            );
            END IF;
        else    
            select COUNTRY_ID into FOREIGN_KEY_COUNTRY_ID from COUNTRY where COUNTRY_NAME = vCOUNTRY_NAME;
        END IF;

        -- check if state exists
        IF EXISTING_STATE_NAME = 0 THEN
            FOREIGN_KEY_STATE_ID := 'STATE_'||STATE_ID_SEQ.NEXTVAL;
            -- STATE DATA VALIDATION
            
            dbms_output.put_line(PCKG_STATE.STATE_CHECK(UPPER(TRIM(vSTATE_NAME))));
            IF PCKG_STATE.STATE_CHECK(UPPER(TRIM(vSTATE_NAME))) = 'NO' THEN
                RAISE INVALID_STATE_EX;
            END IF;
            INSERT INTO STATE VALUES (
                FOREIGN_KEY_STATE_ID,
                upper(trim(vSTATE_NAME)),
                FOREIGN_KEY_COUNTRY_ID
            );
        ELSE
            select STATE_ID into FOREIGN_KEY_STATE_ID from STATE where STATE_NAME = vSTATE_NAME;
        END IF;

        -- check if city exists
        IF NOT EXITSTING_CITY_NAME = 0 THEN
            select CITY_ID into FOREIGN_KEY_CITY_ID from CITY where CITY_NAME = UPPER(TRIM(vCITY_NAME));
        else
            FOREIGN_KEY_CITY_ID := 'CITY_'||CITY_ID_SEQ.NEXTVAL;

            -- CITY DATA VALIDATION
            IF PCKG_CITY.CITY_CHECK(UPPER(TRIM(vCITY_NAME))) = 'NO' THEN
                RAISE INVALID_CITY_EX;
            END IF;
            INSERT INTO CITY VALUES (
                 FOREIGN_KEY_CITY_ID,
                 upper(trim(vCITY_NAME)),
                 FOREIGN_KEY_STATE_ID
            );
        END IF;

        IF EXISTING_ADDRESS = 0 THEN
        INSERT INTO ADDRESS VALUES(
            'ADDR_'||ADDRESS_ID_SEQ.NEXTVAL,
            UPPER(TRIM(vADDRESS_LINE_1)),
            UPPER(TRIM(vADDRESS_LINE_2)),
            TRIM(vZIP_CODE),
            UPPER(TRIM(vADDRESS_TYPE)),
            FOREIGN_KEY_CITY_ID
        );
        END IF;

    if SQL%ROWCOUNT != 1 then
        rollback;
        raise FAILURE_EX;
    else 
        dbms_output.put_line('Address Record Inserted Successfully');
    end if;
    commit;

    EXCEPTION
    when INVALID_INPUT_EX then
        dbms_output.put_line('Invalid Input');
    when FAILURE_EX then
        dbms_output.put_line('Violations, Record Could Not Be Inserted');
    when INVALID_CITY_EX then
        dbms_output.put_line('Invalid City');
    when INVALID_STATE_EX then
        dbms_output.put_line('Invalid State');
    when INVALID_COUNTRY_EX then
        dbms_output.put_line('Invalid Country');
    END INSERT_ADDRESS;

    PROCEDURE UPDATE_ADDRESS(
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type,
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_NAME IN CITY.CITY_NAME%TYPE,
        vSTATE_NAME IN STATE.STATE_NAME%TYPE,
        vADDRESS_TYPE IN ADDRESS.ADDRESS_TYPE%type,
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%TYPE 
    ) AS

        FOREIGN_CITY_ID CITY.CITY_ID%TYPE;
        FOREIGN_STATE_ID STATE.STATE_ID%TYPE;
        FOREIGN_COUNTRY_ID COUNTRY.COUNTRY_ID%TYPE;

    BEGIN
        IF NOT vADDRESS_LINE_1 IS NULL or NOT LENGTH(trim(vADDRESS_LINE_1)) IS NULL then
            UPDATE ADDRESS SET ADDRESS_LINE_1=vADDRESS_LINE_1 WHERE ADDRESS_ID=vADDRESS_ID;
        END IF;

        IF NOT vADDRESS_LINE_2 IS NULL or NOT LENGTH(trim(vADDRESS_LINE_2)) IS NULL then
            UPDATE ADDRESS SET ADDRESS_LINE_2=vADDRESS_LINE_2 WHERE ADDRESS_ID=vADDRESS_ID;
        END IF;

        IF NOT vZIP_CODE IS NULL or NOT LENGTH(trim(vZIP_CODE)) IS NULL then
            UPDATE ADDRESS SET ZIPCODE=vZIP_CODE WHERE ADDRESS_ID=vADDRESS_ID;
        END IF;

        IF NOT vADDRESS_TYPE IS NULL or NOT LENGTH(trim(vADDRESS_TYPE)) IS NULL then
            UPDATE ADDRESS SET ADDRESS_TYPE=vADDRESS_TYPE WHERE ADDRESS_ID=vADDRESS_ID;
        END IF;

        IF NOT vCITY_NAME IS NULL or NOT LENGTH(trim(vCITY_NAME)) IS NULL then
            SELECT CITY_ID INTO FOREIGN_CITY_ID FROM CITY WHERE CITY_ID IN 
            (SELECT CITY_ID FROM ADDRESS WHERE ADDRESS_ID=vADDRESS_ID);
            UPDATE STATE SET STATE_NAME=vSTATE_NAME WHERE STATE_ID=FOREIGN_STATE_ID;
        END IF;

        IF NOT vSTATE_NAME IS NULL or NOT LENGTH(trim(vSTATE_NAME)) IS NULL then
            UPDATE STATE SET STATE_NAME=vSTATE_NAME WHERE STATE_ID IN
            (SELECT STATE_ID FROM CITY WHERE CITY_ID IN
            (SELECT CITY_ID FROM ADDRESS WHERE ADDRESS_ID=vADDRESS_ID));
        END IF;

        IF  NOT vCOUNTRY_NAME IS NULL or NOT LENGTH(trim(vCOUNTRY_NAME)) IS NULL then  
            UPDATE COUNTRY SET COUNTRY_NAME=vCOUNTRY_NAME WHERE COUNTRY_ID IN
            (SELECT COUNTRY_ID FROM STATE WHERE STATE_ID IN
            (SELECT STATE_ID FROM CITY WHERE CITY_ID IN
            (SELECT CITY_ID FROM ADDRESS WHERE ADDRESS_ID=vADDRESS_ID)));
        END IF;
    END UPDATE_ADDRESS;

END PKG_ADDRESS;
/
/*
----------------------------------------------------------ADDRESS END-------------------------------------------------------------------
*/


/*
----------------------------------------------ROLE START-------------------------------------------------------------------------------
*/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_ROLE  AS 
    PROCEDURE INSERT_ROLE(
        vROLE_NAME IN ROLE.ROLE_NAME%type
        ) AS     
        
        ex_INVALID_ROLE_NAME EXCEPTION; 
        DB_ROLE_NAME NUMBER(38);
    
    BEGIN
        
        BEGIN
        select COUNT(ROLE_NAME) INTO DB_ROLE_NAME FROM ROLE WHERE ROLE_NAME = vROLE_NAME;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DB_ROLE_NAME := 0;
        END;
        
        if vROLE_NAME is NULL or LENGTH(TRIM(vROLE_NAME)) IS NULL then
            raise ex_INVALID_ROLE_NAME;
        end if;
        
        IF DB_ROLE_NAME = 0 AND UPPER(vROLE_NAME) in ('OWNER','DEVELOPER','TESTER', 'ANALYST') THEN
            INSERT INTO ROLE(ROLE_ID, ROLE_NAME) VALUES ('ROLE_'||ROLE_ID_SEQ.NEXTVAL, vROLE_NAME);
        END IF; 
        
        EXCEPTION
            when ex_INVALID_ROLE_NAME then
                dbms_output.put_line('Role name is invalid !!!');
    END INSERT_ROLE;
END PCKG_ROLE; 
/

/*
------------------------------------------------ROLE END-------------------------------------------------------------------------------
*/

/*
------------------------------------------------------------EMPLOYEE START-----------------------------------------------------------------
*/

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

    PROCEDURE UPDATE_EMPLOYEE(
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type,
        vEMP_FIRST_NAME IN EMPLOYEE.EMP_FIRST_NAME%type,
        vEMP_LAST_NAME IN EMPLOYEE.EMP_LAST_NAME%type
    ) AS
    ex_INVALID_FIRST_NAME EXCEPTION;
    ex_INVALID_LAST_NAME EXCEPTION;
    ex_EMPLOYEE_DONT_EXIST EXCEPTION;
    vCount Number(5);
    BEGIN
    -- check if the employee exists
    -- if exists change first name and last name
            BEGIN
                SELECT count(*) INTO vCount FROM EMPLOYEE WHERE EMP_EMAIL = UPPER(TRIM(vEMP_EMAIL));
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        vCount := 0;
            END;
            IF vCount = 0 THEN
                raise ex_EMPLOYEE_DONT_EXIST;
            END IF;
            if vEMP_FIRST_NAME is NULL or REGEXP_LIKE(TRIM(vEMP_FIRST_NAME) , '^[0-9]*$') is NULL then
                raise ex_INVALID_FIRST_NAME;
            end if;
            
            if vEMP_LAST_NAME is NULL or REGEXP_LIKE(TRIM(vEMP_LAST_NAME) , '^[0-9]*$') is NULL then
                raise ex_INVALID_LAST_NAME;
            end if;

            UPDATE EMPLOYEE set EMP_FIRST_NAME = UPPER(TRIM(vEMP_FIRST_NAME)), EMP_LAST_NAME = UPPER(TRIM(vEMP_LAST_NAME)) WHERE UPPER(EMP_EMAIL) = UPPER(TRIM(vEMP_EMAIL));
            dbms_output.put_line('EMPLOYEE DATA UPDATED!!!');
        EXCEPTION
            WHEN ex_INVALID_LAST_NAME THEN
                dbms_output.put_line('INVALID LAST NAME !!!!');
            WHEN ex_INVALID_FIRST_NAME THEN
                dbms_output.put_line('INVALID FIRST NAME !!!');
            WHEN ex_EMPLOYEE_DONT_EXIST THEN
                dbms_output.put_line('EMPLOYEE DONT EXIST !!!');
    END UPDATE_EMPLOYEE;

END PCKG_EMPLOYEE;
/

/*
------------------------------------------------------------EMPLOYEE END-------------------------------------------------------------------
*/

/*
---------------------------------------------------------------CAR CATEGORY START-----------------------------------------------------------
*/

CREATE OR REPLACE EDITIONABLE PACKAGE  BODY PCKG_CAR_CATEGORY   AS
    FUNCTION PROCESS_CAR_CATEGORY(
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type
    ) RETURN VARCHAR2 AS
    ex_INVALID_NAME EXCEPTION;
    ex_INVALID_CATEGORY EXCEPTION;
    BEGIN
        IF vCAR_CATEGORY_NAME IS NULL OR LENGTH(vCAR_CATEGORY_NAME) < 1 THEN
            RAISE ex_INVALID_NAME;
        END IF;
        IF vCAR_CATEGORY_NAME NOT IN ('SEDAN','SUV','COUPE','WAGON','HATCHBACK','CONVERTIBLE','MINIVAN','PICKUP TRUCK', 'SPORTS CAR') THEN
            RAISE ex_INVALID_CATEGORY;
        END IF;
        RETURN 'YES';
    EXCEPTION
        WHEN ex_INVALID_NAME THEN
            dbms_output.enable(100000);
            dbms_output.put_line('INVALID CAR_CATEGORY_NAME');
            RETURN 'NO';
        WHEN ex_INVALID_CATEGORY THEN
            dbms_output.enable(100000);
            dbms_output.put_line('CAR_CATEGORY_NAME IS NOT IN (SEDAN,SUV,COUPE,WAGON,HATCHBACK,CONVERTIBLE,MINIVAN,PICKUP TRUCK)');
            RETURN 'NO';
    END PROCESS_CAR_CATEGORY;

    PROCEDURE INSERT_CAR_CATEGORY(
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type
    ) AS
    vCAR_CATEGORY_ID  CAR_CATEGORY.CAR_CATEGORY_ID%type;
    vCount NUMBER(5) DEFAULT 0;
    ex_INVALID EXCEPTION;
    ex_EXISTS EXCEPTION;
    BEGIN
        BEGIN
            select count(CAR_CATEGORY_ID) INTO vCount from CAR_CATEGORY where CAR_CATEGORY_NAME = UPPER(trim(vCAR_CATEGORY_NAME));
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    vCount := 0;
        END;
        IF vCount > 0 THEN
            raise ex_EXISTS;
        END IF;
        IF PROCESS_CAR_CATEGORY(UPPER(trim(vCAR_CATEGORY_NAME))) = 'NO' THEN
            raise ex_INVALID;
        END IF;
        SELECT 'CAR_CATEGORY_'||CAR_CATEGORY_ID_SEQ.NEXTVAL INTO vCAR_CATEGORY_ID FROM DUAL;
        INSERT INTO CAR_CATEGORY(CAR_CATEGORY_ID, CAR_CATEGORY_NAME)
        VALUES(
            vCAR_CATEGORY_ID,
            UPPER(trim(vCAR_CATEGORY_NAME))
            );
        IF SQL%ROWCOUNT != 1 then
            dbms_output.put_line('SORRY, INVALID ENTRY !!!');
            rollback;
        ELSE
            COMMIT;
            dbms_output.put_line('CAR_CATERGORY ADDED SUCCESSFULLY !!!'); 
        END IF;
    
    EXCEPTION
        when ex_INVALID then
            dbms_output.put_line('INSERTED DATA IS NOT AS EXPECTED !!!'); 
        when ex_EXISTS then
            dbms_output.put_line('CAR_CATEGORY ALREADY EXISTS!!!');
    END INSERT_CAR_CATEGORY;
    
    PROCEDURE UPDATE_CAR_CATEGORY(
        vCAR_CATEGORY_ID IN CAR_CATEGORY.CAR_CATEGORY_ID%type,
        newCATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type
    ) AS
    vCount NUMBER(5) DEFAULT 0;
    vCount2 NUMBER(5) DEFAULT 0;
    ex_EXISTS EXCEPTION;
    ex_NOT_EXISTS EXCEPTION;
    ex_INVALID EXCEPTION;
    BEGIN
        BEGIN
            select count(CAR_CATEGORY_ID) INTO vCount FROM CAR_CATEGORY WHERE CAR_CATEGORY_ID = vCAR_CATEGORY_ID;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    vCount := 0;
        END;
        IF vCount != 1 THEN
            RAISE ex_NOT_EXISTS;
        END IF;
        BEGIN
            select count(CAR_CATEGORY_ID) INTO vCount2 from CAR_CATEGORY where CAR_CATEGORY_NAME = UPPER(trim(newCATEGORY_NAME));
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    vCount2 := 0;
        END;
        IF vCount2 > 0 THEN
            RAISE ex_EXISTS;
        END IF;
        IF PROCESS_CAR_CATEGORY(UPPER(trim(newCATEGORY_NAME))) = 'NO' THEN
            raise ex_INVALID;
        END IF;
        UPDATE CAR_CATEGORY SET CAR_CATEGORY_NAME = UPPER(trim(newCATEGORY_NAME)) WHERE CAR_CATEGORY_ID = vCAR_CATEGORY_ID;
    EXCEPTION
        WHEN ex_NOT_EXISTS THEN
            dbms_output.put_line('CAR_CATEGORY_ID DOES NOT EXIST!!!!');
        WHEN ex_EXISTS THEN
            dbms_output.put_line('NEW CAR_CATEGORY VALUE ALREADY EXISTS!!!');
        WHEN ex_INVALID THEN
            dbms_output.put_line('NEW CAR_CATEGORY VALUE IS INVLAID!!!');
    END UPDATE_CAR_CATEGORY;
    
    PROCEDURE CHECK_AND_RETURN_ID(
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type,
        OUT_CATEGORY_ID OUT CAR_CATEGORY.CAR_CATEGORY_ID%type
    ) AS
    vCount NUMBER(5) DEFAULT 0;
    vCAR_CATEGORY_ID CAR_CATEGORY.CAR_CATEGORY_ID%type;
    BEGIN
        BEGIN
            SELECT count(*) INTO vCount FROM CAR_CATEGORY WHERE CAR_CATEGORY_NAME = UPPER(trim(vCAR_CATEGORY_NAME));
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    vCount := 0;
        END;
        IF vCount != 1 THEN
            BEGIN
                INSERT_CAR_CATEGORY(vCAR_CATEGORY_NAME);
            END;
        END IF;
        SELECT CAR_CATEGORY_ID INTO vCAR_CATEGORY_ID FROM CAR_CATEGORY WHERE CAR_CATEGORY_NAME = UPPER(trim(vCAR_CATEGORY_NAME));
        OUT_CATEGORY_ID := vCAR_CATEGORY_ID;
    END CHECK_AND_RETURN_ID;

    PROCEDURE DELETE_CATEGORY_BY_NAME(
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type) AS
        vCAR_CATEGORY_ID CAR_CATEGORY.CAR_CATEGORY_ID%type;
        vCAR_CATEGORY_COUNT NUMBER(5);
        vREGISTERED_CAR_COUNT NUMBER(5);
    BEGIN
        BEGIN
            SELECT COUNT(*) INTO vCAR_CATEGORY_COUNT FROM CAR_CATEGORY WHERE UPPER(CAR_CATEGORY_NAME) = UPPER(vCAR_CATEGORY_NAME);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    vCAR_CATEGORY_COUNT := 0;
        END;
        IF vCAR_CATEGORY_COUNT = 0 THEN
            dbms_output.put_line('CAR_CATEGORY NOT FOUND!!!!');
        ELSE
            SELECT CAR_CATEGORY_ID INTO vCAR_CATEGORY_ID FROM CAR_CATEGORY WHERE UPPER(CAR_CATEGORY_NAME) = UPPER(vCAR_CATEGORY_NAME);
            BEGIN
                SELECT COUNT(*) INTO vREGISTERED_CAR_COUNT FROM CAR_REGISTRATION WHERE UPPER(CAR_CATEGORY_ID) = UPPER(vCAR_CATEGORY_ID);
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        vREGISTERED_CAR_COUNT := 0;
            END;

            IF vREGISTERED_CAR_COUNT = 0 THEN
                --TRY DELETE CAR CATEGORY
                DELETE FROM CAR_CATEGORY WHERE CAR_CATEGORY_ID = UPPER(vCAR_CATEGORY_ID);
            ELSE
                dbms_output.put_line('CATEGORY CANNOT BE DELETED, REGISTERED CARS ARE PRESENT!!!');
            END IF;
        END IF;
    END DELETE_CATEGORY_BY_NAME;
END PCKG_CAR_CATEGORY;
/
/*
----------------------------------------------------------------CAR CATEGORY END-------------------------------------------------------------
*/

/*
------------------------------------------------------------PARKING START-------------------------------------------------------------------
*/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_PARKING AS

    PROCEDURE INSERT_PARKING(
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type) AS
        vCount NUMBER(5) DEFAULT 0;
        vCount2 NUMBER(5) DEFAULT 0;
        ex_INVALID_ADDRESS EXCEPTION;
        ex_EXISTS EXCEPTION;
        BEGIN
            BEGIN
                SELECT COUNT(*) INTO vCount FROM ADDRESS WHERE ADDRESS_ID = TRIM(vADDRESS_ID) and ADDRESS_TYPE = 'PARKING';
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        vCount := 0;
            END;
            IF vCount != 1 THEN
                RAISE ex_INVALID_ADDRESS;
            END IF;
            BEGIN
                SELECT COUNT(*) INTO vCount2 FROM PARKING WHERE ADDRESS_ID = vADDRESS_ID;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        vCount2 := 0;
            END;
            IF vCount2 > 0 THEN
                RAISE ex_EXISTS;
            END IF;
            IF vCount2 < 1 THEN
                INSERT INTO PARKING(PARKING_ID,ADDRESS_ID)
                VALUES (
                    'PARKING_'||PARKING_ID_SEQ.NEXTVAL,
                    UPPER(vADDRESS_ID)
                );
                dbms_output.put_line('PARKING SPOT INSERTED!!');
            END IF;
        EXCEPTION
            WHEN ex_INVALID_ADDRESS THEN
                dbms_output.put_line('ADDRESS ID IS INVALID OR DO NOT EXIST!!');
            WHEN ex_EXISTS THEN
                dbms_output.put_line('PARKING ALREADY EXISTS WITH SAME ADDRESS!!');
    END INSERT_PARKING;

END PCKG_PARKING;
/
/*
--------------------------------------------------------------PARKING END--------------------------------------------------------------------
*/

/*
------------------------------------------------------------PARKING-EXT START-------------------------------------------------------------------
*/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_PARKING_EXT AS

    PROCEDURE INSERT_PARKING_EXT(
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_NAME IN CITY.CITY_NAME%TYPE,
        vSTATE_NAME IN STATE.STATE_NAME%TYPE,
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%TYPE) AS
        EXISTING_ADDRESS_COUNT NUMBER(5);
        vADDRESS_ID ADDRESS.ADDRESS_ID%type;
    BEGIN
        -- Check if the address already exists in address table as parking type
        -- IF address exists, get ID and check if there exists parking id with that address ID
        -- IF address doesn't exist, create one using pkg_address and Create parking id with the created address_id
        BEGIN
            SELECT COUNT(*) INTO EXISTING_ADDRESS_COUNT FROM ADDRESS WHERE UPPER(ADDRESS_LINE_1) = UPPER(TRIM(vADDRESS_LINE_1)) AND ADDRESS_TYPE = 'PARKING';
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    EXISTING_ADDRESS_COUNT := 0;
        END;
        IF EXISTING_ADDRESS_COUNT < 1 THEN
            -- TRY INSERTING ADDRESS
            PKG_ADDRESS.INSERT_ADDRESS(UPPER(vADDRESS_LINE_1), UPPER(vADDRESS_LINE_2), vZIP_CODE, UPPER(vCITY_NAME), UPPER(vSTATE_NAME), 'PARKING', UPPER(vCOUNTRY_NAME));
        END IF;
        BEGIN
            SELECT COUNT(*) INTO EXISTING_ADDRESS_COUNT FROM ADDRESS WHERE UPPER(ADDRESS_LINE_1) = UPPER(TRIM(vADDRESS_LINE_1)) AND ADDRESS_TYPE = 'PARKING';
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    EXISTING_ADDRESS_COUNT := 0;
        END;
        IF EXISTING_ADDRESS_COUNT > 0 THEN
            SELECT ADDRESS_ID INTO vADDRESS_ID FROM ADDRESS WHERE UPPER(ADDRESS_LINE_1) = UPPER(TRIM(vADDRESS_LINE_1)) AND ADDRESS_TYPE = 'PARKING';
            -- TRY INSERTING PARKING
            PCKG_PARKING.INSERT_PARKING(vADDRESS_ID);
        ELSE
            dbms_output.put_line('ADDRESS INSERT FAILED, PLEASE CHECK!!!');
        END IF;
        -- EXCEPTION
    END INSERT_PARKING_EXT;

END PCKG_PARKING_EXT;
/
/*
------------------------------------------------------------PARKING-EXT END-------------------------------------------------------------------
*/

/*
------------------------------------------------------------------ CAR REGISTRATION START --------------------------------------------------------------
*/

create or replace PACKAGE BODY PKG_CAR_REGISTER AS
     PROCEDURE BODY_CAR_REGISTER_DATA(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type,
        vCAR_NAME IN CAR_REGISTRATION.CAR_NAME%type, 
        vCAR_COLOR IN CAR_REGISTRATION.CAR_COLOR%type,
        vCAR_COMPANY IN CAR_REGISTRATION.CAR_COMPANY%type,
        vYEAR_OF_MANUFACTURE IN NUMBER,
        vREGISTRATION_DATE IN CAR_REGISTRATION.REGISTRATION_DATE%type,
        vFUEL_TYPE IN CAR_REGISTRATION.FUEL_TYPE%type,
        vTRANSMISSION_TYPE IN CAR_REGISTRATION.TRANSMISSION_TYPE%type,
        vNO_OF_SEATS IN NUMBER,
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type,
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type,
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_NAME IN CITY.CITY_NAME%TYPE,
        vSTATE_NAME IN STATE.STATE_NAME%TYPE,
        vCOUNTRY_NAME IN COUNTRY.COUNTRY_NAME%TYPE,
        vFEE_RATE IN CAR_LISTING.FEE_RATE%type
    ) AS 
    INVALID_EMPLOYEE_ID EXCEPTION;
    INVALID_CAR_REGISTER_ID_PRESENT EXCEPTION;
    INVALID_ADDRESS_DETAILS EXCEPTION;
    INVALID_ADDRESS_DETAILS_ID EXCEPTION;
    INVALID_FEE_RATE EXCEPTION;
    INVALID_REGISTRATION_DATE EXCEPTION;
    ID_CHECK Number;
    vEMPLOYEE_ID CAR_REGISTRATION.EMPLOYEE_ID%type;
    vADDRESS_ID CAR_REGISTRATION.ADDRESS_ID%type;
    vCAR_CATEGORY_ID CAR_CATEGORY.CAR_CATEGORY_ID%type;
    vCAR_PARKING_ID CAR_LISTING.PARKING_ID%type;
    BEGIN
        if vEMP_EMAIL is NULL or LENGTH(TRIM(vEMP_EMAIL)) is NULL or NOT (TRIM(vEMP_EMAIL)) LIKE '%@_%._%' then
            raise INVALID_EMPLOYEE_ID;
        end if;

         begin
            select Count(*) into ID_CHECK from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
            IF ID_CHECK > 0 THEN
                raise INVALID_CAR_REGISTER_ID_PRESENT;
            END IF;
        end;
        begin
            select Count(*) into ID_CHECK from EMPLOYEE where EMP_EMAIL = TRIM(UPPER(vEMP_EMAIL));
            if(ID_CHECK = 0) then 
                raise INVALID_EMPLOYEE_ID;
            end if;
            select EMPLOYEE_ID into vEMPLOYEE_ID from EMPLOYEE where EMP_EMAIL = TRIM(UPPER(vEMP_EMAIL));
        end;
        begin
            PCKG_CAR_CATEGORY.CHECK_AND_RETURN_ID(TRIM(vCAR_CATEGORY_NAME), vCAR_CATEGORY_ID);
        end;
        if vADDRESS_LINE_1 is NULL or LENGTH(TRIM(vADDRESS_LINE_1)) is NULL or vZIP_CODE is NULL or LENGTH(TRIM(vZIP_CODE)) is NULL or vCITY_NAME is NULL or LENGTH(TRIM(vCITY_NAME)) is NULL or vSTATE_NAME is NULL or LENGTH(TRIM(vSTATE_NAME)) is NULL or vCOUNTRY_NAME is NULL or LENGTH(TRIM(vCOUNTRY_NAME)) is NULL then
            raise INVALID_ADDRESS_DETAILS;
        end if;
        if vREGISTRATION_DATE is NULL or to_char(LENGTH(vREGISTRATION_DATE)) is NULL or vREGISTRATION_DATE > SYSDATE then
                raise INVALID_REGISTRATION_DATE;
        end if;
        begin
            select Count(*) into ID_CHECK from Address where ADDRESS_LINE_1 = TRIM(UPPER(vADDRESS_LINE_1));
            if(ID_CHECK = 0) then  
                PCKG_PARKING_EXT.INSERT_PARKING_EXT(vADDRESS_LINE_1, vADDRESS_LINE_2, vZIP_CODE, vCITY_NAME, vSTATE_NAME, vCOUNTRY_NAME);
                select ADDRESS_ID into vADDRESS_ID from Address where ADDRESS_LINE_1 = TRIM(UPPER(vADDRESS_LINE_1)) and ADDRESS_TYPE = 'PARKING';
            else
                begin
                 select ADDRESS_ID into vADDRESS_ID from Address where ADDRESS_LINE_1 = TRIM(UPPER(vADDRESS_LINE_1)) and ADDRESS_TYPE = 'PARKING';
                 exception 
                    when NO_DATA_FOUND then 
                     raise INVALID_ADDRESS_DETAILS_ID;
                end;

                if vADDRESS_ID is NULL or LENGTH(trim(vADDRESS_ID)) IS NULL then
                    raise INVALID_ADDRESS_DETAILS_ID;
                end if;
            end if;
        end;
        if vFEE_RATE is NULL then
            raise INVALID_FEE_RATE;
        end if;
        begin
            select PARKING_ID into vCAR_PARKING_ID from Parking where ADDRESS_ID = TRIM(UPPER(vADDRESS_ID));
            select count(*) into ID_CHECK from car_listing where PARKING_ID = TRIM(UPPER(vCAR_PARKING_ID));
        end;
        if(ID_CHECK = 0) then
            BODY_CAR_REGISTER(UPPER(vCAR_REGISTER_ID), UPPER(vCAR_NAME), UPPER(vCAR_COLOR), UPPER(vCAR_COMPANY), to_number(vYEAR_OF_MANUFACTURE), vREGISTRATION_DATE, UPPER(vFUEL_TYPE), UPPER(vTRANSMISSION_TYPE), to_number(vNO_OF_SEATS), UPPER(vCAR_CATEGORY_ID), UPPER(vEMPLOYEE_ID), UPPER(vADDRESS_ID));
            PCKG_CAR_LISTING.INSERT_CAR_LISTING('TRUE',vFEE_RATE,TRIM(UPPER(vCAR_REGISTER_ID)),TRIM(UPPER(vCAR_PARKING_ID)));
        else 
            dbms_output.put_line('Parking Full for the giving address');
        end if;
    EXCEPTION
          when INVALID_EMPLOYEE_ID then
            dbms_output.put_line('Invalid employee email !!!');
          when INVALID_CAR_REGISTER_ID_PRESENT then
            dbms_output.put_line('CAR REGISTER ID already present !!!');
          when INVALID_ADDRESS_DETAILS then
            dbms_output.put_line('Invalid Address Details !!!');
          when INVALID_ADDRESS_DETAILS_ID then
            dbms_output.put_line('Address already taken');
         when INVALID_FEE_RATE then
            dbms_output.put_line('FEE RATE IS INVALID !!!');
         when INVALID_REGISTRATION_DATE then
            dbms_output.put_line('Invalid registration date is invalid !!!');

    END BODY_CAR_REGISTER_DATA;

    PROCEDURE BODY_CAR_REGISTER(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type,
        vCAR_NAME IN CAR_REGISTRATION.CAR_NAME%type, 
        vCAR_COLOR IN CAR_REGISTRATION.CAR_COLOR%type,
        vCAR_COMPANY IN CAR_REGISTRATION.CAR_COMPANY%type,
        vYEAR_OF_MANUFACTURE IN NUMBER,
        vREGISTRATION_DATE IN CAR_REGISTRATION.REGISTRATION_DATE%type,
        vFUEL_TYPE IN CAR_REGISTRATION.FUEL_TYPE%type,
        vTRANSMISSION_TYPE IN CAR_REGISTRATION.TRANSMISSION_TYPE%type,
        vNO_OF_SEATS IN NUMBER,
        vCAR_CATEGORY_ID IN CAR_REGISTRATION.CAR_CATEGORY_ID%type,
        vEMPLOYEE_ID IN CAR_REGISTRATION.EMPLOYEE_ID%type,
        vADDRESS_ID IN CAR_REGISTRATION.ADDRESS_ID%type
    ) AS
    Conditions VARCHAR2(244);
    BEGIN
        Select BODY_CAR_REGISTER_CHECK(vCAR_REGISTER_ID, vCAR_NAME, vCAR_COLOR, vCAR_COMPANY, vYEAR_OF_MANUFACTURE, vREGISTRATION_DATE, vFUEL_TYPE, vTRANSMISSION_TYPE, vNO_OF_SEATS, vCAR_CATEGORY_ID, vEMPLOYEE_ID, vADDRESS_ID) INTO Conditions from dual;
        if Conditions = 'YES' THEN
             BODY_CAR_REGISTER_INSERT_TABLE(TRIM(UPPER(vCAR_REGISTER_ID)), TRIM(UPPER(vCAR_NAME)), TRIM(UPPER(vCAR_COLOR)), TRIM(UPPER(vCAR_COMPANY)), to_number(vYEAR_OF_MANUFACTURE), vREGISTRATION_DATE, TRIM(UPPER(vFUEL_TYPE)), TRIM(UPPER(vTRANSMISSION_TYPE)), to_number(vNO_OF_SEATS), TRIM(UPPER(vCAR_CATEGORY_ID)), TRIM(UPPER(vEMPLOYEE_ID)), TRIM(UPPER(vADDRESS_ID)));
             dbms_output.put_line('Data inserted successfully !!!');
        end if;
    END BODY_CAR_REGISTER;

    FUNCTION BODY_CAR_REGISTER_CHECK(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type,
        vCAR_NAME IN CAR_REGISTRATION.CAR_NAME%type, 
        vCAR_COLOR IN CAR_REGISTRATION.CAR_COLOR%type,
        vCAR_COMPANY IN CAR_REGISTRATION.CAR_COMPANY%type,
        vYEAR_OF_MANUFACTURE IN NUMBER,
        vREGISTRATION_DATE IN CAR_REGISTRATION.REGISTRATION_DATE%type,
        vFUEL_TYPE IN CAR_REGISTRATION.FUEL_TYPE%type,
        vTRANSMISSION_TYPE IN CAR_REGISTRATION.TRANSMISSION_TYPE%type,
        vNO_OF_SEATS IN NUMBER,
        vCAR_CATEGORY_ID IN CAR_REGISTRATION.CAR_CATEGORY_ID%type,
        vEMPLOYEE_ID IN CAR_REGISTRATION.EMPLOYEE_ID%type,
        vADDRESS_ID IN CAR_REGISTRATION.ADDRESS_ID%type
       ) 
    RETURN VARCHAR2 AS
        v_date date;
        ID_CHECK NUMBER;
        INVALID_CAR_REGISTER_ID EXCEPTION;
        INVALID_CAR_NAME EXCEPTION;
        INVALID_CAR_COLOR EXCEPTION;
        INVALID_CAR_COMPANY EXCEPTION;
        INVALID_YEAR_OF_MANUFACTURE EXCEPTION;
        INVALID_REGISTRATION_DATE EXCEPTION;
        INVALID_FUEL_TYPE EXCEPTION;
        INVALID_TRANSMISSION_TYPE EXCEPTION;
        INVALID_NO_OF_SEATS EXCEPTION;
        INVALID_CAR_CATEGORY_ID EXCEPTION;
        INVALID_EMPLOYEE_ID EXCEPTION;
        INVALID_ADDRESS_ID EXCEPTION;

    BEGIN     

        if vCAR_REGISTER_ID is NULL or LENGTH(TRIM(vCAR_REGISTER_ID)) = 0 or LENGTH(TRIM(vCAR_REGISTER_ID)) !=18 then
            raise INVALID_CAR_REGISTER_ID;
        end if; 

        if vCAR_NAME is NULL or LENGTH(TRIM(vCAR_NAME)) is NULL then
            raise INVALID_CAR_NAME;
        end if; 

        if vCAR_COLOR is NULL or  LENGTH(TRIM(vCAR_COLOR)) is NULL then
            raise INVALID_CAR_COLOR;
        end if;

        if vCAR_COMPANY is NULL or LENGTH(TRIM(vCAR_COMPANY)) is NULL then
            raise INVALID_CAR_COMPANY;
        end if; 

        if vYEAR_OF_MANUFACTURE is NULL or LENGTH(TRIM(vYEAR_OF_MANUFACTURE)) = 0 or Not(to_number(vYEAR_OF_MANUFACTURE) between 1900 and 2022) then
                raise INVALID_YEAR_OF_MANUFACTURE;
        end if;

        if vFUEL_TYPE is NULL or LENGTH(TRIM(vFUEL_TYPE)) is NULL then
            raise INVALID_FUEL_TYPE;
        end if;  

        if UPPER(vFUEL_TYPE) NOT IN ('GASOLINE', 'DIESEL', 'ELECTRIC') then
            raise INVALID_FUEL_TYPE;
        end if;

        if vTRANSMISSION_TYPE is NULL or  LENGTH(vTRANSMISSION_TYPE) is NULL then
            raise INVALID_TRANSMISSION_TYPE;
        end if;

        if UPPER(vTRANSMISSION_TYPE) NOT IN ('MANUAL', 'AUTOMATIC') then
            raise INVALID_TRANSMISSION_TYPE;
        end if;

        if vNO_OF_SEATS is NULL or  LENGTH(vNO_OF_SEATS) = 0 then
            raise INVALID_NO_OF_SEATS;
        end if;

        if to_char(vNO_OF_SEATS) NOT IN ('4', '6') then
            raise INVALID_NO_OF_SEATS;
        end if;

        if vREGISTRATION_DATE is NULL or to_char(LENGTH(vREGISTRATION_DATE)) is NULL or vREGISTRATION_DATE > SYSDATE then
                raise INVALID_REGISTRATION_DATE;
        end if;

        begin
            select to_date(vREGISTRATION_DATE,'dd-mon-yyyy') into v_date from dual;
            EXCEPTION WHEN OTHERS then 
            RAISE INVALID_REGISTRATION_DATE;
        end;

        if vCAR_CATEGORY_ID is NULL or LENGTH(TRIM(vCAR_CATEGORY_ID)) is NULL then
            raise INVALID_CAR_CATEGORY_ID;
        end if; 

        begin
            select Count(*) into ID_CHECK from CAR_CATEGORY where CAR_CATEGORY_ID = TRIM(UPPER(vCAR_CATEGORY_ID));
            if(ID_CHECK = 0) then 
                raise INVALID_CAR_CATEGORY_ID;
            end if;
        end;

        if vEMPLOYEE_ID is NULL or  LENGTH(vEMPLOYEE_ID) is NULL then
            raise INVALID_EMPLOYEE_ID;
        end if;

        begin
            select Count(*) into ID_CHECK from EMPLOYEE where EMPLOYEE_ID = TRIM(UPPER(vEMPLOYEE_ID));
            if(ID_CHECK = 0) then 
                raise INVALID_EMPLOYEE_ID;
            end if;
        end;

        if vADDRESS_ID is NULL or  LENGTH(vADDRESS_ID) is NULL then
            raise INVALID_ADDRESS_ID;
        end if;

        begin
            select Count(*) into ID_CHECK from ADDRESS where ADDRESS_ID = TRIM(UPPER(vADDRESS_ID)) AND ADDRESS_TYPE = 'PARKING';
             if(ID_CHECK = 0) then 
                raise INVALID_ADDRESS_ID;
            end if;
        end;
        RETURN 'YES';

    EXCEPTION
        when INVALID_CAR_REGISTER_ID then
            dbms_output.put_line('CAR REGISTER ID is invalid !!!');
            RETURN 'NO';
        when INVALID_CAR_NAME then
            dbms_output.put_line('Car Name cannot be Null or Empty !!!');
            RETURN 'NO';
        when INVALID_CAR_COLOR then
            dbms_output.put_line('Car Color cannot be Null or Empty !!!');
            RETURN 'NO';
        when INVALID_CAR_COMPANY then
            dbms_output.put_line('Car Company cannot be Null or Empty !!!');
            RETURN 'NO';
        when INVALID_YEAR_OF_MANUFACTURE then
            dbms_output.put_line('Invalid MANUFACTURE Year must be between 1900 and 2022 !!!');
            RETURN 'NO';
        when INVALID_FUEL_TYPE then
            dbms_output.put_line('Invalid fuel type can be gasoline or diesel !!!');
            RETURN 'NO';
        when INVALID_TRANSMISSION_TYPE then
            dbms_output.put_line('Invalid transmission can be manual or automatic !!!');
            RETURN 'NO';
        when INVALID_NO_OF_SEATS then
            dbms_output.put_line('Invalid number of seat can be 4 or 6 !!!');
            RETURN 'NO';
        when INVALID_REGISTRATION_DATE then
            dbms_output.put_line('Invalid registration date is invalid !!!');
            RETURN 'NO';
        when INVALID_CAR_CATEGORY_ID then
            dbms_output.put_line('Invalid car category id !!!');
            RETURN 'NO';
        when INVALID_EMPLOYEE_ID then
            dbms_output.put_line('Invalid employee id !!!');
            RETURN 'NO';
        when INVALID_ADDRESS_ID then
            dbms_output.put_line('Invalid address id !!!');
            RETURN 'NO';
    END BODY_CAR_REGISTER_CHECK;

    PROCEDURE BODY_CAR_REGISTER_INSERT_TABLE(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type,
        vCAR_NAME IN CAR_REGISTRATION.CAR_NAME%type, 
        vCAR_COLOR IN CAR_REGISTRATION.CAR_COLOR%type,
        vCAR_COMPANY IN CAR_REGISTRATION.CAR_COMPANY%type,
        vYEAR_OF_MANUFACTURE IN NUMBER,
        vREGISTRATION_DATE IN CAR_REGISTRATION.REGISTRATION_DATE%type,
        vFUEL_TYPE IN CAR_REGISTRATION.FUEL_TYPE%type,
        vTRANSMISSION_TYPE IN CAR_REGISTRATION.TRANSMISSION_TYPE%type,
        vNO_OF_SEATS IN NUMBER,
        vCAR_CATEGORY_ID IN CAR_REGISTRATION.CAR_CATEGORY_ID%type,
        vEMPLOYEE_ID IN CAR_REGISTRATION.EMPLOYEE_ID%type,
        vADDRESS_ID IN CAR_REGISTRATION.ADDRESS_ID%type
    ) AS
    BEGIN
        INSERT INTO CAR_REGISTRATION (CAR_REGISTER_ID, CAR_NAME, CAR_COLOR, CAR_COMPANY, YEAR_OF_MANUFACTURE, REGISTRATION_DATE, FUEL_TYPE, TRANSMISSION_TYPE, NO_OF_SEATS, CAR_CATEGORY_ID, EMPLOYEE_ID, ADDRESS_ID) VALUES (vCAR_REGISTER_ID, vCAR_NAME, vCAR_COLOR, vCAR_COMPANY, vYEAR_OF_MANUFACTURE, vREGISTRATION_DATE, vFUEL_TYPE, vTRANSMISSION_TYPE, vNO_OF_SEATS, vCAR_CATEGORY_ID, vEMPLOYEE_ID, vADDRESS_ID);
    END BODY_CAR_REGISTER_INSERT_TABLE; 

    FUNCTION BODY_CAR_REGISTER_ID_CHECK( 
         vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type
       ) 
    RETURN NUMBER AS
    counts NUMBER;
    BEGIN
        select Count(*) into counts FROM CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        RETURN counts;
    END BODY_CAR_REGISTER_ID_CHECK; 

    PROCEDURE BODY_CAR_REGISTER_DELETE_DATA(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type
    ) AS
    temp_car_id Number;
    vlisting_id car_listing.listing_id%type;
    vaddress_id CAR_REGISTRATION.address_id%type;
    vbooking_count Number;
    INVALID_CAR_REGISTER_ID EXCEPTION;
    BEGIN
        if vCAR_REGISTER_ID is NULL or LENGTH(TRIM(vCAR_REGISTER_ID)) = 0 or LENGTH(TRIM(vCAR_REGISTER_ID)) !=18 then
            raise INVALID_CAR_REGISTER_ID;
        end if; 
        Select BODY_CAR_REGISTER_ID_CHECK(vCAR_REGISTER_ID) INTO temp_car_id from dual;
        if (temp_car_id = 0) then
             raise INVALID_CAR_REGISTER_ID;
        end if;
        select listing_id into vlisting_id from car_listing where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        select count(*) into vbooking_count from booking where listing_id = TRIM(UPPER(vlisting_id)) and (BOOKING_STATUS in ('INITIAL', 'IN-PROGRESS'));
        if vbooking_count = 0 then
            Delete from  car_listing where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
            Delete from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
            -- Delete from  parking where address_id = TRIM(UPPER(vaddress_id));
            -- Delete from  address where address_id = TRIM(UPPER(vaddress_id));
            dbms_output.put_line('deleted data successfully');
        else
             dbms_output.put_line('On going booking');
        end if;
    EXCEPTION
      when INVALID_CAR_REGISTER_ID then
        dbms_output.put_line('Invalid CAR_REGISTER_ID !!!');
    END BODY_CAR_REGISTER_DELETE_DATA;

    PROCEDURE BODY_CAR_REGISTER_UPDATE_TABLE(
        vCAR_REGISTER_ID IN CAR_REGISTRATION.CAR_REGISTER_ID%type,
        uCAR_NAME IN CAR_REGISTRATION.CAR_NAME%type, 
        uCAR_COLOR IN CAR_REGISTRATION.CAR_COLOR%type,
        uCAR_COMPANY IN CAR_REGISTRATION.CAR_COMPANY%type,
        uYEAR_OF_MANUFACTURE IN NUMBER,
        uREGISTRATION_DATE IN CAR_REGISTRATION.REGISTRATION_DATE%type,
        uFUEL_TYPE IN CAR_REGISTRATION.FUEL_TYPE%type,
        uTRANSMISSION_TYPE IN CAR_REGISTRATION.TRANSMISSION_TYPE%type,
        uNO_OF_SEATS IN NUMBER,
        uCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type,
        vEMP_EMAIL IN EMPLOYEE.EMP_EMAIL%type
    ) AS
    Conditions VARCHAR2(244);
    temp_car_id Number;
    ID_CHECK Number;
    vCAR_NAME CAR_REGISTRATION.CAR_NAME%type;
    vCAR_COLOR CAR_REGISTRATION.CAR_COLOR%type;
    vCAR_COMPANY CAR_REGISTRATION.CAR_COMPANY%type;
    vYEAR_OF_MANUFACTURE NUMBER;
    vREGISTRATION_DATE CAR_REGISTRATION.REGISTRATION_DATE%type;
    vFUEL_TYPE CAR_REGISTRATION.FUEL_TYPE%type;
    vTRANSMISSION_TYPE CAR_REGISTRATION.TRANSMISSION_TYPE%type;
    vNO_OF_SEATS NUMBER;
    vEMPLOYEE_ID CAR_REGISTRATION.EMPLOYEE_ID%type;
    vADDRESS_ID CAR_REGISTRATION.ADDRESS_ID%type;
    vCAR_CATEGORY_ID CAR_CATEGORY.CAR_CATEGORY_ID%type;
    INVALID_EMPLOYEE_ID EXCEPTION;
    INVALID_CAR_REGISTER_ID EXCEPTION;
    BEGIN
        if vCAR_REGISTER_ID is NULL or LENGTH(TRIM(vCAR_REGISTER_ID)) is NULL then
            raise INVALID_CAR_REGISTER_ID;
        end if;
        Select BODY_CAR_REGISTER_ID_CHECK(vCAR_REGISTER_ID) INTO temp_car_id from dual;
        if Not(temp_car_id > 0) then
             raise INVALID_CAR_REGISTER_ID;
        end if;
        Select ADDRESS_ID into vADDRESS_ID from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        if uCAR_CATEGORY_NAME is NULL or LENGTH(TRIM(uCAR_CATEGORY_NAME)) is NULL then
            Select CAR_CATEGORY_ID into vCAR_CATEGORY_ID from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        else
            begin
            PCKG_CAR_CATEGORY.CHECK_AND_RETURN_ID(uCAR_CATEGORY_NAME, vCAR_CATEGORY_ID);
        end;
        end if;

        if vEMP_EMAIL is NULL or LENGTH(TRIM(vEMP_EMAIL)) is NULL then
            Select EMPLOYEE_ID into vEMPLOYEE_ID from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        else
            if vEMP_EMAIL is NULL or LENGTH(TRIM(vEMP_EMAIL)) is NULL or NOT (TRIM(vEMP_EMAIL)) LIKE '%@_%._%' then
                raise INVALID_EMPLOYEE_ID;
            end if;
            begin
                select Count(*) into ID_CHECK from EMPLOYEE where EMP_EMAIL = TRIM(UPPER(vEMP_EMAIL));
                if(ID_CHECK = 0) then 
                    raise INVALID_EMPLOYEE_ID;
                end if;
                select EMPLOYEE_ID into vEMPLOYEE_ID from EMPLOYEE where EMP_EMAIL = TRIM(UPPER(vEMP_EMAIL));
            end;
        end if;

        if uCAR_NAME is NULL or LENGTH(TRIM(uCAR_NAME)) is NULL then
            Select CAR_NAME into vCAR_NAME from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        else
            vCAR_NAME:= uCAR_NAME;

        end if;

        if uCAR_COLOR is NULL or  LENGTH(uCAR_COLOR) is NULL then
            Select CAR_COLOR into vCAR_COLOR from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        else
            vCAR_COLOR:= uCAR_COLOR;
        end if;

        if uCAR_COMPANY is NULL or LENGTH(TRIM(uCAR_COMPANY)) is NULL then
            Select CAR_COMPANY into vCAR_COMPANY from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        else
            vCAR_COMPANY:= uCAR_COMPANY;
        end if; 

        if uYEAR_OF_MANUFACTURE is NULL or to_char(LENGTH(uYEAR_OF_MANUFACTURE)) is NULL then
            Select YEAR_OF_MANUFACTURE into vYEAR_OF_MANUFACTURE from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        else
            vYEAR_OF_MANUFACTURE:= uYEAR_OF_MANUFACTURE;
        end if;

        if uFUEL_TYPE is NULL or LENGTH(TRIM(uFUEL_TYPE)) is NULL then
            Select FUEL_TYPE into vFUEL_TYPE from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        else
            vFUEL_TYPE:= uFUEL_TYPE;
        end if;  

        if uTRANSMISSION_TYPE is NULL or  LENGTH(uTRANSMISSION_TYPE) is NULL then
            Select TRANSMISSION_TYPE into vTRANSMISSION_TYPE from CAR_REGISTRATION where CAR_REGISTER_ID = UPPER(vCAR_REGISTER_ID);
        else
            vTRANSMISSION_TYPE:= uTRANSMISSION_TYPE;
        end if;

        if uNO_OF_SEATS is NULL or  LENGTH(uNO_OF_SEATS) = 0 then
            Select NO_OF_SEATS into vNO_OF_SEATS from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        else
            vNO_OF_SEATS:= uNO_OF_SEATS;
        end if;

        if uREGISTRATION_DATE is NULL or to_char(LENGTH(uREGISTRATION_DATE)) is NULL then
                Select REGISTRATION_DATE into vREGISTRATION_DATE from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        else
            vREGISTRATION_DATE:= uREGISTRATION_DATE;
        end if;

        Select BODY_CAR_REGISTER_CHECK(vCAR_REGISTER_ID, vCAR_NAME, vCAR_COLOR, vCAR_COMPANY, vYEAR_OF_MANUFACTURE, vREGISTRATION_DATE, vFUEL_TYPE, vTRANSMISSION_TYPE, vNO_OF_SEATS, vCAR_CATEGORY_ID, vEMPLOYEE_ID, vADDRESS_ID) INTO Conditions from dual;
        if Conditions = 'YES' and  temp_car_id > 0 THEN
            UPDATE CAR_REGISTRATION SET CAR_NAME = UPPER(vCAR_NAME),  
            CAR_COLOR = TRIM(UPPER(vCAR_COLOR)),
            CAR_COMPANY = TRIM(UPPER(vCAR_COMPANY)),
            YEAR_OF_MANUFACTURE = to_number(vYEAR_OF_MANUFACTURE),
            REGISTRATION_DATE = vREGISTRATION_DATE,
            FUEL_TYPE = TRIM(UPPER(vFUEL_TYPE)),
            TRANSMISSION_TYPE = TRIM(UPPER(vTRANSMISSION_TYPE)),
            NO_OF_SEATS = to_number(vNO_OF_SEATS),
            CAR_CATEGORY_ID = TRIM(UPPER(vCAR_CATEGORY_ID)),
            EMPLOYEE_ID = TRIM(UPPER(vEMPLOYEE_ID)),
            ADDRESS_ID = TRIM(UPPER(vADDRESS_ID))
            WHERE CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
            dbms_output.put_line('Data updated successfully !!!');
         end if;
    EXCEPTION
      when INVALID_EMPLOYEE_ID then
        dbms_output.put_line('Invalid employee email !!!');
      when INVALID_CAR_REGISTER_ID then
        dbms_output.put_line('Invalid CAR_REGISTER_ID !!!');
    END BODY_CAR_REGISTER_UPDATE_TABLE;

END PKG_CAR_REGISTER;
/
/*
-------------------------------------------------------------------CAR REGISTRATION END ----------------------------------------------------------------
*/


/*
------------------------------------------------------------------CAR LISTING START-------------------------------------------------------------
*/


CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_CAR_LISTING AS
    FUNCTION PROCESS_CAR_LISTING(
        vAVAILABILITY IN CAR_LISTING.AVAILABILITY%type,
        vDATE_POSTED  IN CAR_LISTING.DATE_POSTED%type,
        vFEE_RATE IN CAR_LISTING.FEE_RATE%type,
        vCAR_REGISTER_ID IN CAR_LISTING.CAR_REGISTER_ID%type,
        vCAR_PARKING_ID IN CAR_LISTING.PARKING_ID%type
    ) RETURN VARCHAR2 AS
        CAR_REGISTER_COUNT NUMBER(5);
        CAR_PARKING_COUNT NUMBER(5);
        vCount NUMBER(5);
        ex_INVALID_AVAILABILITY EXCEPTION;
        ex_INVALID_DATE EXCEPTION;
        ex_INVALID_FEE EXCEPTION;
        ex_NO_CAR_REGISTER EXCEPTION;
        ex_PARKING_ID_FULL EXCEPTION;
        ex_PARKING_ID_NOT  EXCEPTION;
    BEGIN
        IF vAVAILABILITY IS NULL OR LENGTH(vAVAILABILITY) < 1 THEN
            RAISE ex_INVALID_AVAILABILITY;
        END IF;
        IF UPPER(trim(vAVAILABILITY)) NOT IN ('TRUE','FALSE') THEN
            RAISE ex_INVALID_AVAILABILITY;
        END IF;
        IF vDATE_POSTED IS NULL THEN
            RAISE ex_INVALID_DATE;
        END IF;
        IF vFEE_RATE IS NULL THEN
            RAISE ex_INVALID_FEE;
        END IF;
        BEGIN
            SELECT count(*) INTO CAR_REGISTER_COUNT FROM CAR_REGISTRATION WHERE CAR_REGISTER_ID = UPPER(TRIM(vCAR_REGISTER_ID));
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    CAR_REGISTER_COUNT := 0;
        END;
        IF CAR_REGISTER_COUNT != 1 THEN
            RAISE ex_NO_CAR_REGISTER;
        END IF;
        BEGIN
            SELECT count(*) INTO vCount FROM PARKING WHERE PARKING_ID = UPPER(TRIM(vCAR_PARKING_ID));
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    vCount := 0;
        END;
        IF vCount = 0 THEN
            RAISE ex_PARKING_ID_NOT;
        END IF;
        BEGIN
            SELECT count(*) INTO CAR_PARKING_COUNT FROM CAR_LISTING WHERE PARKING_ID = UPPER(TRIM(vCAR_PARKING_ID));
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    CAR_PARKING_COUNT := 0;
        END;
        IF CAR_PARKING_COUNT > 0 THEN
            RAISE ex_PARKING_ID_FULL;
        END IF;
        RETURN 'YES';
    EXCEPTION
        WHEN ex_INVALID_AVAILABILITY THEN
            dbms_output.put_line('GIVEN AVAILABILITY VALUE IS WRONG!!');
            RETURN 'NO';
        WHEN ex_INVALID_DATE THEN
            dbms_output.put_line('DATE INPUT IS WRONG!!');
            RETURN 'NO';
        WHEN ex_INVALID_FEE THEN
            dbms_output.put_line('FEE RATE IS INVALID!!');
            RETURN 'NO';
        WHEN ex_NO_CAR_REGISTER THEN
            dbms_output.put_line('CAR_REGISTER NOT FOUND!!');
            RETURN 'NO';
        WHEN ex_PARKING_ID_FULL THEN
            dbms_output.put_line('PARKING_SPOT IS ALREADY TAKEN!!');
            RETURN 'NO';
        WHEN ex_PARKING_ID_NOT THEN
            dbms_output.put_line('PARKING_SPOT IS NOT AVAILABLE!!');
            RETURN 'NO';
    END PROCESS_CAR_LISTING;

    PROCEDURE INSERT_CAR_LISTING(
       vAVAILABILITY IN CAR_LISTING.AVAILABILITY%type,
        vFEE_RATE IN CAR_LISTING.FEE_RATE%type,
        vCAR_REGISTER_ID IN CAR_LISTING.CAR_REGISTER_ID%type,
        vCAR_PARKING_ID IN CAR_LISTING.PARKING_ID%type 
    ) AS
    ex_INVALID EXCEPTION;
    ex_LISTING_EXISTS EXCEPTION;
    vCount Number(5);
    BEGIN
        select count(*) into vCount from car_listing where UPPER(car_register_id) = UPPER(vCAR_REGISTER_ID);
        IF vCount > 0 THEN
            RAISE ex_LISTING_EXISTS;
        END IF;
        IF PROCESS_CAR_LISTING(vAVAILABILITY, SYSDATE,vFEE_RATE,vCAR_REGISTER_ID, vCAR_PARKING_ID) = 'NO' THEN
            RAISE ex_INVALID;
        END IF;
        INSERT INTO CAR_LISTING(LISTING_ID, AVAILABILITY, DATE_POSTED, FEE_RATE, CAR_REGISTER_ID, PARKING_ID)
            VALUES(
                'CAR_LISTING_'||CAR_LISTING_ID_SEQ.NEXTVAL,
                UPPER(TRIM(vAVAILABILITY)),
                SYSDATE,
                vFEE_RATE,
                UPPER(TRIM(vCAR_REGISTER_ID)),
                UPPER(TRIM(vCAR_PARKING_ID))
            );
        dbms_output.put_line('NEW LISTING INSERTED!!');
    EXCEPTION
        WHEN ex_INVALID THEN
            dbms_output.put_line('INVALID CAR LISTING DATA!!!');
        WHEN ex_LISTING_EXISTS THEN
            dbms_output.put_line('LISTING ALREADY EXISTS FOR REGISTRATION ID!!!!');
    END INSERT_CAR_LISTING;

    PROCEDURE UPDATE_CAR_LISTING_PRICE(
        vCAR_LISTING_ID IN CAR_LISTING.LISTING_ID%type,
        vFEE_RATE IN CAR_LISTING.FEE_RATE%type
    ) AS
    vCount NUMBER(5);
    ex_NOT_EXISTS EXCEPTION;
    BEGIN
        -- check if listing exists
        -- if exists update the price
        BEGIN
            SELECT count(*) INTO vCount FROM CAR_LISTING WHERE LISTING_ID = vCAR_LISTING_ID;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    vCount := 0;
        END;

        IF vCount < 1 THEN
            RAISE ex_NOT_EXISTS;
        END IF;
        --TO DO, CHECK IF THE FEE RATE IS NUMBER
        UPDATE CAR_LISTING SET FEE_RATE = vFEE_RATE WHERE LISTING_ID = vCAR_LISTING_ID;
        dbms_output.put_line('LISTING PRICE UPDATED!!');
    EXCEPTION
        WHEN ex_NOT_EXISTS THEN
            dbms_output.put_line('LISTING NOT FOUND!!');
    END UPDATE_CAR_LISTING_PRICE;
END PCKG_CAR_LISTING;
/
/*
-------------------------------------------------------------------CAR LISTING END--------------------------------------------------------------
*/

/*
--------------------------------------------------------------------TRANSACTION START------------------------------------------------------------
*/

CREATE OR REPLACE EDITIONABLE PACKAGE BODY PKG_TRANSACTION AS
    PROCEDURE BODY_TRANSACTION(vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT, vTRANSACTION_ID OUT VARCHAR2) AS
    BEGIN
        vTRANSACTION_ID:= BODY_TRANSACTION_ID_GENERATE(vSTATUS, vTOTAL_COST);
        BODY_TRANSACTION_INSERT(vTRANSACTION_ID, vSTATUS, vTOTAL_COST);
    END BODY_TRANSACTION;
    
    FUNCTION BODY_TRANSACTION_CALL( 
        vSTATUS IN TRANSACTION.STATUS%type, 
        vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2 AS
    vTRANSACTION_ID VARCHAR2(244);
    BEGIN
        vTRANSACTION_ID:= BODY_TRANSACTION_ID_GENERATE(vSTATUS, vTOTAL_COST);
        BODY_TRANSACTION_INSERT(vTRANSACTION_ID, vSTATUS, vTOTAL_COST);
        RETURN vTRANSACTION_ID;
    END BODY_TRANSACTION_CALL;
    
    PROCEDURE BODY_TRANSACTION_INSERT(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT) AS
    Conditions VARCHAR2(244);
    BEGIN
        Select BODY_TRANSACTION_CHECK(vSTATUS, vTOTAL_COST) INTO Conditions from dual;
        if Conditions = 'YES' THEN
             BODY_TRANSACTION_INSERT_TABLE(vTRANSACTION_ID, UPPER(vSTATUS), vTOTAL_COST);
             dbms_output.put_line('Data inserted successfully !!!');
        end if;
    END BODY_TRANSACTION_INSERT;
    
    PROCEDURE BODY_TRANSACTION_INSERT_TABLE(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT) AS
    -- temp_trans_id TRANSACTION.TRANSACTION_ID%type;
    BEGIN
        -- select 'T_'|| TRANSACTION_ID_SEQ.nextval INTO temp_trans_id FROM dual;
        INSERT INTO TRANSACTION (TRANSACTION_ID, STATUS, TOTAL_COST) VALUES (vTRANSACTION_ID, vSTATUS, vTOTAL_COST);
    END BODY_TRANSACTION_INSERT_TABLE; 
    
    PROCEDURE BODY_TRANSACTION_UPDATE_TABLE_SUCCESS(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2) AS
    temp_trans_id Number;
    BEGIN
        Select BODY_TRANSACTION_ID_CHECK(vTRANSACTION_ID) INTO temp_trans_id from dual;
        if temp_trans_id > 0 THEN
            UPDATE TRANSACTION SET STATUS = UPPER(vSTATUS) WHERE TRANSACTION_ID = vTRANSACTION_ID;
            dbms_output.put_line('Data updated successfully !!!');
        ELSE
            dbms_output.put_line('Invalid TRANSACTION ID !!!');
         end if;
    END BODY_TRANSACTION_UPDATE_TABLE_SUCCESS;

    PROCEDURE BODY_TRANSACTION_UPDATE_TABLE(vTRANSACTION_ID IN VARCHAR2, vSTATUS IN VARCHAR2, vTOTAL_COST IN FLOAT) AS
    Conditions VARCHAR2(244);
    temp_trans_id Number;
    BEGIN
        Select BODY_TRANSACTION_ID_CHECK(vTRANSACTION_ID) INTO temp_trans_id from dual;
        
        Select BODY_TRANSACTION_CHECK(vSTATUS, vTOTAL_COST) INTO Conditions from dual;
        if Conditions = 'YES' and  temp_trans_id > 0 THEN
            UPDATE TRANSACTION SET STATUS = UPPER(vSTATUS),  TOTAL_COST = vTOTAL_COST WHERE TRANSACTION_ID = vTRANSACTION_ID;
            dbms_output.put_line('Data updated successfully !!!');
        ELSE
            dbms_output.put_line('Invalid TRANSACTION ID !!!');
         end if;
    END BODY_TRANSACTION_UPDATE_TABLE; 
    
    FUNCTION BODY_TRANSACTION_ID_CHECK( 
        vTRANSACTION_ID IN TRANSACTION.TRANSACTION_ID%type
       ) 
    RETURN NUMBER AS
    counts NUMBER;
    BEGIN

        begin
        select Count(*) into counts FROM TRANSACTION where TRANSACTION_ID = vTRANSACTION_ID;
        RETURN counts;
        exception 
            when NO_DATA_FOUND THEN 
                counts := 0;
        end;
    END BODY_TRANSACTION_ID_CHECK; 

    FUNCTION BODY_TRANSACTION_ID_GENERATE( 
         vSTATUS IN TRANSACTION.STATUS%type, 
         vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2 AS
    temp_trans_id TRANSACTION.TRANSACTION_ID%type;
    BEGIN
        select 'T_'|| TRANSACTION_ID_SEQ.nextval INTO temp_trans_id FROM dual;
        RETURN temp_trans_id;
    END BODY_TRANSACTION_ID_GENERATE; 
    
    FUNCTION BODY_TRANSACTION_CHECK(
        vSTATUS IN TRANSACTION.STATUS%type, 
        vTOTAL_COST IN TRANSACTION.TOTAL_COST%type
       ) 
    RETURN VARCHAR2 AS
        INVALID_STATUS EXCEPTION;
        INVALID_TOTAL_COST EXCEPTION;
        
    BEGIN      
        if vSTATUS is NULL or LENGTH(TRIM(vSTATUS)) is NULL then
            raise INVALID_STATUS;
        end if;
           
        if vTOTAL_COST is NULL or  LENGTH(vTOTAL_COST) = 0 then
            raise INVALID_TOTAL_COST;
        end if;
        
        if UPPER(vSTATUS) NOT IN ('INCOMPLETE', 'PENDING', 'FAIL', 'SUCCESS') then
            raise INVALID_STATUS;
        end if;
        
        RETURN 'YES';
    
    EXCEPTION
        when INVALID_STATUS then
            dbms_output.put_line('Invalid STATUS !!!');
            RETURN 'NO';
        when INVALID_TOTAL_COST then
            dbms_output.put_line('Invalid total cost !!!');
            RETURN 'NO';
    END BODY_TRANSACTION_CHECK;
END PKG_TRANSACTION;
/
/*
--------------------------------------------------------------------TRANSACTION END-----------------------------------------------------------------
*/


/*
------------------------------------------------------------------BOOKING START----------------------------------------------------------------------
*/

create or replace PACKAGE BODY PKG_BOOKING   AS

    -- Validations while adding a new booking
    FUNCTION NEW_BOOKING_VALIDATION(
            vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
            vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
            vUSER_ID IN BOOKING.USER_ID%type,
            vLISTING_ID IN BOOKING.LISTING_ID%type
        ) RETURN VARCHAR2 AS

                EXISTING_BOOKING NUMBER;
                INVALID_BOOKING_EX EXCEPTION;
                INVALID_BOOKING_VAL_EX EXCEPTION;
                CREATED_START_DATE_EX EXCEPTION;
                CREATED_END_DATE_EX EXCEPTION;
                DUPLICATE_BOOKING_EX EXCEPTION;
                CREATED_START_DATE_LESS_THAN_SYS_EX EXCEPTION;
                CREATED_START_DATE_SMALLER_EX EXCEPTION;
                CREATED_END_DATE_LESS_THAN_SYS_EX EXCEPTION;
                ACTUAL_START_DATE_LESS_THAN_SYS_EX EXCEPTION;
                ACTUAL_START_DATE_SMALLER_EX EXCEPTION;
                ACTUAL_END_DATE_LESS_THAN_SYS_EX EXCEPTION;
                INVALID_CREATED_START_DATE_FORMAT EXCEPTION;
                INVALID_CREATED_END_DATE_FORMAT EXCEPTION;
                INVALID_USER_ID_EX EXCEPTION;
                INVALID_LISTING_ID_EX EXCEPTION;
                EXISTS_USER_ID_EX EXCEPTION;
                EXISTS_LISTING_ID_EX EXCEPTION;
                USER_EXISTS NUMBER;
                LISTING_EXISTS NUMBER;

        BEGIN

            SELECT COUNT(*) INTO USER_EXISTS FROM USERS WHERE USER_ID=UPPER(TRIM(vUSER_ID));
            SELECT COUNT(*) INTO LISTING_EXISTS FROM CAR_LISTING WHERE LISTING_ID=UPPER(TRIM(vLISTING_ID));

            -- CHECK IF USER ID IS BLANK OR NULL
            if vUSER_ID is NULL or LENGTH(trim(vUSER_ID)) IS NULL then
                raise INVALID_USER_ID_EX;
            end if;

            if USER_EXISTS = 0 then
                raise EXISTS_USER_ID_EX;
            end if;

            -- CHECK IF LISTING ID IS BLANK OR NULL
            if LISTING_EXISTS = 0 then
                raise EXISTS_LISTING_ID_EX;
            end if;

            -- CHECK IF CREATED_START_DATE IS BLANK OR NULL
            if vCREATED_START_DATE is NULL or to_char(LENGTH(vCREATED_START_DATE)) is NULL then
                raise CREATED_START_DATE_EX;
            end if;

            -- CHECK IF CREATED_END_DATE IS BLANK OR NULL
            if vCREATED_END_DATE is NULL or to_char(LENGTH(vCREATED_END_DATE)) is NULL then
                raise CREATED_END_DATE_EX;
            end if;

            -- CHECK IF CREATED_START_DATE IS GREATER THAN CURRENT_DATE
            -- if COMPARE_TIMESTAMP(vCREATED_START_DATE, SYSTIMESTAMP ) < 0 then
            --     raise CREATED_START_DATE_LESS_THAN_SYS_EX;
            -- end if;

            -- CHECK IF CREATED_START_DATE IS LESS THAN CREATED_END_DATE
            -- if COMPARE_TIMESTAMP(vCREATED_END_DATE, vCREATED_START_DATE ) < 0 then
            --     raise CREATED_START_DATE_SMALLER_EX;
            -- end if;

            -- CHECK IF CREATED_END_DATE IS GREATER THAN CURRENT_DATE
            -- if COMPARE_TIMESTAMP(vCREATED_END_DATE, SYSTIMESTAMP ) < 0 then
            --     raise CREATED_END_DATE_LESS_THAN_SYS_EX;
            -- end if;

            RETURN 'YES';
        EXCEPTION
            when INVALID_BOOKING_EX then
                dbms_output.put_line('[ERROR] Invalid Booking Type, Booking Type cannot be NULL or Empty');
                RETURN 'NO';
            when INVALID_BOOKING_VAL_EX then
                dbms_output.enable(10000);
                dbms_output.put_line('[ERROR] Invalid Booking Type, allowed values are ''COMPLETED'', ''IN-PROGRESS'',''OPEN''');
                RETURN 'NO';
            when CREATED_START_DATE_EX then
                dbms_output.put_line('[ERROR] Invalid Created Start Date, Enter a valid Created Start Date');
                RETURN 'NO';
            when CREATED_END_DATE_EX then
                dbms_output.put_line('[ERROR] Invalid Created End Date, Enter a valid Created End Date');
                RETURN 'NO';
            when DUPLICATE_BOOKING_EX then
                dbms_output.put_line('[ERROR] Duplicate booking, booking with the same id already exists');
                RETURN 'NO';
            when CREATED_START_DATE_LESS_THAN_SYS_EX then
                dbms_output.put_line('[ERROR] CreatedStartDate cannot be less the current date');
                RETURN 'NO';
            when CREATED_START_DATE_SMALLER_EX then
                dbms_output.put_line('[ERROR] CreatedStartDate cannot be less the CreatedEndDate');
                RETURN 'NO';
            when CREATED_END_DATE_LESS_THAN_SYS_EX then
                dbms_output.put_line('[ERROR] CreatedEndDate cannot be less the current date');
                RETURN 'NO';
            when INVALID_CREATED_START_DATE_FORMAT then
                dbms_output.put_line('[ERROR] CreatedStartDate has an Invalid format');
                RETURN 'NO';
            when INVALID_CREATED_END_DATE_FORMAT then
                dbms_output.put_line('[ERROR] CreatedEndDate has an Invalid format');
                RETURN 'NO';
            when INVALID_USER_ID_EX then
                dbms_output.put_line('[ERROR] Invalid UserId');
                RETURN 'NO';
            when INVALID_LISTING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid ListingId');
                RETURN 'NO';
            when EXISTS_USER_ID_EX then
                dbms_output.put_line('[ERROR] User does not exist');
                RETURN 'NO';
            when EXISTS_LISTING_ID_EX then
                dbms_output.put_line('[ERROR] Listing does not exist');
                RETURN 'NO';
            when others then
                RETURN 'NO';
    END NEW_BOOKING_VALIDATION;

    -- Validations while updating a booking to IN-PROGRESS
    FUNCTION BOOKING_IN_PROGRESS_VALIDATION(
            vBOOKING_ID IN BOOKING.BOOKING_ID%type,
            vLISTING_ID IN BOOKING.LISTING_ID%type
        ) RETURN VARCHAR2 AS

                BOOKING_STATUS_INPROG NUMBER;
                BOOKING_STATUS_COMP NUMBER;
                vIS_BOOKING_PRESENT NUMBER;
                NO_BOOKING_EX EXCEPTION;
                INVALID_BOOKING_ID_EX EXCEPTION;
                INVALID_LISTING_ID_EX EXCEPTION;
                BOOKING_INPROG_EX EXCEPTION;
                BOOKING_COMP_EX EXCEPTION;

        BEGIN
            SELECT COUNT(*) INTO BOOKING_STATUS_INPROG FROM BOOKING WHERE BOOKING_STATUS='IN-PROGRESS' AND BOOKING_ID=vBOOKING_ID;
            SELECT COUNT(*) INTO BOOKING_STATUS_COMP FROM BOOKING WHERE BOOKING_STATUS='COMPLETED' AND BOOKING_ID=vBOOKING_ID;
            SELECT COUNT(*) INTO vIS_BOOKING_PRESENT FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;

            -- CHECK IF BOOKING ID IS BLANK OR NULL
            if vBOOKING_ID is NULL or LENGTH(trim(vBOOKING_ID)) IS NULL then
                raise INVALID_BOOKING_ID_EX;
            end if;

            -- CHECK IF LISTING ID IS BLANK OR NULL
            if vLISTING_ID is NULL or LENGTH(trim(vLISTING_ID)) IS NULL then
                raise INVALID_LISTING_ID_EX;
            end if;

            -- CHECK IF BOOKING ID IS PRESENT
            if vIS_BOOKING_PRESENT=0 then
                raise NO_BOOKING_EX;
            end if;

            -- CHECK IF BOOKING IS ALREADY IN PROGRESS
            if BOOKING_STATUS_INPROG > 0 then
                raise BOOKING_INPROG_EX;
            end if;

            -- CHECK IF BOOKING IS ALREADY COMPLETED
            if BOOKING_STATUS_COMP > 0 then
                raise BOOKING_COMP_EX;
            end if;

            RETURN 'YES';
        EXCEPTION
            when INVALID_BOOKING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid Booking ID, Booking ID cannot be NULL or Empty');
                RETURN 'NO';
            when NO_BOOKING_EX then
                dbms_output.put_line('[ERROR] Provided Booking is not present in the database');
                RETURN 'NO';
            when INVALID_LISTING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid Listing ID, Listin ID cannot be NULL or Empty');
                RETURN 'NO';
            when BOOKING_INPROG_EX then
                dbms_output.put_line('[ERROR] This booking is already IN_PROGRESS');
                RETURN 'NO';
            when BOOKING_COMP_EX then
                dbms_output.put_line('[ERROR] This booking has been completed');
                RETURN 'NO';
            when others then
                RETURN 'NO';
    END BOOKING_IN_PROGRESS_VALIDATION;

    -- Validations while updating a booking to COMPLETED
    FUNCTION BOOKING_COMPLETED_VALIDATION(
            vBOOKING_ID IN BOOKING.BOOKING_ID%type,
            vLISTING_ID IN BOOKING.LISTING_ID%type
        ) RETURN VARCHAR2 AS

                BOOKING_STATUS_INITIAL NUMBER;
                BOOKING_STATUS_COMP NUMBER;
                INVALID_BOOKING_ID_EX EXCEPTION;
                BOOKING_INITIAL_EX EXCEPTION;
                BOOKING_COMP_EX EXCEPTION;
                INVALID_LISTING_ID_EX EXCEPTION;

        BEGIN
            SELECT COUNT(*) INTO BOOKING_STATUS_INITIAL FROM BOOKING WHERE BOOKING_STATUS='INITIAL' AND BOOKING_ID=vBOOKING_ID;
            SELECT COUNT(*) INTO BOOKING_STATUS_COMP FROM BOOKING WHERE BOOKING_STATUS='COMPLETED' AND BOOKING_ID=vBOOKING_ID;

            -- CHECK IF BOOKING ID IS BLANK OR NULL
            if vBOOKING_ID is NULL or LENGTH(trim(vBOOKING_ID)) IS NULL then
                raise INVALID_BOOKING_ID_EX;
            end if;

            -- CHECK IF LISTING ID IS BLANK OR NULL
            if vLISTING_ID is NULL or LENGTH(trim(vLISTING_ID)) IS NULL then
                raise INVALID_LISTING_ID_EX;
            end if;

            -- CHECK IF BOOKING IS ALREADY IN PROGRESS
            if BOOKING_STATUS_INITIAL > 0 then
                raise BOOKING_INITIAL_EX;
            end if;

            -- CHECK IF BOOKING IS ALREADY COMPLETED
            if BOOKING_STATUS_COMP > 0 then
                raise BOOKING_COMP_EX;
            end if;

            RETURN 'YES';
        EXCEPTION
            when INVALID_BOOKING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid Booking ID, Booking ID cannot be NULL or Empty');
                RETURN 'NO';
            when BOOKING_INITIAL_EX then
                dbms_output.put_line('[ERROR] This booking is still in INITIAL state');
                RETURN 'NO';
            when BOOKING_COMP_EX then
                dbms_output.put_line('[ERROR] This booking has already been completed');
                RETURN 'NO';
            when INVALID_LISTING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid Listing ID, Listing ID cannot be NULL or Empty');
                RETURN 'NO';
            when others then
                RETURN 'NO';
    END BOOKING_COMPLETED_VALIDATION;

    -- Validations while updating a booking to PAYMENT-SUCCESS
    FUNCTION BOOKING_PAYMENT_VALIDATION(
            vBOOKING_ID IN BOOKING.BOOKING_ID%type
        ) RETURN VARCHAR2 AS

            INVALID_BOOKING_ID_EX EXCEPTION;

        BEGIN

            -- CHECK IF BOOKING ID IS BLANK OR NULL
            if vBOOKING_ID is NULL or LENGTH(trim(vBOOKING_ID)) IS NULL then
                raise INVALID_BOOKING_ID_EX;
            end if;

            RETURN 'YES';
        EXCEPTION
            when INVALID_BOOKING_ID_EX then
                dbms_output.put_line('[ERROR] Invalid Booking ID, Booking ID cannot be NULL or Empty');
                RETURN 'NO';
            when others then
                RETURN 'NO';
    END BOOKING_PAYMENT_VALIDATION;

    -- Function to compare the timestamps
    FUNCTION COMPARE_TIMESTAMP(
        VTIME_ONE IN TIMESTAMP,
        VTIMESTAMP_TWO IN TIMESTAMP
        ) RETURN VARCHAR2 AS

        begin
        return extract (day    from (VTIME_ONE-VTIMESTAMP_TWO))*24*60*60 +
                extract (hour   from (VTIME_ONE-VTIMESTAMP_TWO))*60*60+
                extract (minute from (VTIME_ONE-VTIMESTAMP_TWO))*60+
                extract (second from (VTIME_ONE-VTIMESTAMP_TWO));
	end COMPARE_TIMESTAMP;

    -- Procedure to add a new booking
    PROCEDURE INSERT_NEW_BOOKING(
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vUSER_ID IN BOOKING.USER_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
        ) AS
            vCOMPLETED_COUNT NUMBER;
            v1BOOKING_ID BOOKING.BOOKING_ID%TYPE;
            vDAYS NUMBER(5,2);
            EXISTING_BOOKING NUMBER;
            vFEE_RATE NUMBER(5,2);
			vBLACKLISTED USERS.BLACKLISTED%TYPE;
            FETCH_TRANSACTION_ID TRANSACTION.TRANSACTION_ID%TYPE;
            EXSTING_BOOKING_EX EXCEPTION;
            INVALID_INPUT_EX EXCEPTION;
			NO_DATA_EX EXCEPTION;
			USER_BLACKLISTED_EX EXCEPTION;
        BEGIN
            SELECT COUNT(*) INTO EXISTING_BOOKING FROM BOOKING WHERE USER_ID=vUSER_ID AND BOOKING_STATUS IN ('INITIAL', 'IN-PROGRESS', 'COMPLETED', 'PAYMENT_FAILED');

            -- IF THE USER HAS AN EXSTING OPEN BOOKING, DONT ALLOW TO RE-BOOK
            IF EXISTING_BOOKING > 0 THEN
                RAISE EXSTING_BOOKING_EX;
            END IF;

            -- validate address
        IF NEW_BOOKING_VALIDATION(vCREATED_START_DATE, vCREATED_END_DATE, vUSER_ID, vLISTING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

			BEGIN
				SELECT BLACKLISTED INTO vBLACKLISTED FROM USERS WHERE USER_ID=vUSER_ID;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
			END;


			if (vBLACKLISTED is not NULL or LENGTH(trim(vBLACKLISTED))IS not NULL) and upper(trim(vBLACKLISTED)) = 'TRUE' then
                raise USER_BLACKLISTED_EX;
            end if;

            -- CALCULATE THE NUMBER OF DAYS OF THE BOOKING
            vDAYS := CAST(vCREATED_END_DATE AS DATE) - CAST(vCREATED_START_DATE AS DATE);

            -- IF THE DIFFERENCE IS 0 DAYS, IT NEEDS TO BE CONSIDERED AS 1 DAY
            IF vDAYS = 0 THEN
                vDAYS := 1;
            END IF;

            -- GET THE FEE RATE FROM CAR_LISTING ENTITY
            SELECT FEE_RATE INTO vFEE_RATE FROM CAR_LISTING WHERE LISTING_ID=vLISTING_ID;

            -- GET THE VALUE OF LISTING_IF FROM CAR_REGISTRATION ENTITY
            PKG_TRANSACTION.BODY_TRANSACTION('PENDING', vDAYS * vFEE_RATE, FETCH_TRANSACTION_ID);

            INSERT INTO BOOKING(BOOKING_ID, BOOKING_STATUS, CREATED_START_DATE, CREATED_END_DATE, USER_ID,TRANSACTION_ID,LISTING_ID) VALUES(
                'BOOK_'||BOOKING_ID_SEQ.NEXTVAL,'INITIAL',vCREATED_START_DATE,vCREATED_END_DATE,vUSER_ID,FETCH_TRANSACTION_ID,vLISTING_ID
            );

        EXCEPTION
            when EXSTING_BOOKING_EX then
                dbms_output.put_line('[ERROR] There is an open booking or a pending payment for this customer which needs to be taken care of before booking another ride');
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
            when USER_BLACKLISTED_EX then
                dbms_output.put_line('[ERROR] User blacklisted. Cannot book a ride');
            when NO_DATA_EX then
                dbms_output.put_line('[ERROR] No records found');
    END INSERT_NEW_BOOKING;

    -- Procedure to update a booking to IN-PROGRESS
    PROCEDURE BOOKING_IN_PROGRESS(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
        ) AS
            INVALID_INPUT_EX EXCEPTION;
        BEGIN
        -- validate BOOKING
        IF BOOKING_IN_PROGRESS_VALIDATION(vBOOKING_ID,vLISTING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        -- UPDATE THE BOOKING STATUS
        UPDATE BOOKING SET BOOKING_STATUS='IN-PROGRESS', ACTUAL_START_DATE=LOCALTIMESTAMP WHERE BOOKING_ID=vBOOKING_ID;

        EXCEPTION
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
    END BOOKING_IN_PROGRESS;

    -- Procedure to update a booking to COMPLETED
    PROCEDURE BOOKING_COMPLETED(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type,
        vCOMMENTS IN BOOKING.COMMENTS%type
        ) AS
            vDAYS NUMBER(5,2);
            vFEE_RATE NUMBER(5,2);
            vACTUAL_START_DATE TIMESTAMP;
            vTRANSACTION_ID BOOKING.TRANSACTION_ID%TYPE;
            INVALID_INPUT_EX EXCEPTION;
            NO_DATA_EX EXCEPTION;
        BEGIN
            -- validate BOOKING
        IF BOOKING_COMPLETED_VALIDATION(vBOOKING_ID, vLISTING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        BEGIN
        SELECT ACTUAL_START_DATE INTO vACTUAL_START_DATE FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
        END;

        vDAYS := CAST(LOCALTIMESTAMP AS DATE) - CAST(vACTUAL_START_DATE AS DATE);

        -- IF THE DIFFERENCE IS 0 DAYS, IT NEEDS TO BE CONSIDERED AS 1 DAY
            IF vDAYS = 0 THEN
                vDAYS := 1;
            END IF;

        BEGIN
        SELECT FEE_RATE INTO vFEE_RATE FROM CAR_LISTING WHERE LISTING_ID=vLISTING_ID;
        				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
        END;

        BEGIN
        SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
        				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
        END;

        PKG_TRANSACTION.BODY_TRANSACTION_UPDATE_TABLE(vTRANSACTION_ID,'PENDING', vDAYS * vFEE_RATE);

        -- UPDATE THE BOOKING STATUS
        UPDATE BOOKING SET BOOKING_STATUS='COMPLETED', COMMENTS=vCOMMENTS, ACTUAL_END_DATE=LOCALTIMESTAMP WHERE BOOKING_ID=vBOOKING_ID;

        EXCEPTION
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
            when NO_DATA_EX then
                dbms_output.put_line('[ERROR] No records found');
    END BOOKING_COMPLETED;

    -- Procedure to update a booking to PAYMENT-SUCCESS
    PROCEDURE BOOKING_PAYMENT_SUCCESS(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
        ) AS
            vACTUAL_START_DATE TIMESTAMP;
            RECORD_COUNT NUMBER;
            vTRANSACTION_ID BOOKING.TRANSACTION_ID%TYPE;
            PAID NUMBER;
            INITIAL1 NUMBER;
            IN_PROGRESS NUMBER;
            INVALID_INPUT_EX EXCEPTION;
            NO_RECORD_EX EXCEPTION;
            PAID_EX EXCEPTION;
            INITIAL_EX EXCEPTION;
            IN_PROG_EX EXCEPTION;
            NO_DATA_EX EXCEPTION;
        BEGIN
            -- validate BOOKING
        IF BOOKING_PAYMENT_VALIDATION(vBOOKING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        SELECT COUNT(*) TRANSACTION_ID INTO RECORD_COUNT FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
        SELECT COUNT(*) BOOKING_STATUS INTO PAID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='PAYMENT_DONE';
        SELECT COUNT(*) BOOKING_STATUS INTO INITIAL1 FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='INITIAL';
        SELECT COUNT(*) BOOKING_STATUS INTO IN_PROGRESS FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='IN-PROGRESS';

        IF RECORD_COUNT = 0 THEN
            RAISE NO_RECORD_EX;
        END IF;

        IF PAID != 0 THEN
            RAISE PAID_EX;
        END IF;

        IF INITIAL1 != 0 THEN
            RAISE INITIAL_EX;
        END IF;

        IF IN_PROGRESS != 0 THEN
            RAISE IN_PROG_EX;
        END IF;
        
        BEGIN
        SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
        				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
        END;
        PKG_TRANSACTION.BODY_TRANSACTION_UPDATE_TABLE_SUCCESS(vTRANSACTION_ID, 'SUCCESS');

        -- UPDATE THE BOOKING STATUS
        UPDATE BOOKING SET BOOKING_STATUS='PAYMENT_DONE', ACTUAL_END_DATE=LOCALTIMESTAMP WHERE BOOKING_ID=vBOOKING_ID;

        EXCEPTION
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
            when NO_RECORD_EX then
                dbms_output.put_line('[ERROR] No records found for the provided Booking ID');
            when PAID_EX then
                dbms_output.put_line('[ERROR] Booking already completed and paid');
            when INITIAL_EX then
                dbms_output.put_line('[ERROR] Booking still in INITIAL state, needs to be completed for payment');
            when IN_PROG_EX then
                dbms_output.put_line('[ERROR] Booking still in IN-PROGRESS state, needs to be completed for payment');
            when NO_DATA_EX then
                dbms_output.put_line('[ERROR] No records found');
    END BOOKING_PAYMENT_SUCCESS;

    -- Procedure to update a booking to PAYMENT-FAILED
    PROCEDURE BOOKING_PAYMENT_FAIL(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
        ) AS
            vACTUAL_START_DATE TIMESTAMP;
            RECORD_COUNT NUMBER;
            vTRANSACTION_ID BOOKING.TRANSACTION_ID%TYPE;
            PAID NUMBER;
            INITIAL1 NUMBER;
            IN_PROGRESS NUMBER;
            INVALID_INPUT_EX EXCEPTION;
            NO_RECORD_EX EXCEPTION;
            PAID_EX EXCEPTION;
            INITIAL_EX EXCEPTION;
            IN_PROG_EX EXCEPTION;
            NO_DATA_EX EXCEPTION;
        BEGIN
            -- validate BOOKING
        IF BOOKING_PAYMENT_VALIDATION(vBOOKING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        SELECT COUNT(*) TRANSACTION_ID INTO RECORD_COUNT FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
        SELECT COUNT(*) BOOKING_STATUS INTO PAID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='PAYMENT_FAILED';
        SELECT COUNT(*) BOOKING_STATUS INTO INITIAL1 FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='INITIAL';
        SELECT COUNT(*) BOOKING_STATUS INTO IN_PROGRESS FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='IN-PROGRESS';

        IF RECORD_COUNT = 0 THEN
            RAISE NO_RECORD_EX;
        END IF;

        IF PAID != 0 THEN
            RAISE PAID_EX;
        END IF;

        IF INITIAL1 != 0 THEN
            RAISE INITIAL_EX;
        END IF;

        IF IN_PROGRESS != 0 THEN
            RAISE IN_PROG_EX;
        END IF;
        
        BEGIN
        SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
        				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
        END;
        PKG_TRANSACTION.BODY_TRANSACTION_UPDATE_TABLE_SUCCESS(vTRANSACTION_ID, 'FAILED');

        -- UPDATE THE BOOKING STATUS
        UPDATE BOOKING SET BOOKING_STATUS='PAYMENT_FAILED', ACTUAL_END_DATE=LOCALTIMESTAMP WHERE BOOKING_ID=vBOOKING_ID;

        EXCEPTION
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
            when NO_RECORD_EX then
                dbms_output.put_line('[ERROR] No records found for the provided Booking ID');
            when PAID_EX then
                dbms_output.put_line('[ERROR] Booking already in failed state');
            when INITIAL_EX then
                dbms_output.put_line('[ERROR] Booking still in INITIAL state, needs to be completed for payment');
            when IN_PROG_EX then
                dbms_output.put_line('[ERROR] Booking still in IN-PROGRESS state, needs to be completed for payment');
            when NO_DATA_EX then
                dbms_output.put_line('[ERROR] No records found');
    END BOOKING_PAYMENT_FAIL;

    -- Procedure to cancel a booking
    PROCEDURE BOOKING_CANCELLED(
            vBOOKING_ID IN BOOKING.BOOKING_ID%type
        ) AS
            vCREATED_DATE_TIME BOOKING.CREATED_START_DATE%TYPE;
            CANCELLED_COUNT NUMBER;
            vTRANSACTION_ID BOOKING.TRANSACTION_ID%TYPE;
            NO_DATA_EX EXCEPTION;
            CANNOT_CANCEL_EX EXCEPTION;
            ALREADY_CANCELLED_EX EXCEPTION;
        BEGIN
            -- Fetch the created start date for the user
            BEGIN
                SELECT CREATED_START_DATE INTO vCREATED_DATE_TIME FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
            END;

            -- fetch the transaction id for the user
            BEGIN
                SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
            END;

            -- fetch the count of cancelled booking for the current user
            BEGIN
                SELECT COUNT(*) INTO CANCELLED_COUNT FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID AND BOOKING_STATUS='CANCELLED';
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
					RAISE NO_DATA_EX;
            END;

            -- raise an exception if the booking for the current user is already cancelled
            IF CANCELLED_COUNT > 0 THEN
                RAISE ALREADY_CANCELLED_EX;
            END IF;

            -- dont allow cancellation if the time of cancellation is after the created start date
            IF vCREATED_DATE_TIME > LOCALTIMESTAMP THEN
                UPDATE BOOKING SET BOOKING_STATUS='CANCELLED' WHERE BOOKING_ID=vBOOKING_ID;
            ELSE
                RAISE CANNOT_CANCEL_EX;
            END IF;

            -- change the total cost of the user to 0 after cancellation
            UPDATE TRANSACTION SET TOTAL_COST = 0.0, STATUS='CANCELLED' WHERE TRANSACTION_ID=vTRANSACTION_ID;
        EXCEPTION
            when CANNOT_CANCEL_EX then
                dbms_output.put_line('[ERROR] Cannot cancel the booking after the Start Time of the booking');
            when ALREADY_CANCELLED_EX then
                dbms_output.put_line('[ERROR] The booking is already in CANCELLED state');
            when NO_DATA_EX then
                dbms_output.put_line('[ERROR] No records found');
        END;

END PKG_BOOKING;
/
/*
------------------------------------------------------------------BOOKING END-------------------------------------------------------------------------
*/

/*
-------------------------------------------------------------------USER START-------------------------------------------------------------------------
*/

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
        exe_INVALID_BLACKLISTED EXCEPTION;

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
        
        if vBLACKLISTED is NULL or LENGTH(trim(vBLACKLISTED)) = 0 or UPPER(vBLACKLISTED) NOT IN ('TRUE', 'FALSE') then 
            raise exe_INVALID_BLACKLISTED;
        end if;
        
        IF CHECK_EMAIL_COUNT = 0 AND CHECK_USER_NAME_COUNT = 0 AND CHECK_DL_COUNT = 0 AND CHECK_PASSPORT_COUNT = 0 THEN 
        INSERT INTO USERS(USER_ID, PASSWORD, USER_NAME, EMAIL, PHONE_NO, FIRST_NAME, LAST_NAME, DATE_OF_JOINING, DRIVER_LICENSE, PASSPORT, BLACKLISTED, ADDRESS_ID)
        VALUES
        ('USER_' || USERS_ID_SEQ.NEXTVAL, vPASSWORD, UPPER(vUSER_NAME), LOWER(vEMAIL), vPHONE_NO, UPPER(vFIRST_NAME), UPPER(vLAST_NAME), SYSDATE, vDRIVER_LICENSE, UPPER(vPASSPORT), UPPER(vBLACKLISTED), vADDRESS_ID);
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
            When exe_INVALID_BLACKLISTED then 
                dbms_output.put_line('Invalid blacklisted value !!!'); 
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
        
        IF USER_USER_ID_IN_BOOKING_COUNT = 0 THEN 
        DELETE FROM USERS WHERE UPPER(EMAIL) = UPPER(vEMAIL);
        END IF; 
        
    
        EXCEPTION
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
        ex_INVALID_PHONE_NO EXCEPTION;
        ex_INVALID_PASSPORT_NO EXCEPTION;
        ex_INVALID_BLACKLISTED EXCEPTION;
        
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

        if vDRIVER_LICENSE is NULL or trim(vDRIVER_LICENSE) is NULL or LENGTH(TRIM(vDRIVER_LICENSE)) != 10 then
            raise ex_INVALID_DL;
        end if;
        
        if vEMAIL is NULL or LENGTH(trim(vEMAIL)) = 0 then 
            raise ex_INVALID_EMAIL_FOR_UPDATE;
        end if;
        
        if vPHONE_NO is NULL or LENGTH(trim(vPHONE_NO)) != 10 then 
            raise ex_INVALID_PHONE_NO;
        end if;
        
        if vPASSPORT is NULL or LENGTH(trim(vPASSPORT)) < 6 then 
            raise ex_INVALID_PASSPORT_NO;
        end if;
        
       if vBLACKLISTED is NULL or LENGTH(trim(vBLACKLISTED)) = 0 or UPPER(vBLACKLISTED) NOT IN ('TRUE', 'FALSE') then 
            raise ex_INVALID_BLACKLISTED;
        end if;
        
        if CHECK_PASSPORT(vPASSPORT) = 'NO' AND  CHECK_DRIVER_LICENSE(vDRIVER_LICENSE) = 'NO' then 
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
                dbms_output.put_line('DRIVER LICENSE number is less than 10 digits or invalid !!!');
            when ex_INVALID_EMAIL_FOR_UPDATE then
                dbms_output.put_line('Email is null or invalid !!!');
             when ex_INVALID_PASSPORT_NO then 
                dbms_output.put_line('Passport is NULL or invalid !!!'); 
             when ex_INVALID_PHONE_NO then 
                dbms_output.put_line('Phone number is NULL or invalid !!!'); 
              when ex_INVALID_BLACKLISTED then   
                dbms_output.put_line('Blacklisted value is invalid or null!!!'); 
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

/*
-------------------------------------------------------------------USER END---------------------------------------------------------------------------
*/


/*
-------------------------------------------------------------------FILTER LISTING START-------------------------------------------------------------
*/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY PCKG_CAR_LISTING_EXT AS
    PROCEDURE FILTER_LISTING(
        vUSER_ID IN USERS.USER_ID%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vMIN_NO_OF_SEATS IN NUMBER DEFAULT 2,
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type,
        vBOOKING_START IN TIMESTAMP DEFAULT SYSDATE,
        vBOOKING_END IN TIMESTAMP DEFAULT SYSDATE+1
    ) AS
    -- create some variables and exceptions
    vListings CAR_LISTING.LISTING_ID%type;
    vUSER_COUNT NUMBER(5) DEFAULT 0;
    vBOOKINGS_COUNT NUMBER(5) DEFAULT 0;
    vADDRESS_COUNT NUMBER(5) DEFAULT 0;
    USER_NOT_FOUND EXCEPTION;
    PREV_BOOKING_PENDING EXCEPTION;
    SERVICE_NOT_AVAILABLE EXCEPTION;
    BEGIN
        -- user check
        IF vUSER_ID IS NOT NULL THEN
            SELECT count(*) INTO vUSER_COUNT FROM USERS WHERE USER_ID = UPPER(TRIM(vUSER_ID));
            IF vUSER_COUNT != 1 THEN
                RAISE USER_NOT_FOUND;
            END IF;
        ELSE
            RAISE USER_NOT_FOUND;
        END IF;

        -- check if user has any ongoing bookings or pending transactions
        SELECT count(*) INTO vBOOKINGS_COUNT FROM BOOKING WHERE UPPER(BOOKING_STATUS) IN ('INITIAL','IN-PROGRESS','COMPLETED','PAYMENT_FAILED') AND UPPER(USER_ID) = UPPER(TRIM(vUSER_ID));
        IF vBOOKINGS_COUNT != 0 THEN
            RAISE PREV_BOOKING_PENDING;
        ELSE
            -- FILTER BASED ON PARAMETERS
            
            SELECT count(*) INTO vADDRESS_COUNT FROM ADDRESS WHERE UPPER(ZIPCODE) = UPPER(TRIM(vZIP_CODE)) AND UPPER(ADDRESS_TYPE) = 'PARKING';
            IF vADDRESS_COUNT = 0 THEN
                RAISE SERVICE_NOT_AVAILABLE;
            END IF;
            dbms_output.put_line('AVAILABLE LISTINGS ARE SHOWN BELOW: ');
            DECLARE
                CURSOR V_CUR
                IS
                SELECT * FROM CAR_LISTING
                WHERE
                PARKING_ID IN ( 
                    SELECT PARKING_ID FROM PARKING 
                    WHERE 
                        ADDRESS_ID IN (
                            SELECT ADDRESS_ID FROM ADDRESS WHERE UPPER(ZIPCODE) = UPPER(TRIM(vZIP_CODE)) AND UPPER(ADDRESS_TYPE)='PARKING'
                        )
                    )
                AND
                CAR_REGISTER_ID IN (
                    SELECT CAR_REGISTER_ID FROM CAR_REGISTRATION
                    WHERE 
                        NO_OF_SEATS >= vMIN_NO_OF_SEATS
                        AND 
                        CAR_CATEGORY_ID IN (
                            SELECT CAR_CATEGORY_ID FROM CAR_CATEGORY WHERE
                            CAR_CATEGORY_NAME = UPPER(TRIM(vCAR_CATEGORY_NAME))
                        )
                    )
                    AND
                    LISTING_ID NOT IN(
                        SELECT LISTING_ID FROM BOOKING
                        WHERE
                           CAST(vBOOKING_START as DATE) - CAST(CREATED_END_DATE as DATE) < 0
                    );
BEGIN
    FOR V_REC IN V_CUR LOOP
      DBMS_OUTPUT.PUT_LINE(V_REC.LISTING_ID ||' at PARKING ID : '||V_REC.PARKING_ID || ' with REGISTRATION_ID : ' || V_REC.CAR_REGISTER_ID);
    END LOOP;
END;

        END IF;

    EXCEPTION
        WHEN USER_NOT_FOUND THEN
            dbms_output.put_line('USER DOES NOT EXIST!!!');
        WHEN PREV_BOOKING_PENDING THEN
            dbms_output.put_line('PREVIOUS BOOKINGS HAVE NOT BEEN COMPLETED YET!!!');
        WHEN SERVICE_NOT_AVAILABLE THEN
            dbms_output.put_line('SERVICE IS UNAVAILABLE IN GIVEN AREA!!!!');
    END FILTER_LISTING;
END PCKG_CAR_LISTING_EXT;
/

/*
-------------------------------------------------------------------FILTER LISTING END----------------------------------------------------------------
*/
