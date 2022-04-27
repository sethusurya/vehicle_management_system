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
        vLISTING_ID IN BOOKING.LISTING_ID%type
    );

    PROCEDURE BOOKING_PAYMENT_SUCCESS(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
    );

    PROCEDURE BOOKING_PAYMENT_FAIL(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type
    );

	 FUNCTION COMPARE_TIMESTAMP(
        VTIME_ONE IN TIMESTAMP,
        VTIMESTAMP_TWO IN TIMESTAMP
    ) RETURN VARCHAR2;

END PKG_BOOKING;

/

create or replace PACKAGE BODY PKG_BOOKING   AS

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
            SELECT COUNT(*) INTO BOOKING_STATUS_INPROG FROM BOOKING WHERE BOOKING_STATUS='IN-PROGRESS';
            SELECT COUNT(*) INTO BOOKING_STATUS_COMP FROM BOOKING WHERE BOOKING_STATUS='COMPLETED';
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
            SELECT COUNT(*) INTO BOOKING_STATUS_INITIAL FROM BOOKING WHERE BOOKING_STATUS='INITIAL';
            SELECT COUNT(*) INTO BOOKING_STATUS_COMP FROM BOOKING WHERE BOOKING_STATUS='COMPLETED';

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
            FETCH_TRANSACTION_ID TRANSACTION.TRANSACTION_ID%TYPE;
            EXSTING_BOOKING_EX EXCEPTION;
            INVALID_INPUT_EX EXCEPTION;
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
    END INSERT_NEW_BOOKING;

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

    PROCEDURE BOOKING_COMPLETED(
        vBOOKING_ID IN BOOKING.BOOKING_ID%type,
        vLISTING_ID IN BOOKING.LISTING_ID%type
        ) AS
            vDAYS NUMBER(5,2);
            vFEE_RATE NUMBER(5,2);
            vACTUAL_START_DATE TIMESTAMP;
            vTRANSACTION_ID BOOKING.TRANSACTION_ID%TYPE;
            INVALID_INPUT_EX EXCEPTION;
        BEGIN
            -- validate BOOKING
        IF BOOKING_COMPLETED_VALIDATION(vBOOKING_ID, vLISTING_ID) = 'NO' THEN
            RAISE INVALID_INPUT_EX;
        END IF;

        SELECT ACTUAL_START_DATE INTO vACTUAL_START_DATE FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;

        vDAYS := CAST(LOCALTIMESTAMP AS DATE) - CAST(vACTUAL_START_DATE AS DATE);

        -- IF THE DIFFERENCE IS 0 DAYS, IT NEEDS TO BE CONSIDERED AS 1 DAY
            IF vDAYS = 0 THEN
                vDAYS := 1;
            END IF;

        SELECT FEE_RATE INTO vFEE_RATE FROM CAR_LISTING WHERE LISTING_ID=vLISTING_ID;

        SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;

        PKG_TRANSACTION.BODY_TRANSACTION_UPDATE_TABLE(vTRANSACTION_ID,'PENDING', vDAYS * vFEE_RATE);

        -- UPDATE THE BOOKING STATUS
        UPDATE BOOKING SET BOOKING_STATUS='COMPLETED', ACTUAL_END_DATE=LOCALTIMESTAMP WHERE BOOKING_ID=vBOOKING_ID;

        EXCEPTION
            when INVALID_INPUT_EX then
                dbms_output.put_line('[ERROR] Invalid Input');
    END BOOKING_COMPLETED;

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

        SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
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
    END BOOKING_PAYMENT_SUCCESS;

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

        SELECT TRANSACTION_ID INTO vTRANSACTION_ID FROM BOOKING WHERE BOOKING_ID=vBOOKING_ID;
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
    END BOOKING_PAYMENT_FAIL;

END PKG_BOOKING;