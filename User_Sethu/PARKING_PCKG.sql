SET SERVEROUTPUT ON;

CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_PARKING AS

    PROCEDURE INSERT_PARKING(
        vADDRESS_ID IN ADDRESS.ADDRESS_ID%type);

END PCKG_PARKING;
/

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


-- EG
-- EXECUTE PCKG_PARKING.INSERT_PARKING('ADDRESS_1');