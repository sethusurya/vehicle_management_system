-- CREATE BOOKING ENTITY
  CREATE TABLE BOOKING   
   (  BOOKING_ID   NUMBER(25,0), 
	  BOOKING_STATUS   VARCHAR2(60)  , 
	  CREATED_START_DATE   TIMESTAMP, 
	  CREATED_END_DATE   TIMESTAMP, 
	  ACTUAL_START_DATE   TIMESTAMP  , 
	  ACTUAL_END_DATE   TIMESTAMP  , 
	  COMMENTS   VARCHAR2(255)  , 
	  USER_ID   NUMBER(10,0),
      LISTING_ID   NUMBER(10,0),
      TRANSACTION_ID   NUMBER(10,0)
   );
   

************************************************************

-- CREATE ADDRESS ENTITY   
   CREATE TABLE ADDRESS   
   (  ADDRESS_ID   NUMBER(25,0), 
	  ADDRESS_LINE_1   VARCHAR2(255)  , 
	  ADDRESS_LINE_2   VARCHAR2(255), 
	  ZIP_CODE   VARCHAR2(40), 
	  CITY_ID   VARCHAR2(255)
   );

************************************************************

  ALTER TABLE BOOKING   ADD CONSTRAINT BOOKING_PK   PRIMARY KEY (  BOOKING_ID  );
  ALTER TABLE BOOKING   MODIFY (  BOOKING_STATUS   CONSTRAINT BOOKING_STATUS_NOT_NULL   NOT NULL ENABLE);
  ALTER TABLE BOOKING   MODIFY (  CREATED_START_DATE   CONSTRAINT CREATED_START_DATE_NOT_NULL   NOT NULL ENABLE);
  ALTER TABLE BOOKING   MODIFY (  CREATED_END_DATE   CONSTRAINT CREATED_END_DATE_NOT_NULL   NOT NULL ENABLE);
  ALTER TABLE BOOKING   MODIFY (  ACTUAL_START_DATE   CONSTRAINT ACTUAL_START_DATE_NOT_NULL   NOT NULL ENABLE);
  ALTER TABLE BOOKING   MODIFY (  ACTUAL_END_DATE   CONSTRAINT ACTUAL_END_DATE_NOT_NULL   NOT NULL ENABLE);
  
  -- WILL ADD THESE LATER AFTER CREATION OF 
  ALTER TABLE BOOKING   ADD CONSTRAINT USER_ID_FK1   FOREIGN KEY (  USER_ID  )
	  REFERENCES USERS   (  USER_ID  ) ON DELETE CASCADE ENABLE;
  ALTER TABLE BOOKING   ADD CONSTRAINT LISTING_ID_FK2   FOREIGN KEY (  LISTING_ID  )
	  REFERENCES CAR_LISTINGS   (  LISTING_ID  ) ON DELETE CASCADE ENABLE;	
  ALTER TABLE BOOKING   ADD CONSTRAINT TRANSACTION_ID_FK3   FOREIGN KEY (  TRANSACTION_ID  )
	  REFERENCES TRANSACTION   (  TRANSACTION_ID  ) ON DELETE CASCADE ENABLE;
	  
	  
************************************************************
	  
  ALTER TABLE ADDRESS   ADD CONSTRAINT ADDRESS_PK   PRIMARY KEY (  ADDRESS_ID  );
  ALTER TABLE ADDRESS   MODIFY (  ADDRESS_LINE_1   CONSTRAINT ADDRESS_LINE_1_NOT_NULL   NOT NULL ENABLE);
  ALTER TABLE ADDRESS   MODIFY (  ZIP_CODE   CONSTRAINT ZIP_CODE_NOT_NULL   NOT NULL ENABLE);
  ALTER TABLE ADDRESS   MODIFY (  CITY_ID   CONSTRAINT CITY_ID_NOT_NULL   NOT NULL ENABLE);
  97B38C4960*694DE2BD2

************************************************************

  --CREATE PACKAGE
  CREATE OR REPLACE EDITIONABLE PACKAGE PKG_BOOKING   AS 
    
    FUNCTION BODY_BOOKING(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vBOOKING_STATUS IN BOOKING.BOOKING_STATUS%type,
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vACTUAL_START_DATE IN BOOKING.ACTUAL_START_DATE%type,
        vACTUAL_END_DATE IN BOOKING.ACTUAL_END_DATE%type,
        vCOMMENTS IN BOOKING.COMMENTS%type	
    ) RETURN VARCHAR2;
	
    -- PROCEDURE INSERT_BOOKING(
    --     vBOOKING_ID IN BOOKING.BOOKING_ID%type,
    --     vBOOKING_STATUS IN BOOKING.BOOKING_STATUS%type,
    --     vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
    --     vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
    --     vACTUAL_START_DATE IN BOOKING.ACTUAL_START_DATE%type,
    --     vACTUAL_END_DATE IN BOOKING.ACTUAL_END_DATE%type,
    --     vCOMMENTS IN BOOKING.COMMENTS%type
    --     vUSER_ID IN BOOKING.USER_ID%type
    --     vLISTING_ID IN BOOKING.LISTING_ID%type
    --     vTRANSACTION_ID IN BOOKING.TRANSACTION_ID%type
    -- );

	 FUNCTION COMPARE_TIMESTAMP(
        VTIME_ONE IN TIMESTAMP,
        VTIMESTAMP_TWO IN TIMESTAMP
    ) RETURN VARCHAR2;

    FUNCTION VALIDATE_TIMESTAMP(
        VTIME IN TIMESTAMP
    ) RETURN VARCHAR2;
        
END PKG_BOOKING;

************************************************************

  --CREATE PACKAGE
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
create or replace PACKAGE BODY PKG_BOOKING   AS

  FUNCTION BODY_BOOKING(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vBOOKING_STATUS IN BOOKING.BOOKING_STATUS%type,
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE %type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vACTUAL_START_DATE IN BOOKING.ACTUAL_START_DATE%type,
        vACTUAL_END_DATE IN BOOKING.ACTUAL_END_DATE%type,
        vCOMMENTS IN BOOKING.COMMENTS%type	
    ) RETURN VARCHAR2 AS

			EXISTING_BOOKING NUMBER;
			INVALID_BOOKING_EX EXCEPTION;
			INVALID_BOOKING_VAL_EX EXCEPTION;
			CREATED_START_DATE_EX EXCEPTION;
			CREATED_END_DATE_EX EXCEPTION;
			ACTUAL_START_DATE_EX EXCEPTION;
			ACTUAL_END_DATE_EX EXCEPTION;
			DUPLICATE_BOOKING_EX EXCEPTION;
			CREATED_START_DATE_LESS_THAN_SYS_EX EXCEPTION;
			CREATED_START_DATE_SMALLER_EX EXCEPTION;
			CREATED_END_DATE_LESS_THAN_SYS_EX EXCEPTION;
			ACTUAL_START_DATE_LESS_THAN_SYS_EX EXCEPTION;
			ACTUAL_START_DATE_SMALLER_EX EXCEPTION;
			ACTUAL_END_DATE_LESS_THAN_SYS_EX EXCEPTION;
			INVALID_CREATED_START_DATE_FORMAT EXCEPTION;
			INVALID_CREATED_END_DATE_FORMAT EXCEPTION;
			INVALID_ACTUAL_START_DATE_FORMAT EXCEPTION;
			INVALID_ACTUAL_END_DATE_FORMAT EXCEPTION;


    BEGIN
		-- CHECK IF BOOKING STATUS IS BLACK OR NULL
        if vBOOKING_STATUS is NULL or LENGTH(trim(vBOOKING_STATUS)) IS NULL then
            raise INVALID_BOOKING_EX;
        end if;

		-- CHECK IF BOOKING STATUS IS VALID
        if UPPER(vBOOKING_STATUS) != 'COMPLETED' AND UPPER(vBOOKING_STATUS) != 'IN-PROGRESS' AND UPPER(vBOOKING_STATUS) != 'OPEN' then
            raise INVALID_BOOKING_VAL_EX;
        end if;

		-- CHECK IF CREATED_START_DATE IS BLANK OR NULL
		if vCREATED_START_DATE is NULL or to_char(LENGTH(vCREATED_START_DATE)) is NULL then
            raise CREATED_START_DATE_EX;
        end if;

		-- CHECK IF CREATED_END_DATE IS BLANK OR NULL
		if vCREATED_END_DATE is NULL or to_char(LENGTH(vCREATED_END_DATE)) is NULL then
            raise CREATED_END_DATE_EX;
        end if;

		-- CHECK IF ACTUAL_START_DATE IS BLANK OR NULL		
		if vACTUAL_START_DATE is NULL or to_char(LENGTH(vACTUAL_START_DATE)) is NULL then
            raise ACTUAL_START_DATE_EX;
        end if;

		-- CHECK IF ACTUAL_END_DATE IS BLANK OR NULL	
		if vACTUAL_END_DATE is NULL or to_char(LENGTH(vACTUAL_END_DATE)) is NULL then
            raise ACTUAL_END_DATE_EX;
        end if;
		
		if NOT REGEXP_LIKE(vCREATED_START_DATE, '[0-9]{2}-[0-9]{2}-[0-9]{2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,7} [AaPp][Mm]') then
            raise INVALID_CREATED_START_DATE_FORMAT;
        end if;	
		
		if NOT REGEXP_LIKE(vCREATED_END_DATE, '[0-9]{2}-[0-9]{2}-[0-9]{2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,7} [AaPp][Mm]') then
            raise INVALID_CREATED_END_DATE_FORMAT;
        end if;	
		
		if NOT REGEXP_LIKE(vACTUAL_START_DATE, '[0-9]{2}-[0-9]{2}-[0-9]{2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,7} [AaPp][Mm]') then
            raise INVALID_ACTUAL_START_DATE_FORMAT;
        end if;	
		
		if NOT REGEXP_LIKE(vACTUAL_END_DATE, '[0-9]{2}-[0-9]{2}-[0-9]{2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,7} [AaPp][Mm]') then
            raise INVALID_ACTUAL_END_DATE_FORMAT;
        end if;	

		-- CHECK IF CREATED_START_DATE IS GREATER THAN CURRENT_DATE
		if COMPARE_TIMESTAMP(vCREATED_START_DATE, SYSTIMESTAMP ) < 0 then
            raise CREATED_START_DATE_LESS_THAN_SYS_EX;
        end if;

		-- CHECK IF CREATED_START_DATE IS LESS THAN CREATED_END_DATE
		if COMPARE_TIMESTAMP(vCREATED_END_DATE, vCREATED_START_DATE ) < 0 then
            raise CREATED_START_DATE_SMALLER_EX;
        end if;

		-- CHECK IF CREATED_END_DATE IS GREATER THAN CURRENT_DATE
		if COMPARE_TIMESTAMP(vCREATED_END_DATE, SYSTIMESTAMP ) < 0 then
            raise CREATED_END_DATE_LESS_THAN_SYS_EX;
        end if;

		-- CHECK IF ACTUAL_START_DATE IS GREATER THAN CURRENT_DATE
		if COMPARE_TIMESTAMP(vACTUAL_START_DATE, SYSTIMESTAMP ) < 0 then
            raise ACTUAL_START_DATE_LESS_THAN_SYS_EX;
        end if;

		-- CHECK IF ACTUAL_START_DATE IS LESS THAN ACTUAL_END_DATE
		if COMPARE_TIMESTAMP(vACTUAL_END_DATE, vACTUAL_START_DATE ) < 0 then
            raise ACTUAL_START_DATE_SMALLER_EX;
        end if;

		-- CHECK IF ACTUAL_END_DATE IS GREATER THAN CURRENT_DATE
		if COMPARE_TIMESTAMP(vACTUAL_END_DATE, SYSTIMESTAMP ) < 0 then
            raise ACTUAL_END_DATE_LESS_THAN_SYS_EX;
		end if;

        begin
             select BOOKING_ID into EXISTING_BOOKING from BOOKING where BOOKING_ID = vBOOKING_ID;
             if EXISTING_BOOKING is NOT NULL then
                raise DUPLICATE_BOOKING_EX;
            end if;
        exception
            when DUPLICATE_BOOKING_EX then
                raise DUPLICATE_BOOKING_EX;
            when NO_DATA_FOUND then
                return 'YES';
        end;

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
        when ACTUAL_START_DATE_EX then
            dbms_output.put_line('[ERROR] Invalid Actual Start Date, Enter a valid Created End Date');
            RETURN 'NO';
        when ACTUAL_END_DATE_EX then
            dbms_output.put_line('[ERROR] Invalid Actual End Date, Enter a valid Created End Date');
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
        when ACTUAL_START_DATE_LESS_THAN_SYS_EX then
            dbms_output.put_line('[ERROR] ActualStartDate cannot be less the current date');
            RETURN 'NO';
        when ACTUAL_START_DATE_SMALLER_EX then
            dbms_output.put_line('[ERROR] ActualStartDate cannot be less the ActualEndDate');
            RETURN 'NO';
        when ACTUAL_END_DATE_LESS_THAN_SYS_EX then
            dbms_output.put_line('[ERROR] ActualEndDate cannot be less the current date');
            RETURN 'NO';
        when INVALID_CREATED_START_DATE_FORMAT then
            dbms_output.put_line('[ERROR] CreatedStartDate has an Invalid format');
            RETURN 'NO';
        when INVALID_CREATED_END_DATE_FORMAT then
            dbms_output.put_line('[ERROR] CreatedEndDate has an Invalid format');
            RETURN 'NO';
        when INVALID_ACTUAL_START_DATE_FORMAT then
            dbms_output.put_line('[ERROR] ActualStartDate has an Invalid format');
            RETURN 'NO';
        when INVALID_ACTUAL_END_DATE_FORMAT then
            dbms_output.put_line('[ERROR] ActualEndDate has an Invalid format');
            RETURN 'NO';
        when others then
            RETURN 'NO';
  END BODY_BOOKING;

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

END PKG_BOOKING;

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
            dbms_output.put_line('[ERROR] ZipCode need to be a valid number');
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



BOOKING

1. BOOKING NEW
STATUS
CREAT STRT
CREAT END
USERID
LISTINGID
PASS STATUS AS PENDING AND TOTAL COST ALSO
Declare
returnvalue Varchar2(244);
BEGIN
PKG_TRANSACTION.BODY_TRANSACTION('pending', '10', returnvalue);
dbms_output.put_line(returnvalue);
END;




2. BOOKING IN PROGRESS
BOOKING_ID
STATUS
ACTUAL START DATE



3. BOOKING COMPLETED
BOOKING_ID
STATUS
ACTUAL END DATE
PASS STATUS AS PENDING AND TOTAL COST ALSO

EXECUTE PKG_TRANSACTION.BODY_TRANSACTION_UPDATE_TABLE('T_14','fail', 10);


4. BOOKING PAYMENT COMPLETED
BOOKING_ID
EXECUTE PKG_TRANSACTION.BODY_TRANSACTION_UPDATE_TABLE('T_14','fail', 10);
