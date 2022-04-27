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