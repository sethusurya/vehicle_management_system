

SET SERVEROUTPUT ON;


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