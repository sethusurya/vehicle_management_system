SET SERVEROUTPUT ON;

CREATE OR REPLACE EDITIONABLE PACKAGE PCKG_CAR_CATEGORY   AS
    FUNCTION PROCESS_CAR_CATEGORY(
        vCAR_CATEGORY_ID IN CAR_CATEGORY.CAR_CATEGORY_ID%type,
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type
    ) RETURN VARCHAR2;
END PCKG_CAR_CATEGORY;
/

CREATE OR REPLACE EDITIONABLE PACKAGE  BODY PCKG_CAR_CATEGORY   AS
    FUNCTION PROCESS_CAR_CATEGORY(
        vCAR_CATEGORY_ID IN CAR_CATEGORY.CAR_CATEGORY_ID%type,
        vCAR_CATEGORY_NAME IN CAR_CATEGORY.CAR_CATEGORY_NAME%type
    ) RETURN VARCHAR2 AS
    ex_INVALID_ID EXCEPTION;
    ex_INVALID_NAME EXCEPTION;
    BEGIN
        IF vCAR_CATEGORY_ID IS NULL OR LENGTH(vCAR_CATEGORY_ID) < 1 THEN
            RAISE ex_INVALID_ID;
        END IF;
        IF vCAR_CATEGORY_NAME IS NULL OR LENGTH(vCAR_CATEGORY_NAME) < 1 THEN
            RAISE ex_INVALID_NAME;
        END IF;
        RETURN 'YES';
    EXCEPTION
        WHEN ex_INVALID_ID THEN
            dbms_output.enable(100000);
            dbms_output.put_line('INVALID CAR_CATEGORY_ID');
            RETURN 'NO';
        WHEN ex_INVALID_NAME THEN
            dbms_output.enable(100000);
            dbms_output.put_line('INVALID CAR_CATEGORY_NAME');
            RETURN 'NO';
    END PROCESS_CAR_CATEGORY;
END PCKG_CAR_CATEGORY;
/


SELECT PCKG_CAR_CATEGORY.PROCESS_CAR_CATEGORY('CH_001','SUV') FROM DUAL;