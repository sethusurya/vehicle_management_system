set serveroutput on;

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
    INVALID_FEE_RATE EXCEPTION;
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
        begin
            select Count(*) into ID_CHECK from Address where ADDRESS_LINE_1 = TRIM(UPPER(vADDRESS_LINE_1)) and ADDRESS_TYPE = 'PARKING';
            if(ID_CHECK = 0) then  
                PCKG_PARKING_EXT.INSERT_PARKING_EXT(vADDRESS_LINE_1, vADDRESS_LINE_2, vZIP_CODE, vCITY_NAME, vSTATE_NAME, vCOUNTRY_NAME);
                select ADDRESS_ID into vADDRESS_ID from Address where ADDRESS_LINE_1 = TRIM(UPPER(vADDRESS_LINE_1)) and ADDRESS_TYPE = 'PARKING';
            else
                select ADDRESS_ID into vADDRESS_ID from Address where ADDRESS_LINE_1 = TRIM(UPPER(vADDRESS_LINE_1)) and ADDRESS_TYPE = 'PARKING';
            end if;
        end;
        if vFEE_RATE is NULL then
            raise INVALID_FEE_RATE;
        end if;
        BODY_CAR_REGISTER(UPPER(vCAR_REGISTER_ID), UPPER(vCAR_NAME), UPPER(vCAR_COLOR), UPPER(vCAR_COMPANY), to_number(vYEAR_OF_MANUFACTURE), vREGISTRATION_DATE, UPPER(vFUEL_TYPE), UPPER(vTRANSMISSION_TYPE), to_number(vNO_OF_SEATS), UPPER(vCAR_CATEGORY_ID), UPPER(vEMPLOYEE_ID), UPPER(vADDRESS_ID));
        begin
            dbms_output.put_line(vADDRESS_ID);
            select PARKING_ID into vCAR_PARKING_ID from Parking where ADDRESS_ID = TRIM(UPPER(vADDRESS_ID));
        end;   
        PCKG_CAR_LISTING.INSERT_CAR_LISTING('TRUE',vFEE_RATE,TRIM(UPPER(vCAR_REGISTER_ID)),TRIM(UPPER(vCAR_PARKING_ID)));
    EXCEPTION
          when INVALID_EMPLOYEE_ID then
            dbms_output.put_line('Invalid employee email !!!');
          when INVALID_CAR_REGISTER_ID_PRESENT then
            dbms_output.put_line('CAR REGISTER ID already present !!!');
          when INVALID_ADDRESS_DETAILS then
            dbms_output.put_line('Invalid Address Details !!!');
         when INVALID_FEE_RATE then
            dbms_output.put_line('FEE RATE IS INVALID !!!');

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

        if vREGISTRATION_DATE is NULL or to_char(LENGTH(vREGISTRATION_DATE)) is NULL then
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
    BEGIN
        Select BODY_CAR_REGISTER_ID_CHECK(vCAR_REGISTER_ID) INTO temp_car_id from dual;
        if Not(temp_car_id > 0) then
             dbms_output.put_line('Invalid CAR_REGISTER ID !!!');
        end if;
        select listing_id into vlisting_id from car_listing where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        select address_id into vaddress_id from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
        select count(*) into vbooking_count from booking where listing_id = TRIM(UPPER(vlisting_id)) and (BOOKING_STATUS in ('INITIAL', 'IN-PROGRESS'));
        if vbooking_count = 0 then
            Delete from  car_listing where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
            Delete from CAR_REGISTRATION where CAR_REGISTER_ID = TRIM(UPPER(vCAR_REGISTER_ID));
            Delete from  parking where address_id = TRIM(UPPER(vaddress_id));
            Delete from  address where address_id = TRIM(UPPER(vaddress_id));
            dbms_output.put_line('deleted data successfully');
        else
             dbms_output.put_line('On going booking');
        end if;
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

-- select * from CAR_REGISTRATION;
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthyg7', 'city', 'RED', 'honda ', 2018, '1-JAN-2018', 'gasoline','manual',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','51 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 10);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthyg8', 'civic', 'white', 'honda ', 2019, '1-JAN-2019', 'gasoline','manual',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','52 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 12.5);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthyg9', 'accord', 'black', 'honda ', 2020, '1-FEB-2020', 'gasoline','manual',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','53 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 14.5);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthyg0', 'A7', 'RED', 'audi ', 2019, '1-MAR-2019', 'gasoline','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','54 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 20.5);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya0', 'A8', 'white', 'audi ', 2020, '1-JAN-2020', 'gasoline','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','55 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 22);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya1', 'Q7', 'black', 'audi ', 2017, '1-JUN-2017', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','56 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 25.5);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya2', 'Q5', 'RED', 'audi ', 2018, '1-JAN-2018', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','57 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 22);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya3', 'X7', 'white', 'bmw ', 2021, '1-FEB-2021', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','58 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 25.5);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya4', 'X5', 'black', 'bmw ', 2021, '1-JAN-2021', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','59 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 22);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya5', '330', 'RED', 'bmw ', 2017, '1-JAN-2017', 'gasoline','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','60 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 20.5);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya6', 'ecosport', 'white', 'ford ', 2018, '1-FEB-2018', 'diesel','automatic',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','51 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 12.5);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya7', 'focus', 'black', 'ford ', 2020, '1-JAN-2020', 'gasoline','manual',4,'hatchback','PAGOLU.S@NORTHEASTERN.EDU','61 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 10);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya8', 'model 3', 'RED', 'tesla ', 2019, '1-FEB-2019', 'electric','automatic',4,'SEDAN','PAGOLU.S@NORTHEASTERN.EDU','62 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 17.5);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthya9', 'wrangler', 'white', 'jeep ', 2020, '1-APR-2020', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','63 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 20.5);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DATA('Artyhbnju123fthyb1', 'cherokee', 'black', 'jeep ', 2018, '1-MAR-2018', 'diesel','automatic',6,'suv','PAGOLU.S@NORTHEASTERN.EDU','65 SHEPHERD AVE','APT 2','02115','BOSTON','MA','USA', 22.5);
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_UPDATE_TABLE('Artyhbnju123fthyg2', 'zica', 'white', '', '', '1-JAN-2019', 'gasoline','manual',4,'suv','PAGOLU.S@NORTHEASTERN.EDU');
-- EXECUTE PKG_CAR_REGISTER.BODY_CAR_REGISTER_DELETE_DATA('Artyhbnju123fthyg7');