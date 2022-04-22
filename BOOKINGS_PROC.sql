  --CREATE PACKAGE
  CREATE OR REPLACE EDITIONABLE PACKAGE PKG_BOOKING   AS 
    
    FUNCTION BOOKING_VALIDATION(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vBOOKING_STATUS IN BOOKING.BOOKING_STATUS%type,
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vACTUAL_START_DATE IN BOOKING.ACTUAL_START_DATE%type,
        vACTUAL_END_DATE IN BOOKING.ACTUAL_END_DATE%type,
        vCOMMENTS IN BOOKING.COMMENTS%type	
    ) RETURN VARCHAR2;
	
    PROCEDURE INSERT_BOOKING(
        vBOOKING_STATUS IN BOOKING.BOOKING_STATUS%type,
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vACTUAL_START_DATE IN BOOKING.ACTUAL_START_DATE%type,
        vACTUAL_END_DATE IN BOOKING.ACTUAL_END_DATE%type,
        vCOMMENTS IN BOOKING.COMMENTS%type
        vUSER_ID IN BOOKING.USER_ID%type
        vLISTING_ID IN BOOKING.LISTING_ID%type
        vTRANSACTION_ID IN BOOKING.TRANSACTION_ID%type
    );

	 FUNCTION COMPARE_TIMESTAMP(
        VTIME_ONE IN TIMESTAMP,
        VTIMESTAMP_TWO IN TIMESTAMP
    ) RETURN VARCHAR2;
        
END PKG_BOOKING;

************************************************************

 --CREATE PACKAGE BODY
create or replace PACKAGE BODY PKG_BOOKING   AS

    FUNCTION BOOKING_VALIDATION(
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
    END BOOKING_VALIDATION;

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

    PROCEDURE INSERT_BOOKING(
        vBOOKING_STATUS IN BOOKING.BOOKING_STATUS%type,
        vCREATED_START_DATE IN BOOKING.CREATED_START_DATE%type,
        vCREATED_END_DATE IN BOOKING.CREATED_END_DATE%type,
        vACTUAL_START_DATE IN BOOKING.ACTUAL_START_DATE%type,
        vACTUAL_END_DATE IN BOOKING.ACTUAL_END_DATE%type,
        vCOMMENTS IN BOOKING.COMMENTS%type
        vUSER_ID IN BOOKING.USER_ID%type
        vLISTING_ID IN BOOKING.LISTING_ID%type
        vTRANSACTION_ID IN BOOKING.TRANSACTION_ID%type
    ) AS
        vBOOKING_ID BOOKING.BOOKING_ID%TYPE;
    BEGIN
        SELECT BOOKING_ID INTO vBOOKING_ID FROM BOOKING
        -- validate address
        IF BOOKING_VALIDATION(vADDRESS_LINE_1, vADDRESS_LINE_2, vZIP_CODE) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;
    END;

END PKG_BOOKING;
