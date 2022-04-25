SET SERVEROUTPUT ON;

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
    BEGIN
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

--EG
-- EXECUTE PCKG_CAR_LISTING.INSERT_CAR_LISTING('TRUE',25.50,'CAR_1','PARKING_2');