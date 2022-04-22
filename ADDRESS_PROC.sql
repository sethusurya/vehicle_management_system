  CREATE OR REPLACE EDITIONABLE PACKAGE PKG_ADDRESS   AS 
    
    FUNCTION ADDRESS_VALIDATION(
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type
    ) RETURN VARCHAR2;

    PROCEDURE INSERT_ADDRESS(
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_ID IN NUMBER
    );
	
END PKG_ADDRESS;

************************************************************

 --CREATE PACKAGE BODY
create or replace PACKAGE BODY PKG_ADDRESS   AS

  FUNCTION ADDRESS_VALIDATION(
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type
    ) RETURN VARCHAR2 AS

			ZIPCODE_LENGTH NUMBER;
            ADDR1_LENGTH NUMBER;
            ADDR2_LENGTH NUMBER;
			INVALID_ADDR1_EX EXCEPTION;
			INVALID_ZIP_CODE_EX EXCEPTION;
			ZIP_CODE_NAN_EX EXCEPTION;
			ZIPCODE_LENGTH_EX EXCEPTION;
            ADDR1_LENGTH_EX EXCEPTION;
            ADDR2_LENGTH_EX EXCEPTION;

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
        
        IF(ADDR1_LENGTH > 50) THEN
			RAISE ADDR1_LENGTH_EX;
		END IF;

		-- CHECK IF BOOKING STATUS IS BLACK OR NULL
        if vZIP_CODE is NULL or LENGTH(trim(vZIP_CODE)) IS NULL then
            raise INVALID_ZIP_CODE_EX;
        end if;

		-- CHECK IF BOOKING STATUS IS BLACK OR NULL
        if vZIP_CODE = 0 then
            raise INVALID_ZIP_CODE_EX;
        end if;

		-- CHECK IF BOOKING STATUS IS BLACK OR NULL
        if ZIPCODE_LENGTH <> 5 then
            raise ZIPCODE_LENGTH_EX;
        end if;

		-- CHECK IF DEPT_NAME IS NOT A NUMBER 
		IF(NOT VALIDATE_CONVERSION(vZIP_CODE AS NUMBER) != 1) THEN 
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
        when others then
            RETURN 'NO';
  END ADDRESS_VALIDATION;

    PROCEDURE INSERT_ADDRESS(
        vADDRESS_LINE_1 IN ADDRESS.ADDRESS_LINE_1%type,
        vADDRESS_LINE_2 IN ADDRESS.ADDRESS_LINE_2%type,
        vZIP_CODE IN ADDRESS.ZIPCODE%type,
        vCITY_ID IN NUMBER
    ) AS
    
        INVALID_INPUT_EX EXCEPTION;
        FAILURE_EX EXCEPTION;

    BEGIN
        IF ADDRESS_VALIDATION(vADDRESS_LINE_1, vADDRESS_LINE_2, vZIP_CODE) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        INSERT INTO ADDRESS VALUES(
            ADDRESS_ID_SEQ.NEXTVAL,
            vADDRESS_LINE_1,
            vADDRESS_LINE_2,
            vZIP_CODE,
            vCITY_ID
        );

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

    END;

END PKG_ADDRESS;